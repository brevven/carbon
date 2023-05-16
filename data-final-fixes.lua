require("carbon-recipe-final-stacking")
require("carbon-recipe-final-k2")
require("carbon-recipe-final-se")
require("carbon-recipe-final-rrr")
require("low-density-structure-nanotubes")
require("compatibility/vtkdeepcoremining")
require("carbon-recipe-modules") -- Should be last import, need in both updates and final-fixes

local util = require("data-util");


-- Green circuits in final fixes due to K2 shenanigans 
if mods.MDbobelectronics or mods.bobelectronics then
  util.replace_ingredient("basic-electronic-components", "coal", "graphite")
  util.replace_ingredient("basic-electronic-components", "coke", "graphite")
elseif not mods.pyhightech then
  amt_ec = util.get_amount("electronic-circuit")
  if amt_ec == 1 then
    util.multiply_recipe("electronic-circuit", 2)
    util.set_recipe_time("electronic-circuit-stone", 0.5) -- faster but more complex
  end
  util.replace_some_ingredient("electronic-circuit", "copper-cable", 2, "graphite", 1)
  -- AAI alternate green circuit
  local amt_ec = util.get_amount("electronic-circuit-stone", "electronic-circuit")
  if amt_ec == 1 then
    util.multiply_recipe("electronic-circuit-stone", 2)
    util.set_recipe_time("electronic-circuit-stone", 0.5) -- faster but more complex
  end
  util.replace_some_ingredient("electronic-circuit-stone", "copper-cable", 2, "graphite", 1)
end

if data.raw.recipe["low-density-structure"] and 
  not data.raw.recipe["low-density-structure"].icon and
  not data.raw.recipe["low-density-structure"].icons
  then
  -- final failsafe check, might no longer be necessary, needs testing with a lot of varied mod loadouts
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

if util.me.use_fiber() then
  util.remove_ingredient("low-density-structure", "plastic-bar")
  util.remove_ingredient("low-density-structure-nanotubes", "plastic-bar")
  util.remove_ingredient("se-low-density-structure-beryllium", "plastic-bar")
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

-- furnace recipe rework, remove crucible ingredients one more time
for i, furnace in pairs(util.me.furnaces) do
  for j, ingredient in pairs(util.me.crucible_ingredients)  do
    util.remove_ingredient(furnace, ingredient)
  end
end
util.remove_ingredient("electric-furnace", "cuw") -- support new tungsten

-- Vanilla burner phase tweaks -- green circuits after electronics
if not mods.Krastorio2 and not mods["aai-industry"] and not mods.bzaluminum and not mods.pyhightech then
  util.replace_ingredient("offshore-pump", "electronic-circuit", "copper-cable")
  util.replace_ingredient("lab", "electronic-circuit", "copper-cable")
  util.replace_ingredient("electric-mining-drill", "electronic-circuit", "copper-cable")
  util.replace_ingredient("assembling-machine-1", "electronic-circuit", "copper-plate")
  util.replace_ingredient("radar", "electronic-circuit", "copper-plate")
  util.replace_ingredient("splitter", "electronic-circuit", "copper-cable", 20)

  -- Keep repair pack raw ingredients the same:
  util.remove_ingredient("repair-pack", "electronic-circuit")
  util.add_ingredient("repair-pack", "copper-cable", 6)
  util.set_ingredient("repair-pack", "iron-gear-wheel", 3)

  util.add_effect("electronics", { type = "unlock-recipe", recipe = "electronic-circuit" })
  util.add_effect("electronics", { type = "unlock-recipe", recipe = "inserter" })
  util.add_effect("electronics", { type = "unlock-recipe", recipe = "long-handed-inserter" })
  util.remove_recipe_effect("automation", "long-handed-inserter")
  util.set_enabled("electronic-circuit", false)
  util.set_enabled("inserter", false)
  util.add_prerequisite("logistic-science-pack", "electronics")
end

if not mods["aai-industry"] then
  if not mods.Krastorio2 then
    util.set_enabled("electric-mining-drill", true)
  end
end


if mods["aai-industry"] then
  -- AAI Industry now unlocks steam much later. Move it to an earlier sensible location in the tech tree.
  util.set_prerequisite("steam-power", {"basic-fluid-handling"})
  util.set_tech_recipe("steam-power", {{"automation-science-pack", 1}})
end

util.add_prerequisite("nanobots", "electronics")

if not mods.bzaluminum then
  util.replace_ingredients_prior_to("electronics", "electronic-circuit", "copper-cable", 2)
end

if mods.modmashsplintersubspacelogistics then
  for i, item in pairs({"graphite", "diamond"}) do
    if data.raw.item["super-container-for-"..item] then
      for i, icon in pairs(data.raw.item["super-container-for-"..item].icons) do
        log(serpent.dump(icon))
        if string.find(icon.icon, item) then
          icon.size = 128
          icon.scale = icon.scale / 2
          icon.icon_scale = icon.icon_scale / 2
        end
      end
    end
    if data.raw.recipe["super-container-for-"..item] then
      for i, icon in pairs(data.raw.recipe["super-container-for-"..item].icons) do
        if string.find(icon.icon, item) then
          icon.size = 128
          icon.scale = icon.scale / 4
          icon.icon_scale = icon.icon_scale / 4
        end
      end
    end
    if data.raw.recipe["empty-super-container-of-"..item] then
      for i, icon in pairs(data.raw.recipe["empty-super-container-of-"..item].icons) do
        if string.find(icon.icon, item) then
          icon.size = 128
          icon.scale = icon.scale / 4
          icon.icon_scale = icon.icon_scale / 4
        end
      end
    end
    for i, technology in pairs(data.raw.technology) do
      log(technology.name)
      if string.find(technology.name, "containment") then
        if technology.icons then
          for j, icon in pairs(technology.icons) do
            if string.find(icon.icon, item) then
              icon.size = 128
              icon.scale = icon.scale / 8
              icon.icon_scale = icon.icon_scale / 8
            end
          end
        end
      end
    end
  end
end

-- Must be last
util.create_list()
