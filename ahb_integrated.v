`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 22:04:17
// Design Name: 
// Module Name: ahb_integrated
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
module ahb_integrated(
    input         mem_write,
    input         mem_read,
    input         clk,
    input         reset,
    input  [2:0]  func3,
    input  [31:0] rs2_data,
    input  [31:0] alu_out,
    input  [31:0] address,
    output [31:0] data_out
);

  wire        hready_1, hready_2, hresp_1, hresp_2;
  wire        hready, hresp;
  wire [1:0]  htrans;
  wire [31:0] haddr, hwdata;
  wire [3:0]  hprot;
  wire        hwrite;
  wire [2:0]  hsize;
  wire is_signed;
  wire        wr_en_ram, rd_en_ram, rd_en_rom;
  wire [31:0] wr_data_ram;
  wire [31:0] address_rom, address_ram;
  wire [31:0] rd_data;
  wire [31:0] instr;

  wire        sel_0, sel_1, muxsel;
  wire [31:0] data_out_mux;

  // Master
  master_glue t1 (
    .hready(hready),
    .hresp(hresp),
    .func3(func3),
    .mem_write(mem_write),
    .mem_read(mem_read),
    .rs2_data(rs2_data),
    .alu_out(alu_out),
    .address(address),
    .htrans(htrans),
    .hprot(hprot),
    .hwrite(hwrite),
    .hsize(hsize),
    .haddr(haddr),
    .hwdata(hwdata),
    .data_out_mux(data_out_mux),
    .is_signed(is_signed),
    .data_out(data_out)
  );
  
  // Slave Glue
  slave_glue t2 (
    .haddr(haddr),
    .hwdata(hwdata),
    .htrans(htrans),
    .hprot(hprot),
    .hwrite(hwrite),
    .hsize(hsize),
    .is_signed(is_signed),
    .wr_en_ram(wr_en_ram),
    .rd_en_ram(rd_en_ram),
    .rd_en_rom(rd_en_rom),
    .wr_data_ram(wr_data_ram),
    .address_rom(address_rom),
    .address_ram(address_ram),
    .hready_1(hready_1),
    .hready_2(hready_2),
    .hresp_1(hresp_1),
    .hresp_2(hresp_2)
  );

  // AHB Mux
  ahb_mux t3 (
    .hready_1(hready_1),
    .hready_2(hready_2),
    .hresp_1(hresp_1),
    .hresp_2(hresp_2),
    .rd_data1(instr),
    .rd_data2(rd_data),
    .muxsel(muxsel),
    .data_out_mux(data_out_mux),
    .hready(hready),
    .hresp(hresp)
  );
  // Decoder
  ahb_dec t4 (
    .address(address),
    .sel_0(sel_0),
    .sel_1(sel_1),
    .muxsel(muxsel)
  );

  // RAM
  ahb_ram t5 (
    .clk(clk),
    .reset(reset),
    .sel_1(sel_1),
    .is_signed(is_signed),
    .rd_en_ram(rd_en_ram),
    .wr_en_ram(wr_en_ram),
    .wr_data(wr_data_ram),
    .address_ram(address_ram),
    .hsize(hsize),
    .rd_data(rd_data)
  );

// ROM
  ahb_rom t6 (
    .clk(clk),
    .reset(reset),
    .sel_0(sel_0),
    .rd_en_rom(rd_en_rom),
    .address_rom(address_rom),
    .instr(instr)
  );

endmodule
