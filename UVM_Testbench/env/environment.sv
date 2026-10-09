class environment#(parameter WIDTH=8) extends uvm_env;
  `uvm_component_param_utils(environment#(WIDTH))
  
  scoreboard #(WIDTH) scb;
  read_agent #(WIDTH) ra;
  write_agent #(WIDTH) wa;
  
  function new(string name = "environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb = scoreboard#(WIDTH)::type_id::create("scb",this);
    ra = read_agent#(WIDTH)::type_id::create("ra", this);
    wa = write_agent#(WIDTH)::type_id::create("wa", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    ra.ap.connect(scb.read_fifo.analysis_export);
    wa.ap.connect(scb.write_fifo.analysis_export);
  endfunction
  
endclass
