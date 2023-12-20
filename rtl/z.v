/*标志寄存器*/
module z(
    input[7:0]          din,
    input               clk, rst, zload, 
    output reg[7:0]     dout
    );
    always @(posedge clk or negedge rst) begin
        if(rst == 0) begin
            dout <= 0;
        end
        else if(zload) begin
            dout <= din;
        end
    end
endmodule