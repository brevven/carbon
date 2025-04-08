local util = require("data-util");
local cutil = require("carbon-util")

if util.me.use_fullerenes() then
  cutil.nanotube_recipe("low-density-structure")
  cutil.nanotube_recipe("casting-low-density-structure", "low-density-structure")
  cutil.nanotube_recipe("space-platform-foundation")
  cutil.nanotube_recipe("low-density-structure-from-aluminum", "low-density-structure")

  util.add_to_productivity_research("low-density-structure-productivity", "low-density-structure-nanotubes")
  util.add_to_productivity_research("low-density-structure-productivity", "casting-low-density-structure-nanotubes")
  util.add_to_productivity_research("low-density-structure-productivity", "low-density-structure-from-aluminum-nanotubes")
end
