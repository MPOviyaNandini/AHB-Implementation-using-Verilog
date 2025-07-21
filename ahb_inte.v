`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2025 14:03:35
// Design Name: 
// Module Name: ahb_inte
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
module ahb_inte();
reg [31:0] haddr;
reg [31:0] hwdata;
reg [3:0]  hprot;
reg hwrite;
reg [2:0]hsize;
reg is_signed;
reg [31:0] ramdata;
wire wr_en_ram;
wire rd_en_ram;
wire rd_en_rom;
wire [31:0] wr_data_ram;
wire [31:0] address_rom;
wire [31:0] address_ram;
wire hready_1;
wire hresp_1;
wire hresp_2;
wire  hready_2;
wire [31:0] read_data;

slave_glue_top x1(.haddr(haddr),.hwdata(hwdata),.hprot(hprot),.hwrite(hwrite),.hsize(hsize),
.is_signed(is_signed),.wr_en_ram(wr_en_ram),.rd_en_ram(rd_en_ram),.rd_en_rom(rd_en_rom),
.wr_data_ram(wr_data_ram),.address_rom(address_rom),.address_ram(address_ram),.hready_1(hready_1),.hresp_1(hresp_1),.hresp_2(hresp_2),.hready_2(hready_2));

data_mem x2(.clk(clk),.wr_en_ram(wr_en_ram),.rd_en_ram(rd_en_ram),.address_ram(address_ram),.store_data(store_data),.read_data(read_data));
endmodule

