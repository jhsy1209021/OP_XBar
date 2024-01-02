//`include "graycode_encoder_16.sv"

module read_pointer_handler
#(
    parameter pointer_width = 3
)
(
    input clk_rx,
    input nrst_rx,
    input pop,
    input [pointer_width:0] synced_graycoded_write_pointer,

    output reg empty,
    output [pointer_width-1:0] read_pointer,
    output reg [pointer_width:0] graycoded_read_pointer
);
//Registers
reg [pointer_width:0] read_counter;

//Signals
wire [pointer_width:0] graycoded_read_counter;

// Counter
always@(posedge clk_rx) begin
    if(~nrst_rx)
        read_counter <= {(pointer_width+1){1'b0}};
    
    else begin
        if(pop & ~empty)
            read_counter <= read_counter + { {(pointer_width){1'b0}}, {1'b1} };
    end
end

// Compare to synced read pointer to generate full signal
graycode_encoder #(
    .width(pointer_width + 1)
) encode_read_pointer0(
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
assign read_pointer = read_counter[pointer_width-1:0];
//Add a register to hide graycode encoder combinational circuit in the front of CDC
always@(posedge clk_rx) begin
    if(~nrst_rx)
        graycoded_read_pointer <= {(pointer_width+1){1'b0}};
    else
        graycoded_read_pointer <= graycoded_read_counter;
end
endmodule