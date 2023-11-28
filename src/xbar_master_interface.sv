module xbar_master_interface
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

    //Read Data Channel Payload
    output [ID_WIDTH-1:0]        RID,
    output [DATA_WIDTH-1:0]      RDATA,
    output [1:0]                 RRESP,
    output                       RLAST,

    //Write Response Channel Payload
    output [ID_WIDTH-1:0]        BID,
    output [1:0]                 BRESP,
    
    //Read Data Chaneel Returning info
    output read_data_fifo_empty,
    output [$clog2(masters)-1:0] read_data_return_dest_master,

    //Write Response Returning info
    output write_resp_fifo_empty,
    output [$clog2(masters)-1:0] write_resp_return_dest_master,

    ////////// To Outer Slave //////////
    //Read Address Channel
    output reg [IDS_WIDTH-1:0] ARID_S,
	output reg [ADDR_WIDTH-1:0] ARADDR_S,
	output reg [LEN_WIDTH-1:0] ARLEN_S,
	output reg [SIZE_WIDTH-1:0] ARSIZE_S,
	output reg [1:0] ARBURST_S,
	output ARVALID_S,
	input ARREADY_S,

    //Read Data Channel
	input [IDS_WIDTH-1:0] RID_S,
	input [DATA_WIDTH-1:0] RDATA_S,
	input [1:0] RRESP_S,
	input RLAST_S,
	input RVALID_S,
	output reg RREADY_S,

    //Write Address Channel
	output [IDS_WIDTH-1:0] AWID_S,
	output [ADDR_WIDTH-1:0] AWADDR_S,
	output [LEN_WIDTH-1:0] AWLEN_S,
	output [SIZE_WIDTH-1:0] AWSIZE_S,
	output [1:0] AWBURST_S,
	output AWVALID_S,
	input AWREADY_S,
	
	//Write Data Channel
	output reg [DATA_WIDTH-1:0] WDATA_S,
	output reg [STRB_WIDTH-1:0] WSTRB_S,
	output reg WLAST_S,
	output reg WVALID_S,
	input WREADY_S,
	
	//Write Response Channel
	input [IDS_WIDTH-1:0] BID_S,
	input [1:0] BRESP_S,
	input BVALID_S,
	output reg BREADY_S
);

endmodule