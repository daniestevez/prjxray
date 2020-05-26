# Copyright (C) 2017-2020  The Project X-Ray Authors
#
# Use of this source code is governed by a ISC-style
# license that can be found in the LICENSE file or at
# https://opensource.org/licenses/ISC
#
# SPDX-License-Identifier: ISC
create_project -force -name $env(PROJECT_NAME) -part $env(VIVADO_PART)

read_verilog ../$env(PROJECT_NAME).v
synth_design -top top

source ../zybo.xdc

place_design
route_design

write_checkpoint -force ../$env(PROJECT_NAME).dcp
write_bitstream  -force ../$env(PROJECT_NAME).bit
