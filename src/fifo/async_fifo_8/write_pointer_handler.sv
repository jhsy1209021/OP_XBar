//`include "graycode_encoder_16.sv"

module write_pointer_handler (
    input clk_tx,
    input nrst_tx,
    input push,
    input [3:0] synced_graycoded_read_pointer,

    output reg full,
    output [2:0] write_pointer,
    output reg [3:0] graycoded_write_pointer
);
//Registers
reg [3:0] write_counter;

//Signals
wire [3:0] graycoded_write_counter;

// Counter
always@(posedge clk_tx) begin
    if(~nrst_tx)
        write_counter <= 4'd0;
    
    else begin
        if(push)
            write_counter <= write_counter + 4'd1;
    end
end

// Compare to synced read pointer to generate full signal
graycode_encoder_16 encode_write_pointer0(
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
assign write_pointer = write_counter[2:0];
//Add a register to hide graycode encoder combinational circuit in the front of CDC
always@(posedge clk_tx) begin
    if(~nrst_tx)
        graycoded_write_pointer <= 4'd0;
    else
        graycoded_write_pointer <= graycoded_write_counter;
end

endmodule