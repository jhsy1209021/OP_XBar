module async_fifo
#(
    parameter DATA_WIDTH = 32,
    parameter pointer_width = 3
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
wire [pointer_width:0] graycoded_write_pointer;
wire [pointer_width:0] synced_graycoded_write_pointer;
wire [pointer_width-1:0] write_pointer;
reg [DATA_WIDTH-1:0] fifo_reg [0:(2**pointer_width)-1];

///////////     Rx    ///////////
wire [pointer_width:0] graycoded_read_pointer;
wire [pointer_width:0] synced_graycoded_read_pointer;
wire [pointer_width-1:0] read_pointer;
/**********Definitions**********/

//FIFO -- Tx
always@(posedge clk_tx) begin
    if(~nrst_tx) begin
        for(int i = 0; i < (2**pointer_width); i++)
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
write_pointer_handler #(
    .pointer_width(pointer_width)
) write_pointer_handler0 (
    .clk_tx(clk_tx),
    .nrst_tx(nrst_tx),
    .push(push_tx),
    .synced_graycoded_read_pointer(synced_graycoded_read_pointer),

    .full(full_tx),
    .write_pointer(write_pointer),
    .graycoded_write_pointer(graycoded_write_pointer)
);

//Read Pointer Handler -- Rx
read_pointer_handler #(
    .pointer_width(pointer_width)
) read_pointer_handler0 (
    .clk_rx(clk_rx),
    .nrst_rx(nrst_rx),
    .pop(pop_rx),
    .synced_graycoded_write_pointer(synced_graycoded_write_pointer),

    .empty(empty_rx),
    .read_pointer(read_pointer),
    .graycoded_read_pointer(graycoded_read_pointer)
);

//////////////////// CDC Region ////////////////////
synchronizer #(
    .width(pointer_width+1)
) write_to_read(
    .clk(clk_rx),
    .nrst(nrst_rx),
    
    // asynchronous data
    .async_data(graycoded_write_pointer),
    // synchronous data
    .sync_data(synced_graycoded_write_pointer)
);

synchronizer #(
    .width(pointer_width+1)
) read_to_write(
    .clk(clk_tx),
    .nrst(nrst_tx),
    
    // asynchronous data
    .async_data(graycoded_read_pointer),
    // synchronous data
    .sync_data(synced_graycoded_read_pointer)
);
//////////////////// CDC Region ////////////////////

endmodule