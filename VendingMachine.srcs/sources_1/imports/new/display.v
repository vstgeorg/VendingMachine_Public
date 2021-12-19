`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2021 11:03:06 PM
// Design Name: 
// Module Name: display
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


module display(
    input wire clk,
    input wire clr,
    input wire [3:0]Dig1,
    input wire [3:0]Dig2,
    input wire [3:0]Dig3,
    input wire [3:0]Dig4,
    output [3:0]AN,
    output [6:0]CA
    );
    
    wire clk_enable;
    wire [1:0]S;
    wire [3:0]X;
    
    clkenable c1(.clk(clk), .clr(clr), .clk_enable(clk_enable));
    anodedriver a1(.clk(clk), .reset(clr), .clk_en(clk_enable), .s(S), .an(AN));
    mux4 m1(.s(S), .Dig1(Dig1), .Dig2(Dig2), .Dig3(Dig3), .Dig4(Dig4), .X(X));
    hex2sevseg h1(.x(X), .ca(CA));
    
endmodule
