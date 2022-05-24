	


//Ibraheem duhaidi 1190283



module FA(a,b,Cin,sum,Cout);
		input a,b,Cin;
		output sum,Cout ;
		xor(sum,a,b) ;
		and(Cout,a,b);
		
	
	endmodule 
	
	
	
	//////////////
	
	
	module cmpG(f,a,b);
		
		input a , b ; 
output reg f ; 

always @(a,b)
	begin
		f = 0;
		if (a > b)
			f = 1;
	end

endmodule
	
	
	//////////////////////////////////////
	
	module mux4to1 (w0, w1, w2, w3, s0,s1, f);	
		
	input w0, w1, w2, w3,s0,s1;
	
	output f;

	assign f = s1 ? (s0 ? w3 : w2) : (s0 ? w1 : w0);
		
	endmodule	
	
	
	
	
	
	
	
	module circit_behavioral(A,B,S0,S1,sum,cout);
	 input A,B,S0,S1;
	 output sum,cout;	 
	 
     assign sum = (B & S0 & S1) | (A & S0 & S1) | (A & B & S0) | (~A & B & ~S0 & ~S1) | (A & ~B & ~S0 & ~S1) ;
	 assign cout = (A & ~B & ~S0 & S1) | (A & B & ~S0 & ~S1) ;
endmodule  







module testBehavioral ; 
	reg TA , TB , TS0 , TS1 ; 
	wire TSUM , TCOUT ; 
	circit_behavioral f(TA , TB , TS0 , TS1 ,TSUM , TCOUT  )	; 
	initial
	begin 	 
		 $monitor("Time %0d  A=%b B=%b S0=%b S1=%b SUM =%b Cout=%b",$time,TA,TB,TS0,TS1,TSUM,TCOUT);	  
	  	  
		{TA,TB,TS0,TS1} = 4'b0000;	
			repeat(15)
			#10ns {TA,TB,TS0,TS1} = {TA,TB,TS0,TS1} + 4'b0001;  
	end 
endmodule							


	module all_circuit(a,b,s0,s1,sum,Cout);
		input a,b ;  
		input s0,s1; 
		 
		output sum,Cout;
		wire w0,w1,w2,w3,w4 ;
		FA fa(a,b,0,w0,w1) ;
		cmpG c(w2,a,b);
		and(w3,a,b);
		or(w4,a,b);
		mux4to1 m1(w0,0,w3,w4,s0,s1,sum);
		mux4to1 m2(w1,w2,0,0,s0,s1,Cout);
		
	endmodule	 

module testStructural  ;
	reg TA , TB , TS0 , TS1 ; 
	wire TSUM , TCOUT ; 
	all_circuit d(TA , TB , TS0 , TS1 ,TSUM , TCOUT  )	; 
	initial
	begin 			
		 $monitor("Time %0d  A=%b B=%b S0=%b S1=%b SUM=%b Cout=%b",$time,TA,TB,TS0,TS1,TSUM,TCOUT);	
		{TA,TB,TS0,TS1} = 4'b0000;	
			repeat(15)
			#10ns {TA,TB,TS0,TS1} = {TA,TB,TS0,TS1} + 4'b0001;  
	end  
endmodule 