## This file is a general .xdc for the Basys3 rev B board
## To use it in a project:
## - uncomment the lines corresponding to used pins
## - rename the used ports (in each line, after get_ports) according to the top level signal names in the project

## Clock signal
set_property PACKAGE_PIN W5 [get_ports rawclk]
set_property IOSTANDARD LVCMOS33 [get_ports rawclk]
#set_property CLOCK_DEDICATED_ROUTE FALSE [get_nets CLK_IBUF]


## Switches
set_property PACKAGE_PIN V17 [get_ports rx_en]
	set_property IOSTANDARD LVCMOS33 [get_ports rx_en]
set_property PACKAGE_PIN V16 [get_ports tx_en]
	set_property IOSTANDARD LVCMOS33 [get_ports tx_en]

### LEDs
set_property PACKAGE_PIN U16 [get_ports {ledin[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledin[0]}]
set_property PACKAGE_PIN E19 [get_ports {ledin[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledin[1]}]
set_property PACKAGE_PIN U19 [get_ports {ledin[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledin[2]}]
set_property PACKAGE_PIN V19 [get_ports {ledin[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledin[3]}]
set_property PACKAGE_PIN W18 [get_ports {ledin[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledin[4]}]
set_property PACKAGE_PIN U15 [get_ports {ledin[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledin[5]}]
set_property PACKAGE_PIN U14 [get_ports {ledin[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledin[6]}]
set_property PACKAGE_PIN V14 [get_ports {ledin[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledin[7]}]
set_property PACKAGE_PIN V13 [get_ports {ledout[0]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledout[0]}]
set_property PACKAGE_PIN V3 [get_ports {ledout[1]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledout[1]}]
set_property PACKAGE_PIN W3 [get_ports {ledout[2]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledout[2]}]
set_property PACKAGE_PIN U3 [get_ports {ledout[3]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledout[3]}]
set_property PACKAGE_PIN P3 [get_ports {ledout[4]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledout[4]}]
set_property PACKAGE_PIN N3 [get_ports {ledout[5]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledout[5]}]
set_property PACKAGE_PIN P1 [get_ports {ledout[6]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledout[6]}]
set_property PACKAGE_PIN L1 [get_ports {ledout[7]}]
	set_property IOSTANDARD LVCMOS33 [get_ports {ledout[7]}]

#Buttons
set_property PACKAGE_PIN U18 [get_ports rawreset]
	set_property IOSTANDARD LVCMOS33 [get_ports rawreset]


##USB-RS232 Interface
set_property PACKAGE_PIN B18 [get_ports rx_in]
	set_property IOSTANDARD LVCMOS33 [get_ports rx_in]
set_property PACKAGE_PIN A18 [get_ports tx_out]
	set_property IOSTANDARD LVCMOS33 [get_ports tx_out]
