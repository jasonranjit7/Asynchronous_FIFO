class base_test#(parameter WIDTH = 8) extends uvm_test;
  `uvm_component_param_utils(base_test#(WIDTH))
  
  environment#(WIDTH) env;
  
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env = environment#(WIDTH)::type_id::create("env", this);
  endfunction
  
  virtual function void end_of_elaboration_phase(uvm_phase phase);
    super.end_of_elaboration_phase(phase);
    uvm_top.print_topology();
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.phase_done.set_drain_time(this, 50ns);
  endtask
  
endclass
    
