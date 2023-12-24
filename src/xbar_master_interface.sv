module xbar_master_interface
#(
    //AXI Setup
    parameter ID_WIDTH = 4,
    parameter IDS_WIDTH = 5,
    parameter ADDR_WIDTH = 32,
    parameter LEN_WIDTH = 4,
    parameter SIZE_WIDTH = 3,
    parameter DATA_WIDTH = 32,
    parameter STRB_WIDTH = 4,

    parameter pending_depth = 8,
    parameter masters = 2,
    parameter slaves = 2,
    parameter i_am_slave_number = 0
)
(
    //Global Signal
    input ACLK,
    input ARESETn,

    ////////// Inter-XBar Communication //////////
    //Read Address Channel Payload
    input [ID_WIDTH-1:0]         ARID,
    input [ADDR_WIDTH-1:0]       ARADDR,
    input [LEN_WIDTH-1:0]        ARLEN,
    input [SIZE_WIDTH-1:0]       ARSIZE,
    input [1:0]                  ARBURST,

    //Read Data Channel Payload
    output [ID_WIDTH-1:0]        RID,
    output [DATA_WIDTH-1:0]      RDATA,
    output [1:0]                 RRESP,
    output                       RLAST,

    //Write Address Channel Payload
    input [ID_WIDTH-1:0]         AWID,
    input [ADDR_WIDTH-1:0]       AWADDR,
    input [LEN_WIDTH-1:0]        AWLEN,
    input [SIZE_WIDTH-1:0]       AWSIZE,
    input [1:0]                  AWBURST,

    //Write Data Channel Payload
    input [DATA_WIDTH-1:0]      WDATA,
    input [STRB_WIDTH-1:0]      WSTRB,
    input                       WLAST,

    //Write Response Channel Payload
    output [ID_WIDTH-1:0]        BID,
    output [1:0]                 BRESP,

    //Read Address Channel Forwarding info
    input master_read_addr_fifo_empty [0:masters-1],
    input [$clog2(slaves)-1:0] read_addr_forward_dest_slave [0:masters-1],
    output slave_read_addr_fifo_full,
    output [$clog2(masters)-1:0] grant_read_addr_forward_master,
    
    //Read Data Chaneel Returning info
    input master_read_data_fifo_full,
    input [$clog2(slaves)-1:0] master_grant_read_data_slave_number [0:masters-1],
    output slave_read_data_fifo_empty,
    output [$clog2(masters)-1:0] read_data_return_dest_master,

    //Write Address Channel Forwarding info
    input master_write_addr_fifo_empty [0:masters-1],
    input [$clog2(slaves)-1:0] write_addr_forward_dest_slave [0:masters-1],
    output slave_write_addr_fifo_full,
    output [$clog2(masters)-1:0] grant_write_addr_forward_master,

    //Write Data Channel Forwarding info
    input master_write_data_fifo_empty,
    output slave_write_data_fifo_full,
    output [$clog2(masters)-1:0] write_data_forward_src_master,

    //Write Response Returning info
    input master_write_resp_fifo_full,
    input [$clog2(slaves)-1:0] master_grant_write_resp_slave_number [0:masters-1],
    output slave_write_resp_fifo_empty,
    output [$clog2(masters)-1:0] write_resp_return_dest_master,

    ////////// To Outer Slave //////////
    //Read Address Channel
    output [IDS_WIDTH-1:0] ARID_S,
	output [ADDR_WIDTH-1:0] ARADDR_S,
	output [LEN_WIDTH-1:0] ARLEN_S,
	output [SIZE_WIDTH-1:0] ARSIZE_S,
	output [1:0] ARBURST_S,
	output ARVALID_S,
	input ARREADY_S,

    //Read Data Channel
	input [IDS_WIDTH-1:0] RID_S,
	input [DATA_WIDTH-1:0] RDATA_S,
	input [1:0] RRESP_S,
	input RLAST_S,
	input RVALID_S,
	output RREADY_S,

    //Write Address Channel
	output [IDS_WIDTH-1:0] AWID_S,
	output [ADDR_WIDTH-1:0] AWADDR_S,
	output [LEN_WIDTH-1:0] AWLEN_S,
	output [SIZE_WIDTH-1:0] AWSIZE_S,
	output [1:0] AWBURST_S,
	output AWVALID_S,
	input AWREADY_S,
	
	//Write Data Channel
	output [DATA_WIDTH-1:0] WDATA_S,
	output [STRB_WIDTH-1:0] WSTRB_S,
	output WLAST_S,
	output WVALID_S,
	input WREADY_S,
	
	//Write Response Channel
	input [IDS_WIDTH-1:0] BID_S,
	input [1:0] BRESP_S,
	input BVALID_S,
	output BREADY_S
);
////////// Registers //////////
reg [$clog2(masters):0] current_write_op;

