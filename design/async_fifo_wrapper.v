`include "synchroniser.v"
`include "read_ptr_handler.v"
`include "write_ptr_handler.v"
`include "fifo_mem.v"
module async_fifo_top#(parameter WIDTH=8,DEPTH=8)
  (input wclk,wrst,
   input rclk,r_rst,
   input w_en,r_en,
   input [WIDTH-1:0] d_in,
   output [WIDTH-1:0] d_out,
   output empty,full);
  
  parameter PTR_WIDTH = $clog2(DEPTH)+1;
  
  
  wire [PTR_WIDTH-1:0] g_rd_ptr,g_rd_ptr_sync,g_wr_ptr,g_wr_ptr_sync,
  					 b_rd_ptr,b_rd_ptr_sync,b_wr_ptr,b_wr_ptr_sync;
  
  
  synchroniser #(.WIDTH(PTR_WIDTH)) 
  			   r_sync(.clk(rclk),
                      .rst(r_rst),
                      .d_in(g_wr_ptr),
                      .d_out(g_wr_ptr_sync)
                     );
  
  synchroniser #(.WIDTH(PTR_WIDTH)) 
  			   w_sync(.clk(wclk),
                      .rst(wrst),
                      .d_in(g_rd_ptr),
                      .d_out(g_rd_ptr_sync)
                     );
  
  rd_ptr_handler #(.WIDTH(PTR_WIDTH)) 
   				read_hand (.rclk(rclk),
                           .r_rst(r_rst),
                           .g_wr_ptr_sync(g_wr_ptr_sync),
                           .r_en(r_en),
                           .b_rd_ptr(b_rd_ptr),
                           .g_rd_ptr(g_rd_ptr),
                           .empty(empty)
                          );
  
  wr_ptr_handler #(.WIDTH(PTR_WIDTH)) 
  	  			write_hand (.wclk(wclk),
                            .wrst(wrst),
                            .w_en(w_en),
                            .g_rd_ptr_sync(g_rd_ptr_sync),
                            .full(full),
                            .b_wr_ptr(b_wr_ptr),
                            .g_wr_ptr(g_wr_ptr)
                           );
 
  fifo_mem #(.WIDTH(WIDTH), .DEPTH(DEPTH), .PTR_WIDTH(PTR_WIDTH)) 
  		   memory(.wclk(wclk), .w_en(w_en),
                  .rclk(rclk), .r_en(r_en),
                  .b_rd_ptr(b_rd_ptr),
                  .b_wr_ptr(b_wr_ptr),
                  .full(full), .empty(empty),
                  .d_in(d_in),
                  .d_out(d_out)
                 );
  
  
endmodule
  
  
