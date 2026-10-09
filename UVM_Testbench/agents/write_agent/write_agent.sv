class write_agent#(parameter WIDTH=8) extends uvm_agent;
  `uvm_component_param_utils(write_agent#(WIDTH))
  
  write_driver#(WIDTH) wd;
  write_monitor#(WIDTH) wm;
  
  uvm_sequencer#(write_item#(WIDTH)) seqr;
  
  uvm_analysis_port #(write_item#(WIDTH)) ap;
  
  function new(string name = "write_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    wm = write_monitor#(WIDTH)::type_id::create("write_monitor", this);
    
    if(get_is_active() == UVM_ACTIVE) begin
      seqr = uvm_sequencer#(write_item#(WIDTH))::type_id::create("seqr", this);
      wd = write_driver#(WIDTH)::type_id::create("wd", this);
    end
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    if(get_is_active() == UVM_ACTIVE) begin
      wd.seq_item_port.connect(seqr.seq_item_export);
    end
    
    ap = wm.wp;
  endfunction
endclass
    
    
