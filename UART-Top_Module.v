//uart_top_module
`include "Baud_rate_generator"
`include "UART_Tx"
`include "UART_RX"

module uart_top(input rst,input[7:0]data_in,input wrt_en,clk,input rdy_clr,output rdy,busy,output[7:0] data_out);
  
  wire rx_clk_en; //connecting output of baud rate generator rx_enb signal
  wire tx_clk_en; //connecting output of baud rate generator tx_enb signal
  
  wire tx_temp;  //connecting the output of tx module
  
   BD_gen bg(clk,rst, tx_clk_en, rx_clk_en);
   uart_tx tg(clk,rst, wrt_en, tx_clk_en, data_in, tx_temp, busy);
   uart_rx rg(clk,rst, tx_temp, rdy_clr, rx_clk_en, data_out, rdy);
  
endmodule
    
	
