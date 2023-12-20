/*r3通用寄存器*/
module r3(
    input[7:0]          din,
    input               clk, rst, r3load, 
    output reg[7:0]     dout
    );
    always @(posedge clk or negedge rst) begin
        if(rst == 0) begin
            dout <= 0;
        end
        else if(r3load) begin
            dout <= din;
        end
    end
endmodule