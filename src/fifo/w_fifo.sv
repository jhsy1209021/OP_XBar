module w_fifo
//Parameters
#(
    parameter PENDING_DEPTH = 4,
    parameter DATA_WIDTH = 32,
    parameter STRB_WIDTH = 3
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
reg [$clog2(PENDING_DEPTH)-1:0] front, back, counter;
reg [DATA_WIDTH-1:0] WDATA_reg [0:PENDING_DEPTH-1];
reg [STRB_WIDTH-1:0] WSTRB_reg [0:PENDING_DEPTH-1];
reg WLAST_reg [0:PENDING_DEPTH-1];

//Ring Shifter
always@(posedge ACLK) begin
    if(~ARESETn) begin
        for(int i = 0; i < PENDING_DEPTH; i++) begin
            WDATA_reg[i] <= {DATA_WIDTH{1'b0}};
            WSTRB_reg[i] <= {STRB_WIDTH{1'b0}};
            WLAST_reg[i] <= 1'b0;
        end
    end

    else begin
        if(push) begin
            if(counter != {$clog2(PENDING_DEPTH){1'b1}}) begin
                WDATA_reg[back] <= WDATA;
                WSTRB_reg[back] <= WSTRB;
                WLAST_reg[back] <= WLAST;
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
assign front_WDATA = WDATA_reg[front];
assign front_WSTRB = WSTRB_reg[front];
assign front_WLAST = WLAST_reg[front];
assign full = (counter == {$clog2(PENDING_DEPTH){1'b1}});
assign empty = (counter == {$clog2(PENDING_DEPTH){1'b0}});
endmodule