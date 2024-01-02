module ar_fifo
//Parameters
#(
    //XBar Setup
    parameter ID_WIDTH = 4,
    parameter ADDR_WIDTH = 32,
    parameter LEN_WIDTH = 4,
    parameter SIZE_WIDTH = 3,

    parameter pending_depth = 8
)
//Ports
(
    //Global Signal
    input clk_tx,
    input clk_rx,
    input nrst_tx,
    input nrst_rx,

    //AXI Ports
    input [ID_WIDTH-1:0]        ARID,
    input [ADDR_WIDTH-1:0]      ARADDR,
    input [LEN_WIDTH-1:0]       ARLEN,
    input [SIZE_WIDTH-1:0]      ARSIZE,
    input [1:0]                 ARBURST,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [ID_WIDTH-1:0]         front_ARID,
    output [ADDR_WIDTH-1:0]       front_ARADDR,
    output [LEN_WIDTH-1:0]        front_ARLEN,
    output [SIZE_WIDTH-1:0]       front_ARSIZE,
    output [1:0]                front_ARBURST
);
//Instantiate async_fifo
async_fifo #(
    .DATA_WIDTH(ID_WIDTH + ADDR_WIDTH + LEN_WIDTH + SIZE_WIDTH + 2),
    .pointer_width($clog2(pending_depth))
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
    .DI_tx({ARID, ARADDR, ARLEN, ARSIZE, ARBURST}),
    .DO_rx({front_ARID, front_ARADDR, front_ARLEN, front_ARSIZE, front_ARBURST}),
    .full_tx(full),
    .empty_rx(empty)
);
endmodule
