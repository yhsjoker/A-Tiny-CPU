/*数据暂存器,处理双字节指令时使用，用来存储第八位的地址或数值*/
module tr(
    input[7:0]          din,
    input               clk, rst, trload, 
    output reg[7:0]     dout
    );
    always @(posedge clk or negedge rst) begin
        if(rst == 0) begin
            dout <= 0;
        end
        else if(trload) begin
            dout <= din;
        end
    end
endmodule