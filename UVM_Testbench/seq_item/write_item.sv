class write_item#(parameter WIDTH = 8) extends uvm_sequence_item;
  rand bit w_en;
  rand bit [WIDTH-1:0] d_in;
  
  `uvm_object_param_utils_begin(write_item#(WIDTH))
  	`uvm_field_int(w_en, UVM_DEFAULT)
    `uvm_field_int(d_in, UVM_DEFAULT)
  `uvm_object_utils_end
  
  virtual function string convert2string();
    return $sformatf("w_en = %0h, d_in = %0h",w_en, d_in);
  endfunction
  
  function new(string name = "write_item");
    super.new(name);
  endfunction
  
endclass
  
  
