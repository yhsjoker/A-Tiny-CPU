/*程序计数器，输出当前执行的指令地址
可仿照ar地址寄存器来写，注意替换控制信号*/
module pc(
    input[15:0]         din,
    input               clk, rst, pcload, pcinc,
    output reg[15:0]    dout
    );
    always @(posedge clk or negedge rst) begin
        if(rst == 0) begin
            dout <= 0;
        end
        else begin
            if(pcload) begin
                dout <= din;
            end
            else if(pcinc) begin
                dout <= dout + 16'd1;
            end
        end

    end
endmodule