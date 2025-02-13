require("carbon-recipe-final-stacking")
require("carbon-recipe-final-k2")
require("carbon-recipe-final-se")
require("carbon-recipe-final-rrr")
require("nanotubes-final")
require("compatibility.vtkdeepcoremining")
require("compatibility.any-planet-start")

local futil = require("util")
local util = require("data-util");

util.add_minable_result("simple-entity", "huge-volcanic-rock", {type="item", name="flake-graphite", amount_min=10, amount_max=24})
util.add_minable_result("simple-entity", "big-volcanic-rock", {type="item", name="rough-diamond", amount_min=5, amount_max=10})

util.set_localised_name("low-density-structure", {"item-name.low-density-structure"})

-- supercapacitors with graphene cloned from supercapacitors with activated carbon
if data.raw.recipe["supercapacitor"] then
  local new_recipe = futil.table.deepcopy(data.raw.recipe["supercapacitor"])
  new_recipe.name = new_recipe.name.."-graphene"
  new_recipe.localised_name = {"item-name.supercapacitor"}
  new_recipe.icons = {
      { icon = data.raw.item["supercapacitor"].icon, icon_size = data.raw.item["supercapacitor"].icon_size},
      { icon = "__bzcarbon__/graphics/icons/graphene.png", icon_size = 128, scale=0.125, shift= {-8, -8}, tint={1,1,1}},
    }
  new_recipe.icon = nil
  new_recipe.icon_size = nil
  data:extend({new_recipe})
  util.replace_ingredient(new_recipe.name, "activated-carbon", "graphene", 1)
  util.add_unlock("electromagnetic-plant", new_recipe.name)
end


-- Green circuits in final fixes due to K2 shenanigans 
if mods.MDbobelectronics or mods.bobelectronics then
  util.replace_ingredient("basic-electronic-components", "coal", "graphite")
  util.replace_ingredient("basic-electronic-components", "coke", "graphite")
else
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
  if not mods["space-age"] then
    util.remove_ingredient("low-density-structure", "plastic-bar")
    util.remove_ingredient("low-density-structure-nanotubes", "plastic-bar")
    util.remove_ingredient("se-low-density-structure-beryllium", "plastic-bar")
  end
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
if not mods.Krastorio2 and not mods["aai-industry"] and not mods.bzaluminum then
  util.replace_ingredient("electric-mining-drill", "electronic-circuit", "copper-cable", 6)

  -- Most of this can go post 2.0
  -- util.replace_ingredient("offshore-pump", "electronic-circuit", "copper-cable")
  -- util.replace_ingredient("lab", "electronic-circuit", "copper-cable")
  -- util.replace_ingredient("assembling-machine-1", "electronic-circuit", "copper-plate")
  -- util.replace_ingredient("radar", "electronic-circuit", "copper-plate")
  -- util.replace_ingredient("splitter", "electronic-circuit", "copper-cable", 20)

  -- Keep repair pack raw ingredients the same:
  -- util.remove_ingredient("repair-pack", "electronic-circuit")
  -- util.add_ingredient("repair-pack", "copper-cable", 6)
  -- util.set_ingredient("repair-pack", "iron-gear-wheel", 3)

  -- util.add_effect("electronics", { type = "unlock-recipe", recipe = "electronic-circuit" })
  -- util.add_effect("electronics", { type = "unlock-recipe", recipe = "inserter" })
  -- util.add_effect("electronics", { type = "unlock-recipe", recipe = "long-handed-inserter" })
  -- util.remove_recipe_effect("automation", "long-handed-inserter")
  -- util.set_enabled("electronic-circuit", false)
  -- util.set_enabled("inserter", false)
  -- util.add_prerequisite("logistic-science-pack", "electronics")
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
util.redo_recycling()
util.size_recycler_output()
util.use_fluid_mining_final()

-- Must be last
util.create_list()
