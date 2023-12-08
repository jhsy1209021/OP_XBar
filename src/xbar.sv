module xbar
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
    parameter [ADDR_WIDTH-1:0] address_map_base [0:slaves-1] = {'h0000_0000, 'h1000_0000},
    parameter [ADDR_WIDTH-1:0] address_map_end [0:slaves-1] = {'h0fff_ffff, 'h1fff_ffff}
)
(
    //Global Signal
    input ACLK,
    input ARESETn,
    
    //Masters clk & nrst
    input clk_ex_master [0:masters-1],
    input nrst_ex_master [0:masters-1],
    //Slaves clk & nrst
    input clk_ex_slave [0:slaves-1],
    input nrst_ex_slave [0:slaves-1],

    //To Outer Master Device
    //Read Address Channel
	input [ID_WIDTH-1:0]    ARID_M      [0:masters-1],
	input [ADDR_WIDTH-1:0]  ARADDR_M    [0:masters-1],
	input [LEN_WIDTH-1:0]   ARLEN_M     [0:masters-1],
	input [SIZE_WIDTH-1:0]  ARSIZE_M    [0:masters-1],
	input [1:0]             ARBURST_M   [0:masters-1],
	input                   ARVALID_M   [0:masters-1],
	output                  ARREADY_M   [0:masters-1],
	//Read Data Channel
	output [ID_WIDTH-1:0]   RID_M       [0:masters-1],
	output [DATA_WIDTH-1:0] RDATA_M     [0:masters-1],
	output [1:0]            RRESP_M     [0:masters-1],
	output                  RLAST_M     [0:masters-1],
	output                  RVALID_M    [0:masters-1],
	input                   RREADY_M    [0:masters-1],
	//Write Address Channel
	input [ID_WIDTH-1:0]    AWID_M      [0:masters-1],
	input [ADDR_WIDTH-1:0]  AWADDR_M    [0:masters-1],
	input [LEN_WIDTH-1:0]   AWLEN_M     [0:masters-1],
	input [SIZE_WIDTH-1:0]  AWSIZE_M    [0:masters-1],
	input [1:0]             AWBURST_M   [0:masters-1],
	input                   AWVALID_M   [0:masters-1],
	output                  AWREADY_M   [0:masters-1],
	//Write Data Channel
	input [DATA_WIDTH-1:0]  WDATA_M     [0:masters-1],
	input [STRB_WIDTH-1:0]  WSTRB_M     [0:masters-1],
	input                   WLAST_M     [0:masters-1],
	input                   WVALID_M    [0:masters-1],
	output                  WREADY_M    [0:masters-1],
	//Write Response Channel
	output [ID_WIDTH-1:0]   BID_M       [0:masters-1],
	output [1:0]            BRESP_M     [0:masters-1],
	output                  BVALID_M    [0:masters-1],
	input                   BREADY_M    [0:masters-1],

    //To Outer Slave Device
    //Read Address Channel
	output [IDS_WIDTH-1:0]  ARID_S      [0:slaves-1],
	output [ADDR_WIDTH-1:0] ARADDR_S    [0:slaves-1],
	output [LEN_WIDTH-1:0]  ARLEN_S     [0:slaves-1],
	output [SIZE_WIDTH-1:0] ARSIZE_S    [0:slaves-1],
	output [1:0]            ARBURST_S   [0:slaves-1],
	output                  ARVALID_S   [0:slaves-1],
	input                   ARREADY_S   [0:slaves-1],
	//READ DATA0
	input [IDS_WIDTH-1:0]   RID_S       [0:slaves-1],
	input [DATA_WIDTH-1:0]  RDATA_S     [0:slaves-1],
	input [1:0]             RRESP_S     [0:slaves-1],
	input                   RLAST_S     [0:slaves-1],
	input                   RVALID_S    [0:slaves-1],
	output                  RREADY_S    [0:slaves-1],
	//WRITE ADDRESS0
	output [IDS_WIDTH-1:0]  AWID_S      [0:slaves-1],
	output [ADDR_WIDTH-1:0] AWADDR_S    [0:slaves-1],
	output [LEN_WIDTH-1:0]  AWLEN_S     [0:slaves-1],
	output [SIZE_WIDTH-1:0] AWSIZE_S    [0:slaves-1],
	output [1:0]            AWBURST_S   [0:slaves-1],
	output                  AWVALID_S   [0:slaves-1],
	input                   AWREADY_S   [0:slaves-1],
	//WRITE DATA0
	output [DATA_WIDTH-1:0] WDATA_S     [0:slaves-1],
	output [STRB_WIDTH-1:0] WSTRB_S     [0:slaves-1],
	output                  WLAST_S     [0:slaves-1],
	output                  WVALID_S    [0:slaves-1],
	input                   WREADY_S    [0:slaves-1],
	//WRITE RESPONSE0
	input [IDS_WIDTH-1:0]   BID_S       [0:slaves-1],
	input [1:0]             BRESP_S     [0:slaves-1],
	input                   BVALID_S    [0:slaves-1],
	output                  BREADY_S    [0:slaves-1]
);
//Signals --> S_ixc(Slave interface inter-xbar communication)
//Read Address Channel
wire [ID_WIDTH-1:0]     ARID_S_ixc    [0:masters-1];
wire [ADDR_WIDTH-1:0]   ARADDR_S_ixc  [0:masters-1];
wire [LEN_WIDTH-1:0]    ARLEN_S_ixc   [0:masters-1];
wire [SIZE_WIDTH-1:0]   ARSIZE_S_ixc  [0:masters-1];
wire [1:0]              ARBURST_S_ixc [0:masters-1];
//Read Data Channel
reg [ID_WIDTH-1:0]     RID_S_ixc     [0:masters-1];
reg [DATA_WIDTH-1:0]   RDATA_S_ixc   [0:masters-1];
reg [1:0]              RRESP_S_ixc   [0:masters-1];
reg                    RLAST_S_ixc   [0:masters-1];
//Write Address Channel
wire [ID_WIDTH-1:0]     AWID_S_ixc    [0:masters-1];
wire [ADDR_WIDTH-1:0]   AWADDR_S_ixc  [0:masters-1];
wire [LEN_WIDTH-1:0]    AWLEN_S_ixc   [0:masters-1];
wire [SIZE_WIDTH-1:0]   AWSIZE_S_ixc  [0:masters-1];
wire [1:0]              AWBURST_S_ixc [0:masters-1];
//Write Data Channel
wire [DATA_WIDTH-1:0]   WDATA_S_ixc   [0:masters-1];
wire [STRB_WIDTH-1:0]   WSTRB_S_ixc   [0:masters-1];
wire                    WLAST_S_ixc   [0:masters-1];
//Write Resp Channel
reg [ID_WIDTH-1:0]     BID_S_ixc     [0:masters-1];
reg [1:0]              BRESP_S_ixc   [0:masters-1];

