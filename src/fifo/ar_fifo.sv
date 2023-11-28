module ar_fifo
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
    input [ID_WIDTH-1:0]        ARID,
    input [ADDR_WIDTH-1:0]      ARADDR,
    input [LEN_WIDTH-1:0]       ARLEN,
    input [SIZE_WIDTH-1:0]      ARSIZE,
    input [1:0]                 ARBURST,

    //FIFO Control
    input                       push,
    input                       pop,
    output                      full,
    output                      empty,
    
    //Content
    output [ID_WIDTH-1:0]         front_ARID,
    output [ADDR_WIDTH-1:0]       front_ARADDR,
    output [LEN_WIDTH-1:0]        front_ARLEN,
    output [SIZE_WIDTH-1:0]       front_ARSIZE,
    output [1:0]                front_ARBURST
);
//Registers
reg [$clog2(PENDING_DEPTH)-1:0] front, back, counter;
reg [ID_WIDTH-1:0] ARID_reg [0:PENDING_DEPTH-1];
reg [ADDR_WIDTH-1:0] ARADDR_reg [0:PENDING_DEPTH-1];
reg [LEN_WIDTH-1:0] ARLEN_reg [0:PENDING_DEPTH-1];
reg [SIZE_WIDTH-1:0] ARSIZE_reg [0:PENDING_DEPTH-1];
reg [1:0] ARBURST_reg [0:PENDING_DEPTH-1];

//FIFO
always@(posedge ACLK) begin
    if(~ARESETn) begin
        for(int i = 0; i < PENDING_DEPTH; i++) begin
            ARID_reg[i] <= {ID_WIDTH{1'b0}};
            ARADDR_reg[i] <= {ADDR_WIDTH{1'b0}};
            ARLEN_reg[i] <= {LEN_WIDTH{1'b0}};
            ARSIZE_reg[i] <= {SIZE_WIDTH{1'b0}};
            ARBURST_reg[i] <= {2{1'b0}};
        end
    end

    else begin
        if(push) begin
            if(counter != {$clog2(PENDING_DEPTH){1'b1}}) begin
                ARID_reg[back] <= ARID;
                ARADDR_reg[back] <= ARADDR;
                ARLEN_reg[back] <= ARLEN;
                ARSIZE_reg[back] <= ARSIZE;
                ARBURST_reg[back] <= ARBURST;
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
assign front_ARID = ARID_reg[front];
assign front_ARADDR = ARADDR_reg[front];
assign front_ARLEN = ARLEN_reg[front];
assign front_ARSIZE = ARSIZE_reg[front];
assign front_ARBURST = ARBURST_reg[front];
assign full = (counter == {$clog2(PENDING_DEPTH){1'b1}});
assign empty = (counter == {$clog2(PENDING_DEPTH){1'b0}});
endmodule