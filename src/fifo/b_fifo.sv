module b_fifo
//Parameters
#(
    //XBar Setup
    parameter ID_WIDTH = 4,

    parameter pending_depth = 4    
)
//Ports
(
    //Global Signal
    input ACLK,
    input ARESETn,

    //AXI Ports
    input [ID_WIDTH-1:0]        BID,
    input [1:0]                 BRESP,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [ID_WIDTH-1:0]        front_BID,
    output [1:0]                 front_BRESP
);
//Registers
reg [$clog2(pending_depth)-1:0] front, back;
reg [ID_WIDTH-1:0] BID_reg [0:pending_depth-1];
reg [1:0] BRESP_reg [0:pending_depth-1];

//Ring Shifter
always@(posedge ACLK) begin
    if(~ARESETn) begin
        for(int i = 0; i < pending_depth; i++) begin
            BID_reg[i] <= {ID_WIDTH{1'b0}};
            BRESP_reg[i] <= 2'b0;
        end
    end

    else begin
        if(push & ~full) begin
            BID_reg[back] <= BID;
            BRESP_reg[back] <= BRESP;
        end
    end
end

//front counter
always@(posedge ACLK) begin
    if(~ARESETn)
        front <= {$clog2(pending_depth){1'b0}};
    else begin
        if(pop & ~empty) begin
            front <= front + 1;
        end
    end
end

//back counter
always@(posedge ACLK) begin
    if(~ARESETn)
        back <= {$clog2(pending_depth){1'b0}};
    else begin
        if(push & ~full) begin
            back <= back + 1;
        end
    end
end

//Assign output
assign front_BID = BID_reg[front];
assign front_BRESP = BRESP_reg[front];
assign full = ((back + 1) == front);
assign empty = (back == front);
endmodule