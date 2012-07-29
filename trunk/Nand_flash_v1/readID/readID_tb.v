/**********************************************************

file:  my_toggle_tb.v

Author:	  albert

date: 2012/05/05

Purpose: Tested Two operations, 1 singel cycle toggle, 1 four cycles toggle

 **********************************************************/
//Time scale
`timescale 1 ns /  1 ps

module readID_tb ();
  //---------------------------------------------------------
  // inputs to the DUT are reg type
     reg CLOCK_50,reset;
     reg [7:0] input_data;
  
  //--------------------------------------------------------
  // outputs from the DUT are wire type
     wire  [7:0] output_data,DevID_tb;
     wire  IDread_done,toggleDone_tb,dummy_cnt_tb;
	  wire [1:0] state_reg_tb,IDread_cnt_tb;
	  wire [4:0] outputVEC_tb;
	  
	  
  //---------------------------------------------------------
  // instantiate the Device Under Test (DUT)
  // using named instantiation
  readID readID ( 
            .clk(CLOCK_50),  //pll to 200mhz
            .reset(reset),
            .output_data(output_data),
            .input_data(input_data),
            .toggleDone_tb(toggleDone_tb),
            .IDread_done(IDread_done),
				.dummy_cnt_tb(dummy_cnt_tb),
				.state_reg_tb(state_reg_tb),
				.IDread_cnt_tb(IDread_cnt_tb),
				.DevID_tb(DevID_tb),
				.outputVEC_tb(outputVEC_tb)
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
    // at time 0 reset input value
	 CLOCK_50 = 0; 
	 reset=0;
	 input_data =0;
	 #2000
	 $stop;
  end
  /*****************************************************************************
 	*                  BLOCK 1 -> FSM and Logic test                            *
 	*****************************************************************************/
  //integer i;
  initial 
  begin
	 #200
	 input_data=144;
	 $display("\t\tinput_cmd=%h",input_data); 
	 wait(IDread_done==1)
	 #40
	 $stop;
  end
  
  initial  
  begin
     $dumpfile ("IDread.vcd"); 
     $dumpvars; 
  end 
 
  initial 
  begin
  $monitor("\t\ttime=%d,\tclk=%b,\tstate=%d,\toutput_data=0x%h,\ttoggleDone_tb=%d,\tIDread_done=%b,\tdummy_cnt_tb=%b,\tIDread_cnt_tb=%b,\tDevID_tb=%b,\toutputVEC_tb=%b", $time, CLOCK_50,state_reg_tb,output_data,toggleDone_tb,IDread_done,dummy_cnt_tb,IDread_cnt_tb,DevID_tb,outputVEC_tb);  
  end
  
 
endmodule 
 