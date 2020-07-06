module  controlUnit(input [3:0]opcode ,output reg RegDst,Jump , BranchEq , BranchNeq , BranchGt , BranchLt , MemRead ,MemtoReg ,
                    output reg [3:0]AluOp  , output reg MemWrite , ALUSrc  , RegWrite);

    always @(*) 
    case (opcode)
    /*R_TYPE*/   4'b0000:begin
                    RegDst    = 1'b1 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b000 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b0 ;
                    RegWrite  = 1'b1 ; 
                end

    /*ADDI*/     4'b0001:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b001 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b1 ;
                    RegWrite  = 1'b1 ;

                end

    /*ANDI*/    4'b0010:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b011 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b1 ;
                    RegWrite  = 1'b1 ;                
                end  

    /*ORI*/     4'b0011:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b100 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b1 ;
                    RegWrite  = 1'b1 ;     
                end

    /*SUBI*/    4'b0100:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b010 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b1 ;
                    RegWrite  = 1'b1 ;      
                end

    /*LW*/      4'b0111:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b1 ;
                    MemtoReg  = 1'b1 ;
                    AluOp     = 3'b001 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b1 ;
                    RegWrite  = 1'b1 ;      
                end

    /*SW*/      4'b1000:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b001 ;
                    MemWrite  = 1'b1 ;
                    ALUSrc    = 1'b1 ;
                    RegWrite  = 1'b0 ;   
                end


    /*BEQ*/     4'b1001:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b1 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b010 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b0 ;
                    RegWrite  = 1'b0 ;   
                end

    /*BNE*/     4'b1010:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b1 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b010 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b0 ;
                    RegWrite  = 1'b0 ;   
                end
    
    /*BLT*/     4'b1011:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b1 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b010 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b0 ;
                    RegWrite  = 1'b0 ;   
                end
    
    /*BGT*/     4'b1100:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b0 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b1 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b010 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b0 ;
                    RegWrite  = 1'b0 ;   
                end 

    /*JUMP*/     4'b1111:begin
                    RegDst    = 1'b0 ; 
                    Jump      = 1'b1 ;
                    BranchEq  = 1'b0 ;
                    BranchNeq = 1'b0 ;
                    BranchGt  = 1'b0 ;
                    BranchLt  = 1'b0 ;
                    MemRead   = 1'b0 ;
                    MemtoReg  = 1'b0 ;
                    AluOp     = 3'b001 ;
                    MemWrite  = 1'b0 ;
                    ALUSrc    = 1'b1 ;
                    RegWrite  = 1'b0 ;   
                end                   
        default: 
    endcase

    

endmodule