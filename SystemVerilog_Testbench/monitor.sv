`include "coverage.sv"
class monitor #(parameter WIDTH = 8);
  
  virtual intf #(WIDTH) vif;
  coverage cov;
  
  mailbox #(transaction #(WIDTH)) mon2scb;
  
  function new(virtual intf #(WIDTH) vif, mailbox #(transaction #(WIDTH)) mon2scb, coverage cov);
    this.vif = vif;
    this.mon2scb = mon2scb;
    this.cov = cov;
  endfunction
  
  task main();
    repeat(10) begin
      transaction #(WIDTH) trans;
      @(posedge vif.clk);
      #1;
      cov.ren = vif.r_en;
      cov.wen = vif.w_en;
      cov.e = vif.empty;
      cov.f = vif.full;
      cov.cg1.sample();
        
      trans = new();
      trans.w_en = vif.w_en;
      trans.r_en = vif.r_en;
      trans.d_in = vif.d_in;
      trans.d_out = vif.d_out;
      trans.empty = vif.empty;
      trans.full = vif.full;
        
      mon2scb.put(trans);
      trans.display("monitor signals");
    end
  endtask
endclass
