module ar_fifo
//Parameters
#(
    parameter PENDING_DEPTH = 4,
    parameter ID_WIDTH = 4,
    parameter DATA_WIDTH = 32
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
reg [$clog2(PENDING_DEPTH)-1:0] front, back, counter;
reg [ID_WIDTH-1:0] RID_reg [0:PENDING_DEPTH-1];
reg [DATA_WIDTH-1:0] RDATA_reg [0:PENDING_DEPTH-1];
reg [1:0] RRESP_reg [0:PENDING_DEPTH-1];
reg RLAST_reg [0:PENDING_DEPTH-1];

//Ring Shifter
always@(posedge ACLK) begin
    if(~ARESETn) begin
        for(int i = 0; i < PENDING_DEPTH; i++) begin
            RID_reg[i] <= {ID_WIDTH{1'b0}};
            RDATA_reg[i] <= {DATA_WIDTH{1'b0}};
            RRESP_reg[i] <= 2'b0;
            RLAST_reg[i] <= 1'b0;
        end
    end

    else begin
        if(push) begin
            if(counter != {$clog2(PENDING_DEPTH){1'b1}}) begin
                RID_reg[back] <= RID;
                RDATA_reg[back] <= RDATA;
                RRESP_reg[back] <= RRESP;
                RLAST_reg[back] <= RLAST;
            end
        end
    end
end

//front counter
always@(posedge ACLK) begin
    if(~ARESETn)
        front <= {$clog2(PENDING_DEPTH){1'b0}};
    else begin
        if(pop) begin
            if(counter != {$clog2(PENDING_DEPTH){1'b0}})
                front <= front + 1;
        end
    end
end

//back counter
always@(posedge ACLK) begin
    if(~ARESETn)
        back <= {$clog2(PENDING_DEPTH){1'b0}};
    else begin
        if(push) begin
            if(counter != {$clog2(PENDING_DEPTH){1'b1}})
                back <= back + 1;
        end
    end
end

//counter
always@(posedge ACLK) begin
    if(~ARESETn)
        counter <= {$clog2(PENDING_DEPTH){1'b0}};
    else begin
        priority if(push & pop)
            counter <= counter;
        
        else if(push) begin
            if(counter != {$clog2(PENDING_DEPTH){1'b1}})
                counter <= counter + 1;
        end
        
        else if(pop) begin
            if(counter != {$clog2(PENDING_DEPTH){1'b0}})
                counter <= counter - 1;
        end
    end
end

//Assign output
assign front_RID = RID_reg[front];
assign front_RDATA = RDATA_reg[front];
assign front_RRESP = RRESP_reg[front];
assign front_RLAST = RLAST_reg[front];
assign full = (counter == {$clog2(PENDING_DEPTH){1'b1}});
assign empty = (counter == {$clog2(PENDING_DEPTH){1'b0}});
endmodule