`ifndef XBAR_MASTER_INTERFACE
`define XBAR_MASTER_INTERFACE
    `include "forward_arbiter.sv"
    `include "id_decoder.sv"

    `ifndef FIFOS
    `define FIFOS
        `include "ar_fifo.sv"
        `include "aw_fifo.sv"
        `include "b_fifo.sv"
        `include "r_fifo.sv"
        `include "w_fifo.sv"
    `endif
`endif