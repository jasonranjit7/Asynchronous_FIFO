class write_driver#(parameter WIDTH=8) extends uvm_driver#(write_item#(WIDTH));
  `uvm_component_param_utils(write_driver#(WIDTH))
  
  function new(string name = "write_driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  virtual intf#(WIDTH) vif;
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual intf#(WIDTH))::get(this,"","vif",vif)) begin
      `uvm_fatal("Write_Driver", "Could not get vif")
    end
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    
    vif.w_en<='0;
    vif.d_in<='0;
    
    forever begin
      write_item#(WIDTH) d_item;
      `uvm_info("Write_Driver", $sformatf("Waiting to get item from seqr"), UVM_LOW)
      seq_item_port.get_next_item(d_item);
      drive_item(d_item);
      seq_item_port.item_done();
    end
  endtask
  
  virtual task drive_item(write_item#(WIDTH) d_item);
    @(posedge vif.wclk);
    if(d_item.w_en && !vif.full) begin
      //write
      vif.w_en <= d_item.w_en;
      vif.d_in <= d_item.d_in;
    end
    else begin
      vif.w_en<=0;
      vif.d_in<='0;
    end
    
    @(posedge vif.wclk);
    vif.w_en <= 1'b0;
    vif.d_in <= '0;
  endtask
      
  
endclass
