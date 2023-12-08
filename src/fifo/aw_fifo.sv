module aw_fifo
//Parameters
#(
    //XBar Setup
    parameter ID_WIDTH = 4,
    parameter ADDR_WIDTH = 32,
    parameter LEN_WIDTH = 4,
    parameter SIZE_WIDTH = 3
)
//Ports
(
    //Global Signal
    input clk_tx,
    input clk_rx,
    input nrst_tx,
    input nrst_rx,

    //AXI Ports
    input [ID_WIDTH-1:0]        AWID,
    input [ADDR_WIDTH-1:0]      AWADDR,
    input [LEN_WIDTH-1:0]       AWLEN,
    input [SIZE_WIDTH-1:0]      AWSIZE,
    input [1:0]                 AWBURST,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [ID_WIDTH-1:0]         front_AWID,
    output [ADDR_WIDTH-1:0]       front_AWADDR,
    output [LEN_WIDTH-1:0]        front_AWLEN,
    output [SIZE_WIDTH-1:0]       front_AWSIZE,
    output [1:0]                front_AWBURST
);
//Instantiate async_fifo
async_fifo_8 #(
    .DATA_WIDTH(ID_WIDTH + ADDR_WIDTH + LEN_WIDTH + SIZE_WIDTH + 2)
) async_ar_fifo_8 (
    //Clock
    .clk_tx(clk_tx),
    .clk_rx(clk_rx),
    //Reset
    .nrst_tx(nrst_tx),
    .nrst_rx(nrst_rx),

    //Data Operation
    .push_tx(push),
    .pop_rx(pop),
    .DI_tx({AWID, AWADDR, AWLEN, AWSIZE, AWBURST}),
    .DO_rx({front_AWID, front_AWADDR, front_AWLEN, front_AWSIZE, front_AWBURST}),
    .full_tx(full),
    .empty_rx(empty)
);
endmodule
