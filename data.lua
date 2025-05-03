require("prototypes.basic-crusher")
require("prototypes.graphite")
log("1")
require("prototypes.graphite-particle")
log("2")
require("prototypes.diamond")
log("3")
require("prototypes.diamond-particle")
log("4")

require("carbon-recipe")
log("5")
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
  if not util.k2() then
    require("tech-triggers")
  end
else
  util.set_prerequisite("graphite-processing", {})
end
util.add_prerequisite("uranium-processing", "sulfur-processing")

util.add_unlock("graphite-processing", "basic-crusher")


-- Must be last
util.create_list()
