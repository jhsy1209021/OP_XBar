module graycode_encoder
#(
    parameter width = 4
)
(
    input [width-1:0] number,
    output reg [width-1:0] g_number
);
//Signals

always_comb begin
    for (int i = 0; i < width-1; i++) begin
        g_number[i] = number[i] ^ number[i+1];
    end
    g_number[width-1] = number[width-1] ^ 1'b0;
end
endmodule