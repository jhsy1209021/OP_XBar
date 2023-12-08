//`include "graycode_encoder_16.sv"

module read_pointer_handler (
    input clk_rx,
    input nrst_rx,
    input pop,
    input [3:0] synced_graycoded_write_pointer,

    output reg empty,
    output [2:0] read_pointer,
    output reg [3:0] graycoded_read_pointer
);
reg [3:0] read_counter;
wire [3:0] graycoded_read_counter;

// Counter
always@(posedge clk_rx) begin
    if(~nrst_rx)
        read_counter <= 4'd0;
    
    else begin
        if(pop)
            read_counter <= read_counter + 4'd1;
    end
end

// Compare to synced read pointer to generate full signal
graycode_encoder_16 encode_read_pointer0(
    .number(read_counter),
    .g_number(graycoded_read_counter)
);
always_comb begin
    if((graycoded_read_counter == synced_graycoded_write_pointer))
        empty = 1'b1;
    else
        empty = 1'b0;
end

// Decide output
assign read_pointer = read_counter[2:0];
//Add a register to hide graycode encoder combinational circuit in the front of CDC
always@(posedge clk_rx) begin
    if(~nrst_rx)
        graycoded_read_pointer <= 4'd0;
    else
        graycoded_read_pointer <= graycoded_read_counter;
end
endmodule