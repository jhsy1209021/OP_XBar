`ifndef XBAR_MASTER_INTERFACE
`define XBAR_MASTER_INTERFACE
    `include "xbar_master_interface.sv"
    `include "forward_arbiter.sv"
    `include "id_decoder.sv"

    `ifndef FIFOS
    `define FIFOS
        `include "async_fifo.svh"
        `include "ar_fifo.sv"
        `include "aw_fifo.sv"
        `include "b_fifo.sv"
        `include "r_fifo.sv"
        `include "w_fifo.sv"
    `endif

    `ifndef GRANT_NUMBER_GENERATOR
    `define GRANT_NUMBER_GENERATOR
        `include "grant_number_generator.sv"
    `endif

    `ifndef ONEHOT_DETECTOR
    `define ONEHOT_DETECTOR
        `include "onehot_detector.sv"
    `endif
`endif