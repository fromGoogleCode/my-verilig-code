transcript on
if {[file exists gate_work]} {
	vdel -lib gate_work -all
}
vlib gate_work
vmap work gate_work

vlog -vlog01compat -work work +incdir+. {toggle.vo}

vlog -vlog01compat -work work +incdir+C:/Users/albert/Google\ Drive/Coding_zone/Verilog/Quartus_workspace/Nand_flash_v1/toggle {C:/Users/albert/Google Drive/Coding_zone/Verilog/Quartus_workspace/Nand_flash_v1/toggle/my_toggle_tb.v}

vsim -t 1ps +transport_int_delays +transport_path_delays -L cycloneii_ver -L gate_work -L work -voptargs="+acc" my_toggle_tb

add wave *
view structure
view signals
run -all
