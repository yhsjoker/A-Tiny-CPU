/*地址寄存器，输出要执行的下一指令地址*/
module ar(
	input[15:0]			din, 
	input				clk, rst, arload, arinc, 
	output reg[15:0]	dout
	);
	always@(posedge clk or negedge rst) begin
		if(rst == 0) begin
			dout <= 0;
		end
		else begin
			if(arload) begin
				dout <= din;
			end
			else if(arinc) begin
				dout <= dout + 16'd1;
			end
		end
	end
endmodule