//Signals --> M_ixc(Master interface inter-xbar communication)
//Read Address Channel
reg [ID_WIDTH-1:0]     ARID_M_ixc    [0:slaves-1];
reg [ADDR_WIDTH-1:0]   ARADDR_M_ixc  [0:slaves-1];
reg [LEN_WIDTH-1:0]    ARLEN_M_ixc   [0:slaves-1];
reg [SIZE_WIDTH-1:0]   ARSIZE_M_ixc  [0:slaves-1];
reg [1:0]              ARBURST_M_ixc [0:slaves-1];
//Read Data Channel
wire [ID_WIDTH-1:0]     RID_M_ixc     [0:slaves-1];
wire [DATA_WIDTH-1:0]   RDATA_M_ixc   [0:slaves-1];
wire [1:0]              RRESP_M_ixc   [0:slaves-1];
wire                    RLAST_M_ixc   [0:slaves-1];
//Write Address Channel
reg [ID_WIDTH-1:0]     AWID_M_ixc    [0:slaves-1];
reg [ADDR_WIDTH-1:0]   AWADDR_M_ixc  [0:slaves-1];
reg [LEN_WIDTH-1:0]    AWLEN_M_ixc   [0:slaves-1];
reg [SIZE_WIDTH-1:0]   AWSIZE_M_ixc  [0:slaves-1];
reg [1:0]              AWBURST_M_ixc [0:slaves-1];
//Write Data Channel
reg [DATA_WIDTH-1:0]   WDATA_M_ixc   [0:slaves-1];
reg [STRB_WIDTH-1:0]   WSTRB_M_ixc   [0:slaves-1];
reg                    WLAST_M_ixc   [0:slaves-1];
//Write Resp Channel
wire [ID_WIDTH-1:0]     BID_M_ixc     [0:slaves-1];
wire [1:0]              BRESP_M_ixc   [0:slaves-1];

