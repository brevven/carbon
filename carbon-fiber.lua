local util = require("__bzcarbon__.data-util");

if util.me.use_fiber() then
data:extend({
  {
    type = "item",
    name = "carbon-fiber",
    icon = "__bzcarbon__/graphics/icons/carbon-fiber.png",
    icon_size = 128,
    subgroup = "intermediate-product",
    order = "g[graphite-carbon-fiber]",
    stack_size = util.get_stack_size(100),
  },
  {
    type = "recipe",
    name = "carbon-fiber",
    category = "advanced-crafting",
    order = "d[graphite-carbon-fiber]",
    enabled = false,
    energy_required = 1,
    ingredients = {
      {type="item", name="plastic", amount=1},
      {type="item", name="graphite", amount=1},
    },
    results = {
      {type="item", name= "carbon-fiber", amount=1},
    }
  },
})
end