////////// Signals //////////
//ar_fifo
wire read_addr_push_to_fifo;
wire slave_read_addr_fifo_empty;
//aw_fifo
wire write_addr_push_to_fifo;
wire slave_write_addr_fifo_empty;
wire _slave_write_addr_fifo_full;
//r_fifo
wire slave_read_data_fifo_full;
wire salve_read_data_fifo_pop;
wire [IDS_WIDTH-1:0] front_most_RID;
//w_fifo
wire slave_write_data_fifo_empty;
wire _slave_write_data_fifo_full;
//b_fifo
wire slave_write_resp_fifo_full;
wire slave_write_resp_fifo_pop;
wire [IDS_WIDTH-1:0] front_most_BID;
//arbiter grant result compare
reg [masters-1:0] master_grant_me_read_data;
wire some_masters_grant_me_read_data;
reg [masters-1:0] master_grant_me_write_resp;
wire some_masters_grant_me_write_resp;

////////// Module initiate //////////
assign ARVALID_S = ~slave_read_addr_fifo_empty;
ar_fifo#(
    .pending_depth(pending_depth),
    .ID_WIDTH(IDS_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .LEN_WIDTH(LEN_WIDTH),
    .SIZE_WIDTH(SIZE_WIDTH)
) master_forward_ar_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .ARID({grant_read_addr_forward_master, ARID}),
    .ARADDR(ARADDR),
    .ARLEN(ARLEN),
    .ARSIZE(ARSIZE),
    .ARBURST(ARBURST),

    //FIFO Control
    .push((~master_read_addr_fifo_empty[grant_read_addr_forward_master]) & read_addr_push_to_fifo),
    .pop(ARREADY_S),
    .full(slave_read_addr_fifo_full),
    .empty(slave_read_addr_fifo_empty),
    
    //Content
    .front_ARID(ARID_S),
    .front_ARADDR(ARADDR_S),
    .front_ARLEN(ARLEN_S),
    .front_ARSIZE(ARSIZE_S),
    .front_ARBURST(ARBURST_S)
);

assign AWVALID_S = ~slave_write_addr_fifo_empty;
assign slave_write_addr_fifo_full = _slave_write_addr_fifo_full | current_write_op[0];
aw_fifo#(
    .pending_depth(pending_depth),
    .ID_WIDTH(IDS_WIDTH),
    .ADDR_WIDTH(ADDR_WIDTH),
    .LEN_WIDTH(LEN_WIDTH),
    .SIZE_WIDTH(SIZE_WIDTH)
) master_forward_aw_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .AWID({grant_write_addr_forward_master, AWID}),
    .AWADDR(AWADDR),
    .AWLEN(AWLEN),
    .AWSIZE(AWSIZE),
    .AWBURST(AWBURST),

    //FIFO Control
    .push((~master_write_addr_fifo_empty[grant_write_addr_forward_master]) & write_addr_push_to_fifo),
    .pop(AWREADY_S),
    .full(_slave_write_addr_fifo_full),
    .empty(slave_write_addr_fifo_empty),
    
    //Content
    .front_AWID(AWID_S),
    .front_AWADDR(AWADDR_S),
    .front_AWLEN(AWLEN_S),
    .front_AWSIZE(AWSIZE_S),
    .front_AWBURST(AWBURST_S)
);

assign RREADY_S = ~slave_read_data_fifo_full;
assign RID = front_most_RID[ID_WIDTH-1:0];
// Pop when (master read_fifo is not full) & (some masters grant me)
assign salve_read_data_fifo_pop = (~master_read_data_fifo_full & some_masters_grant_me_read_data);
r_fifo #(
    .pending_depth(pending_depth),
    .ID_WIDTH(IDS_WIDTH),
    .DATA_WIDTH(DATA_WIDTH)
) slave_return_r_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .RID(RID_S),
    .RDATA(RDATA_S),
    .RRESP(RRESP_S),
    .RLAST(RLAST_S),

    //FIFO Control
    .push(RVALID_S),
    .pop(salve_read_data_fifo_pop),
    .full(slave_read_data_fifo_full),
    .empty(slave_read_data_fifo_empty),
    
    //Content
    .front_RID(front_most_RID),
    .front_RDATA(RDATA),
    .front_RRESP(RRESP),
    .front_RLAST(RLAST)
);

