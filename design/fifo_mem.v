module fifo_mem#(parameter WIDTH=8,DEPTH=8,PTR_WIDTH=4)
  (input wclk, input w_en,
   input rclk, input r_en,
   input [PTR_WIDTH-1:0] b_rd_ptr,b_wr_ptr,
   input full, empty,
   input [WIDTH-1:0] d_in,
   output reg [WIDTH-1:0] d_out
  );
  
  reg [WIDTH-1:0] fifo [0:DEPTH-1];
  
  always@(posedge rclk) begin
    if(r_en & !empty) begin
      d_out<=fifo[b_rd_ptr[PTR_WIDTH-2:0]];
    end
  end
  
  always@(posedge wclk) begin
    if(w_en & !full)
      fifo[b_wr_ptr[PTR_WIDTH-2:0]] <= d_in;
  end
endmodule
