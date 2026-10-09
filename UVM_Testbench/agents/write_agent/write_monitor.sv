class write_monitor#(parameter WIDTH =8) extends uvm_monitor;
  `uvm_component_param_utils(write_monitor#(WIDTH))
  
  virtual intf#(WIDTH) vif;
  uvm_analysis_port#(write_item#(WIDTH)) wp;
  
  function new(string name = "write monitor", uvm_component parent= null);
    super.new(name, parent);
    wp = new("wp", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf#(WIDTH))::get(this,"", "vif", vif)) begin
      `uvm_fatal("Write monitor", "vif not found")
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.wclk);
      if(vif.w_en && !vif.full) begin
        write_item#(WIDTH) tr;
        
        tr = write_item#(WIDTH)::type_id::create("tr");
        
        tr.d_in = vif.d_in;
        tr.w_en = vif.w_en;
        
        wp.write(tr);
      end
    end
  endtask
  
endclass
  
