`include "onehot_detector.sv"
`include "grant_number_generator.sv"

module forward_arbiter
#(
    parameter masters = 2,
    parameter slaves = 2,
    parameter i_am_slave_number = 0
)
(
    //Global Signal
    input ACLK,
    input ARESETn,

    //Master Request FIFO Info
    input master_fifo_empty [0:masters-1],
    input [$clog2(slaves)-1:0] master_slave_dest [0:masters-1],

    //Slave Request FIFO Info
    input slave_fifo_full,

    //Granted Master
    output [$clog2(masters)-1:0] grant_master_number
);

//Registers
reg [$clog2(masters)-1:0] round_robin_priority_reg [0:masters-1];

//Signals
wire is_onehot_request_vec;
reg [masters-1:0] master_dest_is_me;
reg [masters-1:0] confirm_request_to_me;

//Compare the master destination to my own number
always_comb begin
    for(int i = 0; i < masters; i++) begin
        master_dest_is_me[i] = (master_slave_dest[i] == i_am_slave_number) ? 1'b1 : 1'b0;
    end
end

//Confirm master is sending request and the dest is to me.
always_comb begin
    for(int i = 0; i < masters; i++) begin
        confirm_request_to_me[i] = (master_dest_is_me[i] & (~master_fifo_empty[i])) ? 1'b1 : 1'b0;
    end
end

//Check request is onehot
onehot_detector
#(
    .width(masters)
)priority_change_determine(
    .input_vec(confirm_request_to_me),
    .is_onehot(is_onehot_request_vec)
);

//Priority shift registers
always@(posedge ACLK) begin
    if(~ARESETn) begin
        for(int i = 0; i < masters; i++)
            round_robin_priority_reg[i] <= i[$clog2(masters)-1:0];
    end

    else begin
        if((~is_onehot_request_vec) & (~slave_fifo_full)) begin
            round_robin_priority_reg[0] <= round_robin_priority_reg[masters-1];
            for(int i = 1; i < masters; i++)
                round_robin_priority_reg[i] <= round_robin_priority_reg[i-1];
        end
    end
end

//Arbitration according to the priority
grant_number_generator
#(
    .candidate(masters)
) arbitration (
    .request_vec(confirm_request_to_me),
    .priority_array(round_robin_priority_reg),
    .grant_number(grant_master_number)
);

endmodule