## Generated SDC file "nand_write.out.sdc"

## Copyright (C) 1991-2010 Altera Corporation
## Your use of Altera Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Altera Program License 
## Subscription Agreement, Altera MegaCore Function License 
## Agreement, or other applicable license agreement, including, 
## without limitation, that your use is for the sole purpose of 
## programming logic devices manufactured by Altera and sold by 
## Altera or its authorized distributors.  Please refer to the 
## applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus II"
## VERSION "Version 10.0 Build 218 06/27/2010 SJ Full Version"

## DATE    "Tue May 29 00:50:29 2012"

##
## DEVICE  "EP2C35F672C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {clk} -period 20.000 -waveform { 0.000 10.000 } [get_ports {clk}]


#**************************************************************
# Create Generated Clock
#**************************************************************

create_generated_clock -name {pll|altpll_component|pll|clk[0]} -source [get_pins {pll|altpll_component|pll|inclk[0]}] -duty_cycle 50.000 -multiply_by 2 -master_clock {clk} [get_pins {pll|altpll_component|pll|clk[0]}] 


#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************



#**************************************************************
# Set Input Delay
#**************************************************************

set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {NandReady}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {buffer_ready}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {input_data[0]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {input_data[1]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {input_data[2]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {input_data[3]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {input_data[4]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {input_data[5]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {input_data[6]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {input_data[7]}]
set_input_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {reset}]


#**************************************************************
# Set Output Delay
#**************************************************************

set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[7]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[8]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[9]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[10]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputUPTO[11]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC1[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC1[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC1[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC1[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC1[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC2[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC2[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC2[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC2[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {outputVEC2[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {output_data[0]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {output_data[1]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {output_data[2]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {output_data[3]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {output_data[4]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {output_data[5]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {output_data[6]}]
set_output_delay -add_delay  -clock [get_clocks {clk}]  0.000 [get_ports {output_data[7]}]


#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************

