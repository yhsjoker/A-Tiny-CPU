transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/r0.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/r1.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/ram.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/z.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/tr.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/top.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/pc.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/ir.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/dr.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/cpu.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/control.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/ar.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/alu.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/light_show.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/clk_div.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/CPU_Controller.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/qtsj.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/x.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/r2.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/r3.v}
vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/rtl/y.v}

vlog -vlog01compat -work work +incdir+C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/simulation/modelsim {C:/Users/24450/Desktop/CSAPP/PCO_complex_stu_2023/simulation/modelsim/top.vt}

vsim -t 1ps -L altera_ver -L lpm_ver -L sgate_ver -L altera_mf_ver -L altera_lnsim_ver -L cycloneive_ver -L rtl_work -L work -voptargs="+acc"  top_vlg_tst

add wave *
view structure
view signals
run -all
