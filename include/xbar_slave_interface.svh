`ifndef XBAR_SLAVE_INTERFACE
`define XBAR_SLAVE_INTERFACE
    `include "backward_arbiter.sv"
    `include "addr_decoder.sv"

    `ifndef FIFOS
    `define FIFOS
        `include "ar_fifo.sv"
        `include "aw_fifo.sv"
        `include "b_fifo.sv"
        `include "r_fifo.sv"
        `include "w_fifo.sv"
    `endif
`endif