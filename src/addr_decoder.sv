module addr_decoder
#(
    //AXI Setup
    parameter ADDR_WIDTH = 32,

    parameter slaves = 2,
    parameter [ADDR_WIDTH-1:0] address_map_base [0:slaves-1] = {'h0000_0000, 'h1000_0000},
    parameter [ADDR_WIDTH-1:0] address_map_end [0:slaves-1] = {'h0fff_ffff, 'h1fff_ffff}
)
(
    input [ADDR_WIDTH-1:0] addr,
    output reg [$clog2(slaves)-1:0] dest_slave
);
//Signals
reg [slaves-1:0] address_greater_than_base;
reg [slaves-1:0] address_smaller_than_end;
wire [slaves-1:0] address_located;

//Base Address Comparator
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        address_greater_than_base[i] = (addr >= address_map_base[i]);
    end
end

//End Address Comparator
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        address_smaller_than_end[i] = (addr <= address_map_end[i]);
    end
end

//There is only one bit overlap.
//"And" two signals, and the only one "1" is the slave located in
assign address_located = ~(address_greater_than_base ^ address_smaller_than_end);

//Address Decoder
always_comb begin
    for(int i = 0; i < slaves; i++) begin
        if(address_located[i]) begin
            dest_slave = i[$clog2(slaves)-1:0];
            break;
        end
        
        else
            dest_slave = 0;
    end
end

endmodule