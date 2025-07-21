`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.07.2025 11:06:01
// Design Name: 
// Module Name: slave_load
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
module slave_load( 
    input [2:0]hsize,
    input is_signed,
    input [31:0] ramdata,
    output [31:0]load_out
);
reg [31:0]pad_val;
reg temp;
always@(*)
begin
    if(is_signed)
    begin
        case(hsize)
            3'b000: pad_val= {{24{ramdata[7]}}, ramdata[7:0]};
            3'b001: pad_val= {{16{ramdata[15]}}, ramdata[15:0]};
            default: pad_val=ramdata[31:0];
        endcase
    end
    else 
    begin
    case(hsize)
            3'b000: pad_val= {{24'b0}, ramdata[7:0]};
            3'b001: pad_val= {{16'b0}, ramdata[15:0]};
            default: pad_val=ramdata[31:0];
        endcase
    end
end
assign load_out=pad_val;
endmodule
