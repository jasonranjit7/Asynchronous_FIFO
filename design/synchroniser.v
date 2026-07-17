module synchroniser#(parameter WIDTH=4)
  (input clk, rst,
   input [WIDTH-1:0] d_in,
   output reg [WIDTH-1:0] d_out
  );
  
  reg [WIDTH-1:0] q1;
  
  always@(posedge clk) begin
    if(rst) begin
      q1<=0;
      d_out<=0;
    end
    else begin
      q1<=d_in;
      d_out<=q1;
    end
  end
  
endmodule
