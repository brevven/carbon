local resource_autoplace = require('resource-autoplace');
local noise = require('noise');

local util = require("data-util");

if util.me.use_rough_diamond() then
data:extend({
	{
    type = "autoplace-control",
    category = "resource",
    name = "diamond",
    richness = true,
    order = "b-e"
	},
	{
    type = "noise-layer",
    name = "diamond"
	},
	{
    type = "resource",
    icon_size = 64, icon_mipmaps = 3,
    name = "diamond",
    icon = "__bzcarbon__/graphics/icons/rough-diamond.png",
    flags = {"placeable-neutral"},
    order="a-b-a",
    map_color = {r=0.30, g=0.54, b=0.92},
    minable =
    {
      mining_particle = "diamond-particle",
      mining_time = 15,
      result = "rough-diamond"
    },
    collision_box = {{ -0.1, -0.1}, {0.1, 0.1}},
    selection_box = {{ -0.5, -0.5}, {0.5, 0.5}},

    autoplace = resource_autoplace.resource_autoplace_settings{
      name = "diamond",
      order = "b-z",
      base_density = 0.5,
      base_spots_per_km2 = 0.5,
      has_starting_area_placement = false,
      regular_rq_factor_multiplier = 0.6,
    },

    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
        stages =
        {
          sheet =
          {
      filename = "__bzcarbon__/graphics/entity/ores/diamond.png",
      priority = "extra-high",
      size = 64,
      frame_count = 8,
      variation_count = 8,
      hr_version =
      {
      filename = "__bzcarbon__/graphics/entity/ores/hr-diamond.png",
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
      name = "rough-diamond",
      icon_size = 64, icon_mipmaps = 3,
      icon = "__bzcarbon__/graphics/icons/rough-diamond.png",
      pictures = {
        {filename="__bzcarbon__/graphics/icons/rough-diamond.png", size=64, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/rough-diamond-1.png", size=64, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/rough-diamond-2.png", size=64, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/rough-diamond-3.png", size=64, scale=0.25},
      },
      subgroup = "raw-resource",
      order = "t-c-a",
      stack_size = util.get_stack_size(50)
  },
})
end
