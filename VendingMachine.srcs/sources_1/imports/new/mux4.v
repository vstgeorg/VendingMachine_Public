`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2021 10:53:50 PM
// Design Name: 
// Module Name: mux4
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


module mux4(
    input wire [1:0]s,
    input wire [3:0]Dig1,
    input wire[3:0]Dig2,
    input wire [3:0]Dig3,
    input wire [3:0]Dig4,
    output reg [3:0]X
    );
    
    always @(s)
        case(s)
            2'b00: X <= Dig1;
            2'b01: X <= Dig2;
            2'b10: X <= Dig3;
            2'b11: X <= Dig4;
        endcase
endmodule
