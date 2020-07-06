module DMemBank(input memread, input memwrite, input [15:0] address, input [15:0] writedata, output reg [15:0] readdata);
 reg [15:0] mem_array [127:0];

   always@(memread, memwrite, address, mem_array[address], writedata)
  begin
    if(memread)begin
      readdata=mem_array[address];
    end

    if(memwrite)begin
      mem_array[address]= writedata;
    end

  end

endmodule