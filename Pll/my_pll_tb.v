//-------------------------------------------------
// File: my_pll_tb.v
// Purpose:  Test Bench
//         
//-----------------------------------------------------------
//Time scale
`timescale 1 ns /  1 ps

module my_pll_tb ();
  //---------------------------------------------------------
  // inputs to the DUT are reg type
     reg CLOCK_50;
  //--------------------------------------------------------
  // outputs from the DUT are wire type
	 wire  locked;
	 wire  CLOCK_200;
  //---------------------------------------------------------
  // instantiate the Device Under Test (DUT)
  // using named instantiation
  pll pll ( 
        .inclk0(CLOCK_50),
		.c0(CLOCK_200),
        .locked(locked)
         );
  //----------------------------------------------------------
  // create a 50Mhz clock
  always
    #10 CLOCK_50 = ~CLOCK_50;   // every ten nanoseconds invert
  //-----------------------------------------------------------
  /*****************************************************************************
 	*                  BLOCK 0 -> Reset check                                    *
 	*****************************************************************************/
  // initial blocks are sequential and start at time 0
  initial
  begin
    $display($time, " <<BLOCK 0: Starting the Simulation >>");
    CLOCK_50 = 1'b0;                                                      
    #5000;
    // let the simulation run for 2000ns
    $display($time, " <<BLOCK 0: Simulation Complete >>");
    $stop;
  end
 /*****************************************************************************
 	*                  BLOCK 1 -> Data Monitor                                  *
 	*****************************************************************************/
 
  initial 
  begin
	$monitor($time, "locked=%b " ,locked );
  end
  
endmodule 
 