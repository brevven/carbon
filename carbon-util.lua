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
  if new_recipe.subgroup == "vulcanus-processes" then
    new_recipe.localised_name = {"recipe-name."..recipe_name}
    new_recipe.icons = {
        { icon = data.raw.recipe[recipe_name].icon, icon_size = data.raw.recipe[recipe_name].icon_size},
        { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
      }
  else
    new_recipe.localised_name = {"item-name."..item_name}
    if new_recipe.icons and #new_recipe.icons > 1 then
      table.insert(new_recipe.icons,
          { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}}
      )
    else
      new_recipe.icons = {
          { icon = data.raw.item[item_name].icon, icon_size = data.raw.item[item_name].icon_size},
          { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
        }
    end
  end
  new_recipe.icon = nil
  new_recipe.icon_size = nil
  new_recipe.icon_mipmaps = nil
  new_recipe.hide_from_signal_gui = false
  data:extend({new_recipe})
  local amt = 2 * util.get_amount(recipe_name, item_name)
  if amt == 0 and mods["hot-metals"] then
    amt = 2 * util.get_amount(recipe_name, "hot-"..item_name)
    util.set_product_amount(new_recipe.name, "hot-"..item_name, amt, {force=true})
  end
  util.add_ingredient(new_recipe.name, "nanotubes", amt, {force=true})
  util.set_product_amount(new_recipe.name, item_name, amt, {force=true})
  util.add_unlock(tech, new_recipe.name)
  return new_recipe.name
end

return cutil
