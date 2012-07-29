transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/albert/Documents/Quartus_workspace/nand_write {C:/Users/albert/Documents/Quartus_workspace/nand_write/toggle.v}
vlog -vlog01compat -work work +incdir+C:/Users/albert/Documents/Quartus_workspace/nand_write {C:/Users/albert/Documents/Quartus_workspace/nand_write/nand_write.v}
vlog -vlog01compat -work work +incdir+C:/Users/albert/Documents/Quartus_workspace/nand_write {C:/Users/albert/Documents/Quartus_workspace/nand_write/pll.v}

vlog -vlog01compat -work work +incdir+C:/Users/albert/Documents/Quartus_workspace/nand_write {C:/Users/albert/Documents/Quartus_workspace/nand_write/nand_write_tb.v}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L cycloneii_ver -L rtl_work -L work -voptargs="+acc" nand_write_tb

add wave *
view structure
view signals
run -all
