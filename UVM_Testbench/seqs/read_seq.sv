class read_seq extends uvm_sequence#(read_item);
  `uvm_object_utils(read_seq)
  
  rand int num = 20;
  
  constraint c_num{
    num>15;
  }
  
  function new(string name = "read_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(num) begin
      `uvm_do(req);
    end
  endtask
endclass
