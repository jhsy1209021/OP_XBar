module graycode_encoder_16(
    input [3:0] number,
    output reg [3:0] g_number
);
//Gray code enum
typedef enum reg[3:0] {
    g0 = 4'b0000,
    g1 = 4'b0001,
    g2 = 4'b0011,
    g3 = 4'b0010,
    g4 = 4'b0110,
    g5 = 4'b0111,
    g6 = 4'b0101,
    g7 = 4'b0100,
    g8 = 4'b1100,
    g9 = 4'b1101,
    g10 = 4'b1111,
    g11 = 4'b1110,
    g12 = 4'b1010,
    g13 = 4'b1011,
    g14 = 4'b1001,
    g15 = 4'b1000
} gray_code;

always_comb begin
    case(number)
        4'd0:
            g_number = g0;
        4'd1:
            g_number = g1;
        4'd2:
            g_number = g2;
        4'd3:
            g_number = g3;
        4'd4:
            g_number = g4;
        4'd5:
            g_number = g5;
        4'd6:
            g_number = g6;
        4'd7:
            g_number = g7;
        4'd8:
            g_number = g8;
        4'd9:
            g_number = g9;
        4'd10:
            g_number = g10;
        4'd11:
            g_number = g11;
        4'd12:
            g_number = g12;
        4'd13:
            g_number = g13;
        4'd14:
            g_number = g14;
        4'd15:
            g_number = g15;
    endcase
end
endmodule