`include "async_fifo.v"

module fifo_fpga_top #(parameter WIDTH=8,DEPTH=8)
  (input clk,
   input rst, //common rst
   input w_en,r_en,
   input [WIDTH-1:0] d_in,
   output [WIDTH-1:0] d_out,
   output empty,full);
  
  wire wclk,rclk;
  
  assign wclk = clk;
  
  reg clk_div =0;
  always@(posedge clk)
    clk_div=~clk_div;
  
  assign rclk=clk_div; 
  
  async_fifo #(.WIDTH(WIDTH), .DEPTH(DEPTH))
  fifo(.wclk(wclk), .wrst(rst),
       .rclk(rclk), .r_rst(rst),
       .w_en(w_en), .r_en(r_en),
       .d_in(d_in), .d_out(d_out),
       .empty(empty),
       .full(full)
      );
  
endmodule
  
  
