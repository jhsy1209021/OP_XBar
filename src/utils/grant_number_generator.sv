module grant_number_generator
#(
    parameter candidate = 2
)
(
    input [candidate-1:0] request_vec,
    input [$clog2(candidate)-1:0] priority_array [0:candidate-1],
    output reg [$clog2(candidate)-1:0] grant_number
);
//Signals
reg [candidate-1:0] rearrage_request_vec;

always_comb begin
    for(int i = 0; i < candidate; i++) begin
        rearrage_request_vec[i] = request_vec[priority_array[i]];
    end
end

always_comb begin
    for(int i = 0; i < candidate; i++) begin
        if(rearrage_request_vec[i] == 1'b1) begin
            grant_number = i[$clog2(candidate)-1:0];
            break;
        end

        else
            grant_number = {$clog2(candidate){1'b0}};
    end
end

endmodule