assign WVALID_S = ~slave_write_data_fifo_empty;
assign slave_write_data_fifo_full = (_slave_write_data_fifo_full | (~current_write_op[0]));
w_fifo #(
    .pending_depth(pending_depth),
    .DATA_WIDTH(DATA_WIDTH),
    .STRB_WIDTH(STRB_WIDTH)
) master_forward_w_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .WDATA(WDATA),
    .WSTRB(WSTRB),
    .WLAST(WLAST),

    //FIFO Control
    .push((~master_write_data_fifo_empty) & current_write_op[0]),
    .pop(WREADY_S),
    .full(_slave_write_data_fifo_full),
    .empty(slave_write_data_fifo_empty),
    
    //Content
    .front_WDATA(WDATA_S),
    .front_WSTRB(WSTRB_S),
    .front_WLAST(WLAST_S)
);

assign BREADY_S = ~slave_write_resp_fifo_full;
assign BID = front_most_BID[ID_WIDTH-1:0];
// Pop when (master resp_fifo is not full) & (some masters grant me)
assign slave_write_resp_fifo_pop = (~master_write_resp_fifo_full & some_masters_grant_me_write_resp);
b_fifo #(
    .pending_depth(pending_depth),
    .ID_WIDTH(IDS_WIDTH)
) slave_return_b_fifo (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //AXI Ports
    .BID(BID_S),
    .BRESP(BRESP_S),

    //FIFO Control
    .push(BVALID_S),
    .pop(slave_write_resp_fifo_pop),
    .full(slave_write_resp_fifo_full),
    .empty(slave_write_resp_fifo_empty),
    
    //Content
    .front_BID(front_most_BID),
    .front_BRESP(BRESP)
);

id_decoder #(
    //AXI Setup
    .ID_WIDTH(ID_WIDTH),
    .IDS_WIDTH(IDS_WIDTH),

    .masters(masters),
    .slaves(slaves)
) salve_read_data_id_decoder (
    .id(front_most_RID),
    .dest_master(read_data_return_dest_master)
);

id_decoder #(
    //AXI Setup
    .ID_WIDTH(ID_WIDTH),
    .IDS_WIDTH(IDS_WIDTH),

    .masters(masters),
    .slaves(slaves)
) salve_write_resp_id_decoder (
    .id(front_most_BID),
    .dest_master(write_resp_return_dest_master)
);

forward_arbiter #(
    .masters(masters),
    .slaves(slaves),
    .i_am_slave_number(i_am_slave_number)
) read_addr_forward_arbiter (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //Master Request FIFO Info
    .master_fifo_empty(master_read_addr_fifo_empty),
    .master_slave_dest(read_addr_forward_dest_slave),

    //Slave Request FIFO Info
    .push_to_fifo(read_addr_push_to_fifo),
    .slave_fifo_full(slave_read_addr_fifo_full),

    //Granted Master
    .grant_master_number(grant_read_addr_forward_master)
);

forward_arbiter #(
    .masters(masters),
    .slaves(slaves),
    .i_am_slave_number(i_am_slave_number)
) write_addr_forward_arbiter (
    //Global Signal
    .ACLK(ACLK),
    .ARESETn(ARESETn),

    //Master Request FIFO Info
    .master_fifo_empty(master_write_addr_fifo_empty),
    .master_slave_dest(write_addr_forward_dest_slave),

    //Slave Request FIFO Info
    .push_to_fifo(write_addr_push_to_fifo),
    .slave_fifo_full(slave_write_addr_fifo_full),

    //Granted Master
    .grant_master_number(grant_write_addr_forward_master)
);

////////// Registers //////////
assign write_data_forward_src_master = current_write_op[$clog2(masters):1];
always@(posedge ACLK) begin
    if(~ARESETn)
        current_write_op[$clog2(masters):1] <= {$clog2(masters){1'b0}};
    else begin
        if((~master_write_addr_fifo_empty[grant_write_addr_forward_master]) & ~slave_write_addr_fifo_full & write_addr_push_to_fifo)
            current_write_op[$clog2(masters):1] <= grant_write_addr_forward_master;
    end
end

always@(posedge ACLK) begin
    if(~ARESETn)
        current_write_op[0] <= 1'b0;
    else begin
        if((~master_write_addr_fifo_empty[grant_write_addr_forward_master]) & ~slave_write_addr_fifo_full & write_addr_push_to_fifo)
            current_write_op[0] <= 1'b1;
        else if(WLAST)
            current_write_op[0] <= 1'b0;
    end
end

////////// Other Signals //////////
//Read Data grant compare
always_comb begin
    for(int i = 0; i < masters; i++) begin
        master_grant_me_read_data[i] = (master_grant_read_data_slave_number[i] == i_am_slave_number);
    end
end
assign some_masters_grant_me_read_data = (|master_grant_me_read_data);
//Write Resp grant comparte
always_comb begin
    for(int i = 0; i < masters; i++) begin
        master_grant_me_write_resp[i] = (master_grant_write_resp_slave_number[i] == i_am_slave_number);
    end
end
assign some_masters_grant_me_write_resp = (|master_grant_me_write_resp);
endmodule