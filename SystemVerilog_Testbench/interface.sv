interface intf #(parameter int WIDTH=8)(input bit clk,
                                        input bit rst);

  logic w_en;
  logic r_en;
  logic [WIDTH-1:0] d_in;
  logic [WIDTH-1:0] d_out;
  logic empty;
  logic full;
  
endinterface
