/*暂存器Y，存放ALU的运算结果*/
module y(
    input[7:0]          din,
    input               clk, rst, yload, 
    output reg[7:0]     dout
    );
    always @(posedge clk or negedge rst) begin
        if(rst == 0) begin
            dout <= 0;
        end
        else if(yload) begin
            dout <= din;
        end
    end
endmodule