module w_fifo
//Parameters
#(
    //XBar Setup
    parameter DATA_WIDTH = 32,
    parameter STRB_WIDTH = 3,

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
    input [DATA_WIDTH-1:0]      WDATA,
    input [STRB_WIDTH-1:0]      WSTRB,
    input                       WLAST,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [DATA_WIDTH-1:0]      front_WDATA,
    output [STRB_WIDTH-1:0]      front_WSTRB,
    output                       front_WLAST
);
//Instantiate async_fifo
async_fifo #(
    .DATA_WIDTH(DATA_WIDTH + STRB_WIDTH + 1),
    .pointer_width($clog2(pending_depth))
) async_w_fifo_8 (
    //Clock
    .clk_tx(clk_tx),
    .clk_rx(clk_rx),
    //Reset
    .nrst_tx(nrst_tx),
    .nrst_rx(nrst_rx),

    //Data Operation
    .push_tx(push),
    .pop_rx(pop),
    .DI_tx({WDATA, WSTRB, WLAST}),
    .DO_rx({front_WDATA, front_WSTRB, front_WLAST}),
    .full_tx(full),
    .empty_rx(empty)
);
endmodule
