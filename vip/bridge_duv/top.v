//==============================================
// Author:       Chang Wan-Yun (Claire)
// Filename:     top.v
// Description:  Top module of AXI bridge VIP
// Version:      1.0
// ============================================


module top #(parameter bit COVERAGE_ON = 0) ();
   
    
    // user defined AXI parameters
    localparam DATA_WIDTH              = 32;
    localparam ADDR_WIDTH              = 32;
    localparam ID_WIDTH                = 4;
    localparam IDS_WIDTH               = 8;
    localparam LEN_WIDTH               = 4;
    localparam MAXLEN                  = 1;
    // fixed AXI parameters
    localparam STRB_WIDTH              = DATA_WIDTH/8;
    localparam SIZE_WIDTH              = 3;
    localparam BURST_WIDTH             = 2;  
    localparam CACHE_WIDTH             = 4;  
    localparam PROT_WIDTH              = 3;  
    localparam BRESP_WIDTH             = 2; 
    localparam RRESP_WIDTH             = 2;      
    localparam AWUSER_WIDTH            = 32; // Size of AWUser field
    localparam WUSER_WIDTH             = 32; // Size of WUser field
    localparam BUSER_WIDTH             = 32; // Size of BUser field
    localparam ARUSER_WIDTH            = 32; // Size of ARUser field
    localparam RUSER_WIDTH             = 32; // Size of RUser field
    localparam QOS_WIDTH               = 4;  // Size of QOS field
    localparam REGION_WIDTH            = 4;  // Size of Region field

    // Slave interface (connects to a master device)

    // Clock and reset    
    wire                        aclk_m;
    wire                        aresetn_m;
    // Clock and reset    
    wire                        aclk_s;
    wire                        aresetn_s;

    // ----------slave 0---------- //
    // Write address channel signals
    wire    [IDS_WIDTH-1:0]     awid_s0;      // Write address ID tag
    wire    [ADDR_WIDTH-1:0]    awaddr_s0;    // Write address
    wire    [LEN_WIDTH-1:0]     awlen_s0;     // Write address burst length
    wire    [SIZE_WIDTH-1:0]    awsize_s0;    // Write address burst size
    wire    [BURST_WIDTH-1:0]   awburst_s0;   // Write address burst type
    wire                        awlock_s0;    // Write address lock type
    wire    [PROT_WIDTH-1:0]    awprot_s0;    // Write address protection level
    wire    [QOS_WIDTH-1:0]     awqos_s0;     // Write address Quality of service
    wire    [REGION_WIDTH-1:0]  awregion_s0;  // Write address slave address region
    wire    [AWUSER_WIDTH-1:0]  awuser_s0;    // Write address user signal

    wire    [CACHE_WIDTH-1:0]   awcache_s0;   // Write address cache type
    wire                        awvalid_s0;   // Write address valid
    wire                        awready_s0;   // Write address ready

    // Write data channel signals
    wire    [DATA_WIDTH-1:0]    wdata_s0;     // Write data
    wire    [DATA_WIDTH/8-1:0]  wstrb_s0;     // Write strobe
    wire                        wlast_s0;     // Write last
    wire                        wvalid_s0;    // Write valid
    wire                        wready_s0;    // Write ready
    wire    [WUSER_WIDTH-1:0]   wuser_s0;     // Write user signal

    // Write response channel signals
    wire    [IDS_WIDTH-1:0]     bid_s0;       // Write response ID tag
    wire    [BRESP_WIDTH-1:0]   bresp_s0;     // Write response
    wire                        bvalid_s0;    // Write response valid
    wire                        bready_s0;    // Write response ready
    wire    [BUSER_WIDTH-1:0]   buser_s0;     // Write response user signal
    
    // Read address channel signals
    wire    [IDS_WIDTH-1:0]     arid_s0;      // Read address ID tag
    wire    [ADDR_WIDTH-1:0]    araddr_s0;    // Read address
    wire    [LEN_WIDTH-1:0]     arlen_s0;     // Read address burst length
    wire    [SIZE_WIDTH-1:0]    arsize_s0;    // Read address burst size
    wire    [BURST_WIDTH-1:0]   arburst_s0;   // Read address burst type
    wire                        arlock_s0;    // Read address lock type
    wire    [PROT_WIDTH-1:0]    arprot_s0;    // Read address protection level
    wire    [QOS_WIDTH-1:0]     arqos_s0;     // Read address Quality of service
    wire    [REGION_WIDTH-1:0]  arregion_s0;  // Read address slave address region
    wire    [ARUSER_WIDTH-1:0]  aruser_s0;    // Read address user signal

    wire    [CACHE_WIDTH-1:0]   arcache_s0;   // Read address cache type
    wire                        arvalid_s0;   // Read address valid
    wire                        arready_s0;   // Read address ready

    // Read data channel signals
    wire    [IDS_WIDTH-1:0]     rid_s0;       // Read ID tag
    wire    [DATA_WIDTH-1:0]    rdata_s0;     // Read data
    wire                        rlast_s0;     // Read last
    wire                        rvalid_s0;    // Read valid
    wire                        rready_s0;    // Read ready
    wire    [RRESP_WIDTH-1:0]   rresp_s0;     // Read response
    wire    [RUSER_WIDTH-1:0]   ruser_s0;     // Read address user signal

    // ----------slave1---------- //
    // Write address channel signals
    wire    [IDS_WIDTH-1:0]     awid_s1;      // Write address ID tag
    wire    [ADDR_WIDTH-1:0]    awaddr_s1;    // Write address
    wire    [LEN_WIDTH-1:0]     awlen_s1;     // Write address burst length
    wire    [SIZE_WIDTH-1:0]    awsize_s1;    // Write address burst size
    wire    [BURST_WIDTH-1:0]   awburst_s1;   // Write address burst type
    wire                        awlock_s1;    // Write address lock type
    wire    [PROT_WIDTH-1:0]    awprot_s1;    // Write address protection level
    wire    [QOS_WIDTH-1:0]     awqos_s1;     // Write address Quality of service
    wire    [REGION_WIDTH-1:0]  awregion_s1;  // Write address slave address region
    wire    [AWUSER_WIDTH-1:0]  awuser_s1;    // Write address user signal

    wire    [CACHE_WIDTH-1:0]   awcache_s1;   // Write address cache type
    wire                        awvalid_s1;   // Write address valid
    wire                        awready_s1;   // Write address ready

    // Write data channel signals
    wire    [DATA_WIDTH-1:0]    wdata_s1;     // Write data
    wire    [DATA_WIDTH/8-1:0]  wstrb_s1;     // Write strobe
    wire                        wlast_s1;     // Write last
    wire                        wvalid_s1;    // Write valid
    wire                        wready_s1;    // Write ready
    wire    [WUSER_WIDTH-1:0]   wuser_s1;     // Write user signal

    // Write response channel signals
    wire    [IDS_WIDTH-1:0]     bid_s1;       // Write response ID tag
    wire    [BRESP_WIDTH-1:0]   bresp_s1;     // Write response
    wire                        bvalid_s1;    // Write response valid
    wire                        bready_s1;    // Write response ready
    wire    [BUSER_WIDTH-1:0]   buser_s1;     // Write response user signal

    // Read address channel signals
    wire    [IDS_WIDTH-1:0]     arid_s1;      // Read address ID tag
    wire    [ADDR_WIDTH-1:0]    araddr_s1;    // Read address
    wire    [LEN_WIDTH-1:0]     arlen_s1;     // Read address burst length
    wire    [SIZE_WIDTH-1:0]    arsize_s1;    // Read address burst size
    wire    [BURST_WIDTH-1:0]   arburst_s1;   // Read address burst type
    wire                        arlock_s1;    // Read address lock type
    wire    [PROT_WIDTH-1:0]    arprot_s1;    // Read address protection level
    wire    [QOS_WIDTH-1:0]     arqos_s1;     // Read address Quality of service
    wire    [REGION_WIDTH-1:0]  arregion_s1;  // Read address slave address region
    wire    [ARUSER_WIDTH-1:0]  aruser_s1;    // Read address user signal

    wire    [CACHE_WIDTH-1:0]   arcache_s1;   // Read address cache type
    wire                        arvalid_s1;   // Read address valid
    wire                        arready_s1;   // Read address ready

    // Read data channel signals
    wire    [IDS_WIDTH-1:0]     rid_s1;       // Read ID tag
    wire    [DATA_WIDTH-1:0]    rdata_s1;     // Read data
    wire                        rlast_s1;     // Read last
    wire                        rvalid_s1;    // Read valid
    wire                        rready_s1;    // Read ready
    wire    [RRESP_WIDTH-1:0]   rresp_s1;     // Read response
    wire    [RUSER_WIDTH-1:0]   ruser_s1;     // Read address user signal


    // ----------slave2---------- //
    // Write address channel signals
    wire    [IDS_WIDTH-1:0]     awid_s2;      // Write address ID tag
    wire    [ADDR_WIDTH-1:0]    awaddr_s2;    // Write address
    wire    [LEN_WIDTH-1:0]     awlen_s2;     // Write address burst length
    wire    [SIZE_WIDTH-1:0]    awsize_s2;    // Write address burst size
    wire    [BURST_WIDTH-1:0]   awburst_s2;   // Write address burst type
    wire                        awlock_s2;    // Write address lock type
    wire    [PROT_WIDTH-1:0]    awprot_s2;    // Write address protection level
    wire    [QOS_WIDTH-1:0]     awqos_s2;     // Write address Quality of service
    wire    [REGION_WIDTH-1:0]  awregion_s2;  // Write address slave address region
    wire    [AWUSER_WIDTH-1:0]  awuser_s2;    // Write address user signal

    wire    [CACHE_WIDTH-1:0]   awcache_s2;   // Write address cache type
    wire                        awvalid_s2;   // Write address valid
    wire                        awready_s2;   // Write address ready

    // Write data channel signals
    wire    [DATA_WIDTH-1:0]    wdata_s2;     // Write data
    wire    [DATA_WIDTH/8-1:0]  wstrb_s2;     // Write strobe
    wire                        wlast_s2;     // Write last
    wire                        wvalid_s2;    // Write valid
    wire                        wready_s2;    // Write ready
    wire    [WUSER_WIDTH-1:0]   wuser_s2;     // Write user signal

    // Write response channel signals
    wire    [IDS_WIDTH-1:0]     bid_s2;       // Write response ID tag
    wire    [BRESP_WIDTH-1:0]   bresp_s2;     // Write response
    wire                        bvalid_s2;    // Write response valid
    wire                        bready_s2;    // Write response ready
    wire    [BUSER_WIDTH-1:0]   buser_s2;     // Write response user signal

    // Read address channel signals
    wire    [IDS_WIDTH-1:0]     arid_s2;      // Read address ID tag
    wire    [ADDR_WIDTH-1:0]    araddr_s2;    // Read address
    wire    [LEN_WIDTH-1:0]     arlen_s2;     // Read address burst length
    wire    [SIZE_WIDTH-1:0]    arsize_s2;    // Read address burst size
    wire    [BURST_WIDTH-1:0]   arburst_s2;   // Read address burst type
    wire                        arlock_s2;    // Read address lock type
    wire    [PROT_WIDTH-1:0]    arprot_s2;    // Read address protection level
    wire    [QOS_WIDTH-1:0]     arqos_s2;     // Read address Quality of service
    wire    [REGION_WIDTH-1:0]  arregion_s2;  // Read address slave address region
    wire    [ARUSER_WIDTH-1:0]  aruser_s2;    // Read address user signal

    wire    [CACHE_WIDTH-1:0]   arcache_s2;   // Read address cache type
    wire                        arvalid_s2;   // Read address valid
    wire                        arready_s2;   // Read address ready

    // Read data channel signals
    wire    [IDS_WIDTH-1:0]     rid_s2;       // Read ID tag
    wire    [DATA_WIDTH-1:0]    rdata_s2;     // Read data
    wire                        rlast_s2;     // Read last
    wire                        rvalid_s2;    // Read valid
    wire                        rready_s2;    // Read ready
    wire    [RRESP_WIDTH-1:0]   rresp_s2;     // Read response
    wire    [RUSER_WIDTH-1:0]   ruser_s2;     // Read address user signal


    // ----------slave3---------- //
    // Write address channel signals
    wire    [IDS_WIDTH-1:0]     awid_s3;      // Write address ID tag
    wire    [ADDR_WIDTH-1:0]    awaddr_s3;    // Write address
    wire    [LEN_WIDTH-1:0]     awlen_s3;     // Write address burst length
    wire    [SIZE_WIDTH-1:0]    awsize_s3;    // Write address burst size
    wire    [BURST_WIDTH-1:0]   awburst_s3;   // Write address burst type
    wire                        awlock_s3;    // Write address lock type
    wire    [PROT_WIDTH-1:0]    awprot_s3;    // Write address protection level
    wire    [QOS_WIDTH-1:0]     awqos_s3;     // Write address Quality of service
    wire    [REGION_WIDTH-1:0]  awregion_s3;  // Write address slave address region
    wire    [AWUSER_WIDTH-1:0]  awuser_s3;    // Write address user signal

    wire    [CACHE_WIDTH-1:0]   awcache_s3;   // Write address cache type
    wire                        awvalid_s3;   // Write address valid
    wire                        awready_s3;   // Write address ready

    // Write data channel signals
    wire    [DATA_WIDTH-1:0]    wdata_s3;     // Write data
    wire    [DATA_WIDTH/8-1:0]  wstrb_s3;     // Write strobe
    wire                        wlast_s3;     // Write last
    wire                        wvalid_s3;    // Write valid
    wire                        wready_s3;    // Write ready
    wire    [WUSER_WIDTH-1:0]   wuser_s3;     // Write user signal

    // Write response channel signals
    wire    [IDS_WIDTH-1:0]     bid_s3;       // Write response ID tag
    wire    [BRESP_WIDTH-1:0]   bresp_s3;     // Write response
    wire                        bvalid_s3;    // Write response valid
    wire                        bready_s3;    // Write response ready
    wire    [BUSER_WIDTH-1:0]   buser_s3;     // Write response user signal

    // Read address channel signals
    wire    [IDS_WIDTH-1:0]     arid_s3;      // Read address ID tag
    wire    [ADDR_WIDTH-1:0]    araddr_s3;    // Read address
    wire    [LEN_WIDTH-1:0]     arlen_s3;     // Read address burst length
    wire    [SIZE_WIDTH-1:0]    arsize_s3;    // Read address burst size
    wire    [BURST_WIDTH-1:0]   arburst_s3;   // Read address burst type
    wire                        arlock_s3;    // Read address lock type
    wire    [PROT_WIDTH-1:0]    arprot_s3;    // Read address protection level
    wire    [QOS_WIDTH-1:0]     arqos_s3;     // Read address Quality of service
    wire    [REGION_WIDTH-1:0]  arregion_s3;  // Read address slave address region
    wire    [ARUSER_WIDTH-1:0]  aruser_s3;    // Read address user signal

    wire    [CACHE_WIDTH-1:0]   arcache_s3;   // Read address cache type
    wire                        arvalid_s3;   // Read address valid
    wire                        arready_s3;   // Read address ready

    // Read data channel signals
    wire    [IDS_WIDTH-1:0]     rid_s3;       // Read ID tag
    wire    [DATA_WIDTH-1:0]    rdata_s3;     // Read data
    wire                        rlast_s3;     // Read last
    wire                        rvalid_s3;    // Read valid
    wire                        rready_s3;    // Read ready
    wire    [RRESP_WIDTH-1:0]   rresp_s3;     // Read response
    wire    [RUSER_WIDTH-1:0]   ruser_s3;     // Read address user signal


    // ----------slave4---------- //
    // Write address channel signals
    wire    [IDS_WIDTH-1:0]     awid_s4;      // Write address ID tag
    wire    [ADDR_WIDTH-1:0]    awaddr_s4;    // Write address
    wire    [LEN_WIDTH-1:0]     awlen_s4;     // Write address burst length
    wire    [SIZE_WIDTH-1:0]    awsize_s4;    // Write address burst size
    wire    [BURST_WIDTH-1:0]   awburst_s4;   // Write address burst type
    wire                        awlock_s4;    // Write address lock type
    wire    [PROT_WIDTH-1:0]    awprot_s4;    // Write address protection level
    wire    [QOS_WIDTH-1:0]     awqos_s4;     // Write address Quality of service
    wire    [REGION_WIDTH-1:0]  awregion_s4;  // Write address slave address region
    wire    [AWUSER_WIDTH-1:0]  awuser_s4;    // Write address user signal

    wire    [CACHE_WIDTH-1:0]   awcache_s4;   // Write address cache type
    wire                        awvalid_s4;   // Write address valid
    wire                        awready_s4;   // Write address ready

    // Write data channel signals
    wire    [DATA_WIDTH-1:0]    wdata_s4;     // Write data
    wire    [DATA_WIDTH/8-1:0]  wstrb_s4;     // Write strobe
    wire                        wlast_s4;     // Write last
    wire                        wvalid_s4;    // Write valid
    wire                        wready_s4;    // Write ready
    wire    [WUSER_WIDTH-1:0]   wuser_s4;     // Write user signal

    // Write response channel signals
    wire    [IDS_WIDTH-1:0]     bid_s4;       // Write response ID tag
    wire    [BRESP_WIDTH-1:0]   bresp_s4;     // Write response
    wire                        bvalid_s4;    // Write response valid
    wire                        bready_s4;    // Write response ready
    wire    [BUSER_WIDTH-1:0]   buser_s4;     // Write response user signal

    // Read address channel signals
    wire    [IDS_WIDTH-1:0]     arid_s4;      // Read address ID tag
    wire    [ADDR_WIDTH-1:0]    araddr_s4;    // Read address
    wire    [LEN_WIDTH-1:0]     arlen_s4;     // Read address burst length
    wire    [SIZE_WIDTH-1:0]    arsize_s4;    // Read address burst size
    wire    [BURST_WIDTH-1:0]   arburst_s4;   // Read address burst type
    wire                        arlock_s4;    // Read address lock type
    wire    [PROT_WIDTH-1:0]    arprot_s4;    // Read address protection level
    wire    [QOS_WIDTH-1:0]     arqos_s4;     // Read address Quality of service
    wire    [REGION_WIDTH-1:0]  arregion_s4;  // Read address slave address region
    wire    [ARUSER_WIDTH-1:0]  aruser_s4;    // Read address user signal

    wire    [CACHE_WIDTH-1:0]   arcache_s4;   // Read address cache type
    wire                        arvalid_s4;   // Read address valid
    wire                        arready_s4;   // Read address ready

    // Read data channel signals
    wire    [IDS_WIDTH-1:0]     rid_s4;       // Read ID tag
    wire    [DATA_WIDTH-1:0]    rdata_s4;     // Read data
    wire                        rlast_s4;     // Read last
    wire                        rvalid_s4;    // Read valid
    wire                        rready_s4;    // Read ready
    wire    [RRESP_WIDTH-1:0]   rresp_s4;     // Read response
    wire    [RUSER_WIDTH-1:0]   ruser_s4;     // Read address user signal

    // ----------slave5---------- //
    // Write address channel signals
    wire    [IDS_WIDTH-1:0]     awid_s5;      // Write address ID tag
    wire    [ADDR_WIDTH-1:0]    awaddr_s5;    // Write address
    wire    [LEN_WIDTH-1:0]     awlen_s5;     // Write address burst length
    wire    [SIZE_WIDTH-1:0]    awsize_s5;    // Write address burst size
    wire    [BURST_WIDTH-1:0]   awburst_s5;   // Write address burst type
    wire                        awlock_s5;    // Write address lock type
    wire    [PROT_WIDTH-1:0]    awprot_s5;    // Write address protection level
    wire    [QOS_WIDTH-1:0]     awqos_s5;     // Write address Quality of service
    wire    [REGION_WIDTH-1:0]  awregion_s5;  // Write address slave address region
    wire    [AWUSER_WIDTH-1:0]  awuser_s5;    // Write address user signal

    wire    [CACHE_WIDTH-1:0]   awcache_s5;   // Write address cache type
    wire                        awvalid_s5;   // Write address valid
    wire                        awready_s5;   // Write address ready

    // Write data channel signals
    wire    [DATA_WIDTH-1:0]    wdata_s5;     // Write data
    wire    [DATA_WIDTH/8-1:0]  wstrb_s5;     // Write strobe
    wire                        wlast_s5;     // Write last
    wire                        wvalid_s5;    // Write valid
    wire                        wready_s5;    // Write ready
    wire    [WUSER_WIDTH-1:0]   wuser_s5;     // Write user signal

    // Write response channel signals
    wire    [IDS_WIDTH-1:0]     bid_s5;       // Write response ID tag
    wire    [BRESP_WIDTH-1:0]   bresp_s5;     // Write response
    wire                        bvalid_s5;    // Write response valid
    wire                        bready_s5;    // Write response ready
    wire    [BUSER_WIDTH-1:0]   buser_s5;     // Write response user signal

    // Read address channel signals
    wire    [IDS_WIDTH-1:0]     arid_s5;      // Read address ID tag
    wire    [ADDR_WIDTH-1:0]    araddr_s5;    // Read address
    wire    [LEN_WIDTH-1:0]     arlen_s5;     // Read address burst length
    wire    [SIZE_WIDTH-1:0]    arsize_s5;    // Read address burst size
    wire    [BURST_WIDTH-1:0]   arburst_s5;   // Read address burst type
    wire                        arlock_s5;    // Read address lock type
    wire    [PROT_WIDTH-1:0]    arprot_s5;    // Read address protection level
    wire    [QOS_WIDTH-1:0]     arqos_s5;     // Read address Quality of service
    wire    [REGION_WIDTH-1:0]  arregion_s5;  // Read address slave address region
    wire    [ARUSER_WIDTH-1:0]  aruser_s5;    // Read address user signal

    wire    [CACHE_WIDTH-1:0]   arcache_s5;   // Read address cache type
    wire                        arvalid_s5;   // Read address valid
    wire                        arready_s5;   // Read address ready

    // Read data channel signals
    wire    [IDS_WIDTH-1:0]     rid_s5;       // Read ID tag
    wire    [DATA_WIDTH-1:0]    rdata_s5;     // Read data
    wire                        rlast_s5;     // Read last
    wire                        rvalid_s5;    // Read valid
    wire                        rready_s5;    // Read ready
    wire    [RRESP_WIDTH-1:0]   rresp_s5;     // Read response
    wire    [RUSER_WIDTH-1:0]   ruser_s5;     // Read address user signal

    // AXI 4 Master Interface (connects to a slave device)

    // ----------master0---------- //
    // Write address channel signals
    wire    [ID_WIDTH-1:0]      awid_m0;      // Write address ID tag
    wire    [ADDR_WIDTH-1:0]    awaddr_m0;    // Write address
    wire    [LEN_WIDTH-1:0]     awlen_m0;     // Write address burst length
    wire    [SIZE_WIDTH-1:0]    awsize_m0;    // Write address burst size
    wire    [BURST_WIDTH-1:0]   awburst_m0;   // Write address burst type
    wire                        awlock_m0;    // Write address lock type
    wire    [PROT_WIDTH-1:0]    awprot_m0;    // Write address protection level
    wire    [CACHE_WIDTH-1:0]   awcache_m0;   // Write address cache type
    wire                        awvalid_m0;   // Write address valid
    wire                        awready_m0;   // Write address ready
    wire    [QOS_WIDTH-1:0]     awqos_m0;     // Write address Quality of service
    wire    [REGION_WIDTH-1:0]  awregion_m0;  // Write address slave address region
    wire    [AWUSER_WIDTH-1:0]  awuser_m0;    // Write address user signal

    // Write data channel signals
    wire    [DATA_WIDTH-1:0]    wdata_m0;     // Write data
    wire    [DATA_WIDTH/8-1:0]  wstrb_m0;     // Write strobe
    wire                        wlast_m0;     // Write last
    wire                        wvalid_m0;    // Write valid
    wire                        wready_m0;    // Write ready
    wire    [WUSER_WIDTH-1:0]   wuser_m0;     // Write user signal
    // Write response channel signals
    wire    [ID_WIDTH-1:0]      bid_m0;       // Write response ID tag
    wire    [BRESP_WIDTH-1:0]   bresp_m0;     // Write response
    wire                        bvalid_m0;    // Write response valid
    wire                        bready_m0;    // Write response ready
    wire    [BUSER_WIDTH-1:0]   buser_m0;     // Write response user signal
    // Read address channel signals
    wire    [ID_WIDTH-1:0]      arid_m0;      // Read address ID tag
    wire    [ADDR_WIDTH-1:0]    araddr_m0;    // Read address
    wire    [LEN_WIDTH-1:0]     arlen_m0;     // Read address burst length
    wire    [SIZE_WIDTH-1:0]    arsize_m0;    // Read address burst size
    wire    [BURST_WIDTH-1:0]   arburst_m0;   // Read address burst type
    wire                        arlock_m0;    // Read address lock type
    wire    [PROT_WIDTH-1:0]    arprot_m0;    // Read address protection level
    wire    [CACHE_WIDTH-1:0]   arcache_m0;   // Read address cache type
    wire                        arvalid_m0;   // Read address valid
    wire                        arready_m0;   // Read address ready
    wire    [QOS_WIDTH-1:0]     arqos_m0;     // Read address Quality of service
    wire    [REGION_WIDTH-1:0]  arregion_m0;  // Read address slave address region
    wire    [ARUSER_WIDTH-1:0]  aruser_m0;    // Read address user signal

    // Read data channel signals
    wire    [ID_WIDTH-1:0]      rid_m0;       // Read ID tag
    wire    [DATA_WIDTH-1:0]    rdata_m0;     // Read data
    wire                        rlast_m0;     // Read last
    wire                        rvalid_m0;    // Read valid
    wire                        rready_m0;    // Read ready
    wire    [RRESP_WIDTH-1:0]   rresp_m0;     // Read response
    wire    [RUSER_WIDTH-1:0]   ruser_m0;     // Read address user signal

    // ----------master1---------- //
    // Write address channel signals
    wire    [ID_WIDTH-1:0]      awid_m1;      // Write address ID tag
    wire    [ADDR_WIDTH-1:0]    awaddr_m1;    // Write address
    wire    [LEN_WIDTH-1:0]     awlen_m1;     // Write address burst length
    wire    [SIZE_WIDTH-1:0]    awsize_m1;    // Write address burst size
    wire    [BURST_WIDTH-1:0]   awburst_m1;   // Write address burst type
    wire                        awlock_m1;    // Write address lock type
    wire    [PROT_WIDTH-1:0]    awprot_m1;    // Write address protection level
    wire    [CACHE_WIDTH-1:0]   awcache_m1;   // Write address cache type
    wire                        awvalid_m1;   // Write address valid
    wire                        awready_m1;   // Write address ready
    wire    [QOS_WIDTH-1:0]     awqos_m1;     // Write address Quality of service
    wire    [REGION_WIDTH-1:0]  awregion_m1;  // Write address slave address region
    wire    [AWUSER_WIDTH-1:0]  awuser_m1;    // Write address user signal

    // Write data channel signals
    wire    [DATA_WIDTH-1:0]    wdata_m1;     // Write data
    wire    [DATA_WIDTH/8-1:0]  wstrb_m1;     // Write strobe
    wire                        wlast_m1;     // Write last
    wire                        wvalid_m1;    // Write valid
    wire                        wready_m1;    // Write ready
    wire    [WUSER_WIDTH-1:0]   wuser_m1;     // Write user signal
    // Write response channel signals
    wire    [ID_WIDTH-1:0]      bid_m1;       // Write response ID tag
    wire    [BRESP_WIDTH-1:0]   bresp_m1;     // Write response
    wire                        bvalid_m1;    // Write response valid
    wire                        bready_m1;    // Write response ready
    wire    [BUSER_WIDTH-1:0]   buser_m1;     // Write response user signal
    // Read address channel signals
    wire    [ID_WIDTH-1:0]      arid_m1;      // Read address ID tag
    wire    [ADDR_WIDTH-1:0]    araddr_m1;    // Read address
    wire    [LEN_WIDTH-1:0]     arlen_m1;     // Read address burst length
    wire    [SIZE_WIDTH-1:0]    arsize_m1;    // Read address burst size
    wire    [BURST_WIDTH-1:0]   arburst_m1;   // Read address burst type
    wire                        arlock_m1;    // Read address lock type
    wire    [PROT_WIDTH-1:0]    arprot_m1;    // Read address protection level
    wire    [CACHE_WIDTH-1:0]   arcache_m1;   // Read address cache type
    wire                        arvalid_m1;   // Read address valid
    wire                        arready_m1;   // Read address ready
    wire    [QOS_WIDTH-1:0]     arqos_m1;     // Read address Quality of service
    wire    [REGION_WIDTH-1:0]  arregion_m1;  // Read address slave address region
    wire    [ARUSER_WIDTH-1:0]  aruser_m1;    // Read address user signal

    // Read data channel signals
    wire    [ID_WIDTH-1:0]      rid_m1;       // Read ID tag
    wire    [DATA_WIDTH-1:0]    rdata_m1;     // Read data
    wire                        rlast_m1;     // Read last
    wire                        rvalid_m1;    // Read valid
    wire                        rready_m1;    // Read ready
    wire    [RRESP_WIDTH-1:0]   rresp_m1;     // Read response
    wire    [RUSER_WIDTH-1:0]   ruser_m1;     // Read address user signal
    // AXI 4 Bridge GLobal Interface (connects to low power controller)

    // Low power signals
    wire                        csysreq;     // Low Power - Power Off Request
    wire                        csysack;     // Low Power - Power Off Acknowledge
    wire                        cactive;     // Low Power - activate

    // Instance of the AXI bridge DUV
    xbar #(
        //AXI Setup
        .ID_WIDTH(4),
        .IDS_WIDTH(8),
        .ADDR_WIDTH(32),
        .LEN_WIDTH(4),
        .SIZE_WIDTH(3),
        .DATA_WIDTH(32),
        .STRB_WIDTH(4),

        .pending_depth(4),
        .masters(2),
        .slaves(6),
        .address_map_base({
            32'h0000_0000,
            32'h1000_0000,
            32'h2000_0000,
            32'h3000_0000,
            32'h4000_0000,
            32'h5000_0000
        }),
        .address_map_end({
            32'h0FFF_FFFF,
            32'h1FFF_FFFF,
            32'h2FFF_FFFF,
            32'h3FFF_FFFF,
            32'h4FFF_FFFF,
            32'h5FFF_FFFF
        })
    ) axi_duv_bridge (
        //Global Signal
        .ACLK(aclk_m),
        .ARESETn(aresetn_m),

        //To Outer Master Device
        //Read Address Channel
        .ARID_M('{
            arid_m0,
            arid_m1
        }),
        .ARADDR_M('{
            araddr_m0,
            araddr_m1
        }),
        .ARLEN_M('{
            arlen_m0,
            arlen_m1
        }),
        .ARSIZE_M('{
            arsize_m0,
            arsize_m1
        }),
        .ARBURST_M('{
            arburst_m0,
            arburst_m1
        }),
        .ARVALID_M('{
            arvalid_m0,
            arvalid_m1
        }),
        .ARREADY_M('{
            arready_m0,
            arready_m1
        }),
        //Read Data Channel
        .RID_M('{
            rid_m0,
            rid_m1
        }),
        .RDATA_M('{
            rdata_m0,
            rdata_m1
        }),
        .RRESP_M('{
            rresp_m0,
            rresp_m1
        }),
        .RLAST_M('{
            rlast_m0,
            rlast_m1
        }),
        .RVALID_M('{
            rvalid_m0,
            rvalid_m1
        }),
        .RREADY_M('{
            rready_m0,
            rready_m1
        }),
        //Write Address Channel
        .AWID_M('{
            awid_m0,
            awid_m1
        }),
        .AWADDR_M('{
            awaddr_m0,
            awaddr_m1
        }),
        .AWLEN_M('{
            awlen_m0,
            awlen_m1
        }),
        .AWSIZE_M('{
            awsize_m0,
            awsize_m1
        }),
        .AWBURST_M('{
            awburst_m0,
            awburst_m1
        }),
        .AWVALID_M('{
            awvalid_m0,
            awvalid_m1
        }),
        .AWREADY_M('{
            awready_m0,
            awready_m1
        }),
        //Write Data Channel
        .WDATA_M('{
            wdata_m0,
            wdata_m1
        }),
        .WSTRB_M('{
            wstrb_m0,
            wstrb_m1
        }),
        .WLAST_M('{
            wlast_m0,
            wlast_m1
        }),
        .WVALID_M('{
            wvalid_m0,
            wvalid_m1
        }),
        .WREADY_M('{
            wready_m0,
            wready_m1
        }),
        //Write Response Channel
        .BID_M('{
            bid_m0,
            bid_m1
        }),
        .BRESP_M('{
            bresp_m0,
            bresp_m1
        }),
        .BVALID_M('{
            bvalid_m0,
            bvalid_m1
        }),
        .BREADY_M('{
            bready_m0,
            bready_m1
        }),

        //To Outer Slave Device
        //Read Address Channel
        .ARID_S('{
            arid_s0,
            arid_s1,
            arid_s2,
            arid_s3,
            arid_s4,
            arid_s5
        }),
        .ARADDR_S('{
            araddr_s0,
            araddr_s1,
            araddr_s2,
            araddr_s3,
            araddr_s4,
            araddr_s5
        }),
        .ARLEN_S('{
            arlen_s0,
            arlen_s1,
            arlen_s2,
            arlen_s3,
            arlen_s4,
            arlen_s5
        }),
        .ARSIZE_S('{
            arsize_s0,
            arsize_s1,
            arsize_s2,
            arsize_s3,
            arsize_s4,
            arsize_s5
        }),
        .ARBURST_S('{
            arburst_s0,
            arburst_s1,
            arburst_s2,
            arburst_s3,
            arburst_s4,
            arburst_s5
        }),
        .ARVALID_S('{
            arvalid_s0,
            arvalid_s1,
            arvalid_s2,
            arvalid_s3,
            arvalid_s4,
            arvalid_s5
        }),
        .ARREADY_S('{
            arready_s0,
            arready_s1,
            arready_s2,
            arready_s3,
            arready_s4,
            arready_s5
        }),
        //READ DATA0
        .RID_S('{
            rid_s0,
            rid_s1,
            rid_s2,
            rid_s3,
            rid_s4,
            rid_s5
        }),
        .RDATA_S('{
            rdata_s0,
            rdata_s1,
            rdata_s2,
            rdata_s3,
            rdata_s4,
            rdata_s5
        }),
        .RRESP_S('{
            rresp_s0,
            rresp_s1,
            rresp_s2,
            rresp_s3,
            rresp_s4,
            rresp_s5
        }),
        .RLAST_S('{
            rlast_s0,
            rlast_s1,
            rlast_s2,
            rlast_s3,
            rlast_s4,
            rlast_s5
        }),
        .RVALID_S('{
            rvalid_s0,
            rvalid_s1,
            rvalid_s2,
            rvalid_s3,
            rvalid_s4,
            rvalid_s5
        }),
        .RREADY_S('{
            rready_s0,
            rready_s1,
            rready_s2,
            rready_s3,
            rready_s4,
            rready_s5
        }),
        //WRITE ADDRESS0
        .AWID_S('{
            awid_s0,
            awid_s1,
            awid_s2,
            awid_s3,
            awid_s4,
            awid_s5
        }),
        .AWADDR_S('{
            awaddr_s0,
            awaddr_s1,
            awaddr_s2,
            awaddr_s3,
            awaddr_s4,
            awaddr_s5
        }),
        .AWLEN_S('{
            awlen_s0,
            awlen_s1,
            awlen_s2,
            awlen_s3,
            awlen_s4,
            awlen_s5
        }),
        .AWSIZE_S('{
            awsize_s0,
            awsize_s1,
            awsize_s2,
            awsize_s3,
            awsize_s4,
            awsize_s5
        }),
        .AWBURST_S('{
            awburst_s0,
            awburst_s1,
            awburst_s2,
            awburst_s3,
            awburst_s4,
            awburst_s5
        }),
        .AWVALID_S('{
            awvalid_s0,
            awvalid_s1,
            awvalid_s2,
            awvalid_s3,
            awvalid_s4,
            awvalid_s5
        }),
        .AWREADY_S('{
            awready_s0,
            awready_s1,
            awready_s2,
            awready_s3,
            awready_s4,
            awready_s5
        }),
        //WRITE DATA0
        .WDATA_S('{
            wdata_s0,
            wdata_s1,
            wdata_s2,
            wdata_s3,
            wdata_s4,
            wdata_s5
        }),
        .WSTRB_S('{
            wstrb_s0,
            wstrb_s1,
            wstrb_s2,
            wstrb_s3,
            wstrb_s4,
            wstrb_s5
        }),
        .WLAST_S('{
            wlast_s0,
            wlast_s1,
            wlast_s2,
            wlast_s3,
            wlast_s4,
            wlast_s5
        }),
        .WVALID_S('{
            wvalid_s0,
            wvalid_s1,
            wvalid_s2,
            wvalid_s3,
            wvalid_s4,
            wvalid_s5
        }),
        .WREADY_S('{
            wready_s0,
            wready_s1,
            wready_s2,
            wready_s3,
            wready_s4,
            wready_s5
        }),
        //WRITE RESPONSE0
        .BID_S('{
            bid_s0,
            bid_s1,
            bid_s2,
            bid_s3,
            bid_s4,
            bid_s5
        }),
        .BRESP_S('{
            bresp_s0,
            bresp_s1,
            bresp_s2,
            bresp_s3,
            bresp_s4,
            bresp_s5
        }),
        .BVALID_S('{
            bvalid_s0,
            bvalid_s1,
            bvalid_s2,
            bvalid_s3,
            bvalid_s4,
            bvalid_s5
        }),
        .BREADY_S('{
            bready_s0,
            bready_s1,
            bready_s2,
            bready_s3,
            bready_s4,
            bready_s5
        })
    );

    axi4_slave axi_slave_0 (
        .aclk            (aclk_s),
        .aresetn         (aresetn_s),
        .awid            (awid_s0),
        .awaddr          (awaddr_s0),
        .awlen           (awlen_s0),
        .awsize          (awsize_s0),
        .awburst         (awburst_s0),
        .awlock          (awlock_s0),
        .awcache         (awcache_s0),
        .awprot          (awprot_s0),
        .awvalid         (awvalid_s0),
        .awready         (awready_s0),
        .awqos           (awqos_s0),  
        .awregion        (awregion_s0),  
        .awuser          (awuser_s0),   
	    .ruser           (ruser_s0),
        .arqos           (arqos_s0),  
        .arregion        (arregion_s0),  
        .aruser          (aruser_s0),
        .buser           (buser_s0),
	    .wuser           (wuser_s0),
      
        .wdata           (wdata_s0),
        .wstrb           (wstrb_s0),
        .wlast           (wlast_s0),
        .wvalid          (wvalid_s0),
        .wready          (wready_s0),
        
        .bid             (bid_s0),
        .bresp           (bresp_s0),
        .bvalid          (bvalid_s0),
        .bready          (bready_s0),
        
        .arid            (arid_s0),
        .araddr          (araddr_s0),
        .arlen           (arlen_s0),
        .arsize          (arsize_s0),
        .arburst         (arburst_s0),
        .arlock          (arlock_s0),
        .arcache         (arcache_s0),
        .arprot          (arprot_s0),
        .arvalid         (arvalid_s0),
        .arready         (arready_s0),
        
        .rid             (rid_s0),
        .rdata           (rdata_s0),
        .rresp           (rresp_s0),
        .rlast           (rlast_s0),
        .rvalid          (rvalid_s0),
        .rready          (rready_s0),
        
        .csysreq         (csysreq),
        .csysack         (csysack),
        .cactive         (cactive)
    );

    defparam axi_slave_0.ADDR_WIDTH              = ADDR_WIDTH;
    defparam axi_slave_0.DATA_WIDTH              = DATA_WIDTH;
    defparam axi_slave_0.ID_WIDTH                = IDS_WIDTH;
    defparam axi_slave_0.LEN_WIDTH               = LEN_WIDTH;
    defparam axi_slave_0.MAXLEN                  = MAXLEN;
    defparam axi_slave_0.READ_INTERLEAVE_ON      = 0;
    defparam axi_slave_0.BYTE_STROBE_ON          = 0;
    defparam axi_slave_0.EXCL_ACCESS_ON          = 0;
    defparam axi_slave_0.DATA_BEFORE_CONTROL_ON  = 0;
    defparam axi_slave_0.COVERAGE_ON             = COVERAGE_ON;
    


    axi4_slave axi_slave_1 (
        .aclk            (aclk_s),
        .aresetn         (aresetn_s),
        .awid            (awid_s1),
        .awaddr          (awaddr_s1),
        .awlen           (awlen_s1),
        .awsize          (awsize_s1),
        .awburst         (awburst_s1),
        .awlock          (awlock_s1),
        .awcache         (awcache_s1),
        .awprot          (awprot_s1),
        .awvalid         (awvalid_s1),
        .awready         (awready_s1),
        .awqos           (awqos_s1),  
        .awregion        (awregion_s1),  
        .awuser          (awuser_s1),   
	    .ruser           (ruser_s1),
        .arqos           (arqos_s1),  
        .arregion        (arregion_s1),  
        .aruser          (aruser_s1),
        .buser           (buser_s1),
	    .wuser           (wuser_s1),
      
        .wdata           (wdata_s1),
        .wstrb           (wstrb_s1),
        .wlast           (wlast_s1),
        .wvalid          (wvalid_s1),
        .wready          (wready_s1),
        
        .bid             (bid_s1),
        .bresp           (bresp_s1),
        .bvalid          (bvalid_s1),
        .bready          (bready_s1),
        
        .arid            (arid_s1),
        .araddr          (araddr_s1),
        .arlen           (arlen_s1),
        .arsize          (arsize_s1),
        .arburst         (arburst_s1),
        .arlock          (arlock_s1),
        .arcache         (arcache_s1),
        .arprot          (arprot_s1),
        .arvalid         (arvalid_s1),
        .arready         (arready_s1),
        
        .rid             (rid_s1),
        .rdata           (rdata_s1),
        .rresp           (rresp_s1),
        .rlast           (rlast_s1),
        .rvalid          (rvalid_s1),
        .rready          (rready_s1),
        
        .csysreq         (csysreq),
        .csysack         (csysack),
        .cactive         (cactive)
    );

    defparam axi_slave_1.ADDR_WIDTH              = ADDR_WIDTH;
    defparam axi_slave_1.DATA_WIDTH              = DATA_WIDTH;
    defparam axi_slave_1.ID_WIDTH                = IDS_WIDTH;
    defparam axi_slave_1.LEN_WIDTH               = LEN_WIDTH;
    defparam axi_slave_1.MAXLEN                  = MAXLEN;
    defparam axi_slave_1.READ_INTERLEAVE_ON      = 0;
   // defparam axi_slave_1.READ_RESP_IN_ORDER_ON  = 1;
    defparam axi_slave_1.BYTE_STROBE_ON          = 0;
    defparam axi_slave_1.EXCL_ACCESS_ON          = 0;
    defparam axi_slave_1.DATA_BEFORE_CONTROL_ON  = 0;
    defparam axi_slave_1.COVERAGE_ON             = COVERAGE_ON;


    axi4_slave axi_slave_2 (
        .aclk            (aclk_s),
        .aresetn         (aresetn_s),
        .awid            (awid_s2),
        .awaddr          (awaddr_s2),
        .awlen           (awlen_s2),
        .awsize          (awsize_s2),
        .awburst         (awburst_s2),
        .awlock          (awlock_s2),
        .awcache         (awcache_s2),
        .awprot          (awprot_s2),
        .awvalid         (awvalid_s2),
        .awready         (awready_s2),
        .awqos           (awqos_s2),  
        .awregion        (awregion_s2),  
        .awuser          (awuser_s2),   
	    .ruser           (ruser_s2),
        .arqos           (arqos_s2),  
        .arregion        (arregion_s2),  
        .aruser          (aruser_s2),
        .buser           (buser_s2),
	    .wuser           (wuser_s2),
      
        .wdata           (wdata_s2),
        .wstrb           (wstrb_s2),
        .wlast           (wlast_s2),
        .wvalid          (wvalid_s2),
        .wready          (wready_s2),
        
        .bid             (bid_s2),
        .bresp           (bresp_s2),
        .bvalid          (bvalid_s2),
        .bready          (bready_s2),
        
        .arid            (arid_s2),
        .araddr          (araddr_s2),
        .arlen           (arlen_s2),
        .arsize          (arsize_s2),
        .arburst         (arburst_s2),
        .arlock          (arlock_s2),
        .arcache         (arcache_s2),
        .arprot          (arprot_s2),
        .arvalid         (arvalid_s2),
        .arready         (arready_s2),
        
        .rid             (rid_s2),
        .rdata           (rdata_s2),
        .rresp           (rresp_s2),
        .rlast           (rlast_s2),
        .rvalid          (rvalid_s2),
        .rready          (rready_s2),
        
        .csysreq         (csysreq),
        .csysack         (csysack),
        .cactive         (cactive)
    );

    defparam axi_slave_2.ADDR_WIDTH              = ADDR_WIDTH;
    defparam axi_slave_2.DATA_WIDTH              = DATA_WIDTH;
    defparam axi_slave_2.ID_WIDTH                = IDS_WIDTH;
    defparam axi_slave_2.LEN_WIDTH               = LEN_WIDTH;
    defparam axi_slave_2.MAXLEN                  = MAXLEN;
    defparam axi_slave_2.READ_INTERLEAVE_ON      = 0;
   // defparam axi_slave_2.READ_RESP_IN_ORDER_ON  = 1;
    defparam axi_slave_2.BYTE_STROBE_ON          = 0;
    defparam axi_slave_2.EXCL_ACCESS_ON          = 0;
    defparam axi_slave_2.DATA_BEFORE_CONTROL_ON  = 0;
    defparam axi_slave_2.COVERAGE_ON             = COVERAGE_ON;


    axi4_slave axi_slave_3 (
        .aclk            (aclk_s),
        .aresetn         (aresetn_s),
        .awid            (awid_s3),
        .awaddr          (awaddr_s3),
        .awlen           (awlen_s3),
        .awsize          (awsize_s3),
        .awburst         (awburst_s3),
        .awlock          (awlock_s3),
        .awcache         (awcache_s3),
        .awprot          (awprot_s3),
        .awvalid         (awvalid_s3),
        .awready         (awready_s3),
        .awqos           (awqos_s3),  
        .awregion        (awregion_s3),  
        .awuser          (awuser_s3),   
	    .ruser           (ruser_s3),
        .arqos           (arqos_s3),  
        .arregion        (arregion_s3),  
        .aruser          (aruser_s3),
        .buser           (buser_s3),
	    .wuser           (wuser_s3),
      
        .wdata           (wdata_s3),
        .wstrb           (wstrb_s3),
        .wlast           (wlast_s3),
        .wvalid          (wvalid_s3),
        .wready          (wready_s3),
        
        .bid             (bid_s3),
        .bresp           (bresp_s3),
        .bvalid          (bvalid_s3),
        .bready          (bready_s3),
        
        .arid            (arid_s3),
        .araddr          (araddr_s3),
        .arlen           (arlen_s3),
        .arsize          (arsize_s3),
        .arburst         (arburst_s3),
        .arlock          (arlock_s3),
        .arcache         (arcache_s3),
        .arprot          (arprot_s3),
        .arvalid         (arvalid_s3),
        .arready         (arready_s3),
        
        .rid             (rid_s3),
        .rdata           (rdata_s3),
        .rresp           (rresp_s3),
        .rlast           (rlast_s3),
        .rvalid          (rvalid_s3),
        .rready          (rready_s3),
        
        .csysreq         (csysreq),
        .csysack         (csysack),
        .cactive         (cactive)
    );

    defparam axi_slave_3.ADDR_WIDTH              = ADDR_WIDTH;
    defparam axi_slave_3.DATA_WIDTH              = DATA_WIDTH;
    defparam axi_slave_3.ID_WIDTH                = IDS_WIDTH;
    defparam axi_slave_3.LEN_WIDTH               = LEN_WIDTH;
    defparam axi_slave_3.MAXLEN                  = MAXLEN;
    defparam axi_slave_3.READ_INTERLEAVE_ON      = 0;
   // defparam axi_slave_3.READ_RESP_IN_ORDER_ON  = 1;
    defparam axi_slave_3.BYTE_STROBE_ON          = 0;
    defparam axi_slave_3.EXCL_ACCESS_ON          = 0;
    defparam axi_slave_3.DATA_BEFORE_CONTROL_ON  = 0;
    defparam axi_slave_3.COVERAGE_ON             = COVERAGE_ON;


    axi4_slave axi_slave_4 (
        .aclk            (aclk_s),
        .aresetn         (aresetn_s),
        .awid            (awid_s4),
        .awaddr          (awaddr_s4),
        .awlen           (awlen_s4),
        .awsize          (awsize_s4),
        .awburst         (awburst_s4),
        .awlock          (awlock_s4),
        .awcache         (awcache_s4),
        .awprot          (awprot_s4),
        .awvalid         (awvalid_s4),
        .awready         (awready_s4),
        .awqos           (awqos_s4),  
        .awregion        (awregion_s4),  
        .awuser          (awuser_s4),   
	    .ruser           (ruser_s4),
        .arqos           (arqos_s4),  
        .arregion        (arregion_s4),  
        .aruser          (aruser_s4),
        .buser           (buser_s4),
	    .wuser           (wuser_s4),
      
        .wdata           (wdata_s4),
        .wstrb           (wstrb_s4),
        .wlast           (wlast_s4),
        .wvalid          (wvalid_s4),
        .wready          (wready_s4),
        
        .bid             (bid_s4),
        .bresp           (bresp_s4),
        .bvalid          (bvalid_s4),
        .bready          (bready_s4),
        
        .arid            (arid_s4),
        .araddr          (araddr_s4),
        .arlen           (arlen_s4),
        .arsize          (arsize_s4),
        .arburst         (arburst_s4),
        .arlock          (arlock_s4),
        .arcache         (arcache_s4),
        .arprot          (arprot_s4),
        .arvalid         (arvalid_s4),
        .arready         (arready_s4),
        
        .rid             (rid_s4),
        .rdata           (rdata_s4),
        .rresp           (rresp_s4),
        .rlast           (rlast_s4),
        .rvalid          (rvalid_s4),
        .rready          (rready_s4),
        
        .csysreq         (csysreq),
        .csysack         (csysack),
        .cactive         (cactive)
    );

    defparam axi_slave_4.ADDR_WIDTH              = ADDR_WIDTH;
    defparam axi_slave_4.DATA_WIDTH              = DATA_WIDTH;
    defparam axi_slave_4.ID_WIDTH                = IDS_WIDTH;
    defparam axi_slave_4.LEN_WIDTH               = LEN_WIDTH;
    defparam axi_slave_4.MAXLEN                  = MAXLEN;
    defparam axi_slave_4.READ_INTERLEAVE_ON      = 0;
   // defparam axi_slave_4.READ_RESP_IN_ORDER_ON  = 1;
    defparam axi_slave_4.BYTE_STROBE_ON          = 0;
    defparam axi_slave_4.EXCL_ACCESS_ON          = 0;
    defparam axi_slave_4.DATA_BEFORE_CONTROL_ON  = 0;
    defparam axi_slave_4.COVERAGE_ON             = COVERAGE_ON;
	
    axi4_slave axi_slave_5 (
        .aclk            (aclk_s),
        .aresetn         (aresetn_s),
        .awid            (awid_s5),
        .awaddr          (awaddr_s5),
        .awlen           (awlen_s5),
        .awsize          (awsize_s5),
        .awburst         (awburst_s5),
        .awlock          (awlock_s5),
        .awcache         (awcache_s5),
        .awprot          (awprot_s5),
        .awvalid         (awvalid_s5),
        .awready         (awready_s5),
        .awqos           (awqos_s5),  
        .awregion        (awregion_s5),  
        .awuser          (awuser_s5),   
	    .ruser           (ruser_s5),
        .arqos           (arqos_s5),  
        .arregion        (arregion_s5),  
        .aruser          (aruser_s5),
        .buser           (buser_s5),
	    .wuser           (wuser_s5),
      
        .wdata           (wdata_s5),
        .wstrb           (wstrb_s5),
        .wlast           (wlast_s5),
        .wvalid          (wvalid_s5),
        .wready          (wready_s5),
        
        .bid             (bid_s5),
        .bresp           (bresp_s5),
        .bvalid          (bvalid_s5),
        .bready          (bready_s5),
        
        .arid            (arid_s5),
        .araddr          (araddr_s5),
        .arlen           (arlen_s5),
        .arsize          (arsize_s5),
        .arburst         (arburst_s5),
        .arlock          (arlock_s5),
        .arcache         (arcache_s5),
        .arprot          (arprot_s5),
        .arvalid         (arvalid_s5),
        .arready         (arready_s5),
        
        .rid             (rid_s5),
        .rdata           (rdata_s5),
        .rresp           (rresp_s5),
        .rlast           (rlast_s5),
        .rvalid          (rvalid_s5),
        .rready          (rready_s5),
        
        .csysreq         (csysreq),
        .csysack         (csysack),
        .cactive         (cactive)
    );

    defparam axi_slave_5.ADDR_WIDTH              = ADDR_WIDTH;
    defparam axi_slave_5.DATA_WIDTH              = DATA_WIDTH;
    defparam axi_slave_5.ID_WIDTH                = IDS_WIDTH;
    defparam axi_slave_5.LEN_WIDTH               = LEN_WIDTH;
    defparam axi_slave_5.MAXLEN                  = MAXLEN;
    defparam axi_slave_5.READ_INTERLEAVE_ON      = 0;
   // defparam axi_slave_5.READ_RESP_IN_ORDER_ON  = 1;
    defparam axi_slave_5.BYTE_STROBE_ON          = 0;
    defparam axi_slave_5.EXCL_ACCESS_ON          = 0;
    defparam axi_slave_5.DATA_BEFORE_CONTROL_ON  = 0;
    defparam axi_slave_5.COVERAGE_ON             = COVERAGE_ON;


    // Instance of the AXI Master (connects to the slave interface of the bridge)
    axi4_master axi_master_0 (
        .aclk            (aclk_m),
        .aresetn         (aresetn_m),
        .awid            (awid_m0),
        .awaddr          (awaddr_m0),
        .awlen           (awlen_m0),
        .awsize          (awsize_m0),
        .awburst         (awburst_m0),
        .awlock          (awlock_m0),
        .awcache         (awcache_m0),
        .awprot          (awprot_m0),
        .awvalid         (awvalid_m0),
        .awready         (awready_m0),
        .awqos           (awqos_m0),  
        .awregion        (awregion_m0),  
        .awuser          (awuser_m0),   
	    .ruser           (ruser_m0),
        .arqos           (arqos_m0),  
        .arregion        (arregion_m0),  
        .aruser          (aruser_m0),
        .buser           (buser_m0),
	    .wuser           (wuser_m0),
       
        .wdata           (wdata_m0),
        .wstrb           (wstrb_m0),
        .wlast           (wlast_m0),
        .wvalid          (wvalid_m0),
        .wready          (wready_m0),
        
        .bid             (bid_m0),
        .bresp           (bresp_m0),
        .bvalid          (bvalid_m0),
        .bready          (bready_m0),
        
        .arid            (arid_m0),
        .araddr          (araddr_m0),
        .arlen           (arlen_m0),
        .arsize          (arsize_m0),
        .arburst         (arburst_m0),
        .arlock          (arlock_m0),
        .arcache         (arcache_m0),
        .arprot          (arprot_m0),
        .arvalid         (arvalid_m0),
        .arready         (arready_m0),
        
        .rid             (rid_m0),
        .rdata           (rdata_m0),
        .rresp           (rresp_m0),
        .rlast           (rlast_m0),
        .rvalid          (rvalid_m0),
        .rready          (rready_m0),
        
        .csysreq         (csysreq),
        .csysack         (csysack),
        .cactive         (cactive)
    );

    defparam axi_master_0.ADDR_WIDTH              = ADDR_WIDTH;
    defparam axi_master_0.DATA_WIDTH              = DATA_WIDTH;
    defparam axi_master_0.ID_WIDTH                = ID_WIDTH;
    defparam axi_master_0.LEN_WIDTH               = LEN_WIDTH;
    defparam axi_master_0.MAXLEN                  = MAXLEN;
    defparam axi_master_0.READ_INTERLEAVE_ON      = 0;
    defparam axi_master_0.BYTE_STROBE_ON          = 0;
    defparam axi_master_0.EXCL_ACCESS_ON          = 0;
    defparam axi_master_0.DATA_BEFORE_CONTROL_ON  = 0;
    defparam axi_master_0.COVERAGE_ON             = COVERAGE_ON;
    

    axi4_master axi_master_1 (
        .aclk            (aclk_m),
        .aresetn         (aresetn_m),
        .awid            (awid_m1),
        .awaddr          (awaddr_m1),
        .awlen           (awlen_m1),
        .awsize          (awsize_m1),
        .awburst         (awburst_m1),
        .awlock          (awlock_m1),
        .awcache         (awcache_m1),
        .awprot          (awprot_m1),
        .awvalid         (awvalid_m1),
        .awready         (awready_m1),
        .awqos           (awqos_m1),  
        .awregion        (awregion_m1),  
        .awuser          (awuser_m1),   
	    .ruser           (ruser_m1),
        .arqos           (arqos_m1),  
        .arregion        (arregion_m1),  
        .aruser          (aruser_m1),
        .buser           (buser_m1),
	    .wuser           (wuser_m1),
       
        .wdata           (wdata_m1),
        .wstrb           (wstrb_m1),
        .wlast           (wlast_m1),
        .wvalid          (wvalid_m1),
        .wready          (wready_m1),
        
        .bid             (bid_m1),
        .bresp           (bresp_m1),
        .bvalid          (bvalid_m1),
        .bready          (bready_m1),
        
        .arid            (arid_m1),
        .araddr          (araddr_m1),
        .arlen           (arlen_m1),
        .arsize          (arsize_m1),
        .arburst         (arburst_m1),
        .arlock          (arlock_m1),
        .arcache         (arcache_m1),
        .arprot          (arprot_m1),
        .arvalid         (arvalid_m1),
        .arready         (arready_m1),
        
        .rid             (rid_m1),
        .rdata           (rdata_m1),
        .rresp           (rresp_m1),
        .rlast           (rlast_m1),
        .rvalid          (rvalid_m1),
        .rready          (rready_m1),
        
        .csysreq         (csysreq),
        .csysack         (csysack),
        .cactive         (cactive)
    );

    defparam axi_master_1.ADDR_WIDTH              = ADDR_WIDTH;
    defparam axi_master_1.DATA_WIDTH              = DATA_WIDTH;
    defparam axi_master_1.ID_WIDTH                = ID_WIDTH;
    defparam axi_master_1.LEN_WIDTH               = LEN_WIDTH;
    defparam axi_master_1.MAXLEN                  = MAXLEN;
    defparam axi_master_1.READ_INTERLEAVE_ON      = 0;
    defparam axi_master_1.BYTE_STROBE_ON          = 0;
    defparam axi_master_1.EXCL_ACCESS_ON          = 0;
    defparam axi_master_1.DATA_BEFORE_CONTROL_ON  = 0;
    defparam axi_master_1.COVERAGE_ON             = COVERAGE_ON;

endmodule // top
