`ifndef AXI_CHANNEL_WIDTH
`define AXI_CHANNEL_WIDTH
    `define AXI_ID_BITS 4
    `define AXI_IDS_BITS 8
    `define AXI_ADDR_BITS 32
    `define AXI_LEN_BITS 4
    `define AXI_SIZE_BITS 3
    `define AXI_DATA_BITS 32
    `define AXI_STRB_BITS 4
`endif

`ifndef AXI_RESP
`define AXI_RESP
    `define AXI_RESP_OKAY 2'h0
    `define AXI_RESP_SLVERR 2'h2
    `define AXI_RESP_DECERR 2'h3
`endif