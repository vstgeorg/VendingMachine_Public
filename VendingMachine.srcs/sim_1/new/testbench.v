`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/21/2021 06:55:51 PM
// Design Name: 
// Module Name: testbench
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


module testbench();

    reg clk;
    reg reset;
    wire [3:0]LED; 
    wire [3:0]digit1; 
    wire [3:0]digit2; 
    wire [3:0]digit3; 
    wire [3:0]digit4;
    reg n; 
    reg q;
    reg d;
    reg [3:0]product;
    integer i = 0;
    
    Vending machine(.clk(clk), .reset(reset), .product(product), .LED(LED), .digit1(digit1), .digit2(digit2), .digit3(digit3), .digit4(digit4), .nickel(n), .quarter(q), .dime(d));
    
    initial 
    begin
        reset = 1; #30
        reset = 0; 
        clk = 1;
        i = 0;
        forever #5 clk <= ~clk; 
    end
    
    always @(negedge clk) begin
        if(i == 0) begin
            product = 4'b0000;
            q = 1;
            i = i + 1;
         end
         else if(i == 1) begin
            q = 0;
            n = 1;
            i = i+1;
         end 
         else if(i == 2) begin
            n = 0;
            i = i + 1;
         end
         else if(i == 3) begin
            product = 4'b0001;
            i = 0;
         end
     end
endmodule
