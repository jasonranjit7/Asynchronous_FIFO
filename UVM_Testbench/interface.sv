interface intf#(parameter WIDTH=8)(
  input wclk,
  input rclk,
  input rst);

  logic w_en;
  logic [WIDTH-1:0] d_in;
  logic full;
  
  logic r_en;
  logic [WIDTH-1:0] d_out;
  logic empty;
  
  clocking w_cb @(posedge wclk);
    default input #1step output #1;
    output w_en, d_in;
    input full;
  endclocking
  
  clocking r_cb @(posedge rclk);
    default input #1step output #1;
    output r_en;
    input d_out, empty;
  endclocking
  
endinterface
