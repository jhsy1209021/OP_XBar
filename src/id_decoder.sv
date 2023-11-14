`include "axi_define.svh"

module id_decoder
#(
    parameter masters = 2,
    parameter slaves = 2
)
(
    input [`AXI_IDS_BITS-1:0] id,
    output [$clog2(masters)-1:0] dest_master
);

assign dest_master = id[`AXI_IDS_BITS-1:`AXI_ID_BITS];

endmodule