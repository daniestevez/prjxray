# Copyright (C) 2017-2020  The Project X-Ray Authors
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC
create_project -force -name top -part $::env(XRAY_PART)
set_msg_config -id {Common 17-55} -new_severity {Warning}
read_verilog ../../verilog/VexRiscv_Lite.v
read_verilog ../../verilog/top.v
read_xdc ../top.xdc
synth_design -directive default -top top -part $::env(XRAY_PART)
report_timing_summary -file top_timing_synth.rpt
report_utilization -hierarchical -file top_utilization_hierarchical_synth.rpt
report_utilization -file top_utilization_synth.rpt
opt_design -directive default
place_design -directive default
report_utilization -hierarchical -file top_utilization_hierarchical_place.rpt
report_utilization -file top_utilization_place.rpt
report_io -file top_io.rpt
report_control_sets -verbose -file top_control_sets.rpt
report_clock_utilization -file top_clock_utilization.rpt
route_design -directive default
phys_opt_design -directive default
report_timing_summary -no_header -no_detailed_paths
write_checkpoint -force top_route.dcp
report_route_status -file top_route_status.rpt
report_drc -file top_drc.rpt
report_timing_summary -datasheet -max_paths 10 -file top_timing.rpt
report_power -file top_power.rpt
set_property BITSTREAM.CONFIG.SPI_BUSWIDTH 4 [current_design]
write_bitstream -force top.bit
write_cfgmem -force -format bin -interface spix4 -size 16 -loadbit "up 0x0 top.bit" -file top.bin
quit
