module testing_reg
(
  input wire clk,reset,
  input wire a,b,
  
  output wire c,
  output wire seq_reg_tb,seq_next_tb,
  
  //TestBench signals below
  output wire [1:0]state_tb,
  output wire [1:0]testing_reg2_tb
  //TestBench signals above
  );
  
 
  //state declaration
  localparam [1:0]
   toggleWAIT = 2'b00,
	toggle1    = 2'b01,
	toggle2    = 2'b10,
	toggleDONE = 2'b11;
	
	
	
	
	//signal declaration
	reg [1:0] state_reg, state_next;
	reg testing_reg1;
   reg [1:0]testing_reg2;
   reg  seq_reg, seq_next;	
	
	
	//FSM 
	always @ (posedge clk, posedge reset)
	if(reset)
	  begin
	     state_reg <= toggleWAIT;
		  seq_reg <=0 ;
	  end
	 else
	  begin
	     state_reg <=state_next;
		   seq_reg  <= seq_next ;
	  end
		
	 //FSM next-state logic
	 always @*
	 begin
	   state_next=state_reg;
		testing_reg1=0;
		testing_reg2=0;
		seq_next=seq_reg;
		case(state_reg)
		 //
		  toggleWAIT:
		    begin 
			  if(a)
			    begin
			     state_next=toggle1;
				  testing_reg1=1;
				  testing_reg2=1;
				  seq_next=1;
				 end
				else
				 begin
				 seq_next=0;
				 testing_reg1=0;
				 testing_reg2=0;
				 end
			 end
		//
		  toggle1:
		    begin
			  if(b)
			    begin
				   state_next=toggleWAIT;
					//testing_reg1=1;
				   testing_reg2=2;
				 end
			  end
			default: state_next=toggleWAIT;
		endcase
	end
	
	  
	
	 assign c=testing_reg1;
	 //TestBench signals below
	 assign state_tb=state_reg;
	 assign testing_reg2_tb=testing_reg2;
	 assign seq_reg_tb=seq_reg;
	 assign seq_next_tb=seq_next;
	 //TestBench signals above

endmodule
		 