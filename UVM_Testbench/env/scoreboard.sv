class scoreboard#(parameter WIDTH=8) extends uvm_scoreboard;
  `uvm_component_param_utils(scoreboard#(WIDTH))
  
  uvm_tlm_analysis_fifo#(read_item) read_fifo;
  uvm_tlm_analysis_fifo#(write_item#(WIDTH)) write_fifo;
  
  //golden model fifo
  bit [WIDTH-1:0] exp_q[$];
  
  int match = 0;
  int mismatch = 0;  
  
  function new(string name = "scoreboard", uvm_component parent=null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    read_fifo = new("read_fifo", this);
    write_fifo = new("write_fifo", this);
    
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    fork
      //write
      forever begin
        write_item#(WIDTH) w_tr;
        write_fifo.get(w_tr);
        exp_q.push_back(w_tr.d_in);
        `uvm_info("SCB", $sformatf("Pushed data = 0x%0h, expected queue size = 0x%0d", w_tr.d_in, exp_q.size()), UVM_MEDIUM)
      end
      
      //read
      forever begin
        read_item r_tr;
        
        bit [WIDTH-1:0] exp_data;
        
        read_fifo.get(r_tr);
        
        if(exp_q.size()==0) begin
          `uvm_error("SCB UNDERFLOW", "queue empty")
          mismatch++;
        end
        else begin
          exp_data = exp_q.pop_front();
          if(r_tr.d_out == exp_data) begin
            `uvm_info("SCB MATCH", $sformatf("MATCH! Expected: 0x%0h, Got: 0x%0h", exp_data, r_tr.d_out), UVM_MEDIUM)
            match++;
          end
          else begin
            `uvm_error("SCB MISMATCH", $sformatf("MISMATCH! Expected: 0x%0h, Got: 0x%0h", exp_data, r_tr.d_out))
            mismatch++;
          end
        end
      end
    join
  endtask
  
  virtual function void report_phase(uvm_phase phase);
    super.report_phase(phase);
    `uvm_info("SCB REPORT", $sformatf("Matches: 0x%0d, Mismatch: 0x%0d, Unread Items: 0x%0d", match, mismatch, exp_q.size()), UVM_MEDIUM)
  endfunction
endclass
    
          
        
