class read_agent#(parameter WIDTH=8) extends uvm_agent;
  `uvm_component_param_utils(read_agent#(WIDTH))
  
  read_driver#(WIDTH) rd;
  read_monitor#(WIDTH) rm;
  
  uvm_sequencer#(read_item#(WIDTH)) seqr;
  
  uvm_analysis_port #(read_item#(WIDTH)) ap;
  
  function new(string name = "read_agent", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    rm = read_monitor#(WIDTH)::type_id::create("read_monitor", this);
    
    if(get_is_active() == UVM_ACTIVE) begin
      seqr = uvm_sequencer#(read_item#(WIDTH))::type_id::create("seqr", this);
      rd = read_driver#(WIDTH)::type_id::create("rd", this);
    end
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    
    if(get_is_active() == UVM_ACTIVE) begin
      rd.seq_item_port.connect(seqr.seq_item_export);
    end
    
    ap = rm.rp;
  endfunction
endclass
    
    
