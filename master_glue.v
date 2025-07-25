`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 20.07.2025 22:06:29
// Design Name: 
// Module Name: master_glue
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
module master_glue (
    input [31:0] data_out_mux,
    input        hready,
    input        hresp,
    input [2:0]  func3,
    input        mem_write,
    input        mem_read,
    input [31:0] rs2_data,
    input [31:0] alu_out,
    input [31:0] address,
    output reg [1:0]  htrans,
    output reg [31:0] haddr,
    output reg [31:0] hwdata,
    output reg [3:0]  hprot,
    output reg        hwrite,
    output reg [2:0]  hsize,
    output reg [31:0] data_out,
    output reg is_signed
);

always @(*) begin
    // Defaults
    htrans   = 2'b00;
    haddr    = 32'b0;
    hwdata   = 32'b0;
    hprot    = 4'b0000;
    hwrite   = 1'b0;
    hsize    = 3'b010;
    is_signed=0;
    data_out = data_out_mux;

    if (hready && !hresp) begin
        htrans = 2'b10; // NONSEQ

        if (address[31:24] == 8'hA0) begin // ROM
            if (!mem_read && !mem_write) begin
                haddr  = address;
                hwrite = 0;
                hprot  = 4'b0000;
                case (func3)
                    3'b000: hsize = 3'b000; // LB
                    3'b001: hsize = 3'b001; // LH
                    3'b010: hsize = 3'b010; // LW
                    3'b100: hsize = 3'b000; // LBU
                    3'b101: hsize = 3'b001; // LHU
                    default: hsize = 3'b010;
                endcase
            end
        end
        else if (address[31:24] == 8'hB0) begin // RAM
            haddr = alu_out;
            hprot = 4'b0001;
            case (func3)
                3'b000: begin
                        hsize = 3'b000;
                        is_signed=1'b1;
                        end
                3'b001: begin
                        hsize = 3'b001;
                        is_signed=1'b1;
                        end
                3'b010: begin
                        hsize = 3'b010;
                        is_signed=1'b1;
                        end
                3'b100: hsize = 3'b000;
                3'b101: hsize = 3'b001;
                default: hsize = 3'b010;
            endcase

            if (mem_write) begin
                hwrite = 1;
                hwdata = rs2_data;
            end else if (mem_read) begin
                hwrite = 0;
            end
        end
    end
    else
    begin
        hwrite=hwrite;
        hsize=hsize;
        haddr=haddr;
        hprot=hprot;
        hwdata = hwdata;
        htrans= htrans;  
        data_out = data_out;
    end
end

endmodule
