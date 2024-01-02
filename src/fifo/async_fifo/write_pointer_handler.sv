//`include "graycode_encoder_16.sv"

module write_pointer_handler
#(
    parameter pointer_width = 3
)
(
    input clk_tx,
    input nrst_tx,
    input push,
    input [pointer_width:0] synced_graycoded_read_pointer,

    output reg full,
    output [pointer_width-1:0] write_pointer,
    output reg [pointer_width:0] graycoded_write_pointer
);
//Registers
reg [pointer_width:0] write_counter;

//Signals
wire [pointer_width:0] graycoded_write_counter;

// Counter
always@(posedge clk_tx) begin
    if(~nrst_tx)
        write_counter <= {(pointer_width+1){1'b0}};
    
    else begin
        if(push & ~full)
            write_counter <= write_counter + { {(pointer_width){1'b0}}, {1'b1} };
    end
end

// Compare to synced read pointer to generate full signal
graycode_encoder #(
    .width(pointer_width + 1)
) encode_write_pointer0(
    .number(write_counter),
    .g_number(graycoded_write_counter)
);
always_comb begin
    if((graycoded_write_counter[3:2] == ~synced_graycoded_read_pointer[3:2]) && (graycoded_write_counter[1:0] == synced_graycoded_read_pointer[1:0]))
        full = 1'b1;
    else
        full = 1'b0;
end

// Decide output
assign write_pointer = write_counter[pointer_width-1:0];
//Add a register to hide graycode encoder combinational circuit in the front of CDC
always@(posedge clk_tx) begin
    if(~nrst_tx)
        graycoded_write_pointer <= {(pointer_width+1){1'b0}};
    else
        graycoded_write_pointer <= graycoded_write_counter;
end

endmodule