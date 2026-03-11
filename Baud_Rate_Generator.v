module BD_gen(input clk,rst, output reg tx_en, reg rx_en);
  
  reg [12:0] tx_counter;
  reg [9:0] rx_counter;
  

  always@(posedge clk)begin
    if(rst)begin
      tx_counter <= 0;
      tx_en <= 0;
      rx_en <= 0;
    end else if(tx_counter == 5208)begin
      tx_counter <= 0;
      tx_en <= 1;
    end
    
    else begin
      tx_counter <= tx_counter + 1;
      tx_en <= 0;
    end
  end
  
  always@(posedge clk)begin
    if(rst)begin
      rx_counter<=0;
    end
    
    if(rx_counter == 325)begin
        rx_counter <= 0;
      rx_en <= 1;
    end
    else begin
      rx_counter <= rx_counter + 1;
      rx_en <= 0;
    end
  end
  
endmodule
