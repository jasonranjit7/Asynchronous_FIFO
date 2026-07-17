`include "environment.sv"
program test#(WIDTH=8)(intf intff);
  environment #(WIDTH) env;
  
  initial begin
    env = new(intff);
    env.test_run();
    
    $display("All transactions complete. Exiting simulation.");
  end
endprogram
