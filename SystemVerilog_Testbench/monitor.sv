class monitor #(parameter WIDTH = 8);
  
  virtual intf #(WIDTH) vif;
  
  mailbox #(transaction #(WIDTH)) mon2scb;
  
  function new(virtual intf #(WIDTH) vif, mailbox #(transaction #(WIDTH)) mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction
  
  task main();
    repeat(10) begin
      transaction #(WIDTH) trans;
      trans = new();
        
      @(posedge vif.clk);
      #1;
        
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
