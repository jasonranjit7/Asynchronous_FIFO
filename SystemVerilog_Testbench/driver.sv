class driver #(parameter WIDTH = 8);
  
  virtual intf #(WIDTH) vif;
  mailbox #(transaction #(WIDTH)) gen2drv;
  
  function new(virtual intf #(WIDTH) vif, mailbox #(transaction #(WIDTH)) gen2drv);
    this.vif = vif;
    this.gen2drv = gen2drv;
  endfunction
  
  task main();
    repeat(10) begin
      transaction #(WIDTH) trans;
      gen2drv.get(trans);
      
      @(posedge vif.clk);
      vif.w_en <= trans.w_en;
      vif.r_en <= trans.r_en;
      vif.d_in <= trans.d_in;
      
      @(posedge vif.clk);
      #1; 
      
      trans.display("driver signals");
    end
  endtask
endclass
