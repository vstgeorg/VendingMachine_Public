`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2021 12:09:57 AM
// Design Name: 
// Module Name: new_disp
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


module new_disp(
    input wire clk,
    input wire clr,
    input wire n, 
    input wire q,
    input wire d,
    input [3:0]product,
    output [3:0]LED,
    output [3:0]AN,
    output [6:0]CA
    );
    
    wire clk_enable;
    wire [3:0]digit1; 
    wire [3:0]digit2; 
    wire [3:0]digit3; 
    wire [3:0]digit4;
    
    clkenable c(.clk(clk), .clr(clr), .clk_enable(clk_enable));
    Vending machine(.clk(clk_enable), .reset(clr), .product(product), .LED(LED), .digit1(digit1), .digit2(digit2), .digit3(digit3), .digit4(digit4), .nickel(n), .quarter(q), .dime(d));
    display disp(.clk(clk), .clr(clr), .Dig1(digit1), .Dig2(digit2), .Dig3(digit3), .Dig4(digit4), .AN(AN), .CA(CA));
    
    
endmodule
