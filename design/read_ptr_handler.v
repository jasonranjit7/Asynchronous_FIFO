module rd_ptr_handler#(parameter WIDTH=4)(input rclk,
                      input r_rst,
                      input [WIDTH-1:0] g_wr_ptr_sync,
                      input r_en,
                      output reg [WIDTH-1:0] b_rd_ptr,
                      output reg [WIDTH-1:0] g_rd_ptr,
                      output reg empty
                                         );
  wire [WIDTH-1:0] b_rd_ptr_nxt,g_rd_ptr_nxt;
  wire rempty;
  
  assign b_rd_ptr_nxt = b_rd_ptr + (r_en && !empty);
  assign g_rd_ptr_nxt = (b_rd_ptr_nxt>>1) ^ b_rd_ptr_nxt;
  assign rempty = g_wr_ptr_sync==g_rd_ptr_nxt;
  
  always@(posedge rclk) begin
    if(r_rst) begin
      empty<=1'b1;
      b_rd_ptr<=0;
      g_rd_ptr<=0;
    end
    else begin
      empty<=rempty;
      b_rd_ptr<=b_rd_ptr_nxt;
      g_rd_ptr<=g_rd_ptr_nxt;
    end
  end
  
endmodule
