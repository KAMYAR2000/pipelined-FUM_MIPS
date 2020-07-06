
module ALU(input[15:0] A , input[15:0] B , input[3:0] ALU_Sel , output reg[15:0] ALU_Result, output reg zero , lt , gt );

    always @(*)
    begin
        case(ALU_Sel)
           4'b0000: ALU_Result = A + B ; // Addition
           4'b0001: ALU_Result = A - B ; // Subtraction
           4'b0010: ALU_Result = A & B   //  Logical and 
           4'b0011: ALU_Result = A | B;  //  Logical or
           4'b0100: ALU_Result = A ^ B;  //  Logical xor 
           4'b0101: ALU_Result = ~(A ^ B);// Logical xnor
           4'b0110: ALU_Result = A < B ? 16'b1 : 16'b0 ;  //Logical slt
           default: ALU_Result = A + B ;       //Addition 
        endcase

    if(A>B)
     begin
      zero = 1'b0 ; 
      gt   = 1'b1 ; 
      lt   = 1'b0 ; 
     end else if (A<B)  
      begin
       zero = 1'b0 ; 
       gt   = 1'b0 ; 
       lt   = 1'b1 ; 
       end 
       else
       begin
        zero = 1'b1 ; 
        gt   = 1'b0 ; 
        lt   = 1'b0 ; 
     end

     end 
     

      


endmodule