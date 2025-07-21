`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2025 13:22:27
// Design Name: 
// Module Name: slave_store
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


module slave_store(
   input  [2:0]  hsize,
    input  [31:0] read_data,
    input  [31:0] wr_data_ram,
    output reg [31:0] store_data

    );

always @(*) begin
        case (hsize)
            3'b000: store_data = {read_data[31:8],  wr_data_ram[7:0]};    // SB
            3'b001: store_data = {read_data[31:16], wr_data_ram[15:0]};   // SH
            3'b010: store_data = wr_data_ram;                             // SW
            default: store_data = wr_data_ram;
        endcase
end

endmodule
