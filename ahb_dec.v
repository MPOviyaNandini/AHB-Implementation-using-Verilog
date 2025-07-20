`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 22:11:51
// Design Name: 
// Module Name: ahb_dec
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
module ahb_dec(address,sel_0,sel_1,muxsel);
input [31:0]address;
output reg sel_0;
output reg sel_1;
output reg muxsel;

always@(*)
begin
        sel_1=0;
        sel_0=0;
        muxsel=0;
    if(address[31:24]==8'hA0)//ROM
    begin
        sel_0=1;
        muxsel=1;
    end
    else if(address[31:24]==8'hB0)//RAM
    begin
         sel_1=1;
         muxsel=0;
    end
     
end
endmodule