//Signals --> fifo infos of slave interface
//Read Address Channel
wire master_read_addr_fifo_empty_S [0:masters-1];
reg slave_read_addr_fifo_full_S [0:masters-1];
//Read Data Channel
wire master_read_data_fifo_full_S [0:masters-1];
//Write Address Channel
wire master_write_addr_fifo_empty_S [0:masters-1];
reg slave_write_addr_fifo_full_S [0:masters-1];
//Write Data Channel
wire master_write_data_fifo_empty_S [0:masters-1];
reg slave_write_data_fifo_full_S [0:masters-1];
//Write Response Channel
wire master_write_resp_fifo_full_S [0:masters-1];

//Signals --> fifo infos of master interface
//Read Address Channel
wire slave_read_addr_fifo_full_M [0:slaves-1];
//Read Data Channel
reg master_read_data_fifo_full_M [0:slaves-1];
wire slave_read_data_fifo_empty_M [0:slaves-1];
//Write Address Channel
wire slave_write_addr_fifo_full_M [0:slaves-1];
//Write Data Channel
reg master_write_data_fifo_empty_M [0:slaves-1];
wire slave_write_data_fifo_full_M [0:slaves-1];
//Write Response Channel
reg master_write_resp_fifo_full_M [0:slaves-1];
wire slave_write_resp_fifo_empty_M [0:slaves-1];

//Signals --> Payload Destination
//Read Address Channel
wire [$clog2(slaves)-1:0] read_addr_forward_dest_slave [0:masters-1];
//Read Data Channel
wire [$clog2(masters)-1:0] read_data_return_dest_master [0:slaves-1];
//Write Address Channel
wire [$clog2(slaves)-1:0] write_addr_forward_dest_slave [0:masters-1];
//Write Data Channel
wire [$clog2(slaves)-1:0] write_data_forward_dest_slave [0:masters-1];
wire [$clog2(masters)-1:0] write_data_forward_src_master [0:slaves-1];
//Write Response Channel
wire [$clog2(masters)-1:0] write_resp_return_dest_master [0:slaves-1];

//Signals --> Arbitration Result
//Read Address Channel
wire [$clog2(masters):0] grant_read_addr_forward_master [0:slaves-1];
wire [slaves-1:0] slave_read_addr_push_to_fifo;
//Read Data Channel
wire [$clog2(slaves):0] grant_read_data_return_slave [0:masters-1];
wire [masters-1:0] master_read_data_push_to_fifo;
//Write Address Channel
wire [$clog2(masters):0] grant_write_addr_forward_master [0:slaves-1];
wire [slaves-1:0] slave_write_addr_push_to_fifo;
//Write Response Channel
wire [$clog2(slaves):0] grant_write_resp_return_slave [0:masters-1];
wire [masters-1:0] master_write_resp_push_to_fifo;

