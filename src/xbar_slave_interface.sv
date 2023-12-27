module xbar_slave_interface
#(
    //AXI Setup
    parameter ID_WIDTH = 4,
    parameter IDS_WIDTH = 8,
    parameter ADDR_WIDTH = 32,
    parameter LEN_WIDTH = 4,
    parameter SIZE_WIDTH = 3,
    parameter DATA_WIDTH = 32,
    parameter STRB_WIDTH = 4,

    parameter pending_depth = 8,
    parameter masters = 2,
    parameter slaves = 2,
    parameter i_am_master_number = 0,
    parameter [ADDR_WIDTH-1:0] address_map_base [0:slaves-1] = {'h0000_0000, 'h1000_0000},
    parameter [ADDR_WIDTH-1:0] address_map_end [0:slaves-1] = {'h0fff_ffff, 'h1fff_ffff}
)
(
    //Global Signal
    input ACLK,
    input ARESETn,

    ////////// Inter-XBar Communication //////////
    //Read Address Channel Payload
    output [ID_WIDTH-1:0]         ARID,
    output [ADDR_WIDTH-1:0]       ARADDR,
    output [LEN_WIDTH-1:0]        ARLEN,
    output [SIZE_WIDTH-1:0]       ARSIZE,
    output [1:0]                  ARBURST,

    //Read Data Channel Payload
    input [ID_WIDTH-1:0]        RID,
    input [DATA_WIDTH-1:0]      RDATA,
    input [1:0]                 RRESP,
    input                       RLAST,

    //Write Address Channel Payload
    output [ID_WIDTH-1:0]         AWID,
    output [ADDR_WIDTH-1:0]       AWADDR,
    output [LEN_WIDTH-1:0]        AWLEN,
    output [SIZE_WIDTH-1:0]       AWSIZE,
    output [1:0]                  AWBURST,

    //Write Data Channel Payload
    output [DATA_WIDTH-1:0]      WDATA,
    output [STRB_WIDTH-1:0]      WSTRB,
    output                       WLAST,

    //Write Response Channel Payload
    input [ID_WIDTH-1:0]        BID,
    input [1:0]                 BRESP,

    //Read Address Channel forwarding info
    input slave_read_addr_fifo_full,
    input [$clog2(masters)-1:0] slave_grant_read_addr_master_number [0:slaves-1],
    input [slaves-1:0] slave_read_addr_push_to_fifo,
    output master_read_addr_fifo_empty,
    output [$clog2(slaves)-1:0] read_addr_forward_dest_slave,

    //Read Data Channel Returning info
    input slave_read_data_fifo_empty [0:slaves-1],
    input [$clog2(masters)-1:0] read_data_return_dest_master [0:slaves-1],
    output master_read_data_fifo_full,
    output [$clog2(slaves)-1:0] grant_read_data_return_slave,
    output master_read_data_push_to_fifo,

    //Write Address Channel forwarding info
    input slave_write_addr_fifo_full,
    input [$clog2(masters)-1:0] slave_grant_write_addr_master_number [0:slaves-1],
    input [slaves-1:0] slave_write_addr_push_to_fifo,
    output master_write_addr_fifo_empty,
    output [$clog2(slaves)-1:0] write_addr_forward_dest_slave,

    //Write Data Channel forwarding info
    input slave_write_data_fifo_full,
    output master_write_data_fifo_empty,
    output [$clog2(slaves)-1:0] write_data_forward_dest_slave,

    //Write Resp Channel Returning info
    input slave_write_resp_fifo_empty [0:slaves-1],
    input [$clog2(masters)-1:0] write_resp_return_dest_master [0:slaves-1],
    output master_write_resp_fifo_full,
    output [$clog2(slaves)-1:0] grant_write_resp_return_slave,
    output master_write_resp_push_to_fifo,
    
    ////////// To Outer Master //////////
    //Read Address Channel
    input [ID_WIDTH-1:0] ARID_M,
	input [ADDR_WIDTH-1:0] ARADDR_M,
	input [LEN_WIDTH-1:0] ARLEN_M,
	input [SIZE_WIDTH-1:0] ARSIZE_M,
	input [1:0] ARBURST_M,
	input ARVALID_M,
	output ARREADY_M,

    //Read Data Channel
	output [ID_WIDTH-1:0] RID_M,
	output [DATA_WIDTH-1:0] RDATA_M,
	output [1:0] RRESP_M,
	output RLAST_M,
	output RVALID_M,
	input RREADY_M,

    //Write Address Channel
	input [ID_WIDTH-1:0] AWID_M,
	input [ADDR_WIDTH-1:0] AWADDR_M,
	input [LEN_WIDTH-1:0] AWLEN_M,
	input [SIZE_WIDTH-1:0] AWSIZE_M,
	input [1:0] AWBURST_M,
	input AWVALID_M,
	output AWREADY_M,
	
	//Write Data Channel
	input [DATA_WIDTH-1:0] WDATA_M,
	input [STRB_WIDTH-1:0] WSTRB_M,
	input WLAST_M,
	input WVALID_M,
	output WREADY_M,
	
	//Write Response Channel
	output [ID_WIDTH-1:0] BID_M,
	output [1:0] BRESP_M,
	output BVALID_M,
	input BREADY_M
);
////////// Registers //////////
reg [$clog2(slaves):0] current_write_op;
reg [(2**ID_WIDTH)-1:0] ar_id_table;
reg [(2**ID_WIDTH)-1:0] aw_id_table;

