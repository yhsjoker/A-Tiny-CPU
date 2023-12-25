/*组合逻辑控制单元，根据时钟生成为控制信号和内部信号*/
/*
输入：
       din：指令，8位，来自IR；
       clk：时钟信号，1位，上升沿有效；
       rst：复位信号，1位，与cpustate共同组成reset信号；
       cpustate：当前CPU的状态（IN，CHECK，RUN），2位；
       z：零标志，1位，零标志寄存器的输出，如果指令中涉及到z，可加上，否则可去掉；
输出：
      clr：清零控制信号
     自行设计的各个控制信号
*/
//省略号中是自行设计的控制信号，需要自行补充，没用到z的话去掉z

module control(
	input[7:0]			din,
	input				clk, rst, z,
	input[1:0]			cpustate,
	output				arload, arinc,
	output				drload, drhbus, drlbus,
	output				irload,
	output				pcload, pcinc, pcbus,
	output				r0load, r0bus,
	output				r1load, r1bus,
	output				r2load, r2bus,
	output				r3load, r3bus,
	output				trload, trbus,
	output				xload,
	output				yload, ybus,
	output				zload,	
	output				read, write, 
	output				membus, busmem,
	output reg[3:0]		alus, 	 
	output				clr
	); 

	//在下方加上自行定义的状态
	wire reset;
	wire fetch1, fetch2, fetch3;
	wire nop1;
	wire add1, add2, add3;
	wire sub1, sub2, sub3;
	wire and1, and2, and3;
	wire or1, or2, or3;
	wire inc1, inc2;
	wire dec1, dec2;
	wire not1, not2;
	wire shl1, shl2;
	wire mvr1;
	wire mvrd1, mvrd2;
	wire jmp1, jmp2, jmp3;
	wire skp1, skp2;
	wire lad1, lad2, lad3, lad4, lad5;
	wire sto1, sto2, sto3, sto4, sto5;
			
	//加上自行设计的指令，这里是译码器的输出，所以nop指令经译码器输出后为inop。
	//类似地，add指令指令经译码器输出后为iadd；inac指令经译码器输出后为iinac，......
	reg inop;
	reg	iadd;
	reg	isub;
	reg	iand;
	reg	ior;
	reg	iinc;
	reg	idec;
	reg	inot;
	reg	ishl;
	reg	imvr;
	reg	imvrd;
	reg	ijmp;
	reg	ijmpz;
	reg	ijpnz;
	reg	ilad;
	reg	isto;

	//时钟节拍，8个为一个指令周期，t0-t2分别对应fetch1-fetch3，t3-t7分别对应各指令的执行周期，当然不是所有指令都需要5个节拍的。例如add指令只需要2个节拍：t3和t4
	reg t0, t1, t2, t3, t4, t5, t6, t7; //时钟节拍，8个为一个周期


	// 内部信号：clr清零，inc自增
	wire inc;
	assign reset = rst & (cpustate == 2'b11);


	//clr信号是每条指令执行完毕后必做的清零，下面clr赋值语句要修改，需要“或”各指令的最后一个周期
	assign clr = nop1 || add3 || sub3 || and3 || or3 || inc2 || dec2 || not2 || shl2 || mvr1 || mvrd2 || jmp3 || skp2 || lad5 || sto5;
	assign inc = ~clr;


	//generate the control signal using state information
	//取公过程
	assign fetch1 = t0;
	assign fetch2 = t1;
	assign fetch3 = t2;


	//什么都不做的译码
	assign nop1 = inop && t3;//inop表示nop指令，nop1是nop指令的执行周期的第一个状态也是最后一个状态，因为只需要1个节拍t3完成


	//以下写出各条指令状态的表达式
	assign add1 = iadd && t3;
	assign add2 = iadd && t4;
	assign add3 = iadd && t5;

	assign sub1 = isub && t3;
	assign sub2 = isub && t4;
	assign sub3 = isub && t5;

	assign and1 = iand && t3;
	assign and2 = iand && t4;
	assign and3 = iand && t5;

	assign or1 = ior && t3;
	assign or2 = ior && t4;
	assign or3 = ior && t5;

	assign inc1 = iinc && t3;
	assign inc2 = iinc && t4;

	assign dec1 = idec && t3;
	assign dec2 = idec && t4;

	assign not1 = inot && t3;
	assign not2 = inot && t4;

	assign shl1 = ishl && t3;
	assign shl2 = ishl && t4;

	assign mvr1 = imvr && t3;

	assign mvrd1 = imvrd && t3;
	assign mvrd2 = imvrd && t4;

	assign jmp1 = (ijmp && t3) || (ijmpz && t3 && (z == 1)) || (ijpnz && t3 && (z == 0));
	assign jmp2 = (ijmp && t4) || (ijmpz && t4 && (z == 1)) || (ijpnz && t4 && (z == 0));
	assign jmp3 = (ijmp && t5) || (ijmpz && t5 && (z == 1)) || (ijpnz && t5 && (z == 0));

	assign skp1 = (ijmpz && t3 && (z == 0)) || (ijpnz && t3 && (z == 1));
	assign skp2 = (ijmpz && t4 && (z == 0)) || (ijpnz && t4 && (z == 1));

	assign lad1 = ilad && t3;
	assign lad2 = ilad && t4;
	assign lad3 = ilad && t5;
	assign lad4 = ilad && t6;
	assign lad5 = ilad && t7;

	assign sto1 = isto && t3;
	assign sto2 = isto && t4;
	assign sto3 = isto && t5;
	assign sto4 = isto && t6;
	assign sto5 = isto && t7;

	//以下给出了pcbus的逻辑表达式，写出其他控制信号的逻辑表达式
	assign arload = fetch1 || fetch3 || lad3 || sto3;
	assign arinc = jmp1 || lad1 || sto1;

	assign drload = fetch2 || mvrd1 || jmp1 || jmp2 || lad1 || lad2 || lad4 || sto1 || sto2 || sto4;
	assign drhbus = jmp3 || lad3 || sto3;
	assign drlbus = mvrd2 || lad5 || sto5;

	assign irload = fetch3;

	assign pcload = jmp3; 
	assign pcinc = fetch2 || mvrd1 || skp1 || skp2 || lad1 || lad2 || sto1 || sto2;
	assign pcbus = fetch1 || fetch3;

	assign r0load = (add3 || sub3 || and3 || or3 || inc2 || dec2 || not2 || shl2 || mvr1 || mvrd2 || lad5) && (din[3:2] == 2'b00);
	assign r0bus = ((add1 || sub1 || and1 || or1 || mvr1) && (din[1:0] == 2'b00))
				|| ((add2 || sub2 || and2 || or2 || inc1 || dec1 || not1 || shl1 || sto4) && (din[3:2] == 2'b00));

	assign r1load = (add3 || sub3 || and3 || or3 || inc2 || dec2 || not2 || shl2 || mvr1 || mvrd2 || lad5) && (din[3:2] == 2'b01);
	assign r1bus = ((add1 || sub1 || and1 || or1 || mvr1) && (din[1:0] == 2'b01))
				|| ((add2 || sub2 || and2 || or2 || inc1 || dec1 || not1 || shl1 || sto4) && (din[3:2] == 2'b01));

	assign r2load = (add3 || sub3 || and3 || or3 || inc2 || dec2 || not2 || shl2 || mvr1 || mvrd2 || lad5) && (din[3:2] == 2'b10);
	assign r2bus = ((add1 || sub1 || and1 || or1 || mvr1) && (din[1:0] == 2'b10))
				|| ((add2 || sub2 || and2 || or2 || inc1 || dec1 || not1 || shl1 || sto4) && (din[3:2] == 2'b10));

	assign r3load = (add3 || sub3 || and3 || or3 || inc2 || dec2 || not2 || shl2 || mvr1 || mvrd2 || lad5) && (din[3:2] == 2'b11);
	assign r3bus = ((add1 || sub1 || and1 || or1 || mvr1) && (din[1:0] == 2'b11))
				|| ((add2 || sub2 || and2 || or2 || inc1 || dec1 || not1 || shl1 || sto4) && (din[3:2] == 2'b11));

	assign trload = jmp2 || lad2 || sto2;
	assign trbus = jmp3 || lad3 || sto3;

	assign xload = add1 || sub1 || and1 || or1;

	assign yload = add2 || sub2 || and2 || or2 || inc1 || dec1 || not1 || shl1;
	assign ybus = add3 || sub3 || and3 || or3 || inc2 || dec2 || not2 || shl2;

	assign zload = add2 || sub2 || and2 || or2 || inc1 || dec1 || not1 || shl1;

	assign read = fetch2 || mvrd1 || jmp1 || jmp2 || lad1 || lad2 || lad4 || sto1 || sto2;
	assign write = sto5;

	assign membus = fetch2 || mvrd1 || jmp1 || jmp2 || lad1 || lad2 || lad4 || sto1 || sto2;
	assign busmem = sto5;


	always@(posedge clk or negedge reset)
	begin
	if(!reset)
		begin//各指令清零，以下已为nop指令清零，请补充其他指令，为其他指令清零
			alus <= 4'bxxxx;
			
			inop  <= 0;
			iadd  <= 0; 
			isub  <= 0;
			iand  <= 0; 
			ior   <= 0;
			iinc  <= 0;
			idec  <= 0;
			inot  <= 0; 
			ishl  <= 0;
			imvr  <= 0;
			imvrd <= 0;
			ijmp  <= 0; 
			ijmpz <= 0;
			ijpnz <= 0;
			ilad  <= 0;
			isto  <= 0;
		end
	else 
		begin
			case(din[7:4])	//译码处理过程
			4'd0:  begin		//op为0000，是nop指令，因此这里inop的值是1，而其他指令应该清零，请补充为其他指令清零的语句
				alus  <= 4'bxxxx;
				inop  <= 1;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd1:  begin
					//op为0001，应该是add指令，因此iadd指令为1，其他指令都应该是0。
					//后续各分支类似，只有一条指令为1，其他指令为0，以下分支都给出nop指令的赋值，需要补充其他指令
				alus  <= 4'b0001;
				inop  <= 0;
				iadd  <= 1; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd2:  begin
				alus  <= 4'b0010;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 1;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd3:  begin
				alus  <= 4'b0101;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 1; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd4:  begin
				alus  <= 4'b0110;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 1;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd5:  begin
				alus  <= 4'b0011;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 1;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd6:	begin
				alus  <= 4'b0100;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 1;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end
				
			4'd7:	begin
				alus  <= 4'b0111;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 1; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd8:	begin
				alus  <= 4'b1000;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 1;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;	
				end

			4'd9:	begin
				alus  <= 4'bxxxx;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 1;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd10:	begin
				alus  <= 4'bxxxx;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 1;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd11:	begin
				alus <= 4'bxxxx;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 1; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;	
				end

			4'd12:	begin
				alus <= 4'bxxxx;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 1;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 0;	
				end

			4'd13:	begin
				alus <= 4'bxxxx;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 1;
				ilad  <= 0;
				isto  <= 0;
				end

			4'd14:	begin
				alus <= 4'bxxxx;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 1;
				isto  <= 0;
				end

			4'd15:	begin
				alus <= 4'bxxxx;
				inop  <= 0;
				iadd  <= 0; 
				isub  <= 0;
				iand  <= 0; 
				ior   <= 0;
				iinc  <= 0;
				idec  <= 0;
				inot  <= 0; 
				ishl  <= 0;
				imvr  <= 0;
				imvrd <= 0;
				ijmp  <= 0; 
				ijmpz <= 0;
				ijpnz <= 0;
				ilad  <= 0;
				isto  <= 1;	
				end

			endcase
		end
	end

	always @(posedge clk or negedge reset) begin
		if(!reset) begin
			t0 <= 1;
			t1 <= 0;
			t2 <= 0;
			t3 <= 0;
			t4 <= 0;
			t5 <= 0;
			t6 <= 0;
			t7 <= 0;
		end
		else begin
			if(inc) begin
				t7 <= t6;
				t6 <= t5;
				t5 <= t4;
				t4 <= t3;
				t3 <= t2;
				t2 <= t1;
				t1 <= t0;
				t0 <= 0;
			end
			else if(clr) begin
				t0 <= 1;
				t1 <= 0;
				t2 <= 0;
				t3 <= 0;
				t4 <= 0;
				t5 <= 0;
				t6 <= 0;
				t7 <= 0;
			end
		end

	end
/*—————结束—————*/
endmodule
	
		