////////// Instantiate Slave Interface to Connect to Outer Master Devices //////////
genvar number_of_master;
generate
    for(number_of_master = 0; number_of_master < masters; number_of_master = number_of_master + 1) begin : slave_interfaces
        xbar_slave_interface #(
            //AXI Setup
            .ID_WIDTH(ID_WIDTH),
            .IDS_WIDTH(IDS_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .LEN_WIDTH(LEN_WIDTH),
            .SIZE_WIDTH(SIZE_WIDTH),
            .DATA_WIDTH(DATA_WIDTH),
            .STRB_WIDTH(STRB_WIDTH),

            .masters(masters),
            .slaves(slaves),
            .i_am_master_number(number_of_master),
            .address_map_base(address_map_base),
            .address_map_end(address_map_end)
        ) generate_slave_interfaces (
            //Global Signal
            .ACLK(ACLK),
            .ARESETn(ARESETn),
            .clk_ex_master(clk_ex_master[number_of_master]),
            .nrst_ex_master(nrst_ex_master[number_of_master]),

            ////////// Inter-XBar Communication //////////
            //Read Address Channel Payload
            .ARID(ARID_S_ixc[number_of_master]),
            .ARADDR(ARADDR_S_ixc[number_of_master]),
            .ARLEN(ARLEN_S_ixc[number_of_master]),
            .ARSIZE(ARSIZE_S_ixc[number_of_master]),
            .ARBURST(ARBURST_S_ixc[number_of_master]),

            //Read Data Channel Payload
            .RID(RID_S_ixc[number_of_master]),
            .RDATA(RDATA_S_ixc[number_of_master]),
            .RRESP(RRESP_S_ixc[number_of_master]),
            .RLAST(RLAST_S_ixc[number_of_master]),

            //Write Address Channel Payload
            .AWID(AWID_S_ixc[number_of_master]),
            .AWADDR(AWADDR_S_ixc[number_of_master]),
            .AWLEN(AWLEN_S_ixc[number_of_master]),
            .AWSIZE(AWSIZE_S_ixc[number_of_master]),
            .AWBURST(AWBURST_S_ixc[number_of_master]),

            //Write Data Channel Payload
            .WDATA(WDATA_S_ixc[number_of_master]),
            .WSTRB(WSTRB_S_ixc[number_of_master]),
            .WLAST(WLAST_S_ixc[number_of_master]),

            //Write Response Channel Payload
            .BID(BID_S_ixc[number_of_master]),
            .BRESP(BRESP_S_ixc[number_of_master]),

            //Read Address Channel forwarding info
            .slave_read_addr_fifo_full(slave_read_addr_fifo_full_S[number_of_master]),
            .slave_grant_read_addr_master_number(grant_read_addr_forward_master),
            .slave_read_addr_push_to_fifo(slave_read_addr_push_to_fifo),
            .master_read_addr_fifo_empty(master_read_addr_fifo_empty_S[number_of_master]),
            .read_addr_forward_dest_slave(read_addr_forward_dest_slave[number_of_master]),

            //Read Data Channel Returning info
            .slave_read_data_fifo_empty(slave_read_data_fifo_empty_M),
            .read_data_return_dest_master(read_data_return_dest_master),
            .master_read_data_fifo_full(master_read_data_fifo_full_S[number_of_master]),
            .grant_read_data_return_slave(grant_read_data_return_slave[number_of_master]),
            .master_read_data_push_to_fifo(master_read_data_push_to_fifo[number_of_master]),

            //Write Address Channel forwarding info
            .slave_write_addr_fifo_full(slave_write_addr_fifo_full_S[number_of_master]),
            .slave_grant_write_addr_master_number(grant_write_addr_forward_master),
            .slave_write_addr_push_to_fifo(slave_write_addr_push_to_fifo),
            .master_write_addr_fifo_empty(master_write_addr_fifo_empty_S[number_of_master]),
            .write_addr_forward_dest_slave(write_addr_forward_dest_slave[number_of_master]),

            //Write Data Channel forwarding info
            .slave_write_data_fifo_full(slave_write_data_fifo_full_S[number_of_master]),
            .master_write_data_fifo_empty(master_write_data_fifo_empty_S[number_of_master]),
            .write_data_forward_dest_slave(write_data_forward_dest_slave[number_of_master]),

            //Write Resp Channel Returning info
            .slave_write_resp_fifo_empty(slave_write_resp_fifo_empty_M),
            .write_resp_return_dest_master(write_resp_return_dest_master),
            .master_write_resp_fifo_full(master_write_resp_fifo_full_S[number_of_master]),
            .grant_write_resp_return_slave(grant_write_resp_return_slave[number_of_master]),
            .master_write_resp_push_to_fifo(master_write_resp_push_to_fifo[number_of_master]),
            
            ////////// To Outer Master //////////
            //Read Address Channel
            .ARID_M(ARID_M[number_of_master]),
            .ARADDR_M(ARADDR_M[number_of_master]),
            .ARLEN_M(ARLEN_M[number_of_master]),
            .ARSIZE_M(ARSIZE_M[number_of_master]),
            .ARBURST_M(ARBURST_M[number_of_master]),
            .ARVALID_M(ARVALID_M[number_of_master]),
            .ARREADY_M(ARREADY_M[number_of_master]),

            //Read Data Channel
            .RID_M(RID_M[number_of_master]),
            .RDATA_M(RDATA_M[number_of_master]),
            .RRESP_M(RRESP_M[number_of_master]),
            .RLAST_M(RLAST_M[number_of_master]),
            .RVALID_M(RVALID_M[number_of_master]),
            .RREADY_M(RREADY_M[number_of_master]),

            //Write Address Channel
            .AWID_M(AWID_M[number_of_master]),
            .AWADDR_M(AWADDR_M[number_of_master]),
            .AWLEN_M(AWLEN_M[number_of_master]),
            .AWSIZE_M(AWSIZE_M[number_of_master]),
            .AWBURST_M(AWBURST_M[number_of_master]),
            .AWVALID_M(AWVALID_M[number_of_master]),
            .AWREADY_M(AWREADY_M[number_of_master]),
            
            //Write Data Channel
            .WDATA_M(WDATA_M[number_of_master]),
            .WSTRB_M(WSTRB_M[number_of_master]),
            .WLAST_M(WLAST_M[number_of_master]),
            .WVALID_M(WVALID_M[number_of_master]),
            .WREADY_M(WREADY_M[number_of_master]),
            
            //Write Response Channel
            .BID_M(BID_M[number_of_master]),
            .BRESP_M(BRESP_M[number_of_master]),
            .BVALID_M(BVALID_M[number_of_master]),
            .BREADY_M(BREADY_M[number_of_master])
        );
    end
