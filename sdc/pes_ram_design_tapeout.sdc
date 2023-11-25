###############################################################################
# Created by write_sdc
# Sat Nov 25 19:35:19 2023
###############################################################################
current_design pes_ram_design_tapeout
###############################################################################
# Timing Constraints
###############################################################################
create_clock -name clk -period 25.0000 [get_ports {clk}]
set_clock_transition 0.1500 [get_clocks {clk}]
set_clock_uncertainty 0.2500 clk
set_propagated_clock [get_clocks {clk}]
set_clock_latency -source -min 4.6500 [get_clocks {clk}]
set_clock_latency -source -max 5.5700 [get_clocks {clk}]
###############################################################################
# Environment
###############################################################################
set_load -pin_load 0.1900 [get_ports {io_oeb[15]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[14]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[13]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[12]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[11]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[10]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[9]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[8]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[7]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[6]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[5]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[4]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[3]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[2]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[1]}]
set_load -pin_load 0.1900 [get_ports {io_oeb[0]}]
set_load -pin_load 0.1900 [get_ports {q_a[7]}]
set_load -pin_load 0.1900 [get_ports {q_a[6]}]
set_load -pin_load 0.1900 [get_ports {q_a[5]}]
set_load -pin_load 0.1900 [get_ports {q_a[4]}]
set_load -pin_load 0.1900 [get_ports {q_a[3]}]
set_load -pin_load 0.1900 [get_ports {q_a[2]}]
set_load -pin_load 0.1900 [get_ports {q_a[1]}]
set_load -pin_load 0.1900 [get_ports {q_a[0]}]
set_load -pin_load 0.1900 [get_ports {q_b[7]}]
set_load -pin_load 0.1900 [get_ports {q_b[6]}]
set_load -pin_load 0.1900 [get_ports {q_b[5]}]
set_load -pin_load 0.1900 [get_ports {q_b[4]}]
set_load -pin_load 0.1900 [get_ports {q_b[3]}]
set_load -pin_load 0.1900 [get_ports {q_b[2]}]
set_load -pin_load 0.1900 [get_ports {q_b[1]}]
set_load -pin_load 0.1900 [get_ports {q_b[0]}]
set_input_transition 0.6100 [get_ports {clk}]
set_timing_derate -early 0.9500
set_timing_derate -late 1.0500
###############################################################################
# Design Rules
###############################################################################
set_max_transition 1.0000 [current_design]
set_max_fanout 20.0000 [current_design]
