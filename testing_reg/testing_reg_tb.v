//Time scale
`timescale 1 ns /  1 ps

module testing_reg_tb ();
  //---------------------------------------------------------
  // inputs to the DUT are reg type
     reg CLOCK_50,reset,a,b;
     
  //--------------------------------------------------------
  // outputs from the DUT are wire type
     wire  testing_reg1;
	  wire [1:0]state_tb;
	  wire [1:0]testing_reg2_tb;
	  wire seq_reg_tb,seq_next_tb;
	  
  //---------------------------------------------------------
  // instantiate the Device Under Test (DUT)
  // using named instantiation
  testing_reg testing_reg ( 
            .clk(CLOCK_50),  //pll to 200mhz
            .reset(reset),
            .a(a),
            .b(b),
            .c(testing_reg1),
            .testing_reg2_tb(testing_reg2_tb),
				.state_tb(state_tb),
				.seq_reg_tb(seq_reg_tb),
				.seq_next_tb(seq_next_tb)
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
	 a =0;
	 b =0;
	 //#5 reset = 1;
    #500;
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
	 #55
	 $display($time, " <<  run 1 >>");
	 a = 1;
	 
    #50
	 b=1;
	//end
  end
endmodule 
 