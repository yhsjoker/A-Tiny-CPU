transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/r0.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/r1.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/ram.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/z.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/tr.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/top.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/pc.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/ir.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/dr.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/cpu.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/control.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/ar.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/alu.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/light_show.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/clk_div.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/CPU_Controller.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/qtsj.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/x.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/r2.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/r3.v}
vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/rtl {I:/PCO_complex_teacher2023new/rtl/y.v}

vlog -vlog01compat -work work +incdir+I:/PCO_complex_teacher2023new/simulation/modelsim {I:/PCO_complex_teacher2023new/simulation/modelsim/top.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_vlg_tst

add wave *
view structure
view signals
run -all
