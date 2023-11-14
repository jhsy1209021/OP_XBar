module onehot_detector
#(
    parameter width = 2
)
(
    input [width-1:0] input_vec,
    output is_onehot
);

// Detect algorithm:
// if or_reduce(input_vec) == 0 --> not onehot
//
// else
// -> 1. Generate true onehot signal
// -> 2. compare(xor) the "true onehot signal" and "input_vec"
// -> 3. "and_reduce" the compare result

//Signals
reg [width-1:0] mask;
wire [width-1:0] true_onehot_signal;
wire [width-1:0] compare_result_per_bit;

//Generate leading 0 mask
always@(*) begin
    mask[0] = 1'b1;
    for(int i = 1; i < width; i++) begin
        mask[i] = (mask[i-1] & input_vec[i-1]);
    end
end
//Generate true onehot signal
assign true_onehot_signal = input_vec & mask;

//Compare input_vec and true onehot signal
assign compare_result_per_bit = ~(input_vec ^ true_onehot_signal);

//Or-Reduce input_vec to make sure input_vec has at least one set bit
//AND-Reduce to determine "input_vec" and "true_onehot_signal" is identical
assign is_onehot = (&compare_result_per_bit) & (|input_vec);

endmodule