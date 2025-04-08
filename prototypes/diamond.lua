local resource_autoplace = require('resource-autoplace');
local item_sounds = require('__base__.prototypes.item_sounds')
local util = require("data-util");

if util.me.use_rough_diamond() then
local planet = mods["space-age"] and "vulcanus" or "nauvis"

resource_autoplace.initialize_patch_set("diamond", true)
data.raw.planet[planet].map_gen_settings.autoplace_controls["diamond"] = {}
data.raw.planet[planet].map_gen_settings.autoplace_settings.entity.settings["diamond"] = {}
if mods.tenebris then
  data.raw.planet.tenebris.map_gen_settings.autoplace_controls["diamond"] = {}
  data.raw.planet.tenebris.map_gen_settings.autoplace_settings.entity.settings["diamond"] = {}
end

data:extend({
	{
    type = "autoplace-control",
    category = "resource",
    name = "diamond",
    richness = true,
    order = mods["space-age"] and "b-d-a" or "a-g",
	},
	-- {
  --   type = "noise-layer",
  --   name = "diamond"
	-- },
	{
    type = "resource",
    name = "diamond",
    icon = "__bzcarbon__/graphics/icons/rough-diamond.png",
    icon_size = 128,
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
      order = mods["space-age"] and "b-d-a" or "a-g",
      base_density = mods["space-age"] and 6 or 0.5,
      base_spots_per_km2 = mods["space-age"] and 1.3 or 0.5,
      has_starting_area_placement = not not mods["space-age"],
      regular_rq_factor_multiplier = mods["space-age"] and 1 or 0.6,
    },

    stage_counts = {15000, 9500, 5500, 2900, 1300, 400, 150, 80},
    stages =
    {
      sheet =
      {
        filename = "__bzcarbon__/graphics/entity/ores/hr-diamond.png",
        priority = "extra-high",
        size = 128,
        frame_count = 8,
        variation_count = 8,
        scale = 0.5
      }
    },
  },
  {
      type = "item",
      name = "rough-diamond",
      icon_size = 128,
      icon = "__bzcarbon__/graphics/icons/rough-diamond.png",
      pictures = {
        {filename="__bzcarbon__/graphics/icons/rough-diamond.png", size=128, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/rough-diamond-1.png", size=128, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/rough-diamond-2.png", size=128, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/rough-diamond-3.png", size=128, scale=0.25},
        {filename="__bzcarbon__/graphics/icons/rough-diamond-4.png", size=128, scale=0.25},
      },
      inventory_move_sound = item_sounds.resource_inventory_move,
      pick_sound = item_sounds.resource_inventory_pickup,
      drop_sound = item_sounds.resource_inventory_move,
      subgroup = "raw-resource",
      order = "t-c-a",
      stack_size = util.get_stack_size(50)
  },
})
end
