// This module detect whether data is valid or not
// using the charateristics of "Gray Code"

module synchronizer
#(
    parameter width = 3
)
(
    input clk,
    input nrst,
    
    // asynchronous data
    input [width-1:0] async_data,
    // synchronous data
    output [width-1:0] sync_data
);
reg [width-1:0] sync_reg1;
reg [width-1:0] sync_reg2;

// First stage sync register
always@(posedge clk) begin
    if(~nrst)
        sync_reg1 <= {width{1'b0}};
    else
        sync_reg1 <= async_data;
    //sync_reg1 <= async_data;
end

// Second stage sync register
always@(posedge clk) begin
    if(~nrst)
        sync_reg2 <= {width{1'b0}};
    else
        sync_reg2 <= sync_reg1;
    //sync_reg2 <= sync_reg1;
end

assign sync_data = sync_reg2;

endmodule