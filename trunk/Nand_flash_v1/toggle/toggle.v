/**********************************************************

file:  toggle.v

Author:	  albert

date: 2012/05/05

toggle takes 50Mhz clk and passes to PLL module, PLL module will output a 200MHZ once its locked

Static timing analysis @200Mhz verified.

 **********************************************************/
module toggle
(
  input wire clk,reset,enable,
  input wire [11:0]cntUPTO,   
  input wire [4:0] outputVEC1,outputVEC2, //check if we can embedded to a local reg
  output wire done,
  output reg [4:0]outputVEC,
  //output wire pll_locked,   
  output reg dummy_cnt //@@
  
  /*//TestBench signals below
  output wire [1:0]state_tb,
  output wire clk200_tb,
  output wire [3:0]delayCNT_tb,
  output wire [11:0]internalCNT_tb
  //TestBench signals above*/
  );
  
  /*
  //PLL module 
   wire locked;
   wire clk200;
  //PLL instansiate
  pll pll (
   .inclk0(clk),
	.c0(clk200),
	.locked(locked)
	);
	*/
  
  //state declaration
  localparam [1:0]
    toggleWAIT = 2'b00,
	toggle1    = 2'b01,
	toggle2    = 2'b10,
	toggleDONE = 2'b11;
	
	//constant declaration
	localparam TOGGEL_SETUP = 3;  //how many clk cycles needed
	localparam TOGGEL_HOLD  = 2;
	
	
	//signal declaration
	reg [1:0] state_reg, state_next;
	reg [11:0]internalCNT_reg,internalCNT_next;	
	reg [3:0] delayCNT_reg,delayCNT_next; 
	reg toggleDone_reg,toggleDone_next;             //@@
	
	
	//FSM 
	always @ (posedge clk, posedge reset)
	if(reset)
	  begin
	      state_reg <= toggleWAIT;
		  internalCNT_reg <= 0;
		  delayCNT_reg <= 0;
		  toggleDone_reg <=0;
	  end
	 else
	  begin
	      state_reg <=state_next;
		  internalCNT_reg <= internalCNT_next;
		  delayCNT_reg <=delayCNT_next;
		  toggleDone_reg <= toggleDone_next;
	  end
		
	 //FSM next-state logic
	 always @*
	 begin
	   dummy_cnt=0;
	    state_next=state_reg;
		internalCNT_next=internalCNT_reg;
		delayCNT_next=delayCNT_reg;
		toggleDone_next =  toggleDone_reg;
		//outputVEC_enable_next= outputVEC_enable_reg;
		case(state_reg)
		 //
		  toggleWAIT:
		    begin  
			  outputVEC=0;
			  if(enable)
			  //if(enable && locked)
			    begin
			      state_next=toggle1;
				  //outputVEC_enable_next=0;
				  delayCNT_next=0;
				  internalCNT_next=0;
				 end
				else
				 begin
				 //outputVEC_enable_next=0;
			     delayCNT_next=0;
				 internalCNT_next=0;
				 toggleDone_next=0;
				 end
			 end
		//
		  toggle1:
		    begin
			outputVEC=outputVEC1;
			 delayCNT_next=delayCNT_reg+4'd1;
			  if(delayCNT_next==TOGGEL_SETUP)
			    begin
				    state_next=toggle2;
					//outputVEC_enable_next=1;
					internalCNT_next=internalCNT_reg+4'd1;
					dummy_cnt=1;
				end 
			  end
		//
		  toggle2:
		    begin
			 outputVEC=outputVEC2;
			  delayCNT_next=delayCNT_reg+4'd1;
			   if(delayCNT_next== (TOGGEL_SETUP+TOGGEL_HOLD))
				  begin
				   if(internalCNT_reg==cntUPTO)
					 begin
					   state_next=toggleDONE;
						toggleDone_next = 1;
					 end
					else
					  begin
					   state_next=toggle1;
						delayCNT_next=0;
					  end
				  end	  
			 end
		//
		  toggleDONE:
		    begin
			 outputVEC=0;
			  internalCNT_next=0;
		      delayCNT_next=0;
			  if(!enable)
			   begin
			    state_next=toggleWAIT;
				toggleDone_next=0;
			   end
			 end
			default: state_next=toggleWAIT;
		endcase
	end
	
	  
	 assign done=toggleDone_reg;
	 //assign pll_locked=locked;
	 
	 /*//TestBench signals below
	 assign state_tb=state_reg;
	 //assign clk200_tb=clk200;
	 assign delayCNT_tb=delayCNT_reg;
	 assign internalCNT_tb=internalCNT_reg;
	 //TestBench signals above*/

endmodule
		 