local util = require("control-util")

script.on_init(util.check_fluid_mining)
script.on_event(defines.events.on_console_command, util.list)
script.on_configuration_changed(util.ore_fix)

util.add_list_command_handler()
util.add_regenerate_command_handler()
util.warptorio2_expansion_helper()
