`timescale 1ns/1ps

`include "uvm_macros.svh"
//import uvm_pkg::*;
`include "fifo_pkg.sv"
`include "interface.sv"

import fifo_pkg::*;

module tb_async_fifo #(
  parameter WIDTH = 8,
  parameter DEPTH = 8
)();
  
  

  bit rclk = 0;
  bit wclk = 0;
  bit rst = 0;

  
  always #10 rclk = ~rclk;   
  always #3.33 wclk = ~wclk;  
  
  initial begin
    rst = 1;
    #25;
    rst = 0;
  end

  intf #(WIDTH) vif(.rclk(rclk), .wclk(wclk),.rst(rst));

  fifo_top #(
    .WIDTH(WIDTH),
    .DEPTH(DEPTH)
  ) DUT (
    .wclk (vif.wclk),
    .rclk (vif.rclk),
    .rst  (vif.rst),
    .w_en (vif.w_en),
    .r_en (vif.r_en),
    .d_in (vif.d_in),
    .d_out(vif.d_out),
    .full (vif.full),
    .empty(vif.empty)
  );
  initial begin
    $dumpfile("image.vcd");
    $dumpvars(0);
    uvm_config_db#(virtual intf#(WIDTH))::set(null, "*", "vif", vif);
    
    run_test(); 
  end

endmodule
