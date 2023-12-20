/*数据寄存器，存放双指令中低8位指向地址的存放值*/
module dr(
    input[7:0]          din, 
    input               clk, rst, drload,
    output reg[7:0]     dout
    );
    always @(posedge clk or negedge rst) begin
        if(rst == 0) begin
            dout <= 0;
        end
        else if(drload) begin
            dout <= din;
        end
    end
endmodule