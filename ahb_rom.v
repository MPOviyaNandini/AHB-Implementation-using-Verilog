`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 22:14:36
// Design Name: 
// Module Name: ahb_rom
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
module ahb_rom(
    input clk,
    input reset,
    input sel_0,
    input rd_en_rom,
    input [31:0] address_rom,
    output reg [31:0] instr
);

    reg [31:0] rom[4:0];
    wire [2:0] rom_index;
    assign rom_index = address_rom[2:0];  // 4-byte aligned word address

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            rom[0] <= 32'hAAAA_AAAA;  // 0x0000_0000
            rom[1] <= 32'hBBBB_BBBB;  // 0x0000_0004
            rom[2] <= 32'hCCCC_CCCC;  // 0x0000_0008
            rom[3] <= 32'hDDDD_DDDD;  // optional
            rom[4] <= 32'hEEEE_EEEE;  // optional
            instr  <= 32'b0;
        end
        else if (rd_en_rom&&sel_0) begin
            instr <= rom[rom_index];
        end
        else 
        instr  <= 32'b0;
    end

endmodule
