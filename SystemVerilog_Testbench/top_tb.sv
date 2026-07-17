`include "test.sv"
module tb_async_fifo #(WIDTH=8, DEPTH=8)();
  
  bit clk;
  bit rst;
  
  always #5 clk = ~clk;
  
  initial begin
    clk = 0;
    rst = 1;
    #20 rst = 0;
  end
  
  intf #(WIDTH) intff(clk, rst);
  test #(WIDTH) tst(intff);
  
  fifo_fpga_top #(.WIDTH(WIDTH), .DEPTH(DEPTH)) DUT(
    .clk(intff.clk),
    .rst(intff.rst),
    .w_en(intff.w_en),
    .r_en(intff.r_en),
    .d_in(intff.d_in),
    .d_out(intff.d_out),
    .full(intff.full),
    .empty(intff.empty)
  );
  
  initial begin
    $dumpfile("image.vcd");
    $dumpvars(0);
  end
endmodule
