local util = require("data-util");
local futil = require("util")

if util.me.use_fullerenes() then
  data:extend({
    {
      type = "recipe",
      name = "low-density-structure-nanotubes",
      icons = {
        { icon = "__base__/graphics/icons/low-density-structure.png", icon_size = 64, icon_mipmaps = 4},
        { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
      },
      category = "advanced-crafting",
      subgroup = data.raw.item["low-density-structure"].subgroup,
      order = "o[low-density-structure-nanotubes]",
    },
  })
  if data.raw.recipe["low-density-structure"].normal and data.raw.recipe["low-density-structure"].normal.ingredients then
    data.raw.recipe["low-density-structure-nanotubes"].normal = {
      enabled = false,
      energy_required = 20,
      results = {{"low-density-structure", 2}},
      ingredients = {
        {"nanotubes", 2},
        table.unpack(futil.table.deepcopy(data.raw.recipe["low-density-structure"].normal.ingredients)),
      },
    }
    if data.raw.recipe["low-density-structure"].expensive and data.raw.recipe["low-density-structure"].expensive.ingredients then
      data.raw.recipe["low-density-structure-nanotubes"].expensive = {
        enabled = false,
        energy_required = 20,
        results = {{"low-density-structure", 2}},
        ingredients = {
          {"nanotubes", 2},
          table.unpack(futil.table.deepcopy(data.raw.recipe["low-density-structure"].expensive.ingredients)),
        },
      }
    end
  else
    local recipe = data.raw.recipe["low-density-structure-nanotubes"]
    recipe.enabled = false
    recipe.energy_required = 20
    recipe.results = {{"low-density-structure", 2}}
    recipe.ingredients = {
      {"nanotubes", 2},
      table.unpack(futil.table.deepcopy(data.raw.recipe["low-density-structure"].ingredients)),
    }
  end

  if util.me.reuse() then
    util.add_product("low-density-structure-nanotubes", {type="item", name="diamond", amount=1, probability = 0.5})
  end
end
