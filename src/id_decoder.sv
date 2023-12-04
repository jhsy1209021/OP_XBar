module id_decoder
#(
    //AXI Setup
    parameter ID_WIDTH = 4,
    parameter IDS_WIDTH = 5,

    parameter masters = 2,
    parameter slaves = 2
)
(
    input [IDS_WIDTH-1:0] id,
    output [$clog2(masters)-1:0] dest_master
);

assign dest_master = id[IDS_WIDTH-1:ID_WIDTH];

endmodule