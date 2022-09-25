local util = require("data-util");
local cutil = require("carbon-util")

if mods["space-exploration"] then
  -- core mining balancing graphite at full, diamond removed
  util.remove_product("se-core-fragment-omni", "rough-diamond")

  if util.me.use_fullerenes() then
    cutil.nanotube_recipe("se-aeroframe-scaffold", "se-aeroframe-scaffold", "se-aeroframe-scaffold")
    local nm_name = cutil.nanotube_recipe("se-nanomaterial", "se-nanomaterial", "se-nanomaterial")
    util.set_ingredient(nm_name, "nanotubes", 2)
  end
end
