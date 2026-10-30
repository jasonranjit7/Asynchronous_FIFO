class read_monitor#(parameter WIDTH=8) extends uvm_monitor;
  `uvm_component_param_utils(read_monitor#(WIDTH))
  
  virtual intf#(WIDTH) vif;
  uvm_analysis_port#(read_item#(WIDTH)) rp;
  
  function new(string name = "read_monitor", uvm_component parent=null);
    super.new(name, parent);
    rp = new("rp", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf#(WIDTH))::get(this,"","vif",vif)) begin
      `uvm_fatal("RD MONITOR", "Could not get VIF")
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    bit rd_active_prev_phase;
    forever begin
      @(posedge vif.rclk);
      if(vif.rst)
        rd_active_prev_phase = 0;
      else begin
        if(rd_active_prev_phase) begin
          read_item tr;
          tr = read_item#(WIDTH)::type_id::create("tr");
          tr.r_en = rd_active_prev_phase;
          tr.d_out = vif.d_out;

          rp.write(tr);
        end
      end
      rd_active_prev_phase = vif.r_en && !vif.empty;
    end
  endtask
  
endclass
      
      
    
