`include "xbar_slave_interface.svh"

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
    //Read Data Channel Payload
    input [ID_WIDTH-1:0]        RID,
    input [DATA_WIDTH-1:0]      RDATA,
    input [1:0]                 RRESP,
    input                       RLAST,

    //Write Response Channel Payload
    input [ID_WIDTH-1:0]        BID,
    input [1:0]                 BRESP,

    //Read Address Channel Payload
    output [ID_WIDTH-1:0]         ARID,
    output [ADDR_WIDTH-1:0]       ARADDR,
    output [LEN_WIDTH-1:0]        ARLEN,
    output [SIZE_WIDTH-1:0]       ARSIZE,
    output [1:0]                  ARBURST,

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

    //Read Data Channel Returning info
    input slave_read_data_fifo_empty [slaves-1:0],
    input [$clog2(masters)-1:0] read_data_return_dest_master [slaves-1:0],
    output master_read_data_fifo_full,
    output [$clog2(slaves)-1:0] grant_read_data_return_slave,

    //Write Resp Channel Returning info
    input slave_write_resp_fifo_empty [slaves-1:0],
    input [$clog2(masters)-1:0] write_resp_return_dest_master [slaves-1:0],
    output master_write_resp_fifo_full,
    output [$clog2(slaves)-1:0] grant_write_resp_return_slave,

    //Read Address Channel forwarding info
    input slave_read_addr_fifo_full,
    output master_read_addr_fifo_empty,
    output [$clog2(slaves)-1:0] read_addr_forward_dest_slave,

    //Write Address Channel forwarding info
    input slave_write_addr_fifo_full,
    output master_write_addr_fifo_empty,
    output [$clog2(slaves)-1:0] write_addr_forward_dest_slave,

    //Write Data Channel forwarding info
    input slave_write_data_fifo_full,
    output master_write_data_fifo_empty,
    output [$clog2(slaves)-1:0] write_data_forward_dest_slave,

    ////////// To Outer Master //////////
    //Read Address Channel
    input reg [ID_WIDTH-1:0] ARID_M,
	input reg [ADDR_WIDTH-1:0] ARADDR_M,
	input reg [LEN_WIDTH-1:0] ARLEN_M,
	input reg [SIZE_WIDTH-1:0] ARSIZE_M,
	input reg [1:0] ARBURST_M,
	input ARVALID_M,
	output ARREADY_M,

    //Read Data Channel
	output [ID_WIDTH-1:0] RID_M,
	output [DATA_WIDTH-1:0] RDATA_M,
	output [1:0] RRESP_M,
	output RLAST_M,
	output RVALID_M,
	input reg RREADY_M,

    //Write Address Channel
	input [ID_WIDTH-1:0] AWID_M,
	input [ADDR_WIDTH-1:0] AWADDR_M,
	input [LEN_WIDTH-1:0] AWLEN_M,
	input [SIZE_WIDTH-1:0] AWSIZE_M,
	input [1:0] AWBURST_M,
	input AWVALID_M,
	output AWREADY_M,
	
	//Write Data Channel
	input reg [DATA_WIDTH-1:0] WDATA_M,
	input reg [STRB_WIDTH-1:0] WSTRB_M,
	input reg WLAST_M,
	input reg WVALID_M,
	output WREADY_M,
	
	//Write Response Channel
	output [ID_WIDTH-1:0] BID_M,
	output [1:0] BRESP_M,
	output BVALID_M,
	input reg BREADY_M
);
////////// Registers //////////
reg [$clog2(slaves):0] current_write_op;

////////// Signals //////////
//ar_fifo
wire master_read_addr_fifo_full;
//aw fifo
wire master_write_addr_fifo_full;
wire _master_write_addr_fifo_empty;
//r fifo
wire master_read_data_fifo_empty;
//w fifo
wire master_write_data_fifo_full;
wire _master_write_data_fifo_empty;
//b fifo
wire master_write_resp_fifo_empty;

////////// Module initiate //////////
assign ARREADY_M = ~master_read_addr_fifo_full;
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
    .pop(~slave_read_addr_fifo_full),
    .full(master_read_addr_fifo_full),
    .empty(master_read_addr_fifo_empty),
    
    //Content
    .front_ARID(ARID),
    .front_ARADDR(ARADDR),
    .front_ARLEN(ARLEN),
    .front_ARSIZE(ARSIZE),
    .front_ARBURST(ARBURST)
);

assign AWREADY_M = ~master_write_addr_fifo_full;
assign master_write_addr_fifo_empty = _master_write_addr_fifo_empty | current_write_op[0];
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
    .pop(~slave_write_addr_fifo_full),
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
    .push(~slave_read_data_fifo_empty[grant_read_data_return_slave]),
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
    .pop(~slave_write_data_fifo_full),
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
    .push(~slave_write_resp_fifo_empty[grant_write_resp_return_slave]),
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
) master_read_req_addr_decoder (
    .addr(ARADDR),
    .dest_slave(read_addr_forward_dest_slave)
);

addr_decoder #(
    //AXI Setup
    .ADDR_WIDTH(ADDR_WIDTH),

    .slaves(slaves),
    .address_map_base(address_map_base),
    .address_map_end(address_map_end)
) master_write_req_addr_decoder (
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
    .master_fifo_full(master_write_resp_fifo_full),

    //Grant Slave
    .grant_slave_number(grant_write_resp_return_slave)
);

////////// Registers //////////
//current_write_op[$clog2(slaves):1] --> current slaves that occupied the write data channel
always@(posedge ACLK) begin
    if(~ARESETn) begin
        current_write_op[$clog2(slaves):1] <= {$clog2(slaves){1'b0}};
    end

    else begin
        if(~master_write_addr_fifo_empty & ~slave_write_addr_fifo_full)
            current_write_op[$clog2(slaves):1] <= write_addr_forward_dest_slave;
    end
end
//current_write_op[0] --> write data channel is occupied or not
always@(posedge ACLK) begin
    if(~ARESETn) begin
        current_write_op[0] <= 1'b0;
    end

    else begin
        if(~master_write_addr_fifo_empty & ~slave_write_addr_fifo_full)
            current_write_op[0] <= 1'b1;
        else if(WLAST)
            current_write_op[0] <= 1'b0;
    end
end
endmodule