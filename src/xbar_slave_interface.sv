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

    //Read Address Channel forwarding info
    output read_addr_fifo_empty,
    output [$clog2(slaves)-1:0] read_addr_forwarding_dest_slave,

    //Write Address Channel forwarding info
    output write_addr_fifo_empty,
    output [$clog2(slaves)-1:0] write_addr_forwarding_dest_slave,

    //Write Data Channel forwarding info
    output write_data_fifo_empty,
    output [$clog2(slaves)-1:0] write_data_forwarding_dest_slave,

    ////////// To Outer Master //////////
    //Read Address Channel
    input reg [IDS_WIDTH-1:0] ARID_M,
	input reg [ADDR_WIDTH-1:0] ARADDR_M,
	input reg [LEN_WIDTH-1:0] ARLEN_M,
	input reg [SIZE_WIDTH-1:0] ARSIZE_M,
	input reg [1:0] ARBURST_M,
	input ARVALID_M,
	output ARREADY_M,

    //Read Data Channel
	output [IDS_WIDTH-1:0] RID_M,
	output [DATA_WIDTH-1:0] RDATA_M,
	output [1:0] RRESP_M,
	output RLAST_M,
	output RVALID_M,
	input reg RREADY_M,

    //Write Address Channel
	input [IDS_WIDTH-1:0] AWID_M,
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
	output [IDS_WIDTH-1:0] BID_M,
	output [1:0] BRESP_M,
	output BVALID_M,
	input reg BREADY_M
);

endmodule