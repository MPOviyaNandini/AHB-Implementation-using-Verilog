`timescale 1ns / 1ps

module ahb_inte_tb;

  // Inputs
  reg clk;
  reg [31:0] haddr;
  reg [31:0] hwdata;
  reg [3:0]  hprot;
  reg hwrite;
  reg [2:0]  hsize;
  reg is_signed;
  reg [31:0] ramdata;

  // Outputs
  wire wr_en_ram;
  wire rd_en_ram;
  wire rd_en_rom;
  wire [31:0] wr_data_ram;
  wire [31:0] address_rom;
  wire [31:0] address_ram;
  wire hready_1;
  wire hresp_1;
  wire hresp_2;
  wire hready_2;
  wire [31:0] load_out;
  wire [31:0] store_data;
  wire [31:0] read_data;

  // Instantiate the Unit Under Test (UUT)
  ahb_inte uut (
    .clk(clk),
    .haddr(haddr),
    .hwdata(hwdata),
    .hprot(hprot),
    .hwrite(hwrite),
    .hsize(hsize),
    .is_signed(is_signed),
    .ramdata(ramdata),
    .wr_en_ram(wr_en_ram),
    .rd_en_ram(rd_en_ram),
    .rd_en_rom(rd_en_rom),
    .wr_data_ram(wr_data_ram),
    .address_rom(address_rom),
    .address_ram(address_ram),
    .hready_1(hready_1),
    .hresp_1(hresp_1),
    .hresp_2(hresp_2),
    .hready_2(hready_2),
    .load_out(load_out),
    .store_data(store_data),
    .read_data(read_data)
  );

  // Clock generation
  initial clk = 0;
  always #5 clk = ~clk;

  // Test sequence
  initial begin
    // Initialize Inputs
    haddr      = 0;
    hwdata     = 0;
    hprot      = 4'b0011;
    hwrite     = 0;
    hsize      = 3'b010; // Word (32-bit)
    is_signed  = 0;
    ramdata    = 0;

    // Wait for global reset
    #10;

    // Write to address 0x04
    haddr   = 32'h00000004;
    hwdata  = 32'hA5A5A5A5;
    hwrite  = 1;
    #10;

    // Wait and read from address 0x04
    hwrite  = 0;
    haddr   = 32'h00000004;
    #10;

    // Add more read/write sequences as needed

    // End of simulation
    #50;
    $finish;
  end

  // Monitor output
  initial begin
    $monitor("Time=%0t | haddr=0x%h | hwdata=0x%h | wr_en_ram=%b | rd_en_ram=%b | wr_data_ram=0x%h | read_data=0x%h",
              $time, haddr, hwdata, wr_en_ram, rd_en_ram, wr_data_ram, read_data);
  end

endmodule