endgenerate

//Instantiate Master Interface to Connect to Outer Slave Devices
genvar number_of_slave;
generate
    for(number_of_slave = 0; number_of_slave < slaves; number_of_slave = number_of_slave + 1) begin : master_interfaces
        xbar_master_interface #(
            //AXI Setup
            .ID_WIDTH(ID_WIDTH),
            .IDS_WIDTH(IDS_WIDTH),
            .ADDR_WIDTH(ADDR_WIDTH),
            .LEN_WIDTH(LEN_WIDTH),
            .SIZE_WIDTH(SIZE_WIDTH),
            .DATA_WIDTH(DATA_WIDTH),
            .STRB_WIDTH(STRB_WIDTH),

            .masters(masters),
            .slaves(slaves),
            .i_am_slave_number(number_of_slave)
        ) generate_master_interfaces (
            //Global Signal
            .ACLK(ACLK),
            .ARESETn(ARESETn),
            .clk_ex_slave(clk_ex_slave[number_of_slave]),
            .nrst_ex_slave(nrst_ex_slave[number_of_slave]),

            ////////// Inter-XBar Communication //////////
            //Read Address Channel Payload
            .ARID(ARID_M_ixc[number_of_slave]),
            .ARADDR(ARADDR_M_ixc[number_of_slave]),
            .ARLEN(ARLEN_M_ixc[number_of_slave]),
            .ARSIZE(ARSIZE_M_ixc[number_of_slave]),
            .ARBURST(ARBURST_M_ixc[number_of_slave]),

            //Read Data Channel Payload
            .RID(RID_M_ixc[number_of_slave]),
            .RDATA(RDATA_M_ixc[number_of_slave]),
            .RRESP(RRESP_M_ixc[number_of_slave]),
            .RLAST(RLAST_M_ixc[number_of_slave]),

            //Write Address Channel Payload
            .AWID(AWID_M_ixc[number_of_slave]),
            .AWADDR(AWADDR_M_ixc[number_of_slave]),
            .AWLEN(AWLEN_M_ixc[number_of_slave]),
            .AWSIZE(AWSIZE_M_ixc[number_of_slave]),
            .AWBURST(AWBURST_M_ixc[number_of_slave]),

            //Write Data Channel Payload
            .WDATA(WDATA_M_ixc[number_of_slave]),
            .WSTRB(WSTRB_M_ixc[number_of_slave]),
            .WLAST(WLAST_M_ixc[number_of_slave]),

            //Write Response Channel Payload
            .BID(BID_M_ixc[number_of_slave]),
            .BRESP(BRESP_M_ixc[number_of_slave]),

            //Read Address Channel Forwarding info
            .master_read_addr_fifo_empty(master_read_addr_fifo_empty_S),
            .read_addr_forward_dest_slave(read_addr_forward_dest_slave),
            .slave_read_addr_push_to_fifo(slave_read_addr_push_to_fifo[number_of_slave]),
            .slave_read_addr_fifo_full(slave_read_addr_fifo_full_M[number_of_slave]),
            .grant_read_addr_forward_master(grant_read_addr_forward_master[number_of_slave]),
            
            //Read Data Chaneel Returning info
            .master_read_data_fifo_full(master_read_data_fifo_full_M[number_of_slave]),
            .master_grant_read_data_slave_number(grant_read_data_return_slave),
            .master_read_data_push_to_fifo(master_read_data_push_to_fifo),
            .slave_read_data_fifo_empty(slave_read_data_fifo_empty_M[number_of_slave]),
            .read_data_return_dest_master(read_data_return_dest_master[number_of_slave]),

            //Write Address Channel Forwarding info
            .master_write_addr_fifo_empty(master_write_addr_fifo_empty_S),
            .write_addr_forward_dest_slave(write_addr_forward_dest_slave),
            .slave_write_addr_fifo_full(slave_write_addr_fifo_full_M[number_of_slave]),
            .grant_write_addr_forward_master(grant_write_addr_forward_master[number_of_slave]),
            .slave_write_addr_push_to_fifo(slave_write_addr_push_to_fifo[number_of_slave]),

            //Write Data Channel Forwarding info
            .master_write_data_fifo_empty(master_write_data_fifo_empty_M[number_of_slave]),
            .slave_write_data_fifo_full(slave_write_data_fifo_full_M[number_of_slave]),
            .write_data_forward_src_master(write_data_forward_src_master[number_of_slave]),

            //Write Response Returning info
            .master_write_resp_fifo_full(master_write_resp_fifo_full_M[number_of_slave]),
            .master_grant_write_resp_slave_number(grant_write_resp_return_slave),
            .master_write_resp_push_to_fifo(master_write_resp_push_to_fifo),
            .slave_write_resp_fifo_empty(slave_write_resp_fifo_empty_M[number_of_slave]),
            .write_resp_return_dest_master(write_resp_return_dest_master[number_of_slave]),
            
            ////////// To Outer Slave //////////
            //Read Address Channel
            .ARID_S(ARID_S[number_of_slave]),
            .ARADDR_S(ARADDR_S[number_of_slave]),
            .ARLEN_S(ARLEN_S[number_of_slave]),
            .ARSIZE_S(ARSIZE_S[number_of_slave]),
            .ARBURST_S(ARBURST_S[number_of_slave]),
            .ARVALID_S(ARVALID_S[number_of_slave]),
            .ARREADY_S(ARREADY_S[number_of_slave]),

            //Read Data Channel
            .RID_S(RID_S[number_of_slave]),
            .RDATA_S(RDATA_S[number_of_slave]),
            .RRESP_S(RRESP_S[number_of_slave]),
            .RLAST_S(RLAST_S[number_of_slave]),
            .RVALID_S(RVALID_S[number_of_slave]),
            .RREADY_S(RREADY_S[number_of_slave]),

            //Write Address Channel
            .AWID_S(AWID_S[number_of_slave]),
            .AWADDR_S(AWADDR_S[number_of_slave]),
            .AWLEN_S(AWLEN_S[number_of_slave]),
            .AWSIZE_S(AWSIZE_S[number_of_slave]),
            .AWBURST_S(AWBURST_S[number_of_slave]),
            .AWVALID_S(AWVALID_S[number_of_slave]),
            .AWREADY_S(AWREADY_S[number_of_slave]),
            
            //Write Data Channel
            .WDATA_S(WDATA_S[number_of_slave]),
            .WSTRB_S(WSTRB_S[number_of_slave]),
            .WLAST_S(WLAST_S[number_of_slave]),
            .WVALID_S(WVALID_S[number_of_slave]),
            .WREADY_S(WREADY_S[number_of_slave]),
            
            //Write Response Channel
            .BID_S(BID_S[number_of_slave]),
            .BRESP_S(BRESP_S[number_of_slave]),
            .BVALID_S(BVALID_S[number_of_slave]),
            .BREADY_S(BREADY_S[number_of_slave])
        );
    end
