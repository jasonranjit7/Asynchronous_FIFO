module wr_ptr_handler #(parameter WIDTH = 4)(input wclk,
                      input wrst,
                      input w_en,
                      input [WIDTH-1:0] g_rd_ptr_sync,//double flopped gray rd ptr
                      output reg full,
                      output reg [WIDTH-1:0] b_wr_ptr, //binary write pointer
                      output reg [WIDTH-1:0] g_wr_ptr //gray write pointer
                     );
  
  wire wfull;
  
  wire [WIDTH-1:0] b_wr_ptr_nxt = b_wr_ptr+(w_en&!full);
  wire [WIDTH-1:0] g_wr_ptr_nxt = (b_wr_ptr_nxt>>1) ^ b_wr_ptr_nxt;
  
  
  assign wfull = (g_wr_ptr_nxt == {~g_rd_ptr_sync[WIDTH-1:WIDTH-2],g_rd_ptr_sync[WIDTH-3:0]});
  
  always@(posedge wclk) begin
    if(wrst) begin
      full<=0;
      b_wr_ptr<=0;
      g_wr_ptr<=0;
    end
    else begin
      full<=wfull;
      b_wr_ptr<=b_wr_ptr_nxt;
      g_wr_ptr<=g_wr_ptr_nxt;
    end
  end
  
endmodule
                  
