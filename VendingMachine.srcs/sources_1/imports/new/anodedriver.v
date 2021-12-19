`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2021 10:17:43 PM
// Design Name: 
// Module Name: anodedriver
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


module anodedriver(
    input wire clk_en,
    input wire clk,
    input wire reset,
    output reg [3:0]an,
    output reg [1:0]s
    );
    
    initial
    s <= 0;
    
    always @(posedge clk or posedge reset)
        if(reset == 1)
            s <= 0;
        else if(clk_en == 1)
            s <= s + 1;
    
    always @(s)
        case(s)
            2'b00: an <= 4'b1110;
            2'b01: an <= 4'b1101;
            2'b10: an <= 4'b1011;
            2'b11: an <= 4'b0111;
         endcase
endmodule
