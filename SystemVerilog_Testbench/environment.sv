`include "generator.sv"
`include "driver.sv"
`include "interface.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment #(parameter WIDTH = 8);

  generator  #(WIDTH) gen;
  driver     #(WIDTH) drv;
  monitor    #(WIDTH) mon;
  scoreboard #(WIDTH) scb;
  
  virtual intf #(WIDTH) vif;
  
  mailbox #(transaction #(WIDTH)) gen2drv;
  mailbox #(transaction #(WIDTH)) mon2scb;
  
  function new(virtual intf #(WIDTH) vif);
    this.vif = vif;
    
    gen2drv = new();
    mon2scb = new();
    
    gen = new(gen2drv);
    drv = new(vif, gen2drv);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction
  
  task test_run();
    fork
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join
  endtask
endclass
