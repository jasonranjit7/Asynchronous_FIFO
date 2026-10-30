class read_driver#(parameter WIDTH = 8) extends uvm_driver#(read_item#(WIDTH));
  `uvm_component_param_utils(read_driver#(WIDTH))
  
  function new(string name = "read_driver", uvm_component parent = null);
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
    
    vif.r_en<='0;
    
    forever begin
      read_item r_item;
      `uvm_info("Write_Driver", $sformatf("Waiting to get item from seqr"), UVM_LOW)
      seq_item_port.get_next_item(r_item);
      drive_item(r_item);
      seq_item_port.item_done();
    end
  endtask
  
  virtual task drive_item(read_item r_item);
    @(posedge vif.rclk);
    if(r_item.r_en && !vif.empty) begin
      //read
      vif.r_en <= r_item.r_en;
    end
    else begin
      vif.r_en<=0;
    end
    
    @(posedge vif.rclk);
    vif.r_en <= 1'b0;
  endtask
      
  
endclass
