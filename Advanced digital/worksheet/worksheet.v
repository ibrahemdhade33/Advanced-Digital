module mux2to1 (w0, w1, s, f);
	input w0, w1, s;
	output f;
	
	assign f = s ? w1 : w0;
		
endmodule



module dec2to4 (a,b, En, Y);
	input a,b;
	input En;
	output reg [0:3] Y;
		
	always @(a,b, En)
		case ({En,a,b})
			3'b100: Y = 4'b0111;
			3'b101: Y = 4'b1011;
			3'b110: Y = 4'b1101;
			3'b111: Y = 4'b1110;
			default: Y = 4'b1111;
		endcase
	
endmodule	 

module all(a,b,c,d,f1,f2);
	
input a,b,c,d ; 
output f1,f2 ; 
wire [0:3]w; 

dec2to4 decoder(a,b,~d,w);
wire [0:3]w1 ; 
dec2to4 decoder1(c,~b,d,w1);
wire w2,w3;	
and(w2,w[0],w[1]); 
xor(w3,w[2],w[3]);
xnor(f2,w1[2],w1[3]);
mux2to1 mux(w2,w3,w1[0],f1) ;
	
endmodule 





module all_behavioral(a,b,c,d,f1,f2);
	
input a,b,c,d ; 
output reg f1,f2 ; 
always @(a,b,c,d,f1,f2)	
	begin
	f1 = ~d | b ;
	f2 = (b&(~c)&d) | (a&~d) ;
	end
endmodule


module test_worksheet();
	reg a,b,c,d ;
	wire f1,f2; 
	all ttl(a,b,c,d,f1,f2);
	initial 
	begin
	 
     
	 {a,b,c,d} = 4'b0000;	
			repeat(15)
			#10 {a,b,c,d} = {a,b,c,d} + 4'b0001;
   end

	
endmodule


