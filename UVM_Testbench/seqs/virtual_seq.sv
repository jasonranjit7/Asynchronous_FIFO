class virtual_seq#(parameter WIDTH=8) extends uvm_sequence;
  `uvm_object_param_utils(virtual_seq#(WIDTH))
  
  rand int num = 20;
  
  constraint c_items { num inside {[10:1000]}; }
  
  uvm_sequencer #(write_item#(WIDTH)) w_seqr;
  uvm_sequencer #(read_item) r_seqr;
  
  function new(string name = "virtual_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    write_seq #(WIDTH) w_req;
    read_seq r_req;
    
    w_req = write_seq#(WIDTH)::type_id::create("w_req");
    r_req = read_seq::type_id::create("r_req");
    
    w_req.num = num;
    r_req.num = num;
    
    fork
      w_req.start(w_seqr);
      r_req.start(r_seqr);
    join
  endtask
endclass
    
