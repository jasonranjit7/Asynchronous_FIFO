`include "transaction.sv"
class generator#(parameter WIDTH = 8);
  
  transaction #(WIDTH) trans;
  
  mailbox #(transaction #(WIDTH)) gen2drv;
  
  function new(mailbox #(transaction #(WIDTH)) gen2drv);
    this.gen2drv=gen2drv;
  endfunction
  
  task main();
    repeat(10)
      begin
        trans=new();
        
        
        if(!trans.randomize())
          $fatal("Randomisation failed");
        
        trans.display("Generated signals");
        gen2drv.put(trans);
      end
  endtask
endclass
