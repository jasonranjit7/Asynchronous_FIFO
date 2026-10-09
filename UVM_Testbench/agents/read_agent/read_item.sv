class read_item#(parameter WIDTH=8) extends uvm_sequence_item;
  rand bit r_en;
  logic [WIDTH-1:0] d_out;
  
  `uvm_object_param_utils_begin(read_item)
  	`uvm_field_int(r_en, UVM_DEFAULT)
  `uvm_field_int(d_out, UVM_DEFAULT)
  `uvm_object_utils_end
  
  virtual function string convert2string();
    return $sformatf("r_en = %0h",r_en);
  endfunction
  
  function new(string name = "read_item");
    super.new(name);
  endfunction
  
endclass
  
  
