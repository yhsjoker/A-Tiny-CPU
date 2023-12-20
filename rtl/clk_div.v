/*分频程序*/
//`timescale 1ns / 1ps
//`include"headfile.v"

module clk_div(
	input			clk, reset,
	input[31:0]		symbol,
	output reg		div_clk
	);
	reg[31:0] count;
	always@(posedge clk) begin
		if(!reset) begin
			div_clk <= 1;
			count <= 0;
		end
		else begin
			if(count == symbol) begin 
				div_clk <= ~div_clk;
				count <= 0;
			end
			else begin
				count <= count + 1'b1;
			end
		end
	end
endmodule	