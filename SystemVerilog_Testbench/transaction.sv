class transaction #(parameter WIDTH=8);

  rand bit w_en;
  rand bit r_en;
  rand bit [WIDTH-1:0] d_in;
  
  //outputs
  bit [WIDTH-1:0] d_out;
  bit empty;
  bit full;
  
  //constraints
  constraint no_simul_rw{
    w_en+r_en<=1;
  }
  
  constraint op_dist{
    w_en dist {0 :=50, 1:=50};
    r_en dist {0 :=20, 1:=80};
  }
  
  function void display(string name);
    $display(name);
    $display("w_en = %b, r_en = %b, d_in = %b, full = %b, empty = %b,d_out = %0b",w_en, r_en, d_in,full,empty,d_out);
  endfunction
  
  function void display_write(string name);
    $display(name);
    $display("d_in = %0b, full = %b",d_in, full);
  endfunction
  
  function void display_read(string name);
    $display(name);
    $display("d_out = %0b, empty = %b",d_out, empty);
  endfunction
  
endclass
