`timescale 1ns / 1ps


module fsm(clk, rst, w, z);
input clk, rst, w;
output  z;
reg [1:0] state, nextState;
parameter [1:0] A = 2'b00, B = 2'b01; 

always @ (w or state)
begin
    case (state)
    A:if(w) nextState = B;
     else  nextState = A;
     
    B:if(w) nextState = B;
      else nextState = A;
      
    endcase
 end
 
always @ (posedge clk or negedge rst) begin
    if(!rst)
        state <= A;
    else
        state <= nextState;
end
assign z = (state == A && w == 1);
endmodule