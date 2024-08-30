vlib work
vlog ALU_16B.v ALU_16B_tb.v
vsim -voptargs=+accs work.ALU_16B_tb
add wave *
run -all