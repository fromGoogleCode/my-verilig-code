/**********************************************************

file:  my_toggle_tb.v

Author:	  albert

date: 2012/05/05

Purpose: Tested Two operations, 1 singel cycle toggle, 1 four cycles toggle

 **********************************************************/
//Time scale
`timescale 1 ns /  1 ps

module nand_write_tb ();
  //---------------------------------------------------------
  // inputs to the DUT are reg type
     reg CLOCK_50,reset,NandReady,buffer_ready;
     reg [7:0] input_data;
  
      wire WriteDone;
		wire [7:0] output_data;
		wire [4:0] outputVEC1; // FORMAT: nCE|CLE|ALE|nRE|nWE
		wire [4:0] outputVEC2; // FORMAT: nCE|CLE|ALE|nRE|nWE
		wire [11:0] outputUPTO;
 
  //testbench signals
   wire clk150_tb,locked_tb,toggleDone_tb;
   wire [3:0] state_reg_tb;
   wire [11:0] CNT_reg_tb;
   wire	[2:0] add_cnt_reg_tb;  
   wire toggle_enable_reg_tb;
  //testbench signals
 
  // instantiate the Device Under Test (DUT)
  // using named instantiation
  nand_write nand_write
(
  .clk(CLOCK_50),
  .reset(reset),
  .NandReady(NandReady),
  .buffer_ready(buffer_ready),
  .input_data(input_data),
  
  .WriteDone(WriteDone),
  .output_data(output_data),
  .outputVEC1(outputVEC1), // FORMAT: nCE|CLE|ALE|nRE|nWE
  .outputVEC2(outputVEC2), // FORMAT: nCE|CLE|ALE|nRE|nWE
  .outputUPTO(outputUPTO),
  
  //testbench signals
  .clk150_tb(clk150_tb),
  .locked_tb(locked_tb),
  .toggleDone_tb(toggleDone_tb),
  .state_reg_tb(state_reg_tb),
  .CNT_reg_tb(CNT_reg_tb),
  .add_cnt_reg_tb(add_cnt_reg_tb),  
  .toggle_enable_reg_tb(toggle_enable_reg_tb)
  //testbench signals
  );
  //----------------------------------------------------------
  always
    #10 CLOCK_50 = ~CLOCK_50;   
  //-----------------------------------------------------------
  /*****************************************************************************
 	*                  BLOCK 0 -> Reset check                                    *
 	*****************************************************************************/
  // initial blocks are sequential and start at time 0
  initial
  begin
    $display($time, " <<BLOCK 0: Starting the Simulation >>");                                                   
    // at time 0 reset input value
	 CLOCK_50 = 0; 
	 reset=0;
	 NandReady =0;
	 buffer_ready =0;
	 input_data = 0;
	 
    #1000;
    // let the simulation run for 500ns
    $display($time, " <<BLOCK 0: Simulation Complete >>");
    $stop;
  end
  /*****************************************************************************
 	*                  BLOCK 1 -> FSM and Logic test                            *
 	*****************************************************************************/
  //integer i;
  initial 
  begin
   
     wait (locked_tb==1)
	  #200
	 $display($time, " <<  run 1 >>");
	 input_data=8'h80;
   
	//end
  end
endmodule 
 