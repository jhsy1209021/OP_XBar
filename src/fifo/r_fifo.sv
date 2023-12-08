module r_fifo
//Parameters
#(
    //XBar Setup
    parameter ID_WIDTH = 4,
    parameter DATA_WIDTH = 32,

    parameter pending_depth = 4
)
//Ports
(
    //Global Signal
    input ACLK,
    input ARESETn,

    //AXI Ports
    input [ID_WIDTH-1:0]        RID,
    input [DATA_WIDTH-1:0]      RDATA,
    input [1:0]                 RRESP,
    input                       RLAST,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [ID_WIDTH-1:0]        front_RID,
    output [DATA_WIDTH-1:0]      front_RDATA,
    output [1:0]                 front_RRESP,
    output                       front_RLAST
);
//Registers
reg [$clog2(pending_depth)-1:0] front, back;
reg [ID_WIDTH-1:0] RID_reg [0:pending_depth-1];
reg [DATA_WIDTH-1:0] RDATA_reg [0:pending_depth-1];
reg [1:0] RRESP_reg [0:pending_depth-1];
reg RLAST_reg [0:pending_depth-1];

//Ring Shifter
always@(posedge ACLK) begin
    if(~ARESETn) begin
        for(int i = 0; i < pending_depth; i++) begin
            RID_reg[i] <= {ID_WIDTH{1'b0}};
            RDATA_reg[i] <= {DATA_WIDTH{1'b0}};
            RRESP_reg[i] <= 2'b0;
            RLAST_reg[i] <= 1'b0;
        end
    end

    else begin
        if(push & ~full) begin
            RID_reg[back] <= RID;
            RDATA_reg[back] <= RDATA;
            RRESP_reg[back] <= RRESP;
            RLAST_reg[back] <= RLAST;
        end
    end
end

//front counter
always@(posedge ACLK) begin
    if(~ARESETn)
        front <= {$clog2(pending_depth){1'b0}};
    else begin
        if(pop & ~empty) begin
            front <= front + {$clog2(pending_depth){1'b1}};
        end
    end
end

//back counter
always@(posedge ACLK) begin
    if(~ARESETn)
        back <= {$clog2(pending_depth){1'b0}};
    else begin
        if(push & ~full) begin
            back <= back + {$clog2(pending_depth){1'b1}};
        end
    end
end

//Assign output
assign front_RID = RID_reg[front];
assign front_RDATA = RDATA_reg[front];
assign front_RRESP = RRESP_reg[front];
assign front_RLAST = RLAST_reg[front];
assign full = ((back + {$clog2(pending_depth){1'b1}}) == front);
assign empty = (back == front);
endmodule
