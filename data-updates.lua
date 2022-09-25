require("carbon-recipe-updates")
require("carbon-fiber-recipe-updates")
require("map-gen-preset-updates")
require("carbon-matter")
require("strange-matter")
require("compatibility/248k")
require("compatibility/orewashing")
require("carbon-recipe-modules") -- Should be last import, need in both updates and final-fixes

-- require("omni")

local util = require("data-util");

if mods.Asteroid_Mining then
  require("__Asteroid_Mining__.scripts.addmodule")
  if util.me.use_flake_graphite() then
    amfunc.addtype("flake-graphite", {a = 0,r = 0.0,g = 0.2,b = 0.5})
  end
  if util.me.use_rough_diamond() then
    amfunc.addtype("rough-diamond", {a = 0,r = 0.0,g = 0.2,b = 0.8})
  end
end

-- Must be last
util.create_list()
