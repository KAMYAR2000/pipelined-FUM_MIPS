module InstructionMem(input memRead , input [7:0] readAddress , output reg [15:0] readInst);

reg[15:0] instruction_memory[255:0] ; 

always @(memRead , readAddress)
    begin
        if(memRead)
            begin
                readInst = instruction_memory[readAddress];
            end
    end
endmodule


