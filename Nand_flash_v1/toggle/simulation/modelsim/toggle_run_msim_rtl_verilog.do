transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/albert/Google\ Drive/Coding_zone/Verilog/Quartus_workspace/Nand_flash_v1/toggle {C:/Users/albert/Google Drive/Coding_zone/Verilog/Quartus_workspace/Nand_flash_v1/toggle/toggle.v}

vlog -vlog01compat -work work +incdir+C:/Users/albert/Google\ Drive/Coding_zone/Verilog/Quartus_workspace/Nand_flash_v1/toggle {C:/Users/albert/Google Drive/Coding_zone/Verilog/Quartus_workspace/Nand_flash_v1/toggle/my_toggle_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc" my_toggle_tb

add wave *
view structure
view signals
run -all
