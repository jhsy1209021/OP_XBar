// This module detect whether data is valid or not
// using the charateristics of "Gray Code"

module synchronizer_3
(
    input clk,
    input nrst,
    
    // asynchronous data
    input [3:0] async_data,
    // synchronous data
    output [3:0] sync_data
);
reg [3:0] sync_reg1;
reg [3:0] sync_reg2;

// First stage sync register
always@(posedge clk) begin
    if(~nrst)
        sync_reg1 <= 4'd0;
    else
        sync_reg1 <= async_data;
    //sync_reg1 <= async_data;
end

// Second stage sync register
always@(posedge clk) begin
    if(~nrst)
        sync_reg2 <= 4'd0;
    else
        sync_reg2 <= sync_reg1;
    //sync_reg2 <= sync_reg1;
end

assign sync_data = sync_reg2;

endmodule