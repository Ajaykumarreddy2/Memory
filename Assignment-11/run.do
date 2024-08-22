vlib work
vlog tb.v
vsim tb  +testcase=fd_write_bd_read
add wave -position insertpoint sim:/tb/m/*
run -all

