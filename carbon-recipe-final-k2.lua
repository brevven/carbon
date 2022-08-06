local bzutil = require("data-util");
local util = require("util")
if mods.Krastorio2 then
  if bzutil.me.use_fullerenes() then
  -- Add extra nanotube recipes.
  -- This could be moved to data-updates in future if necessary
    data:extend({
      {
        type = "recipe",
        name = "imersium-plate-nanotubes",
        icons = {
          { icon = data.raw.item["imersium-plate"].icon, icon_size = data.raw.item["imersium-plate"].icon_size},
          { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
            },
        category = "smelting",
        subgroup = "raw-material",
        order = "e00-a2[imersium-plate]",
        enabled = false,
        energy_required = 32,
        ingredients = {
          {"nanotubes", 6},
          table.unpack(util.table.deepcopy(data.raw.recipe["imersium-plate"].ingredients)),
        },
        result = "imersium-plate",
        result_count = 6,
      },
      {
        type = "recipe",
        name = "imersium-beam-nanotubes",
        icons = {
          { icon = data.raw.item["imersium-beam"].icon, icon_size = data.raw.item["imersium-beam"].icon_size},
          { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
            },
        category = "smelting-crafting",
        subgroup = "smelting-crafting",
        hide_from_player_crafting = true,
        order = data.raw.item["imersium-beam"].order.."z",
        enabled = false,
        energy_required = 12,
        ingredients = {
          {"nanotubes", 4},
          table.unpack(util.table.deepcopy(data.raw.recipe["kr-s-c-imersium-beam"].ingredients)),
        },
        result = "imersium-beam",
        result_count = 2,
      },
      {
        type = "recipe",
        name = "imersium-gear-wheel-nanotubes",
        icons = {
          { icon = data.raw.item["imersium-gear-wheel"].icon, icon_size = data.raw.item["imersium-gear-wheel"].icon_size},
          { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
            },
        category = "smelting-crafting",
        subgroup = "smelting-crafting",
        hide_from_player_crafting = true,
        order = data.raw.item["imersium-gear-wheel"].order.."z",
        enabled = false,
        energy_required = 12,
        ingredients = {
          {"nanotubes", 2},
          table.unpack(util.table.deepcopy(data.raw.recipe["kr-s-c-imersium-gear-wheel"].ingredients)),
        },
        result = "imersium-gear-wheel",
        result_count = 2,
      },
    })

  bzutil.add_effect("nanotubes", {type="unlock-recipe", recipe="imersium-plate-nanotubes"})
  bzutil.add_effect("nanotubes", {type="unlock-recipe", recipe="imersium-beam-nanotubes"})
  bzutil.add_effect("nanotubes", {type="unlock-recipe", recipe="imersium-gear-wheel-nanotubes"})
  end
end
