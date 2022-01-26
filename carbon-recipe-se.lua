local util = require("__bzcarbon__.data-util");
if mods["space-exploration"] then

if util.me.use_rough_diamond() then
  se_resources["diamond"] = {
    order = "b-z",
    has_starting_area_placement = false,
    base_density = 0.5,
    base_spots_per_km2 = 0.5,
  }
end

if util.me.use_flake_graphite() then
  se_delivery_cannon_recipes["flake-graphite"] = {name= "flake-graphite"}
end
se_delivery_cannon_recipes["graphite"] = {name= "graphite"}
se_delivery_cannon_recipes["diamond"] = {name= "diamond"}
if util.me.use_rough_diamond() then
  se_delivery_cannon_recipes["rough-diamond"] = {name= "rough-diamond"}
end

data:extend({
    {
      type = "recipe",
      name = "diamond-synthesis-vulcanite",
      category = "smelting",
      order = "g[diamond]",
      energy_required = 40,
      enabled = false,
      always_show_made_in = true,
      allow_as_intermediate = false,
      ingredients = {
        {name = "graphite", amount = 20},
        {name = "se-vulcanite-block", amount = 1},
      },
      results = {
        {name = "diamond", amount = 3},
      },
      icons =
      {
        { icon = "__bzcarbon__/graphics/icons/diamond.png", icon_size = 128},
        { icon = "__space-exploration-graphics__/graphics/icons/vulcanite-block.png", icon_size = 64, scale=0.25, shift= {-10, -10}},
      },
    },
})
util.add_effect("se-processing-vulcanite", {type="unlock-recipe", recipe="diamond-synthesis-vulcanite"})
end
