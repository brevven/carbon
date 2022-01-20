require("carbon-recipe-final-stacking")
require("carbon-recipe-final-k2")
require("carbon-recipe-final-se")
require("carbon-recipe-final-rrr")
require("low-density-structure-nanotubes")
require("carbon-recipe-modules") -- Should be last import, need in both updates and final-fixes

local util = require("data-util");


-- Green circuits in final fixes due to K2 shenanigans 
if not mods.MDbobelectronics then
  util.replace_some_ingredient("electronic-circuit", "copper-cable", 1, "graphite", 1)
  -- AAI alternate green circuit
  util.replace_some_ingredient("electronic-circuit-stone", "copper-cable", 1, "graphite", 1)
else
  util.replace_ingredient("basic-electronic-component", "coal", "graphite")
  util.replace_ingredient("basic-electronic-component", "coke", "graphite")
end

if data.raw.recipe["low-density-structure"] and 
  not data.raw.recipe["low-density-structure"].icon and
  not data.raw.recipe["low-density-structure"].icons
  then
  util.set_subgroup("low-density-structure", data.raw.item["low-density-structure"].subgroup)
  util.set_icons("low-density-structure", {
    { icon = "__base__/graphics/icons/low-density-structure.png", icon_size = 64, icon_mipmaps = 4},
  })
  util.set_subgroup("se-low-density-structure-beryllium", data.raw.item["low-density-structure"].subgroup)
  util.set_icons("se-low-density-structure-beryllium", {
    { icon = "__base__/graphics/icons/low-density-structure.png", icon_size = 64, icon_mipmaps = 4},
  })
  util.set_subgroup("low-density-structure-RS", data.raw.item["low-density-structure"].subgroup)
  util.set_icons("low-density-structure-RS", {
    { icon = "__base__/graphics/icons/low-density-structure.png", icon_size = 64, icon_mipmaps = 4},
  })
end


-- Only electric smelters can make Diamonds
function diamondsInElectricSmelter(entity)
  if entity.energy_source.type == "electric" then
    local isSmelter = false
    local isSmelterRS = false
    for j, category in pairs(entity.crafting_categories) do
      if category == "smelting" then
        isSmelter = true
      end
      if category == "smelting-RS" then
        isSmelterRS = true
      end
    end
    if isSmelter then
     table.insert(entity.crafting_categories,"diamond-synthesis")
    end
    if isSmelterRS then
     table.insert(entity.crafting_categories,"diamond-synthesis-RS")
    end
  end
end
for i, entity in pairs(data.raw.furnace) do
  diamondsInElectricSmelter(entity)
end
for i, entity in pairs(data.raw["assembling-machine"]) do
  diamondsInElectricSmelter(entity)
end 

-- furnace recipe rework, remove crucible ingredients
for i, furnace in pairs(util.me.furnaces) do
  for j, ingredient in pairs(util.me.crucible_ingredients)  do
    util.remove_ingredient(furnace, ingredient)
  end
end

-- Vanilla burner phase tweaks -- green circuits after electronics
if not mods.Krastorio2 and not mods["aai-industry"] then
  util.replace_ingredient("offshore-pump", "electronic-circuit", "copper-cable")
  util.replace_ingredient("lab", "electronic-circuit", "copper-cable")
  util.replace_ingredient("electric-mining-drill", "electronic-circuit", "copper-cable")
  util.replace_ingredient("assembling-machine-1", "electronic-circuit", "copper-plate")
  util.replace_ingredient("radar", "electronic-circuit", "copper-plate")

  util.add_effect("electronics", { type = "unlock-recipe", recipe = "electronic-circuit" })
  util.add_effect("electronics", { type = "unlock-recipe", recipe = "inserter" })
  util.add_effect("electronics", { type = "unlock-recipe", recipe = "long-handed-inserter" })
  util.remove_recipe_effect("automation", "long-handed-inserter")
  util.set_enabled("electronic-circuit", false)
  util.set_enabled("inserter", false)
end
util.set_enabled("electric-mining-drill", true)


-- Must be last
util.create_list()
