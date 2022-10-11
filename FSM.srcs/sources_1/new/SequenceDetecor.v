`timescale 1ns / 1ps

module SequenceDetecor(clk, rst, x, z);
input clk, rst, x;
output reg z;

reg [1:0] state, nextstate;


always@(x or state)
begin
    case (state)
        0: begin if (x == 1) begin 
             nextstate = 2'b01;
             z = 0;
             end
             else begin
             nextstate = 2'b00;
             z = 0;
             end
        end
        1: begin if (x == 1) begin
             nextstate = 2'b01;
             z = 0;
             end
             else begin
             nextstate = 2'b10;
             z = 0;
             end
        end
        2: begin if (x == 1) begin
             nextstate = 2'b01;
             z = 1;
             end
             else begin
             nextstate = 2'b00;
             z = 0;
             end
        end
    endcase
end

always@ (posedge(clk) or posedge (rst))
begin
    if (rst == 1) 
        state <= 2'b00;
    else
        state <= nextstate;
end

endmodule



module SD (clk, rst, x, z);
input clk, rst, x;
output z;
reg [1:0] state, nextState;
parameter [1:0] A=2'b00, B=2'b01, C=2'b10; 

always @ (x or state)
begin
    case (state)
        A: if (x) nextState = B;
         else nextState = A;
        B: if (x) nextState = B;
         else nextState = C;
        C: if (x) nextState = B;
         else nextState = A;
    endcase
end
always @ (posedge clk or negedge rst) begin
    if(!rst)
     state <= A;
    else
     state <= nextState;
end
    assign z = (state == C && x ==1); 
endmodule