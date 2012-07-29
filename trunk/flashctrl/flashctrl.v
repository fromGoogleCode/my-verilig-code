/**********************************************************

file:  flashctrl.v

Author:	  albert

date: 2012/07/18

Description

 **********************************************************/
module flashctrl
(
  input wire clk,reset,
  //================= Bus signals ====================
  input wire h_sel,       //slave select
  input wire h_write,     //slave write/nRead
  input wire [10:0]h_addr,//bus address, lower 11 bit
  input wire [1:0]h_trans,     //transmission signal type
  input wire [2:0]h_size,     //signal width
  input wire [2:0]h_burst,    //burst signal
  input wire [31:0]h_wdata,   //bus data in
  output wire [31:0]hr_data, //data to master
  output wire [1:0]hr_resp, //response the master
  output wire hr_ready, //slave ready to master
  
  
  //================== DMA Module sginals =====================
  input wire [31:0]data_ToFlash, //DMA input data
  output wire [31:0]data_FromFlash, //data to DMA
  input wire en_flash_write,   //DMA input enable
  input wire en_flash_read,    //DMA output enable
  output wire ready_read_flash, //DMA
  output wire ready_write_flash, //DMA
  //==================Nand flash signals ======================
  input wire [7:0] nand_dataIN, //data from nand
  output wire [7:0] nand_dataOUT, //data to nand
  input wire nandRB_L,         //nand read busy singnal
  output wire nand_doen, //input output select
  output wire WE_L, 
  output wire CE_L, 
  output wire CE_L1,
  output wire CE_L2,
  output wire CE_L3,
  output wire WP_L, 
  output wire RE_L, 
  output wire ALE_L,
  output wire CLE_L,

  );
  
  //PLL module  
   wire locked;
   wire clk150;
  //PLL instansiate
  pll pll (
   .inclk0(clk),
	.c0(clk150),
	.locked(locked)
	);
	
	//toggle module
	wire [4:0]outputVEC;
	wire [11:0]internalCNT_from_toggle;
	wire toggleDone;
	wire enableToggle;
	
	toggle toggle(
  .clk(clk150),
  .reset(reset),
  .enable(enableToggle),
  .locked(locked),
  .cntUPTO(outputUPTO),
  .outputVEC1(outputVEC1),
  .outputVEC2(outputVEC2),
  .done(toggleDone),
  .outputVEC(outputVEC),
  .internalCNT_out(internalCNT_from_toggle)
  ); 
	
  
  //state declaration 
  localparam [3:0]
   pageWriteWAIT    = 4'b0000,
	pageWriteCmd1    = 4'b0001,  //latch the cmd
	pageWriteAddr    = 4'b0010, //4 cycle address
	pageWriteBuffer  = 4'b0011, //wait for 100ns and buffer ready signal
	pageWriteData    = 4'b0100, //write 2048 bytes
	pageWriteCmd2    = 4'b0101, //second cmd
	pageWriteBusyWait =4'b0110, //wait for nand to ready
	pageWriteDone    = 4'b0111;  
	
	
	//constant declaration
	localparam writeCmd1 = 8'h80;
	localparam writeCmd2 = 8'h10;
	
	localparam TestData= 8'shff;
	
	//simulate buff and address reg
	/*parameter MEM_SIZE = 1024;
    reg [7:0] buff [0:MEM_SIZE -1];
	 reg [7:0] add_reg [0:3];
	
   integer k;
	integer i;
   initial
   begin
   for (k = 0; k < 3 ; k = k + 1)
   begin
   add_reg[k] = 8'h00;
   end
   end

   initial
   begin
   for (i = 0; i < MEM_SIZE ; i = i + 1)
   begin
   buff[i] = 8'h00;
   end
   end*/	
	
	
	//signal declaration
	reg [3:0] state_reg, state_next;
	reg [11:0]CNT_reg,CNT_next;
   reg [2:0] add_cnt_reg,add_cnt_next;	
	reg toggle_enable_reg,toggle_enable_next;
	
	
	//FSM 
	always @ (posedge clk150, posedge reset)
	if(reset)
	  begin
	     state_reg <= pageWriteWAIT;
        CNT_reg <=0;
		  add_cnt_reg   <= 0;
		  toggle_enable_reg <=0;
	  end
	 else
	  begin
	    state_reg <=state_next;
		 CNT_reg <=CNT_next;
		 add_cnt_reg   <= add_cnt_next;
		 toggle_enable_reg <=toggle_enable_next;
	  end
		
	 //FSM next-state logic
	 always @*
	 begin
	   state_next=state_reg;
		CNT_next=CNT_reg;
		add_cnt_next=add_cnt_reg;
		WriteDone=0;
		toggle_enable_next=toggle_enable_reg;
		
		
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
				  output_data=TestData;
				  toggle_enable_next=1;
				 
				 end
				else
				 begin
				 //avoid inferred latch
				 outputUPTO=0;
				 outputVEC1=0;
				 outputVEC2=0;
				 output_data=0;
				 //reg reset
				 add_cnt_next=0;
             CNT_next = 0;
				 toggle_enable_next=0;
				 end
			 end
		//
		  pageWriteCmd1:
		    begin
			  if(toggleDone==1) //@@@@@@@@@@@@
			    begin
				   state_next=pageWriteAddr;
					outputUPTO=4;
				   outputVEC1=5'b00110;
				   outputVEC2=5'b00111;
					output_data=TestData-1; 
				   toggle_enable_next=1;
				 end
			   else
				 begin
				 outputUPTO=1;
				 outputVEC1=5'b01010;
				 outputVEC2=5'b01011;
				 output_data=TestData;
				 toggle_enable_next=0;
				 end
			  end
		//
		  pageWriteAddr:
		    begin
			  if(toggleDone==1)
			    begin
				   state_next=pageWriteBuffer;
					add_cnt_next=0;
					toggle_enable_next=1;
				 end
			  else if(internalCNT_from_toggle== add_cnt_reg+1)
			     begin
					add_cnt_next=add_cnt_reg+3'b001;
					outputUPTO=4;
				   outputVEC1=5'b00110;
				   outputVEC2=5'b00111;
					output_data=TestData-2;
				  end
			  else
			      toggle_enable_next=0;
			 end
		//
		  pageWriteBuffer:
		    begin
			 //
			 if(CNT_reg==20 && buffer_ready)
			 begin
			      state_next=pageWriteData;
					outputUPTO=15;
				   outputVEC1=5'b00010;
				   outputVEC2=5'b00011;
					CNT_next=0;
					output_data=TestData; //@@@
				   toggle_enable_next=1;
			 end
			 else
			 begin
			 CNT_next=CNT_reg+11'b1;
			 outputUPTO=0;
			 outputVEC1=0;
			 outputVEC2=0;
			 output_data=0;
			 toggle_enable_next=0;
			 end
			 end
		//
		  pageWriteData:
		    begin
			 //
			 if(toggleDone==1)
			    begin
				   state_next=pageWriteCmd2;
					CNT_next=0;
					outputUPTO=1;
				   outputVEC1=5'b01010;
				   outputVEC2=5'b01011;
				   output_data=writeCmd2; 
				   toggle_enable_next=1;
				 end
			  else if(internalCNT_from_toggle== CNT_reg+1)
			     begin 
					CNT_next=CNT_reg+11'b1;
					output_data=TestData;
					outputUPTO=2048;
				   outputVEC1=5'b00010;
				   outputVEC2=5'b00011;
				  end
			 end
		//
		  pageWriteCmd2:
		    begin
			  if(toggleDone==1)
			    begin
				   state_next=pageWriteBusyWait;
					outputUPTO=0;
			      outputVEC1=0;
			      outputVEC2=0;
			      output_data=0;
				 end
			  else
			    begin
				   outputUPTO=1;
				   outputVEC1=5'b01010;
				   outputVEC2=5'b01011;
				   output_data=writeCmd2;
				 end
			  end
		//
		  pageWriteBusyWait:
		    begin
			  if(!NandReady)
			    begin
				   state_next=pageWriteDone;
				 end
				  outputUPTO=0;
			     outputVEC1=0;
			     outputVEC2=0;
			     output_data=0;
			  end
	   //
		  pageWriteDone:
		    begin
			  if(NandReady)
			   begin
			     WriteDone=1;
				  state_next=pageWriteWAIT;
				end
				outputUPTO=0;
			     outputVEC1=0;
			     outputVEC2=0;
			     output_data=0;
			  end
			 
			default: state_next=pageWriteWAIT;
		endcase
	end
	
	assign enableToggle=toggle_enable_reg;
	//techbench signals
	  assign clk150_tb=clk150;
	  assign locked_tb=locked;
	  assign toggleDone_tb=toggleDone;
     assign state_reg_tb=state_reg;
  
  assign CNT_reg_tb=CNT_reg;
	assign add_cnt_reg_tb=add_cnt_reg;  
   assign toggle_enable_reg_tb=toggle_enable_reg;
endmodule
		 