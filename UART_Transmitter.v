module uart_tx(input clk,rst,wrt_en,enb, input [7:0]data_in, output reg tx, busy);
  
  parameter idle_state = 2'b00;
  parameter start_state = 2'b01;
  parameter data_state = 2'b10;
  parameter stop_state = 2'b11;
  
  reg [2:0] index = 0;
  reg [7:0] data = data_in;
  reg [1:0] state = idle_state;
  
  always@(posedge clk)begin
    if(rst)
      tx <= 1'b1;
  end
  
  always@(posedge clk)begin
    case(state)
      idle_state:
        begin
          if(wrt_en)begin
            state<=start_state;
            data<=data_in;
            index<=0;
          end
          
          else
              state<=idle_state;
        end
      
      
      start_state:
        begin
          if(enb)begin
            tx<=1'b0;
            state<=data_state;
          end
            
          else
              state<=start_state;
          
        end

      
      data_state:
          begin
            if(enb && index == 3'h7)begin
              state<=stop_state;
            end
            
              
            else
                index<= index + 3'h1;
        		tx<= data[index];
            
          end

      
      stop_state:
            begin
              if(enb)begin
          		tx<=1'b1;
          		state<=idle_state;
              end
            end
            
      
      default: begin
      tx <= 1'b1;
      state<=idle_state;
      end
    endcase
  end
  
  assign busy=(state != idle_state);
endmodule