////////// Signals //////////
//ar_fifo
wire master_read_addr_fifo_full;
wire _master_read_addr_fifo_empty;
wire master_read_addr_fifo_pop;
//aw fifo
wire master_write_addr_fifo_full;
wire _master_write_addr_fifo_empty;
wire master_write_addr_fifo_pop;
//r fifo
wire master_read_data_fifo_empty;
//w fifo
wire master_write_data_fifo_full;
wire _master_write_data_fifo_empty;
//b fifo
wire master_write_resp_fifo_empty;
//arbiter grant result compare
reg [slaves-1:0] slave_read_addr_grant_me;
wire some_slaves_read_addr_grant_me;
wire some_slaves_read_addr_push_to_fifo;
reg [slaves-1:0] slave_write_addr_grant_me;
wire some_slaves_write_addr_grant_me;
wire some_slaves_write_addr_push_to_fifo;

////////// Module initiate //////////
assign ARREADY_M = ~master_read_addr_fifo_full;
// Block transfer when the previous request with same id have not been finished
assign master_read_addr_fifo_empty = _master_read_addr_fifo_empty | ar_id_table[ARID];
// Pop when (slave read_addr fifo is no full) & (some slaves grant me) & (some slaves say... "Push this araddr to fifo!!")
assign master_read_addr_fifo_pop = ~slave_read_addr_fifo_full & some_slaves_read_addr_grant_me & some_slaves_read_addr_push_to_fifo;
ar_fifo#(
    .pending_depth(pending_depth),
    .ID_WIDTH(ID_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .LEN_WIDTH(LEN_WIDTH),
    .SIZE_WIDTH(SIZE_WIDTH)
) master_forward_ar_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .ARID(ARID_M),
    .ARADDR(ARADDR_M),
    .ARLEN(ARLEN_M),
    .ARSIZE(ARSIZE_M),
    .ARBURST(ARBURST_M),

    //FIFO Control
    .push(ARVALID_M),
    .pop(master_read_addr_fifo_pop),
    .full(master_read_addr_fifo_full),
    .empty(_master_read_addr_fifo_empty),
    
    //Content
    .front_ARID(ARID),
    .front_ARADDR(ARADDR),
    .front_ARLEN(ARLEN),
    .front_ARSIZE(ARSIZE),
    .front_ARBURST(ARBURST)
);