endgenerate

////////// AXI XBar Muxes //////////
// --> Return <-- //
//ixc_return --> Read Data Channel
always_comb begin
    for(int i = 0; i < masters; i++) begin
        RID_S_ixc[i] = RID_M_ixc[grant_read_data_return_slave[i][$clog2(slaves)-1:0]];
        RDATA_S_ixc[i] = RDATA_M_ixc[grant_read_data_return_slave[i][$clog2(slaves)-1:0]];
        RRESP_S_ixc[i] = RRESP_M_ixc[grant_read_data_return_slave[i][$clog2(slaves)-1:0]];
        RLAST_S_ixc[i] = RLAST_M_ixc[grant_read_data_return_slave[i][$clog2(slaves)-1:0]];
    end
end
//ixc_return --> Write Response Channel
always_comb begin
    for(int i = 0; i < masters; i++) begin
        BID_S_ixc[i] = BID_M_ixc[grant_write_resp_return_slave[i][$clog2(slaves)-1:0]];
        BRESP_S_ixc[i] = BRESP_M_ixc[grant_write_resp_return_slave[i][$clog2(slaves)-1:0]];
    end
end
//fifo_info_return --> Read Address Channel, Write Address Channel, Write Data Channel
always_comb begin
    for(int i = 0; i < masters; i++) begin
        slave_read_addr_fifo_full_S[i] = slave_read_addr_fifo_full_M[read_addr_forward_dest_slave[i]];
        slave_write_addr_fifo_full_S[i] = slave_write_addr_fifo_full_M[write_addr_forward_dest_slave[i]];
        slave_write_data_fifo_full_S[i] = slave_write_data_fifo_full_M[write_data_forward_dest_slave[i]];
    end
