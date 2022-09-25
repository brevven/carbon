require("graphite")
require("graphite-particle")
require("diamond")
require("diamond-particle")

require("carbon-recipe")
require("carbon-recipe-k2")  -- must be after carbon-recipe
require("carbon-recipe-se")
require("carbon-fiber")


local util = require("data-util");

if mods["aai-vehicles-miner"] then
  -- steam required for graphite mining
  data.raw.fluid.steam.auto_barrel = true
end


-- Must be last
util.create_list()
