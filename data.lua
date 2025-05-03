require("prototypes.basic-crusher")
require("prototypes.graphite")
require("prototypes.graphite-particle")
require("prototypes.diamond")
require("prototypes.diamond-particle")

require("carbon-recipe")
require("carbon-recipe-k2")  -- must be after carbon-recipe
require("carbon-recipe-se")
require("prototypes.activated-carbon")
require("prototypes.carbon-fiber")


local util = require("data-util");

if mods["aai-vehicles-miner"] then
  -- steam required for graphite mining
  data.raw.fluid.steam.auto_barrel = true
end

util.add_fluid_mining()

if util.me.use_flake_graphite() then
  if not mods.Krastorio2 then
    require("tech-triggers")
  end
else
  util.set_prerequisite("graphite-processing", {})
end
util.add_prerequisite("uranium-processing", "sulfur-processing")

util.add_unlock("graphite-processing", "basic-crusher")


-- Must be last
util.create_list()
