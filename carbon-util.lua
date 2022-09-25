local futil = require("util")
local util = require("data-util");

local cutil = {}

function cutil.nanotube_recipe(recipe_name, item_name, tech)
  if not tech then tech = "nanotubes" end
  if not item_name then item_name = recipe_name end
  if not data.raw.recipe[recipe_name] or not data.raw.item[item_name] then return end
  -- local normal = get_normal(recipe_name)

  local new_recipe = futil.table.deepcopy(data.raw.recipe[recipe_name])
  new_recipe.name = recipe_name.."-nanotubes"
  new_recipe.icons = {
      { icon = data.raw.item[item_name].icon, icon_size = data.raw.item[item_name].icon_size},
      { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
    }
  new_recipe.icon = nil
  new_recipe.icon_size = nil
  new_recipe.icon_mipmaps = nil
  data:extend({new_recipe})
  local amt = 2 * util.get_amount(recipe_name, item_name)
  util.add_ingredient(new_recipe.name, "nanotubes", amt, {force=true})
  util.set_product_amount(new_recipe.name, item_name, amt, {force=true})
  util.add_unlock(tech, new_recipe.name)
  return new_recipe.name
end

return cutil
