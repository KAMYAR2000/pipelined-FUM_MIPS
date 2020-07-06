module FUM_MIPS ();

reg clk;
reg stall;

//IF stage wires
wire [15:0] Instruction, nextPc;
reg [7:0] PC;


//ID stage wires
reg  [15:0] IR_2, PC1_2;
reg  [7:0] PC_2;
wire [15:0] jSE_2, imm_2, readDataA, readDataB;
wire RegDst_2, Beq_2, Bne_2, Blt_2, Bgt_2, MemRead_2, MemToReg_2, MemWrite_2, ALUSrc_2, RegWrite_2, Jump_2;
wire [3:0] ALUOp_2;

//EX stage wires
reg  [15:0] IR_3, PC1_3, imm_3, jSE_3, ReadData1_3, ReadData2_3;
wire [15:0] ALUin_3, ALUOut_3;
wire [3:0] Operation;
wire [2:0] WireDst_3;
reg  RegDst_3, Beq_3, Bne_3, Blt_3, Bgt_3, MemRead_3, MemToReg_3, MemWrite_3, ALUSrc_3, RegWrite_3, Jump_3;
wire gt_3, lt_3;
reg  [3:0] ALUOp_3;
reg  [1:0] ForwardA, ForwardB;

//MEM stage wires
reg RegWrite_4, Beq_4, Bne_4, Blt_4, Bgt_4, MemToReg_4, MemRead_4, MemWrite_4, lt_4, gt_4;
reg [15:0] ALUOut_4, ReadData2_4;
wire[15:0] MemReadData_4;
reg [15:0] IR_4;
reg [2:0] WireDst_4;

//WB stage wires
reg  regWrite , MemToReg_5;
reg  [15:0] MemReadData_5, ALUOut_5;
wire [15:0] writeData;
reg  [2:0]  distReg;
reg  [15:0] IR_5;


//Fetch
always @(negedge clk) begin
	  PC = nextPc ;
	  if(stall) 
		PC = PC-1;
end
adder PcAdder(PC, 16'b000000000000010, nextPc , clk);
InstructionMem InstructionMem_inst(1, PC, Instruction);
always @(negedge clk)
begin
    if (stall)
      IR_2 <= IR_2;
    else
      IR_2 <= Instruction;
			
	ID_PC <= PC;			
    // ID_PC1 <= nextPc;
end





//Decode
RegFile RegisterFile(clk, IR[11:9], IR[8:6], distReg, writeData, regWrite, readDataA, readDataB);
SignExtend SignExtend_inst(IR[5:0], ID_imm, clk);
always @(*)
begin
    if (EX_MemRead && ((IR_3[8:6] == IR_2[11:9]) || (IR_3[8:6] == IR_2[8:6])))                  //stalling even with forwarding when after lw comes sub
        stall = 1'b1;
    else
        stall = 1'b0;
end

ControlUnit Control(IR[15:12], RegDst_2, Jump_2, Beq_2,Bne_2, Bgt_2, Blt_2, MemRead_2, MemToReg_2,ALUOp_2 ,MemWrite_2 ,  ALUSrc_2, RegWrite_2);

always @(negedge clk)		    
begin
    RegDst_3        <= RegDst_2;
    ALUOp_3         <= ALUOp_2;
    ALUSrc_3        <= ALUSrc_2;
    Beq_3           <= Beq_2;
    Bne_3           <= Bne_2;
    Blt_3           <= Blt_2;
    Bgt_3           <= Bgt_2;
    MemRead_3       <= MemRead_2;
    MemWrite_3      <= MemWrite_2;
    RegWrite_3      <= RegWrite_2;
    MemToReg_3      <= MemToReg_2;
    PC1_3           <= PC1_2;                 //doubt
    ReadData1_3     <= readDataA_2;
    ReadData2_3     <= readDataB_2;
    IR_3            <= IR_2;
    imm_3           <= imm_2;
end


//execute   
wire [15:0] mux1, mux2;
MUX_16bit_3to1 MultiplexerA(ReadData1_3, writeData, ALUOut_4, mux1_out, ForwardA);
MUX_16bit_3to1 MultiplexerB(ReadData2_3, writeData, ALUOut_4, mux2_out, ForwardB);
MUX_3bit_2to1 RegDst_Multiplexer(IR_3[5:3], IR_3[8:6], WriteRegister_3, RegDst_3);
                            //////////////////////////////////////////////////////////////////////////////////
MUX_16bit_2to1 MultiplexerBB(imm_4, MUXB_out, ALUin_4, ALUSrc_4);
ALU Alu(mux1_out, ALUin_4, ALUOp_4, ALUOut_4, zero_4و lt_4 و gt_4);
 
always @(*)
begin
    
    if (RegWrite_4
        && (WriteRegister_4 != 0)
        && (WriteRegister_4 == IR_3[11:9]))
        ForwardA = 2'b10;

    
    else if (RegWrite_5
        && (WriteRegister_5 != 0)
        && !(RegWrite_4 && (WriteRegister_4 != 0) && (WriteRegister_4 != IR_3[11:9]))
        && (WriteRegister_5 == IR_3[11:9]))
        ForwardA = 2'b01;
    else
        ForwardA = 2'b00;


 
    if (RegWrite_4
        && (WriteRegister_4 != 0)
        && (WriteRegister_4 == IR_3[8:6]))
        ForwardB = 2'b10;
    
    else if (RegWrite_5
        && (WriteRegister_5 != 0)
        && !(RegWrite_4 && (WriteRegister_4 != 0) && (WriteRegister_4 != IR_3[8:6]))
        && (WriteRegister_5 == IR_3[8:6]))
        ForwardB = 2'b01;
    else
        ForwardB = 2'b00;
end

    
    always @(negedge clk)		    
    begin
        Beq_4               <= Beq_3;
        Bne_4               <= Bne_3;
        Blt_4               <= Blt_3;
        Bgt_4               <= Bgt_3;
        MemRead_4           <= MemRead_3;
        MemWrite_4          <= MemWrite_3;
        RegWrite_4          <= RegWrite_3;
        MemToReg_4          <= MemToReg_3;
	    lt_4                <= lt_3;
        gt_4                <= gt_3;
        ALUOut_4            <= ALUOut_3;
        ReadData2_4         <= ReadData2_3;
        WireDst_4           <= WireDst_3;
        IR_4                <= IR_3;
    end


//memory
DataMem DataMem_inst(MemRead_4, MemWrite_4, ALUOut_4, ReadData2_4, MemReadData_4);
always @(negedge clk)		
begin
    
    RegWrite_5         <= RegWrite_4;
    MemToReg_5         <= MemToReg_4;
    ALUOut_5           <= ALUOut_4;
    MemReadData_5      <= MemReadData_4;
    WriteRegister_5    <= WriteRegister_4;
    IR_5      <= IR_4;
end

//WB
MUX_16bit_2to1 Multiplexer_WB(MemReadData_5, ALUOut_5, Wb_5, MemToReg_5);

endmodule