assign AWREADY_M = ~master_write_addr_fifo_full;
//Block transfer when (previous WDATA transfer have not been complete yet) | (previous request with same id have not been finished)
assign master_write_addr_fifo_empty = (_master_write_addr_fifo_empty | current_write_op[0]) | aw_id_table[AWID];
//Pop when (slave fifo is not full) & (current_write_op[0] indicates that no write transfer in progress) & (some slaves grant me) & & (some slaves say... "Push this awaddr to fifo!!")
assign master_write_addr_fifo_pop = (~slave_write_addr_fifo_full & ~current_write_op[0] & some_slaves_write_addr_grant_me & some_slaves_write_addr_push_to_fifo);
aw_fifo#(
    .pending_depth(pending_depth),
    .ID_WIDTH(ID_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .LEN_WIDTH(LEN_WIDTH),
    .SIZE_WIDTH(SIZE_WIDTH)
) master_forward_aw_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .AWID(AWID_M),
    .AWADDR(AWADDR_M),
    .AWLEN(AWLEN_M),
    .AWSIZE(AWSIZE_M),
    .AWBURST(AWBURST_M),

    //FIFO Control
    .push(AWVALID_M),
    .pop(master_write_addr_fifo_pop),
    .full(master_write_addr_fifo_full),
    .empty(_master_write_addr_fifo_empty),
    
    //Content
    .front_AWID(AWID),
    .front_AWADDR(AWADDR),
    .front_AWLEN(AWLEN),
    .front_AWSIZE(AWSIZE),
    .front_AWBURST(AWBURST)
);

assign RVALID_M = ~master_read_data_fifo_empty;
r_fifo #(
    .pending_depth(pending_depth),
    .ID_WIDTH(ID_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
) slave_return_r_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .RID(RID),
    .RDATA(RDATA),
    .RRESP(RRESP),
    .RLAST(RLAST),

    //FIFO Control
    .push((~slave_read_data_fifo_empty[grant_read_data_return_slave]) & master_read_data_push_to_fifo),
    .pop(RREADY_M),
    .full(master_read_data_fifo_full),
    .empty(master_read_data_fifo_empty),
    
    //Content
    .front_RID(RID_M),
    .front_RDATA(RDATA_M),
    .front_RRESP(RRESP_M),
    .front_RLAST(RLAST_M)
);

assign WREADY_M = ~master_write_data_fifo_full;
//Block transfer when (master_write_data_fifo is empty) | (currently no write is in progress)
assign master_write_data_fifo_empty = (_master_write_data_fifo_empty | (~current_write_op[0]));
w_fifo #(
    .pending_depth(pending_depth),
    .DATA_WIDTH(DATA_WIDTH),
    .STRB_WIDTH(STRB_WIDTH)
) master_forward_w_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .WDATA(WDATA_M),
    .WSTRB(WSTRB_M),
    .WLAST(WLAST_M),

    //FIFO Control
    .push(WVALID_M),
    .pop((~slave_write_data_fifo_full) & current_write_op[0]),
    .full(master_write_data_fifo_full),
    .empty(_master_write_data_fifo_empty),
    
    //Content
    .front_WDATA(WDATA),
    .front_WSTRB(WSTRB),
    .front_WLAST(WLAST)
);

assign BVALID_M = ~master_write_resp_fifo_empty;
b_fifo #(
    .pending_depth(pending_depth),
    .ID_WIDTH(ID_WIDTH)
) slave_return_b_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .BID(BID),
    .BRESP(BRESP),

    //FIFO Control
    .push((~slave_write_resp_fifo_empty[grant_write_resp_return_slave]) & master_write_resp_push_to_fifo),
    .pop(BREADY_M),
    .full(master_write_resp_fifo_full),
    .empty(master_write_resp_fifo_empty),
    
    //Content
    .front_BID(BID_M),
    .front_BRESP(BRESP_M)
);

addr_decoder #(
    //AXI Setup
    .ADDR_WIDTH(ADDR_WIDTH),

    .slaves(slaves),
    .address_map_base(address_map_base),
    .address_map_end(address_map_end)
) master_read_addr_addr_decoder (
    .addr(ARADDR),
    .dest_slave(read_addr_forward_dest_slave)
);

addr_decoder #(
    //AXI Setup
    .ADDR_WIDTH(ADDR_WIDTH),

    .slaves(slaves),
    .address_map_base(address_map_base),
    .address_map_end(address_map_end)
) master_write_addr_addr_decoder (
    .addr(AWADDR),
    .dest_slave(write_addr_forward_dest_slave)
);

