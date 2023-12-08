`include "read_pointer_handler.sv"
`include "write_pointer_handler.sv"
`include "graycode_encoder_16.sv"
`include "synchronizer_3.sv"

module async_fifo_8
#(
    parameter DATA_WIDTH = 32
)
(
    //Clock
    input clk_tx,
    input clk_rx,
    //Reset
    input nrst_tx,
    input nrst_rx,

    //Data Operation
    input push_tx,
    input pop_rx,
    input [DATA_WIDTH-1:0] DI_tx,
    output [DATA_WIDTH-1:0] DO_rx,
    output full_tx,
    output empty_rx
);
/**********Definitions**********/
///////////     Tx    ///////////
wire [3:0] graycoded_write_pointer;
wire [3:0] synced_graycoded_write_pointer;
wire [2:0] write_pointer;
reg [DATA_WIDTH-1:0] fifo_reg [0:7];

///////////     Rx    ///////////
wire [3:0] graycoded_read_pointer;
wire [3:0] synced_graycoded_read_pointer;
wire [2:0] read_pointer;
/**********Definitions**********/

//FIFO -- Tx
always@(posedge clk_tx) begin
    if(~nrst_tx) begin
        for(int i = 0; i < 8; i++)
            fifo_reg[i] <= {DATA_WIDTH{1'b0}};
    end

    else begin
        if(push_tx & (~full_tx)) begin
            fifo_reg[write_pointer] <= DI_tx;
        end
    end
end
// FIFO -- Rx
assign DO_rx = fifo_reg[read_pointer];

//Write Pointer Handler -- Tx
write_pointer_handler write_pointer_handler0(
    .clk_tx(clk_tx),
    .nrst_tx(nrst_tx),
    .push(push_tx),
    .synced_graycoded_read_pointer(synced_graycoded_read_pointer),

    .full(full_tx),
    .write_pointer(write_pointer),
    .graycoded_write_pointer(graycoded_write_pointer)
);

//Read Pointer Handler -- Rx
read_pointer_handler read_pointer_handler0(
    .clk_rx(clk_rx),
    .nrst_rx(nrst_rx),
    .pop(pop_rx),
    .synced_graycoded_write_pointer(synced_graycoded_write_pointer),

    .empty(empty_rx),
    .read_pointer(read_pointer),
    .graycoded_read_pointer(graycoded_read_pointer)
);

//////////////////// CDC Region ////////////////////
synchronizer_3 write_to_read(
    .clk(clk_rx),
    .nrst(nrst_rx),
    
    // asynchronous data
    .async_data(graycoded_write_pointer),
    // synchronous data
    .sync_data(synced_graycoded_write_pointer)
);

synchronizer_3 read_to_write(
    .clk(clk_tx),
    .nrst(nrst_tx),
    
    // asynchronous data
    .async_data(graycoded_read_pointer),
    // synchronous data
    .sync_data(synced_graycoded_read_pointer)
);
//////////////////// CDC Region ////////////////////

endmodule