class write_seq#(parameter WIDTH=8) extends uvm_sequence#(write_item#(WIDTH));
  `uvm_object_param_utils(write_seq)
  
  rand int num = 20;
  
  constraint c_num{
    num>15;
  }
  
  function new(string name="write_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(num) begin
      `uvm_do(req)
    end
  endtask
endclass
  
  
