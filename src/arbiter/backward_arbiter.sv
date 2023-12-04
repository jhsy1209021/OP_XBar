module backward_arbiter
#(
    parameter masters = 2,
    parameter slaves = 2,
    parameter i_am_master_number = 0
)
(
    //Global Signal
    input ACLK,
    input ARESETn,

    //Slaves Return FIFO Info
    input slave_fifo_empty [0:slaves-1],
    input [$clog2(masters)-1:0] slave_master_dest [0:slaves-1],

    //Master return FIFO Info
    input master_fifo_full,

    //Grant Slave
    output [$clog2(slaves)-1:0] grant_slave_number
);

//Registers
reg [$clog2(slaves)-1:0] round_robin_priority_reg [0:slaves-1];

//Signals
wire is_onehot_return_vec;
reg [slaves-1:0] slave_dest_is_me;
reg [slaves-1:0] confirm_return_to_me;

//Compare the slave return destination to my own number
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        slave_dest_is_me[i] = (slave_master_dest[i] == i_am_master_number) ? 1'b1 : 1'b0;
    end
end

//Confirm slave is returning request and dest is me
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        confirm_return_to_me[i] = (slave_dest_is_me[i] & (~slave_fifo_empty[i]));
    end
end

//Check request is onehot
onehot_detector
#(
    .width(slaves)
)priority_change_determine(
    .input_vec(confirm_return_to_me),
    .is_onehot(is_onehot_return_vec)
);

//Priority Shift register
always@(posedge ACLK) begin
    if(~ARESETn) begin
        for(int i = 0; i < slaves; i++)
            round_robin_priority_reg[i] <= i[$clog2(slaves)-1:0];
    end

    else begin
        if((~is_onehot_return_vec) & (~master_fifo_full)) begin
            round_robin_priority_reg[0] <= round_robin_priority_reg[slaves-1];
            for(int i = 1; i < slaves; i++)
                round_robin_priority_reg[i] <= round_robin_priority_reg[i-1];
        end
    end
end

//Arbitration according to the priority
grant_number_generator
#(
    .candidate(slaves)
) arbitration (
    .request_vec(confirm_return_to_me),
    .priority_array(round_robin_priority_reg),
    .grant_number(grant_slave_number)
);

endmodule