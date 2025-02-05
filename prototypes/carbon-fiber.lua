local util = require("data-util");

if util.me.use_fiber() then
if mods["space-age"] then
  -- ammonia from spoilage for polyacrylonitrile and for graphene 
  data:extend({
    {
      type = "recipe",
      name = "ammonia-from-spoilage",
      category = "organic",
      subgroup = "agriculture-processes",
      icons = {
        {icon = "__space-age__/graphics/icons/fluid/ammonia.png", icon_size = 64},
        {icon = "__space-age__/graphics/icons/spoilage.png", icon_size = 64, scale= 0.25, shift = {-8,-8}},
      },
      enabled = false,
      energy_required = 5,
      ingredients = {
        util.item("spoilage", 1),
      },
      results = {
        util.fluid("ammonia", 10),
      },
    }
  })
end
data:extend({
  {
    type = "item",
    name = "polyacrylonitrile",
    icon = "__bzcarbon__/graphics/icons/pan.png",
    icon_size = 128,
    subgroup = "intermediate-product",
    order = "g[graphite-acrylic-fiber]",
    stack_size = util.get_stack_size(100),
  },
  {
    type = "recipe",
    name = "polyacrylonitrile",
    category = "chemistry",
    order = "d[graphite-carbon-fiber]",
    enabled = false,
    energy_required = 1,
    ingredients = data.raw.fluid["ammonia"] and
    {
      {type="fluid", name="petroleum-gas", amount=5},
      {type="fluid", name="ammonia", amount=5},
    } or {
      {type="fluid", name="petroleum-gas", amount=10},
    },
    results = {
      {type="item", name= "polyacrylonitrile", amount=1},
    },
  },
})
if mods["space-age"] then
  util.set_category("polyacrylonitrile", "organic")
  util.remove_ingredient("polyacrylonitrile", "petroleum-gas")
  util.add_ingredient("polyacrylonitrile", "jelly", 10)
  util.add_ingredient("polyacrylonitrile", "jelly", 10)
  util.add_ingredient("polyacrylonitrile", "ammonia", 10)
  util.add_ingredient("carbon-fiber", "ammonia", 10)
  util.replace_ingredient("carbon-fiber", "carbon", "polyacrylonitrile")
  util.set_item_icons("carbon-fiber", { {icon = "__bzcarbon__/graphics/icons/carbon-fiber.png", icon_size = 128,} })
  util.add_unlock("biochamber", "ammonia-from-spoilage")
  util.add_unlock("carbon-fiber", "polyacrylonitrile")
else
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
      energy_required = 24,
      ingredients = {
        {type="fluid", name="epoxy", amount = 20},
        {"plastic-bar", 2},
        {"polyacrylonitrile", 4},
      },
      results = {
        {type="item", name= "carbon-fiber", amount=8},
      },
    },
  })
  data:extend({
    {
      type = "technology",
      name = "carbon-fiber",
      icon_size = 256,
      icon = "__bzcarbon__/graphics/technology/carbon-fiber.png",
      effects = {
        {type="unlock-recipe", recipe="polyacrylonitrile"},
        {type="unlock-recipe", recipe="carbon-fiber"},
      },
      unit =
      {
        count = 30,
        ingredients = 
        {
          {"automation-science-pack", 1},
          {"logistic-science-pack", 1},
          {"chemical-science-pack", 1},
        },
        time = 10,
      },
      prerequisites = {"chemical-science-pack", "plastics"},
      order = "b-b"
    },
  })
  util.replace_some_ingredient("carbon-fiber", "plastic", 1, "silica", 2, {force=true})
  util.add_prerequisite("low-density-structure", "carbon-fiber")
  util.add_prerequisite("exoskeleton-equipment", "carbon-fiber")
  util.add_prerequisite("military-3", "carbon-fiber")
end
end
