/*算术逻辑单元，x来自于Rs，bus来自于Rd*/
module alu(
    input[3:0]      alus,
    input[7:0]      x, bus, 
    output reg[7:0] dout
    );
    always@(*) begin
        case(alus)
            4'b0000:	dout = 8'b00000000;      //清零
            4'b0001:	dout = bus + x;          //加法
            4'b0010:	dout = bus - x;          //减法
            4'b0011:	dout = x + 8'b00000001;  //自增
            4'b0100:	dout = x - 8'b00000001;  //自减
            4'b0101:	dout = bus & x;          //与
            4'b0110:	dout = bus | x;          //或
            4'b0111:    dout = ~x;               //非
            4'b1000:    dout = bus ^ x;          //异或
            default:    dout = 8'bx;
        endcase
    end
endmodule
