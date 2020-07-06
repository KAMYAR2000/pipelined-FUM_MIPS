module  ALUControl(input [2:0] ALUop , input [2:0]func , output reg [3:0] aluop);
            always @(*) 
             begin
               if(aluop==3'b000)
                begin
                  case (func)
                    3'b000 : aluop = 4'b0000 ;
                    3'b001 : aluop = 4'b0001 ;
                    3'b010 : aluop = 4'b0010 ;
                    3'b011 : aluop = 4'b0011 ;
                    3'b100 : aluop = 4'b0100 ; 
                    3'b101 : aluop = 4'b0101 ;
                    3'b110 : aluop = 4'b0110 ;
                    default: aluop = 4'b0000 ;
                  endcase

                end
                else begin
                  case(aluop)
                    3'b001 : aluop = 4'b0000 ;
                    3'b010 : aluop = 4'b0001 ;
                    3'b011 : aluop = 4'b0010 ;
                    3'b100 : aluop = 4'b0011 ; 
                    3'b101 : aluop = 4'b0100 ;
                    3'b110 : aluop = 4'b0101 ;
                    default: aluop = 4'b0000 ;
                  endcase
                end
             end

endmodule