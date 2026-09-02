class coverage;
  
  bit wen,ren,e,f;
  
  covergroup cg1 ();
    
    w: coverpoint wen;
    rd: coverpoint ren;
    e: coverpoint e;
    f: coverpoint f;
    
    
    wr: cross wen,ren{
      illegal_bins both_one = binsof(ren) intersect {1} && binsof(wen) intersect {1};
  }
  endgroup:cg1
  
  function new();
    cg1 = new();
  endfunction
  
endclass
    
