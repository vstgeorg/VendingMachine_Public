`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2021 03:42:45 PM
// Design Name: 
// Module Name: Vending
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Vending(nickel, dime, quarter, product, LED, clk, reset, digit1, digit2, digit3, digit4);
    input clk, reset, nickel, dime, quarter; 
    input [3:0]product;
    output reg [3:0]LED; 
    output reg [3:0]digit1; 
    output reg [3:0]digit2; 
    output reg [3:0]digit3; 
    output reg [3:0]digit4;
    
    reg [3:0]lastState, curState, nextState;
    parameter zero = 0, five = 1, ten = 2, fifteen = 3, twenty = 4, twentyFive = 5, thirty = 6, thirtyFive = 7, change = 8;
    parameter prod1 = 4'b0001, prod2 = 4'b0010, prod3 = 4'b0100, prod4 = 4'b1000;
    
    //state-transitioning logic
    always @( nickel or  dime or  quarter or curState or product)
        case(curState)
            zero: begin
            $display("here @ zero");
                if(nickel) nextState = five;
                else if(dime) nextState = ten;
                else if(quarter) nextState = twentyFive;
                else nextState = zero;
                end
            five: begin
            $display("here @ five");
                if(nickel) nextState = ten;
                else if(dime) nextState = fifteen;
                else if(quarter) nextState = thirty;
                else nextState = five;
                end
            ten: begin
            $display("here @ ten");
                if(nickel) nextState = fifteen;
                else if(dime) nextState = twenty;
                else if(quarter) nextState = thirtyFive;
                else nextState = ten;
                end
            fifteen: begin
                if(nickel) nextState = twenty;
                else if(dime) nextState = twentyFive;
                else if(quarter) nextState = thirtyFive;
                else if(product == prod1) nextState = change;
                else nextState = fifteen;
                end
            twenty: begin
                if(nickel) nextState = twentyFive;
                else if(dime) nextState = thirty;
                else if(quarter) nextState = thirtyFive;
                else if(product == prod1 || product == prod2) nextState = change;
                else nextState = twenty;
                end
            twentyFive: begin
                if(nickel) nextState = thirty;
                else if(dime) nextState = thirtyFive;
                else if(quarter) nextState = thirtyFive;
                else if(product == prod1 || product == prod2 || product == prod3) nextState = change;
                else nextState = twentyFive;
                end
            thirty: begin
                if(nickel) nextState = thirtyFive;
                else if(dime) nextState = thirtyFive;
                else if(quarter) nextState = thirtyFive;
                else if(product == prod1 || product == prod2 || product == prod3 || product == prod4) nextState = change;
                else nextState = thirty;
                end
            thirtyFive: begin
                if(!reset) nextState = thirtyFive;
                else if(product == prod1 || product == prod2 || product == prod3 || product == prod4) nextState = change;
                end
            default: nextState = zero;
        endcase
        
    //synchronous reset + updating states
    always @(posedge clk or posedge reset)   
        if(reset) begin 
            digit1 = 4'b0000;
            digit2 = 4'b0000;
            digit3 = 4'b0000;
            digit4 = 4'b0000;
            LED = 4'b0000;
            curState = zero; end
        else  begin lastState = curState; curState = nextState; end
        
    //output behavior
    always @(curState or product)
        case(curState)
            zero: begin
            $display("displaying  zero");
                digit1 = 4'b0000;
                digit2 = 4'b0000; end
            five: begin
            $display("displaying  five");
                digit1 = 4'b0000;
                digit2 = 4'b0101; end
            ten: begin
            $display("displaying  ten");
                digit1 = 4'b0001;
                digit2 = 4'b0000; end
            fifteen: begin
                digit1 = 4'b0001;
                digit2 = 4'b0101; end
            twenty: begin
                digit1 = 4'b0010;
                digit2 = 4'b0000; end
            twentyFive: begin
                digit1 = 4'b0010;
                digit2 = 4'b0101; end
            thirty: begin
                digit1 = 4'b0011;
                digit2 = 4'b0000; end
            thirtyFive: begin
                digit1 = 4'b0011;
                digit2 = 4'b0101; end
            change: begin
                if(product[0]) begin LED = 4'b0001; digit3 = 4'b0001; digit4 = 4'b0101; end
                else if(product[1]) begin LED = 4'b0010; digit3 = 4'b0010; digit4 = 4'b0000; end
                else if(product[2]) begin LED = 4'b0100; digit3 = 4'b0010; digit4 = 4'b0101; end
                else  begin LED = 4'b1000; digit3 = 4'b0011; digit4 = 4'b0000; end
                case(lastState)
                    fifteen: begin
                        digit1 = 4'b0000;
                        digit2 = 4'b0000; end
                    twenty: begin
                        if(product[0]) begin digit1 = 4'b0000; digit2 = 4'b0101; end
                        else begin digit1 = 4'b0000; digit2 = 4'b0000; end end
                    twentyFive: begin
                        if(product[0]) begin digit1 = 4'b0001; digit2 = 4'b0000; end
                        else if(product[1]) begin digit1 = 4'b0000; digit2 = 4'b0101; end
                        else begin digit1 = 4'b0000; digit2 = 4'b0101; end end
                    thirty: begin
                        if(product[0]) begin digit1 = 4'b0001; digit2 = 4'b0101; end
                        else if(product[1]) begin digit1 = 4'b0001; digit2 = 4'b0000; end
                        else if(product[2]) begin digit1 = 4'b0000; digit2 = 4'b0101; end
                        else begin digit1 = 4'b0000; digit2 = 4'b0000; end end   
                    thirtyFive: begin
                        if(product[0]) begin digit1 = 4'b0010; digit2 = 4'b0000; end
                        else if(product[1]) begin digit1 = 4'b0001; digit2 = 4'b0101; end
                        else if(product[2]) begin digit1 = 4'b0001; digit2 = 4'b0000; end
                        else begin digit1 = 4'b0000; digit2 = 4'b0101; end end
                    default: begin
                    $display("reseting 2");
                        digit1 = 4'b0000;
                        digit2 = 4'b0000;
                        digit3 = 4'b0000;
                        digit4 = 4'b0000;end
                endcase
                #5
                digit1 = 4'b0000;
                digit2 = 4'b0000;
                digit3 = 4'b0000;
                digit4 = 4'b0000;
                LED = 4'b0000; 
            curState = zero; nextState = zero; lastState = zero; end
            default: begin
            $display("reseting 3");
                 digit1 = 4'b0000;
                 digit2 = 4'b0000;
                 digit3 = 4'b0000;
                 digit4 = 4'b0000;end
            endcase    
endmodule
