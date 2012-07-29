transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/albert/Documents/Quartus_workspace/toggle {C:/Users/albert/Documents/Quartus_workspace/toggle/toggle.v}
vlog -vlog01compat -work work +incdir+C:/Users/albert/Documents/Quartus_workspace/toggle {C:/Users/albert/Documents/Quartus_workspace/toggle/pll.v}

vlog -vlog01compat -work work +incdir+C:/Users/albert/Documents/Quartus_workspace/toggle {C:/Users/albert/Documents/Quartus_workspace/toggle/my_toggle_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc" my_toggle_tb

add wave *
view structure
view signals
run -all
