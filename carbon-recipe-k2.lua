local util = require("__bzcarbon__.data-util");

if mods.Krastorio2 then
data:extend({
{
    type = "recipe",
    name = "heavy-water-graphene",
    icons = {
          { icon = util.k2assets().."/icons/fluids/heavy-water.png", icon_size = 64, icon_mipmaps = 3,},
          { icon = "__bzcarbon__/graphics/icons/graphene.png", icon_size = 128,  scale=0.25, shift= {-8, -8}},
        },
    category = "electrolysis",
    subgroup = "fluid-recipes",
    order = "y06[heavy-water]",
    enabled = false,
    energy_required = 60,
    ingredients = {
      {type="item", name="graphene", amount=1, catalyst_amount=1},
      {type="fluid", name="water", amount=500},
    },
    results = {
      {type="item", name="graphene", amount=1, probability=.8, catalyst_amount=1},
      {type="fluid", name="heavy-water", amount=40},
    },
  }
})
util.add_effect("graphene", {type="unlock-recipe", recipe="heavy-water-graphene"})
util.add_prerequisite("fullerenes", "kr-atmosphere-condensation")
end