end

// --> Forward <-- //
//ixc_forward --> Read Address Channel
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        ARID_M_ixc[i] = ARID_S_ixc[grant_read_addr_forward_master[i][$clog2(masters)-1:0]];
        ARADDR_M_ixc[i] = ARADDR_S_ixc[grant_read_addr_forward_master[i][$clog2(masters)-1:0]];
        ARLEN_M_ixc[i] = ARLEN_S_ixc[grant_read_addr_forward_master[i][$clog2(masters)-1:0]];
        ARSIZE_M_ixc[i] = ARSIZE_S_ixc[grant_read_addr_forward_master[i][$clog2(masters)-1:0]];
        ARBURST_M_ixc[i] = ARBURST_S_ixc[grant_read_addr_forward_master[i][$clog2(masters)-1:0]];
    end
end
//ixc_forward --> Write Address Channel
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        AWID_M_ixc[i] = AWID_S_ixc[grant_write_addr_forward_master[i][$clog2(masters)-1:0]];
        AWADDR_M_ixc[i] = AWADDR_S_ixc[grant_write_addr_forward_master[i][$clog2(masters)-1:0]];
        AWLEN_M_ixc[i] = AWLEN_S_ixc[grant_write_addr_forward_master[i][$clog2(masters)-1:0]];
        AWSIZE_M_ixc[i] = AWSIZE_S_ixc[grant_write_addr_forward_master[i][$clog2(masters)-1:0]];
        AWBURST_M_ixc[i] = AWBURST_S_ixc[grant_write_addr_forward_master[i][$clog2(masters)-1:0]];
    end
end
//ixc_forward --> Write Data Channel
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        WDATA_M_ixc[i] = WDATA_S_ixc[write_data_forward_src_master[i]];
        WSTRB_M_ixc[i] = WSTRB_S_ixc[write_data_forward_src_master[i]];
        WLAST_M_ixc[i] = WLAST_S_ixc[write_data_forward_src_master[i]];
    end
end
//fifo_info_forward --> Read Data Channel, Write Data Channel, Write Response Channel
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        master_read_data_fifo_full_M[i] = master_read_data_fifo_full_S[read_data_return_dest_master[i]];
        master_write_resp_fifo_full_M[i] = master_write_resp_fifo_full_S[write_resp_return_dest_master[i]];
        master_write_data_fifo_empty_M[i] = master_write_data_fifo_empty_S[write_data_forward_src_master[i]];
    end
end

endmodule