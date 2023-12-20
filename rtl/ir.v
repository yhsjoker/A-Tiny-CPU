/*指令寄存器，存储要执行的指令*/

//注意：该寄存器是时钟的下降沿有效
module ir(
    input[7:0]          din,
    input               clk, rst, irload,
    output reg[7:0]     dout
    );
    always @(negedge clk or negedge rst) begin
        if(rst == 0) begin
            dout <= 0;
        end
        else if(irload) begin
            dout <= din;
        end
    end
endmodule