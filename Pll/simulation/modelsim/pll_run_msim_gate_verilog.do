transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {pll_fast.vo}

vlog -vlog01compat -work work +incdir+C:/Users/albert/Documents/Quartus_workspace/Pll {C:/Users/albert/Documents/Quartus_workspace/Pll/my_pll_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L cycloneii_ver -L gate_work -L work -voptargs="+acc" my_pll_tb

add wave *
view structure
view signals
run -all
