local resource_autoplace = require('resource-autoplace');
local noise = require('noise');

local util = require("__bzcarbon__.data-util");

if util.me.use_flake_graphite() then
data:extend({
	{
    type = "autoplace-control",
    category = "resource",
    name = "graphite",
    richness = true,
    order = "b-e"
	},
	{
    type = "noise-layer",
    name = "graphite"
	},
	{
    type = "resource",
    icon_size = 64, icon_mipmaps = 3,
    name = "graphite",
    icon = "__bzcarbon__/graphics/icons/flake-graphite.png",
    flags = {"placeable-neutral"},
    order="a-b-a",
    map_color = {r=0.18, g=0.17, b=0.30},
    minable =
    {
      hardness = 1,
      mining_particle = "graphite-particle",
      mining_time = 1,
      fluid_amount = 1,
      required_fluid = "steam",
      result = "flake-graphite"
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},

    autoplace = resource_autoplace.resource_autoplace_settings{
      name = "graphite",
      order = "b-z",
      base_density = 6,
      base_spots_per_km2 = 1,
      has_starting_area_placement = true,
      regular_rq_factor_multiplier = 1.2,
      starting_rq_factor_multiplier = 1.4,
    },

    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
        stages =
        {
          sheet =
          {
      filename = "__bzcarbon__/graphics/entity/ores/graphite.png",
      priority = "extra-high",
      size = 64,
      frame_count = 8,
      variation_count = 8,
      hr_version =
      {
      filename = "__bzcarbon__/graphics/entity/ores/hr-graphite.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
          }
    },
  },
  {
      type = "item",
      name = "flake-graphite",
      icon_size = 64, icon_mipmaps = 3,
      icon = "__bzcarbon__/graphics/icons/flake-graphite.png",
      pictures = {
        {filename="__bzcarbon__/graphics/icons/flake-graphite.png", size=64, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/flake-graphite-1.png", size=64, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/flake-graphite-2.png", size=64, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/flake-graphite-3.png", size=64, scale=0.25},
      },
      subgroup = "raw-resource",
      order = "t-c-a",
      stack_size = util.get_stack_size(50)
  },
})
end
