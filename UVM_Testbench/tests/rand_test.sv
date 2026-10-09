class rand_test extends base_test#(8);
  `uvm_component_utils(rand_test)
  
  function new(string name = "rand_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    virtual_seq#(WIDTH) v_seq;
    
    super.run_phase(phase);
    
    phase.raise_objection(this,"Starting test virtual sequence");
    
    v_seq = virtual_seq#(WIDTH)::type_id::create("v_seq");
    
    v_seq.w_seqr = env.wa.seqr;
    v_seq.r_seqr = env.ra.seqr;
    
    v_seq.start(null);
    
    phase.drop_objection(this,"Completed");
    
  endtask
endclass
  
