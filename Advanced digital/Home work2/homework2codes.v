module mux2to1_v3 (w0, w1, s, f);
	input w0, w1, s;
	output reg f;
	
	always @(w0, w1, s)
		if (s==0)
			f = w0;
		else
			f = w1;
		
endmodule



module D_FF (D,CLK,RST,Q,Qp);
   output Q,Qp;
   input D,CLK,RST;
   reg Q;
   assign Qp = ~Q ;
   always @(posedge CLK or negedge RST )
	   if(~RST)
		   Q=0;
	   else 
     	   Q = D;
	 
endmodule 





module JK_FF (J,K,CLK,RST,Q,Qp);
   output Q,Qp;
   input  J,K,CLK,RST;
   reg  Q;
   assign Qp = ~ Q ;
   always @(posedge CLK or negedge RST)
	   if(~RST)
		   Q =0 ; 
		else 
           case({J,K})
             2'b00: Q = Q;
             2'b01: Q = 1'b0;
             2'b10: Q = 1'b1;
             2'b11: Q = ~ Q;
           endcase
endmodule	 

 module all_circuit(Q0,Q1,Q0_p,Q1_p,CLK,RST,y); 
	
	input y ,CLK,RST; 
	output Q0,Q1,Q0_p,Q1_p ;
	wire D,j,k;
	
	assign D = (~y&Q0)  | (~y&Q1) ;
	assign k = y ;
	wire w1 ;
	nand(w1,Q0,Q1) ; 
	
	assign pr0 = Q0,pr1 =Q1;  
	mux2to1_v3 mux_res(Q1_p,w1,y,j); 
	JK_FF  jk_res  (j,k,CLK,RST,Q0,Q0_p);
	D_FF D_res (D,CLK,RST,Q1,Q1_p);
    
	
	
endmodule




module testTcircuit;
  reg y,CLK,RST; //inputs for circuit
  wire Q0,Q1,Q0_p,Q1_p; //output from circuit
  all_circuit b (Q0,Q1,Q0_p,Q1_p,CLK,RST,y);
  initial begin
   RST = 0; CLK = 0; 
   	#5 RST = 1;
  	$monitor("time = %0d CLK = %b RST=%d  Y=%b Q0=%b Q1=%b ",$time,CLK,RST,y,Q0,Q1);
   
   repeat (7)
   #25 CLK = ~CLK;	
   #85 y=~y;
  end 
  initial begin
    y = 0; #15 y = 1;
    repeat (8)
    #10 y = ~ y;       
   end

  
endmodule



 module behaviroal (y,Q0,Q1,Q0_p,Q1_p,CLK,RST);
   input y,CLK,RST;
   output Q0,Q1,Q0_p,Q1_p;
   reg [1:0] state;
   parameter S0=2'b00,S1=2'b01,S2=2'b10,S3=2'b11; 
   assign Q0_p = ~Q0 ; 
   assign Q1_p = ~Q1 ;
   always @(posedge CLK or negedge RST)
     if (~RST) state = S0;  //Initialize to state S0
     else
	case(state)
           S0:  state = S1;  
           S1: if (y)  state = S0; else state = S3;    
           S2: if (y) state = S1;
           S3: if (y) state = S0; 
       endcase
   assign Q0 = state[0]; 
   assign Q1 = state[1];//Output of flip-flops
endmodule


