/*数据暂存器x，存放ALU的一个输入，另外一个输入来自于总线*/
module x(
    input[7:0]          din,
    input               clk, rst, xload, 
    output reg[7:0]     dout
    );
    always @(posedge clk or negedge rst) begin
        if(rst == 0) begin
            dout <= 0;
        end
        else if(xload) begin
            dout <= din;
        end
    end
endmodule