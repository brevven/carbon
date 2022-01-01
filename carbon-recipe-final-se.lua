local util = require("util")
local bzutil = require("__bzcarbon__.data-util");

if mods["space-exploration"] then
if bzutil.me.use_fullerenes() then
  -- Add an extra nanotube aeroframe scaffold recipe. 
  -- This could be moved to data-updates in future if necessary
  data:extend({
    {
      type = "recipe",
      name = "aeroframe-scaffold-nanotubes",
      icons = {
        { icon = data.raw.item["se-aeroframe-scaffold"].icon, icon_size = data.raw.item["se-aeroframe-scaffold"].icon_size},
        { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
      },
      category = "crafting",
      order = data.raw.item["se-aeroframe-scaffold"].order.."z",
      enabled = false,
      energy_required = 2,
      ingredients = {
        {"nanotubes", 2},
        table.unpack(util.table.deepcopy(data.raw.recipe["se-aeroframe-scaffold"].ingredients)),
      },
      result = "se-aeroframe-scaffold",
      result_count = 2,
    },
  })
  bzutil.add_effect("se-aeroframe-scaffold", {type="unlock-recipe", recipe="aeroframe-scaffold-nanotubes"})

  data:extend({
    {
      type = "recipe",
      name = "nanomaterial-nanotubes",
      icons = {
        { icon = data.raw.item["se-nanomaterial"].icon, icon_size = data.raw.item["se-nanomaterial"].icon_size},
        { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
      },
      category = data.raw.recipe["se-nanomaterial"].category,
      order = data.raw.item["se-nanomaterial"].order.."z",
      subgroup = data.raw.item["se-nanomaterial"].subgroup,
      enabled = false,
      energy_required = data.raw.recipe["se-nanomaterial"].energy_required,
      ingredients = {
        {"nanotubes", 2},
        table.unpack(util.table.deepcopy(data.raw.recipe["se-nanomaterial"].ingredients)),
      },
      results = {
        table.unpack(util.table.deepcopy(data.raw.recipe["se-nanomaterial"].results)),
      }
    }
  })
  bzutil.add_to_product("nanomaterial-nanotubes", "se-nanomaterial", 16)
  bzutil.add_effect("se-nanomaterial", {type="unlock-recipe", recipe="nanomaterial-nanotubes"})

  -- core mining balancing
  bzutil.add_to_product("se-core-fragment-omni", "graphite", -3)
  end
end
