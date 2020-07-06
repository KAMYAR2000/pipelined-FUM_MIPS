module RegFile (clk , readreg1 , readreg2 , writereg , writedata , regwrite , readdate1 , readdata2);
    input[2:0] readreg1 , readreg2 , writereg ; 
    input[15:0] writedata ; 
    input clk , regwrite ;
    output[15:0] readdate1 , readdata2;

    reg[15:0] regfile [7:0] ; 

    always @(negedge clk)
    begin
        regfile[0] = 0 ;
        if(regwrite)
            begin
                regfile[writereg] <= writedata
            end
    end


    assign readdate1 = regfile[readreg1] ; 
    assign readdata2 = regfile[readreg2] ; 
    



endmodule