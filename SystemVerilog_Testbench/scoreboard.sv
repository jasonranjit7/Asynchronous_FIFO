class scoreboard #(parameter WIDTH = 8);
  
  mailbox #(transaction #(WIDTH)) mon2scb;
  
  //A simple array queue to mimic the ideal FIFO
  bit [WIDTH-1:0] ideal_fifo[$]; 
  
  function new(mailbox #(transaction #(WIDTH)) mon2scb);
    this.mon2scb = mon2scb;
  endfunction
  
  task main();
    transaction #(WIDTH) trans;
    
    repeat(10) begin
      mon2scb.get(trans);
      trans.display("Scoreboard Received");
      
      //Write operation in our Golden Model
      if (trans.w_en && !trans.full) begin
        ideal_fifo.push_back(trans.d_in);
        $display("[SCB] Data %0h pushed to Golden Model. Queue size: %0d", trans.d_in, ideal_fifo.size());
      end
      
      //Read operation & CHECK the data
      if (trans.r_en && !trans.empty) begin
        bit [WIDTH-1:0] expected_data;
        
        if (ideal_fifo.size() > 0) begin
          expected_data = ideal_fifo.pop_front();
        
          if (trans.d_out === expected_data) begin
            $display("[SCB PASS] Match! Expected: %0h, Got: %0h", expected_data, trans.d_out);
          end else begin
            $error("[SCB FAIL] Mismatch! Expected: %0h, Got: %0h", expected_data, trans.d_out);
          end
        end
      end
    end
  endtask
endclass
