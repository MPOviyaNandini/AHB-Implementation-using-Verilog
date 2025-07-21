`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2025 13:13:54
// Design Name: 
// Module Name: data_mem
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

module data_mem(
    input         clk,
    input         wr_en_ram,
    input         rd_en_ram,
    input  [31:0] address_ram,
    input  [31:0] store_data,
    output reg [31:0] read_data
);

    reg [7:0] mem [0:1023]; // 1KB byte-addressable memory

    // Write operation
    always @(posedge clk) begin
        if (wr_en_ram) begin
            mem[address_ram]     <= store_data[7:0];
            mem[address_ram + 1] <= store_data[15:8];
            mem[address_ram + 2] <= store_data[23:16];
            mem[address_ram + 3] <= store_data[31:24];
        end
    end

    // Read operation
    always @(*) begin
        if (rd_en_ram) begin
            read_data = {mem[address_ram + 3], mem[address_ram + 2], mem[address_ram + 1], mem[address_ram]};
        end else begin
            read_data = 32'b0;
        end
    end

endmodule
