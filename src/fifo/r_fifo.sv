module r_fifo
//Parameters
#(
    //XBar Setup
    parameter ID_WIDTH = 4,
    parameter DATA_WIDTH = 32
)
//Ports
(
    //Global Signal
    input clk_tx,
    input clk_rx,
    input nrst_tx,
    input nrst_rx,

    //AXI Ports
    input [ID_WIDTH-1:0]        RID,
    input [DATA_WIDTH-1:0]      RDATA,
    input [1:0]                 RRESP,
    input                       RLAST,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [ID_WIDTH-1:0]        front_RID,
    output [DATA_WIDTH-1:0]      front_RDATA,
    output [1:0]                 front_RRESP,
    output                       front_RLAST
);
//Instantiate async_fifo
async_fifo_8 #(
    .DATA_WIDTH(ID_WIDTH + DATA_WIDTH + 2 + 1)
) async_r_fifo_8 (
    //Clock
    .clk_tx(clk_tx),
    .clk_rx(clk_rx),
    //Reset
    .nrst_tx(nrst_tx),
    .nrst_rx(nrst_rx),

    //Data Operation
    .push_tx(push),
    .pop_rx(pop),
    .DI_tx({RID, RDATA, RRESP, RLAST}),
    .DO_rx({front_RID, front_RDATA, front_RRESP, front_RLAST}),
    .full_tx(full),
    .empty_rx(empty)
);
endmodule
