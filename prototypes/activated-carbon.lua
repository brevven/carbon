local util = require("data-util");

if mods["space-age"] then
local precursor = "solid-fuel"
if mods["wood-industry"] then precursor = "charcoal" end
  data:extend({
  {
    type = "item",
    name = "activated-carbon",
    icon = "__bzcarbon__/graphics/icons/activated-carbon.png",
    icon_size = 128,
    subgroup = "intermediate-product",
    order = "g[activated-carbon]",
    stack_size = util.get_stack_size(100),
  },
  {
    type = "recipe",
    name = "activated-carbon",
    category = "chemistry",
    order = "d[graphite-carbon-fiber]",
    enabled = false,
    energy_required = 2.5,
    ingredients = data.raw.fluid["ammonia"] and
    {
      util.item(precursor),
      util.fluid("steam"),
      (mods.bztitanium or mods.bzzirconium) and util.fluid("vacuum") or nil
    },
    results = {
      {type="item", name= "activated-carbon", amount=1},
    },
  },
  })
  if util.me.use_carbon_black() then
  data:extend({
  {
    type = "recipe",
    name = "activated-carbon-black",
    localised_name = {"item-name.activated-carbon"},
    icons = {
      { icon = "__bzcarbon__/graphics/icons/activated-carbon.png", icon_size = 128},
      { icon = "__bzcarbon__/graphics/icons/carbon-black.png", icon_size = 64, scale = 0.25, shift = {-8, -8}},
    },
    category = "chemistry",
    order = "d[graphite-carbon-fiber]",
    enabled = false,
    energy_required = 2.5,
    ingredients = data.raw.fluid["ammonia"] and
    {
      util.item("carbon-black", 5),
      util.fluid("steam"),
      (mods.bztitanium or mods.bzzirconium) and util.fluid("vacuum") or nil
    },
    results = {
      {type="item", name= "activated-carbon", amount=1},
    },
  },
  })
  end
  util.add_unlock("advanced-oil-processing", "activated-carbon")
  util.add_unlock("advanced-oil-processing", "activated-carbon-black")
  util.add_ingredient("supercapacitor", "activated-carbon", 10)
end
