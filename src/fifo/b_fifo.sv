module b_fifo
//Parameters
#(
    //XBar Setup
    parameter ID_WIDTH = 4 
)
//Ports
(
    //Global Signal
    input clk_tx,
    input clk_rx,
    input nrst_tx,
    input nrst_rx,

    //AXI Ports
    input [ID_WIDTH-1:0]        BID,
    input [1:0]                 BRESP,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [ID_WIDTH-1:0]        front_BID,
    output [1:0]                 front_BRESP
);
//Instantiate async_fifo
async_fifo_8 #(
    .DATA_WIDTH(ID_WIDTH + 2)
) async_b_fifo_8 (
    //Clock
    .clk_tx(clk_tx),
    .clk_rx(clk_rx),
    //Reset
    .nrst_tx(nrst_tx),
    .nrst_rx(nrst_rx),

    //Data Operation
    .push_tx(push),
    .pop_rx(pop),
    .DI_tx({BID, BRESP}),
    .DO_rx({front_BID, front_BRESP}),
    .full_tx(full),
    .empty_rx(empty)
);
endmodule