backward_arbiter #(
    .masters(masters),
    .slaves(slaves),
    .i_am_master_number(i_am_master_number)
) read_data_backward_arbiter (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //Slaves Return FIFO Info
    .slave_fifo_empty(slave_read_data_fifo_empty),
    .slave_master_dest(read_data_return_dest_master),

    //Master return FIFO Info
    .master_fifo_full(master_read_data_fifo_full),

    //Grant Slave
    .push_to_fifo(master_read_data_push_to_fifo),
    .grant_slave_number(grant_read_data_return_slave)
);

backward_arbiter #(
    .masters(masters),
    .slaves(slaves),
    .i_am_master_number(i_am_master_number)
) write_resp_backward_arbiter (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //Slaves Return FIFO Info
    .slave_fifo_empty(slave_write_resp_fifo_empty),
    .slave_master_dest(write_resp_return_dest_master),

    //Master return FIFO Info
    .push_to_fifo(master_write_resp_push_to_fifo),
    .master_fifo_full(master_write_resp_fifo_full),

    //Grant Slave
    .grant_slave_number(grant_write_resp_return_slave)
);

////////// Registers //////////
//current_write_op[$clog2(slaves):1] --> current slaves that occupied the write data channel
assign write_data_forward_dest_slave = current_write_op[$clog2(slaves):1];
always@(posedge ACLK) begin
    if(~ARESETn) begin
        current_write_op[$clog2(slaves):1] <= {$clog2(slaves){1'b0}};
    end

    else begin
        if(~master_write_addr_fifo_empty & ~slave_write_addr_fifo_full & some_slaves_write_addr_grant_me)
            current_write_op[$clog2(slaves):1] <= write_addr_forward_dest_slave;
    end
end
//current_write_op[0] --> write data channel is occupied or not
always@(posedge ACLK) begin
    if(~ARESETn) begin
        current_write_op[0] <= 1'b0;
    end

    else begin
        if(~master_write_addr_fifo_empty & ~slave_write_addr_fifo_full & some_slaves_write_addr_grant_me)
            current_write_op[0] <= 1'b1;
        else if(WLAST)
            current_write_op[0] <= 1'b0;
    end
end

//ar_id_table
always@(posedge ACLK) begin
    if(~ARESETn) begin
        ar_id_table <= {(2**ID_WIDTH){1'b0}};
    end

    else begin
        if(~slave_read_addr_fifo_full & ~master_read_addr_fifo_empty & some_slaves_read_addr_grant_me)
            ar_id_table[ARID] <= 1'b1;
        else if(RLAST & ~slave_read_data_fifo_empty[grant_read_data_return_slave] & ~master_read_data_fifo_full & master_read_data_push_to_fifo) // RLAST & (grant slave push) & master ~full & arbiter says...push to fifo!!
            ar_id_table[RID] <= 1'b0;
    end
end

//aw_id_table
always@(posedge ACLK) begin
    if(~ARESETn) begin
        aw_id_table <= {(2**ID_WIDTH){1'b0}};
    end

    else begin
        if(~master_write_addr_fifo_empty & ~slave_write_addr_fifo_full & some_slaves_write_addr_grant_me)
            aw_id_table[AWID] <= 1'b1;
        else if(~slave_write_resp_fifo_empty[grant_write_resp_return_slave] & ~master_write_resp_fifo_full & master_write_resp_push_to_fifo) // (grant slave push) & master ~full & arbiter says...push to fifo!!
            aw_id_table[BID] <= 1'b0;
    end
end

////////// Other Signals //////////
//Read Address grant compare
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        slave_read_addr_grant_me[i] = (slave_grant_read_addr_master_number[i] == i_am_master_number);
    end
end
assign some_slaves_read_addr_grant_me = (|slave_read_addr_grant_me);
//Write Address grant compare
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        slave_write_addr_grant_me[i] = (slave_grant_write_addr_master_number[i] == i_am_master_number);
    end
end
assign some_slaves_write_addr_grant_me = (|slave_write_addr_grant_me);

//Push to fifo <-- This signal is set when arbiter gives valid grant number
assign some_slaves_read_addr_push_to_fifo = (|slave_read_addr_push_to_fifo);
assign some_slaves_write_addr_push_to_fifo = (|slave_write_addr_push_to_fifo);
endmodule