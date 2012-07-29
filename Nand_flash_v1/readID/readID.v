/**********************************************************

file:  nand_write.v

Author:	  albert

date: 2012/05/13

Description

 **********************************************************/
module readID
(
  input wire clk,reset,
  output reg IDread_done,
  output reg [7:0] TonandIO,
  input wire [7:0] ctrl_in_data,
  input wire [7:0] nandIOin,
  
  //testbench signals
  output wire toggleDone_tb,dummy_cnt_tb,
  output wire [1:0] state_reg_tb,IDread_cnt_tb,
  output wire [7:0] DevID_tb,
  output wire [4:0] outputVEC_tb
  //testbench signals
  );
  
  /*
  //PLL module  
   wire locked;
   wire clk150;
  //PLL instansiate
  pll pll (
   .inclk0(clk),
	.c0(clk150),
	.locked(locked)
	);
	*/
	
	//toggle module
	wire [4:0]outputVEC;
	wire toggleDone;
	wire dummy_cnt;
	

  
  //state declaration 
  localparam [1:0]
   readIDwait       = 2'b00,
	readID           = 2'b01,  //latch the cmd
	readIDaddr       = 2'b10, //4 cycle address
	readIDfour       = 2'b11; //wait for 100ns and buffer ready signal

	
	
	//constant declaration
	localparam CMD = 8'h90;
	
	
	//signal declaration
	reg [3:0] state_reg, state_next;
	reg toggle_enable_reg,toggle_enable_next;
	reg [4:0] setupSignal,setupSignal_next; // FORMAT: nCE|CLE|ALE|nRE|nWE
   reg [4:0] holdSignal,holdSignal_next; // FORMAT: nCE|CLE|ALE|nRE|nWE
   reg [11:0] outputUPTO,outputUPTO_next;
	reg [1:0] IDread_cnt,IDread_cnt_next;
	reg [7:0] DevID;
	
	toggle toggle(
  .clk(clk),
  .reset(reset),
  .enable(toggle_enable_reg),   //input for toggle
  .cntUPTO(outputUPTO),    //input for toggle
  .setupSignal(setupSignal), //input for toggle
  .holdSignal(holdSignal), //input for toggle
  .done(toggleDone),       
  .outputVEC(outputVEC),
  .dummy_cnt(dummy_cnt)
  ); 
	
	//FSM 
	always @ (posedge clk, posedge reset)
	if(reset)
	  begin
	     state_reg <= readIDwait;
		  toggle_enable_reg <=0;
		  setupSignal <= 0;
        holdSignal <= 0;
        outputUPTO <= 0; 
		  IDread_cnt <= 0;
	  end
	 else
	  begin
	    state_reg <=state_next;
		 toggle_enable_reg <=toggle_enable_next;
		 setupSignal <=setupSignal_next;
		 holdSignal <=holdSignal_next;
		 outputUPTO <=outputUPTO_next;
       IDread_cnt <=IDread_cnt_next;
		 
	  end
		
	 //FSM next-state logic
	 always @*
	 begin
	    state_next=state_reg;
		 toggle_enable_next=toggle_enable_next;
		 setupSignal_next=setupSignal;
		 holdSignal_next=holdSignal;
		 outputUPTO_next=outputUPTO;

		case(state_reg)
		 //
		  readIDwait:
		    begin 
			  if( ctrl_in_data== CMD )
			    begin
			     state_next=readID;
				  setupSignal_next=5'b10010;
              holdSignal_next=5'b11010;
              outputUPTO_next=1;
				  TonandIO=CMD;
				  toggle_enable_next=1;
				 end
				else
				 begin
				 //avoid inferred latch
				 setupSignal_next=0;
             holdSignal_next=0;
             outputUPTO_next=0;
				 //reg reset
				 toggle_enable_next=0;
				 IDread_cnt_next=0;
				 IDread_done=0;
				 DevID=0;
				 TonandIO=0;
				 end
			 end
		//
		  readID:
		    begin
			  if(toggleDone==1) //@@@@@@@@@@@@
			    begin
				  state_next=readIDaddr;
				  setupSignal_next=5'b10010;
              holdSignal_next=5'b11100;
              outputUPTO_next=1;
				  TonandIO=0;
				  toggle_enable_next=1;
				 end
			   else
				 begin
				 setupSignal_next=5'b10010;
             holdSignal_next=5'b11010;
             outputUPTO_next=1;
				 TonandIO=CMD;
				 toggle_enable_next=0;
				 end
			  end
		//
		  readIDaddr:
		    begin
			  if(toggleDone==1) //@@@@@@@@@@@@
			    begin
				   state_next=readIDfour;
					setupSignal_next=5'b00001;
               holdSignal_next=5'b00000;
              outputUPTO_next=4;
				  TonandIO=0;
				  toggle_enable_next=1;
				 end
			   else
				 begin
				 setupSignal_next=5'b10010;
              holdSignal_next=5'b11100;
             outputUPTO_next=1;
				 TonandIO=0;
				 toggle_enable_next=0;
				 end
			 end
		//
		  readIDfour:
		     begin
			  if(toggleDone==1) //@@@@@@@@@@@@
			    begin
				   state_next=readIDwait;
					setupSignal_next=0;
               holdSignal_next=0;
               outputUPTO_next=0;
				   IDread_done=1;
				 end
			   else
				 begin
				 if(dummy_cnt==1)
				 begin
				 IDread_cnt_next=IDread_cnt_next+1;
				 DevID=nandIOin;
				 end
				 setupSignal_next=5'b00001;
             holdSignal_next=5'b00000;
             outputUPTO_next=4;
				 toggle_enable_next=0;
				 end
			 end 
			default: state_next=readIDwait;
		endcase
	end
	
	  
	//techbench signals
	  assign toggleDone_tb=toggleDone;
	  assign dummy_cnt_tb=dummy_cnt;
	  assign state_reg_tb=state_reg;
	  assign IDread_cnt_tb=IDread_cnt;
	  assign DevID_tb=DevID;
	  assign outputVEC_tb=outputVEC;
	  
endmodule
		 