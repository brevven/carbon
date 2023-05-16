local util = require("data-util");

if mods.pyhightech then
  -- tier 1 changes (rest is in carbon-recipe.lua)
  util.set_prerequisite("graphite-processing", {"vacuum-tube-electronics"})
  util.add_unlock("graphite-processing", "graphite-crushing")

  local pyfix0 = "-grade-0"
  local pyfix1 = "-grade-1"
  local pyfix2 = "-grade-2"
  local pyfix3 = "-grade-3"
  local pyfix3 = "-grade-4"

  -- tier 2
  data:extend({
    {
      type = "recipe",
      name = "graphite-crushing-2-1",
      icon = "__bzcarbon__/graphics/icons/graphite-2.png", icon_size = 128,
      main_product = "graphite"..pyfix0,
      category = "crusher",
      order = "d[graphite]",
      enabled = false,
      energy_required = 0.5,
      ingredients = {{"flake-graphite", 4}},
      results = {
        {"graphite"..pyfix0, 1},
        {type="item", name="stone", amount=1, probability = .1},
      }
    },
    {
      type = "recipe",
      name = "graphite-crushing-2-2",
      category = "impact-crusher",
      order = "d[graphite]",
      enabled = false,
      energy_required = 2,
      ingredients = {{"graphite"..pyfix0, 1}},
      result = "graphite",
      result_count = 2,
    },
  })

  data:extend({
    {
      type = "technology",
      name = "graphite-processing-2",
      icon_size = 128,
      icon = "__bzcarbon__/graphics/icons/graphite.png",
      effects = {},
      unit =
      {
        count = 30,
        ingredients = 
        {
          {"automation-science-pack", 1},
        },
        time = 30,
      },
      prerequisites = {"machines-mk01"},
      order = "b-b"
    },
  })
  if mods.pyalienlife then
    util.set_tech_recipe("graphite-processing-2", {
          {"automation-science-pack", 2},
          {"py-science-pack-1", 1},
    })
  end
  util.add_unlock("graphite-processing-2", "graphite-crushing-2-1")
  util.add_unlock("graphite-processing-2", "graphite-crushing-2-2")

  -- tier 3
  --
  local gtint = {a=1, r=0.7, g=0.7, b=0.9}
  data:extend({
    { 
      type = "item",
      name = "graphite"..pyfix1,
      icons = {{
        icon = "__pyraworesgraphics__/graphics/icons/grade-1-lead.png",
        icon_size = 32,
        tint = gtint,
      }},
      subgroup = "raw-material",
      order = "g[graphite]",
      stack_size = util.get_stack_size(100)
    },
    { 
      type = "item",
      name = "graphite"..pyfix2,
      icons = {{
        icon = "__pyraworesgraphics__/graphics/icons/grade-2-lead.png",
        icon_size = 32,
        tint = gtint,
      }},
      subgroup = "raw-material",
      order = "g[graphite]",
      stack_size = util.get_stack_size(100)
    },
    { 
      type = "item",
      name = "graphite"..pyfix3,
      icons = {{
        icon = "__pyraworesgraphics__/graphics/icons/grade-3-lead.png",
        icon_size = 32,
        tint = gtint,
      }},
      subgroup = "raw-material",
      order = "g[graphite]",
      stack_size = util.get_stack_size(100)
    },

    {
      type = "recipe",
      name = "graphite-crushing-3-2",
      main_product="graphite"..pyfix2,
      category = "impact-crusher",
      order = "d[graphite]",
      enabled = false,
      energy_required = 2,
      ingredients = {{"graphite"..pyfix0, 1}},
      results = {
        {"graphite"..pyfix2, 2},
        {type="item", name="gravel", amount=1, probability = .1},
      },
    },

    {
      type = "recipe",
      name = "graphite-crushing-3-3",
      main_product="graphite"..pyfix1,
      category = "flotation",
      order = "d[graphite]",
      enabled = false,
      energy_required = 10,
      ingredients = {
        {"graphite"..pyfix2, 5},
        {type="fluid", name="kerosene", amount=10}
      },
      results = {
        {"graphite"..pyfix1, 4},
        {type="fluid", name="dirty-water-heavy", amount=15}
      },
    },
    {
      type = "recipe",
      name = "graphite-crushing-3-4",
      main_product="graphite",
      category = "classifier",
      order = "d[graphite]",
      enabled = false,
      energy_required = 2,
      ingredients = {
        {"graphite"..pyfix1, 1}
      },
      results = {
        {"graphite", 2},
        {"graphite"..pyfix2, 1}
      },
    },
  })

  data:extend({
    {
      type = "technology",
      name = "graphite-processing-3",
      icon_size = 128,
      icon = "__bzcarbon__/graphics/icons/graphite.png",
      effects = {},
      unit =
      {
        count = 500,
        ingredients = 
        {
          {"automation-science-pack", 1},
        },
        time = 120,
      },
      prerequisites = {"machines-mk01"},
      order = "b-b"
    },
  })
  if mods.pyalienlife then
    util.set_tech_recipe("graphite-processing-3", {
          {"automation-science-pack", 10},
          {"py-science-pack-1", 6},
          {"logistic-science-pack", 3},
          {"py-science-pack-2", 2},
          {"chemical-science-pack", 1},
    })
  end
  util.add_unlock("graphite-processing-3", "graphite-crushing-3-2")
  util.add_unlock("graphite-processing-3", "graphite-crushing-3-3")
  util.add_unlock("graphite-processing-3", "graphite-crushing-3-4")
end

