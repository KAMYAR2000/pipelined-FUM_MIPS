module Mux_16bit_3to1(p1, p2, p3, out, sel);
input [15:0] p1, p2, p3;
input [1:0] sel;
output reg [15:0] out;
	always@(*) begin
		if(sel==2'b00)
			out = p1;
		else if(sel==2'b01)
      out = p2;
    else if(sel==2'b10)
      out = p3;
    end
endmodule