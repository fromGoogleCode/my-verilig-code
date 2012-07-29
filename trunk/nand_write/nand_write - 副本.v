/**********************************************************

file:  nand_write.v

Author:	  albert

date: 2012/05/13

Description

 **********************************************************/
module nand_write
(
  input wire clk,reset,NandReady,buffer_ready,
  input wire [7:0] input_data,
  
  output reg WriteDone,
  output reg [7:0] output_data,
  output reg [4:0] outputVEC1, // FORMAT: nCE|CLE|ALE|nRE|nWE
  output reg [4:0] outputVEC2, // FORMAT: nCE|CLE|ALE|nRE|nWE
  output reg [11:0] outputUPTO
  
  );
  
  //PLL module  
   wire locked;
   wire clk200;
  //PLL instansiate
  pll pll (
   .inclk0(clk),
	.c0(clk200),
	.locked(locked)
	);
	
	//toggle module
	wire outputVEC;
	wire internalCNT_from_toggle;
	wire toggleDone;
	wire enableToggle;
	
	toggle toggle(
  .clk(clk200),
  .reset(reset),
  .enable(enableToggle),
  .cntUPTO(outputUPTO),
  .outputVEC1(outputVEC1),
  .outputVEC2(outputVEC2),
  .done(toggelDone),
  .outputVEC(outputVEC),
  .internalCNT_out(internalCNT_from_toggle)
  ); 
	
  
  //state declaration 
  localparam [3:0]
   pageWriteWAIT    = 4'b0000,
	pageWriteCmd1     = 4'b0001,  //latch the cmd
	pageWriteAddr    = 4'b0010, //4 cycle address
	pageWriteBuffer  = 4'b0011, //wait for 100ns and buffer ready signal
	pageWriteData    = 4'b0100, //write 2048 bytes
	pageWriteCmd2    = 4'b0101, //second cmd
	pageWriteBusyWait =4'b0110, //wait for nand to ready
	pageWriteDone    = 4'b0111;  
	
	
	//constant declaration
	localparam writeCmd1 = 8'h80;
	localparam writeCmd2 = 8'h10;
	
	//simulate buff and address reg
	parameter MEM_SIZE = 1024;
    reg [7:0] buff [0:MEM_SIZE -1];
	 reg [7:0] add_reg [0:3];
	 
	
	
	//signal declaration
	reg [3:0] state_reg, state_next;
	reg [11:0]CNT_reg,CNT_next;
   reg [2:0] add_cnt_reg,add_cnt_next;	
	reg toggle_enable_next,toggle_enable_reg;
	
	
	//FSM 
	always @ (posedge clk200, posedge reset)
	if(reset)
	  begin
	     state_reg <= pageWriteWAIT;
        CNT_reg <=0;
		  toggle_enable_reg <=0;
		  add_cnt_reg   <= 0;
	  end
	 else
	  begin
	    state_reg <=state_next;
		 CNT_reg <=CNT_next;
		 toggle_enable_reg <=toggle_enable_next;
		 add_cnt_reg   <= add_cnt_next;
	  end
		
	 //FSM next-state logic
	 always @*
	 begin
	   state_next=state_reg;
		CNT_next=CNT_reg;
		toggle_enable_next=toggle_enable_reg;
		add_cnt_next=add_cnt_reg;
		WriteDone=0;
		
		case(state_reg)
		 //
		  pageWriteWAIT:
		    begin 
			  if( input_data== writeCmd1 && locked )
			    begin
			     state_next=pageWriteCmd1;
				  outputUPTO=1;
				  outputVEC1=5'b01010;
				  outputVEC2=5'b01011;
				  output_data=writeCmd1;
				  toggle_enable_next=1;
				  add_cnt_next=0;
				 end
				else
				 begin
				 outputUPTO=0;
			    toggle_enable_next=0;
				 add_cnt_next=0;

				 end
			 end
		//
		  pageWriteCmd1:
		    begin
			  if(toggelDone==1)
			    begin
				   state_next=pageWriteAddr;
					outputUPTO=4;
				   outputVEC1=5'b00110;
				   outputVEC2=5'b00111;
					output_data=add_reg[add_cnt_reg]; 
				   toggle_enable_next=1;
				 end
			  end
		//
		  pageWriteAddr:
		    begin
			  if(toggelDone==1)
			    begin
				   state_next=pageWriteBuffer;
					add_cnt_next=0;
				 end
			  else if(internalCNT_from_toggle== add_cnt_reg+1)
			     begin
					add_cnt_next=add_cnt_reg+1;
					output_data=add_reg[add_cnt_reg+1];
				  end
			 end
		//
		  pageWriteBuffer:
		    begin
			 //
			 CNT_next=CNT_reg+1;
			 if(CNT_reg==20 && buffer_ready)
			 begin
			      state_next=pageWriteData;
					outputUPTO=2048;
				   outputVEC1=5'b00010;
				   outputVEC2=5'b00011;
					CNT_next=0;
					output_data=buff[CNT_next]; //@@@
				   toggle_enable_next=1;
			 end
			 end
		//
		  pageWriteData:
		    begin
			 //
			 if(toggelDone==1)
			    begin
				   state_next=pageWriteCmd2;
					CNT_next=0;
				 end
			  else if(internalCNT_from_toggle== CNT_reg+1)
			     begin 
					CNT_next=CNT_reg+1;
					output_data=buff[CNT_reg+1];
				  end
			 end
		//
		  pageWriteCmd2:
		    begin
			  if(toggelDone==1)
			    begin
				   state_next=pageWriteBusyWait;
					outputUPTO=1;
				   outputVEC1=5'b01010;
				   outputVEC2=5'b01011;
				   output_data=writeCmd2; 
				   toggle_enable_next=1;
				 end
			  end
		//
		  pageWriteBusyWait:
		    begin
			  if(toggelDone==1 && (!NandReady))
			    begin
				   state_next=pageWriteDone;
				 end
			  end
	   //
		  pageWriteDone:
		    begin
			  if(NandReady)
			   begin
			     WriteDone=1;
				  state_next=pageWriteWAIT;
				end
			  end
			 
			default: state_next=pageWriteWAIT;
		endcase
	end
	
	assign enableToggle=toggle_enable_reg;
endmodule
		 