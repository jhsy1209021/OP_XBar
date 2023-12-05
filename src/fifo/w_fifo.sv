module w_fifo
//Parameters
#(
    //XBar Setup
    parameter DATA_WIDTH = 32,
    parameter STRB_WIDTH = 3,

    parameter pending_depth = 4
)
//Ports
(
    //Global Signal
    input ACLK,
    input ARESETn,

    //AXI Ports
    input [DATA_WIDTH-1:0]      WDATA,
    input [STRB_WIDTH-1:0]      WSTRB,
    input                       WLAST,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [DATA_WIDTH-1:0]      front_WDATA,
    output [STRB_WIDTH-1:0]      front_WSTRB,
    output                       front_WLAST
);
//Registers
reg [$clog2(pending_depth)-1:0] front, back;
reg [DATA_WIDTH-1:0] WDATA_reg [0:pending_depth-1];
reg [STRB_WIDTH-1:0] WSTRB_reg [0:pending_depth-1];
reg WLAST_reg [0:pending_depth-1];

//Ring Shifter
always@(posedge ACLK) begin
    if(~ARESETn) begin
        for(int i = 0; i < pending_depth; i++) begin
            WDATA_reg[i] <= {DATA_WIDTH{1'b0}};
            WSTRB_reg[i] <= {STRB_WIDTH{1'b0}};
            WLAST_reg[i] <= 1'b0;
        end
    end

    else begin
        if(push & ~full) begin
            WDATA_reg[back] <= WDATA;
            WSTRB_reg[back] <= WSTRB;
            WLAST_reg[back] <= WLAST;
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
assign front_WDATA = WDATA_reg[front];
assign front_WSTRB = WSTRB_reg[front];
assign front_WLAST = WLAST_reg[front];
assign full = ((back + 1) == front);
assign empty = (back == front);
endmodule