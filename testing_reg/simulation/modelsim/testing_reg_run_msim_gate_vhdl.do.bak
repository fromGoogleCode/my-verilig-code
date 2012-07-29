transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vcom -93 -work work {testing_reg.vho}

vlog -vlog01compat -work work +incdir+C:/Users/albert/Documents/Quartus_workspace/testing_reg {C:/Users/albert/Documents/Quartus_workspace/testing_reg/testing_reg_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -sdftyp /NA=testing_reg_vhd.sdo -L cycloneii -L gate_work -L work -voptargs="+acc" testing_reg_tb

add wave *
view structure
view signals
run -all
