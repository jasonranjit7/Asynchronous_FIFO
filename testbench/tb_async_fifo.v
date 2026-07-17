module tb_async_fifo #(parameter WIDTH =8, DEPTH=8)();
  reg wclk,rclk,wrst,r_rst,w_en,r_en;
  reg [WIDTH-1:0] d_in;
  wire [WIDTH-1:0] d_out;
  wire empty,full;
  
  
  //write clk
  initial begin
    wclk = 0;  
    forever #5 wclk = ~wclk;
  end
  
  //read clk
  initial begin
    rclk = 0;
    forever #10 rclk = ~rclk;
  end
  
  //module inst
  async_fifo_top #(.WIDTH(WIDTH), .DEPTH(DEPTH)) 
  DUT(.wclk(wclk), .wrst(wrst), .rclk(rclk),
      .r_rst(r_rst),
      .w_en(w_en),
      .r_en(r_en),
      .d_in(d_in),
      .d_out(d_out),
      .empty(empty),
      .full(full)
     );
  
  
  //write reset
  task w_reset;
    begin
      wrst=1'b1;
      repeat(2)@(posedge wclk);
      @(negedge wclk);
      wrst = 0;
      @(posedge wclk);
      #1;
    end
  endtask
  
  //read reset
  task r_reset;
    begin
      r_rst=1'b1;
      repeat(2)@(posedge rclk);
      @(negedge rclk);
      r_rst = 0;
      @(posedge rclk);
      #1;
    end
  endtask
  
  
  //write op
  task write;
    input [WIDTH-1:0] data;
    begin
      @(negedge wclk)
      if(!full) begin
        $display("--WRITE OPERATION--");

        @(negedge wclk);
        d_in = data;
        w_en = 1'b1;

        @(posedge wclk);
        #1;
        w_en=0;
        d_in = 0;
        
        if(data == DUT.memory.fifo[DUT.read_hand.b_rd_ptr])
          $display("Successfully written ");
        else
          $display("Unsuccessfully written ");
      end
      else
        $display("FIFO full");
      
    end
  endtask
  
  task read;
    begin
      @(negedge rclk)
      if(!empty) begin
        $display("--READ OPERATION--");

        repeat(1)@(negedge rclk);
        
        r_en = 1'b1;
        repeat(1)@(posedge rclk);
        #1;
        
        r_en=0;
        repeat(1)@(posedge rclk);
        #1;
        
        $display("--Read %b from FIFO--", d_out);
      end
      else
        $display("FIFO empty");
        
    end
  endtask
    
      
      
      
      
  
  initial begin
    wrst=1;
    r_rst=1;
    w_en=0;
    r_en=0;
    $dumpfile("image.vcd");
    $dumpvars(0, tb_async_fifo);
    
    //reset
    fork
      w_reset();
      r_reset();
    join
    
    write(8'hFF);
    write(8'd7);
    
    repeat(4)@(posedge rclk);
    
    //$display(DUT.memory.fifo[DUT.read_hand.b_rd_ptr]);
    
    read();
    read();
    
    #10
    
    $finish();
  end  
  
endmodule
