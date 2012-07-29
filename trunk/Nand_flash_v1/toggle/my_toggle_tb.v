/**********************************************************

file:  my_toggle_tb.v

Author:	  albert

date: 2012/05/05

Purpose: Tested Two operations, 1 singel cycle toggle, 1 four cycles toggle

 **********************************************************/
//Time scale
`timescale 1 ns /  1 ps

module my_toggle_tb ();
  //---------------------------------------------------------
  // inputs to the DUT are reg type
     reg CLOCK_50,reset,enable;
     reg [11:0] cntUPTO;
     reg [4:0] setupSignal,holdSignal; 
  //--------------------------------------------------------
  // outputs from the DUT are wire type
     wire  done;
     wire  [4:0]outputVEC;
	  //wire  locked_out;
	  wire [1:0]state_tb;
	  //wire clk200_tb;
	  wire [3:0]delayCNT_tb;
	  wire dummy_cnt;
	  
  //---------------------------------------------------------
  // instantiate the Device Under Test (DUT)
  // using named instantiation
  
  toggle toggle ( 
            .clk(CLOCK_50),  //pll to 200mhz
            .reset(reset),
            .enable(enable),
            .cntUPTO(cntUPTO),
            .setupSignal(setupSignal),
            .holdSignal(holdSignal),
            .done(done),
            .outputVEC(outputVEC),
				//s.locked_out(locked_out),
				.state_tb(state_tb),
				//.clk200_tb(clk200_tb),
				.delayCNT_tb(delayCNT_tb),
				.dummy_cnt(dummy_cnt)
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
	 enable =0;
	 cntUPTO =0;
	 setupSignal = 0;
	 holdSignal = 0;
	 
    #2000;
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
  
     //wait (locked_out==1)
	  #50
	  enable = 1;
	 cntUPTO =1;
	 setupSignal = 5'b10010;
	 holdSignal = 5'b11010;
	 $display("\t\tToggle_enable=%b,\tcntUPTO=%d,\tVEC1=%b,\tVEC2=%b",enable,cntUPTO,setupSignal,holdSignal); 
	 #20
	 enable=0;
    
	 wait(done==1)
	 #20
	 enable=1;
	 cntUPTO =4;
	 setupSignal = 5'b11010;
	 holdSignal = 5'b10010;
	 $display("\t\tToggle_enable=%b,\tcntUPTO=%d,\tVEC1=%b,\tVEC2=%b",enable,cntUPTO,setupSignal,holdSignal); 
	 #20
	 enable=0;
	 wait(done==1)
	 #40
	 $stop;
	 
   
	//end
  end
  
  initial  
  begin
     $dumpfile ("toggle.vcd"); 
     $dumpvars; 
  end 
 
  initial 
  begin
  $monitor("\t\ttime=%d,\tclk=%b,\tenable=%b,\tState=%d,\tdelay_cnt=%d,\tdummy_cnt=%d,\tOUTVEC=%b,\tdone=%b", $time, CLOCK_50,enable,state_tb,delayCNT_tb,dummy_cnt,outputVEC,done);  
  end
  
 
endmodule 
 