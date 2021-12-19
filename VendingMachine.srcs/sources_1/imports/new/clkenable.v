`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/21/2021 09:59:12 PM
// Design Name: 
// Module Name: clkenable
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


module clkenable(
    input wire clk,
    input wire clr,
    output reg clk_enable
    );
    
    integer count = 0;
    
    always @(posedge clk or posedge clr)
        if(clr == 1) begin
            count <= 0;
            clk_enable <= 0;
        end
        else if(count == 99999999) begin
            count <= 0;
            clk_enable <= 1;
        end else begin
            count <= count + 1;
            clk_enable <= 0;
        end
    
endmodule
