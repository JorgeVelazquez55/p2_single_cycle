set_global_assignment -entity "pll40MHz" -library "lib_pll40MHz" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll40MHz" -library "lib_pll40MHz" -name IP_TOOL_VERSION "22.1"
set_global_assignment -entity "pll40MHz" -library "lib_pll40MHz" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll40MHz" -name SPD_FILE [file join $::quartus(sip_path) "pll40MHz.spd"]
