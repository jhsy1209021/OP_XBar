module aw_fifo
//Parameters
#(
    parameter PENDING_DEPTH = 4,
    parameter ID_WIDTH = 4,
    parameter ADDR_WIDTH = 32,
    parameter LEN_WIDTH = 4,
    parameter SIZE_WIDTH = 3
)
//Ports
(
    //Global Signal
    input ACLK,
    input ARESETn,

    //AXI Ports
    input [ID_WIDTH-1:0]        AWID,
    input [ADDR_WIDTH-1:0]      AWADDR,
    input [LEN_WIDTH-1:0]       AWLEN,
    input [SIZE_WIDTH-1:0]      AWSIZE,
    input [1:0]                 AWBURST,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [ID_WIDTH-1:0]         front_AWID,
    output [ADDR_WIDTH-1:0]       front_AWADDR,
    output [LEN_WIDTH-1:0]        front_AWLEN,
    output [SIZE_WIDTH-1:0]       front_AWSIZE,
    output [1:0]                front_AWBURST
);
//Registers
reg [$clog2(PENDING_DEPTH)-1:0] front, back, counter;
reg [ID_WIDTH-1:0] AWID_reg [0:PENDING_DEPTH-1];
reg [ADDR_WIDTH-1:0] AWADDR_reg [0:PENDING_DEPTH-1];
reg [LEN_WIDTH-1:0] AWLEN_reg [0:PENDING_DEPTH-1];
reg [SIZE_WIDTH-1:0] AWSIZE_reg [0:PENDING_DEPTH-1];
reg [1:0] AWBURST_reg [0:PENDING_DEPTH-1];

//Ring Shifter
always@(posedge ACLK) begin
    if(~ARESETn) begin
        for(int i = 0; i < PENDING_DEPTH; i++) begin
            AWID_reg[i] <= {ID_WIDTH{1'b0}};
            AWADDR_reg[i] <= {ADDR_WIDTH{1'b0}};
            AWLEN_reg[i] <= {LEN_WIDTH{1'b0}};
            AWSIZE_reg[i] <= {SIZE_WIDTH{1'b0}};
            AWBURST_reg[i] <= {2{1'b0}};
        end
    end

    else begin
        if(push) begin
            if(counter != {$clog2(PENDING_DEPTH){1'b1}}) begin
                AWID_reg[back] <= AWID;
                AWADDR_reg[back] <= AWADDR;
                AWLEN_reg[back] <= AWLEN;
                AWSIZE_reg[back] <= AWSIZE;
                AWBURST_reg[back] <= AWBURST;
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
        if(push & pop)
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
assign front_AWID = AWID_reg[front];
assign front_AWADDR = AWADDR_reg[front];
assign front_AWLEN = AWLEN_reg[front];
assign front_AWSIZE = AWSIZE_reg[front];
assign front_AWBURST = AWBURST_reg[front];
assign full = (counter == {$clog2(PENDING_DEPTH){1'b1}});
assign empty = (counter == {$clog2(PENDING_DEPTH){1'b0}});
endmodule