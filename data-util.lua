-- WARNING WARNING WARNING
-- This file will be overwritten in mod zipfiles, edit bzlib/data-util.lua
-- WARNING WARNING WARNING

local me = require("me")
local util = {}

util.me = me
util.get_setting = util.me.get_setting

util.titanium_plate = ""
util.titanium_processing = ""

if mods["FactorioExtended-Plus-Core"] then
  util.titanium_plate = "titanium-alloy"
else
  util.titanium_plate = "titanium-plate"
end

if mods["pyrawores"] then 
  util.titanium_processing = "titanium-mk01"
else
  util.titanium_processing = "titanium-processing"
end

function util.fe_plus(sub)
  if mods["FactorioExtended-Plus-"..sub] then
    return true
  end
end

function util.get_stack_size(default) 
  if mods["Krastorio2"] then
    size = tonumber(krastorio.general.getSafeSettingValue("kr-stack-size"))
    return size or default
  end
  return default
end

function util.k2assets() 
  if mods["Krastorio2Assets"] then
    return "__Krastorio2Assets__"
  end
  return "__Krastorio2__/graphics"
end

-- check if a table contains a sought value
function util.contains(table, sought)
  for i, value in pairs(table) do
    if value == sought then
      return true
    end
  end
  return false
end

-- Set/override a technology's prerequisites
function util.set_prerequisite(technology_name, prerequisites)
  local technology = data.raw.technology[technology_name]
  if technology then
    technology.prerequisites = {}
    for i, prerequisite in pairs(prerequisites) do
      if data.raw.technology[prerequisite] then
        table.insert(technology.prerequisites, prerequisite)
      end
    end
  end
end

-- Add a prerequisite to a given technology
function util.add_prerequisite(technology_name, prerequisite)
  local technology = data.raw.technology[technology_name]
  if technology and data.raw.technology[prerequisite] then
    if technology.prerequisites then
      table.insert(technology.prerequisites, prerequisite)
    else
      technology.prerequisites = {prerequisite}
    end
  end
end

-- Remove a prerequisite from a given technology
function util.remove_prerequisite(technology_name, prerequisite)
  local technology = data.raw.technology[technology_name]
  local index = -1
  if technology then
    for i, prereq in pairs(technology.prerequisites) do
      if prereq == prerequisite then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(technology.prerequisites, index)
    end
  end
end


-- Add an effect to a given technology
function util.add_effect(technology_name, effect)
  local technology = data.raw.technology[technology_name]
  if technology then
    if not technology.effects then technology.effects = {} end
    if effect and effect.type == "unlock-recipe" then
      if not data.raw.recipe[effect.recipe] then
        return
      end
      table.insert(technology.effects, effect)
    end
  end
end

-- Add an effect to a given technology to unlock recipe
function util.add_unlock(technology_name, recipe)
  util.add_effect(technology_name, {type="unlock-recipe", recipe=recipe})
end

-- remove recipe unlock effect from a given technology
function util.remove_recipe_effect(technology_name, recipe_name)
  local technology = data.raw.technology[technology_name]
  local index = -1
  if technology and technology.effects then
    for i, effect in pairs(technology.effects) do
      if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(technology.effects, index)
    end
  end
end

-- Set technology ingredients
function util.set_tech_recipe(technology_name, ingredients)
  local technology = data.raw.technology[technology_name]
  if technology then
    technology.unit.ingredients = ingredients
  end
end

function util.set_enabled(recipe_name, enabled)
  if data.raw.recipe[recipe_name] then
    if data.raw.recipe[recipe_name].normal then data.raw.recipe[recipe_name].normal.enabled = enabled end
    if data.raw.recipe[recipe_name].expensive then data.raw.recipe[recipe_name].expensive.enabled = enabled end
    if not data.raw.recipe[recipe_name].normal then data.raw.recipe[recipe_name].enabled = enabled end
  end
end

function util.set_hidden(recipe_name)
  if data.raw.recipe[recipe_name] then
    if data.raw.recipe[recipe_name].normal then data.raw.recipe[recipe_name].normal.hidden = true end
    if data.raw.recipe[recipe_name].expensive then data.raw.recipe[recipe_name].expensive.hidden = true end
    if not data.raw.recipe[recipe_name].normal then data.raw.recipe[recipe_name].hidden = true end
  end
end

-- Add a given quantity of ingredient to a given recipe
function util.add_or_add_to_ingredient(recipe_name, ingredient, quantity)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and data.raw.item[ingredient] then
    me.add_modified(recipe_name)
    add_or_add_to_ingredient(data.raw.recipe[recipe_name], ingredient, quantity)
    add_or_add_to_ingredient(data.raw.recipe[recipe_name].normal, ingredient, quantity)
    add_or_add_to_ingredient(data.raw.recipe[recipe_name].expensive, ingredient, quantity)
  end
end

function add_or_add_to_ingredient(recipe, ingredient, quantity)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == ingredient or existing.name == ingredient then
        add_to_ingredient(recipe, ingredient, quantity)
        return
      end
    end
    table.insert(recipe.ingredients, {ingredient, quantity})
  end
end

-- Add a given quantity of ingredient to a given recipe
function util.add_ingredient(recipe_name, ingredient, quantity)
  if me.bypass[recipe_name] then return end
  local is_fluid = not not data.raw.fluid[ingredient]
  if data.raw.recipe[recipe_name] and (data.raw.item[ingredient] or is_fluid) then
    me.add_modified(recipe_name)
    add_ingredient(data.raw.recipe[recipe_name], ingredient, quantity, is_fluid)
    add_ingredient(data.raw.recipe[recipe_name].normal, ingredient, quantity, is_fluid)
    add_ingredient(data.raw.recipe[recipe_name].expensive, ingredient, quantity, is_fluid)
  end
end

function add_ingredient(recipe, ingredient, quantity, is_fluid)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == ingredient or existing.name == ingredient then
        return
      end
    end
    if is_fluid then
      table.insert(recipe.ingredients, {type="fluid", name=ingredient, amount=quantity})
    else
      table.insert(recipe.ingredients, {ingredient, quantity})
    end
  end
end

-- Add a given ingredient prototype to a given recipe
function util.add_ingredient_raw(recipe_name, ingredient)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and (data.raw.item[ingredient.name] or data.raw.item[ingredient[1]]) then
    me.add_modified(recipe_name)
    add_ingredient_raw(data.raw.recipe[recipe_name], ingredient)
    add_ingredient_raw(data.raw.recipe[recipe_name].normal, ingredient)
    add_ingredient_raw(data.raw.recipe[recipe_name].expensive, ingredient)
  end
end

function add_ingredient_raw(recipe, ingredient)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if (
          (existing[1] and (existing[1] == ingredient[1] or existing[1] == ingredient.name)) or 
          (existing.name and (existing.name == ingredient[1] or existing.name == ingredient.name))
      ) then
        return
      end
    end
    table.insert(recipe.ingredients, ingredient)
  end
end

-- Set an ingredient to a given quantity
function util.set_ingredient(recipe_name, ingredient, quantity)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and data.raw.item[ingredient] then
    me.add_modified(recipe_name)
    set_ingredient(data.raw.recipe[recipe_name], ingredient, quantity)
    set_ingredient(data.raw.recipe[recipe_name].normal, ingredient, quantity)
    set_ingredient(data.raw.recipe[recipe_name].expensive, ingredient, quantity)
  end
end

function set_ingredient(recipe, ingredient, quantity)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == ingredient  then
        existing[2] = quantity
        return
      elseif existing.name == ingredient then
        existing.amount = quantity
        existing.amount_min = nil
        existing.amount_max = nil
        return
      end
    end
    table.insert(recipe.ingredients, {ingredient, quantity})
  end
end
-- Add a given quantity of product to a given recipe. 
-- Only works for recipes with multiple products
function util.add_product(recipe_name, product)
  if data.raw.recipe[recipe_name] and (data.raw.item[product[1]] or data.raw.item[product.name]) then
    add_product(data.raw.recipe[recipe_name], product)
    add_product(data.raw.recipe[recipe_name].normal, product)
    add_product(data.raw.recipe[recipe_name].expensive, product)
  end
end

function add_product(recipe, product)
  if recipe ~= nil then
    if not recipe.normal then
      if recipe.results == nil then
        recipe.results = {{recipe.result, recipe.result_count and recipe.result_count or 1}}
      end
      recipe.result = nil
      recipe.result_count = nil
      table.insert(recipe.results, product)
    end
  end
end

-- Get the amount of the ingredient, will check base/normal not expensive
function util.get_ingredient_amount(recipe_name, ingredient_name)
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    if recipe.normal and recipe.normal.ingredients then
      for i, ingredient in pairs(recipe.normal.ingredients) do
        if ingredient[1] == ingredient_name then return ingredient[2] end
        if ingredient.name == ingredient_name then return ingredient.amount end
      end
    elseif recipe.ingredients then
      for i, ingredient in pairs(recipe.ingredients) do
        if ingredient[1] == ingredient_name then return ingredient[2] end
        if ingredient.name == ingredient_name then return ingredient.amount end
      end
    end
    return 1
  end
  return 0
end

-- Get the amount of the result, will check base/normal not expensive
function util.get_amount(recipe_name, product)
  if not product then product = recipe_name end
  local recipe = data.raw.recipe[recipe_name]
  if recipe then
    if recipe.normal and recipe.normal.results then
      for i, result in pairs(recipe.normal.results) do
        if result[1] == product then return result[2] end
        if result.name == product then return result.amount end
      end
    elseif recipe.normal and recipe.normal.result_count then
      return recipe.normal.result_count
    elseif recipe.results then
      for i, result in pairs(recipe.results) do
        if result[1] == product then return result[2] end
        if result.name == product then return result.amount end
      end
    elseif recipe.result_count then
      return recipe.result_count
    end
    return 1
  end
  return 0
end

-- Replace one ingredient with another in a recipe
function util.replace_ingredient(recipe_name, old, new, amount)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and (data.raw.item[new] or data.raw.fluid[new]) then
    me.add_modified(recipe_name)
    replace_ingredient(data.raw.recipe[recipe_name], old, new, amount)
    replace_ingredient(data.raw.recipe[recipe_name].normal, old, new, amount)
    replace_ingredient(data.raw.recipe[recipe_name].expensive, old, new, amount)
  end
end

function replace_ingredient(recipe, old, new, amount)
	if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == new or existing.name == new then
        return
      end
    end
		for i, ingredient in pairs(recipe.ingredients) do 
			if ingredient.name == old then 
        ingredient.name = new 
        if amount then ingredient.amount = amount end
      end
			if ingredient[1] == old then 
        ingredient[1] = new
        if amount then ingredient[2] = amount end
      end
		end
	end
end

-- Remove an ingredient from a recipe
function util.remove_ingredient(recipe_name, old)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    remove_ingredient(data.raw.recipe[recipe_name], old)
    remove_ingredient(data.raw.recipe[recipe_name].normal, old)
    remove_ingredient(data.raw.recipe[recipe_name].expensive, old)
  end
end

function remove_ingredient(recipe, old)
  index = -1
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, ingredient in pairs(recipe.ingredients) do 
      if ingredient.name == old or ingredient[1] == old then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(recipe.ingredients, index)
    end
  end
end

-- Replace an amount of an ingredient in a recipe. Keep at least 1 of old.
function util.replace_some_ingredient(recipe_name, old, old_amount, new, new_amount)
  if me.bypass[recipe_name] then return end
  local is_fluid = not not data.raw.fluid[new]
  if data.raw.recipe[recipe_name] and (data.raw.item[new] or is_fluid) then
    me.add_modified(recipe_name)
    replace_some_ingredient(data.raw.recipe[recipe_name], old, old_amount, new, new_amount, is_fluid)
    replace_some_ingredient(data.raw.recipe[recipe_name].normal, old, old_amount, new, new_amount, is_fluid)
    replace_some_ingredient(data.raw.recipe[recipe_name].expensive, old, old_amount, new, new_amount, is_fluid)
  end
end

function replace_some_ingredient(recipe, old, old_amount, new, new_amount, is_fluid)
	if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == new or existing.name == new then
        return
      end
    end
		for i, ingredient in pairs(recipe.ingredients) do 
			if ingredient.name == old then
        ingredient.amount = math.max(1, ingredient.amount - old_amount)
      end
			if ingredient[1] == old then
        ingredient[2] = math.max(1, ingredient[2] - old_amount)
      end
		end
    add_ingredient(recipe, new, new_amount, is_fluid)
	end
end

-- set the amount of a product. 
function util.set_product_amount(recipe_name, product, amount)
  me.add_modified(recipe_name)
  if data.raw.recipe[recipe_name] then
    if me.bypass[recipe_name] then return end
    set_product_amount(data.raw.recipe[recipe_name], product, amount)
    set_product_amount(data.raw.recipe[recipe_name].normal, product, amount)
    set_product_amount(data.raw.recipe[recipe_name].expensive, product, amount)
	end
end

function set_product_amount(recipe, product, amount)
  if recipe then
    if recipe.result_count then
      recipe.result_count = amount
    end
    if recipe.results then
      for i, result in pairs(recipe.results) do
        if result.name == product then
          if result.amount then
            result.amount = amount
          end
          if result.amount_min ~= nil then
            result.amount_min =  nil
            result.amount_max =  nil
            result.amount = amount
          end
        end
        if result[1] == product then
          result[2] = amount
        end
      end
    end
    if not recipe.results and not recipe.result_count then
      -- implicit one item result
      recipe.result_count = amount
    end
  end
end

-- multiply the cost, energy, and results of a recipe by a multiple
function util.multiply_recipe(recipe_name, multiple)
  me.add_modified(recipe_name)
  if data.raw.recipe[recipe_name] then
    if me.bypass[recipe_name] then return end
    multiply_recipe(data.raw.recipe[recipe_name], multiple)
    multiply_recipe(data.raw.recipe[recipe_name].normal, multiple)
    multiply_recipe(data.raw.recipe[recipe_name].expensive, multiple)
	end
end

function multiply_recipe(recipe, multiple)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required * multiple
    end
    if recipe.result_count then
      recipe.result_count = recipe.result_count * multiple
    end
    if recipe.results then
      for i, result in pairs(recipe.results) do
        if result.name then
          if result.amount then
            result.amount = result.amount * multiple
          end
          if result.amount_min ~= nil then
            result.amount_min = result.amount_min * multiple
            result.amount_max = result.amount_max * multiple
          end
          if result.catalyst_amount then
            result.catalyst_amount = result.catalyst_amount * multiple
          end
        end
        if result[1] then
          result[2] = result[2] * multiple
        end
      end
    end
    if not recipe.results and not recipe.result_count then
      -- implicit one item result
      recipe.result_count = multiple
    end
    if recipe.ingredients then
      for i, ingredient in pairs(recipe.ingredients) do
        if ingredient.name then
          ingredient.amount = ingredient.amount * multiple
        end
        if ingredient[1] then
          ingredient[2] = ingredient[2] * multiple
        end
      end
    end
  end
end

-- Returns true if a recipe has an ingredient
function util.has_ingredient(recipe_name, ingredient)
  return data.raw.recipe[recipe_name] and (
        has_ingredient(data.raw.recipe[recipe_name], ingredient) or
        has_ingredient(data.raw.recipe[recipe_name].normal, ingredient))
end

function has_ingredient(recipe, ingredient)
  if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing[1] == ingredient or existing.name == ingredient then
        return true
      end
    end
  end
  return false
end

-- Remove a product from a recipe, WILL NOT remove the only product
function util.remove_product(recipe_name, old)
  me.add_modified(recipe_name)
  if data.raw.recipe[recipe_name] then
    if me.bypass[recipe_name] then return end
    remove_product(data.raw.recipe[recipe_name], old)
    remove_product(data.raw.recipe[recipe_name].normal, old)
    remove_product(data.raw.recipe[recipe_name].expensive, old)
  end
end

function remove_product(recipe, old)
  index = -1
	if recipe ~= nil and recipe.results ~= nil then
		for i, result in pairs(recipe.results) do 
      if result.name == old or result[1] == old then
        index = i
        break
      end
    end
    if index > -1 then
      table.remove(recipe.results, index)
    end
  end
end

function util.set_main_product(recipe_name, product)
  if data.raw.recipe[recipe_name] then
    set_main_product(data.raw.recipe[recipe_name], product)
    set_main_product(data.raw.recipe[recipe_name].normal, product)
    set_main_product(data.raw.recipe[recipe_name].expensive, product)
  end
end

function set_main_product(recipe, product)
  if recipe then
    recipe.main_product = product
  end
end

-- Replace one product with another in a recipe
function util.replace_product(recipe_name, old, new)
  if data.raw.recipe[recipe_name] then
    replace_product(data.raw.recipe[recipe_name], old, new)
    replace_product(data.raw.recipe[recipe_name].normal, old, new)
    replace_product(data.raw.recipe[recipe_name].expensive, old, new)
  end
end

function replace_product(recipe, old, new)
  if recipe then
    if recipe.main_product == old then
      recipe.main_product = new
    end
    if recipe.result == old then
      recipe.result = new
      return
    end
    if recipe.results then
      for i, result in pairs(recipe.results) do
        if result.name == old then result.name = new end
        if result[1] == old then result[1] = new end
      end
    end
  end
end

-- Remove an element of type t and name from data.raw
function util.remove_raw(t, name)
  if not data.raw[t] then 
    log(t.." not found in data.raw")
    return
  end
  if data.raw[t][name] then
    for i, elem in pairs(data.raw[t]) do
      if elem.name == name then 
        data.raw[t][i] = nil
        break
      end
    end
  end
end

-- Set energy required
function util.set_recipe_time(recipe_name, time)
  me.add_modified(recipe_name)
  if data.raw.recipe[recipe_name] then
    if me.bypass[recipe_name] then return end
    set_recipe_time(data.raw.recipe[recipe_name], time)
    set_recipe_time(data.raw.recipe[recipe_name].normal, time)
    set_recipe_time(data.raw.recipe[recipe_name].expensive, time)
	end
end

function set_recipe_time(recipe, time)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = time
    end
  end
end

-- Multiply energy required
function util.multiply_time(recipe_name, factor)
  me.add_modified(recipe_name)
  if data.raw.recipe[recipe_name] then
    if me.bypass[recipe_name] then return end
    multiply_time(data.raw.recipe[recipe_name], factor)
    multiply_time(data.raw.recipe[recipe_name].normal, factor)
    multiply_time(data.raw.recipe[recipe_name].expensive, factor)
	end
end

function multiply_time(recipe, factor)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required * factor
    end
  end
end

-- Add to energy required
function util.add_time(recipe_name, amount)
  me.add_modified(recipe_name)
  if data.raw.recipe[recipe_name] then
    if me.bypass[recipe_name] then return end
    add_time(data.raw.recipe[recipe_name], amount)
    add_time(data.raw.recipe[recipe_name].normal, amount)
    add_time(data.raw.recipe[recipe_name].expensive, amount)
	end
end

function add_time(recipe, amount)
  if recipe then
    if recipe.energy_required then
      recipe.energy_required = recipe.energy_required + amount
    end
  end
end

-- Set recipe category
function util.set_category(recipe_name, category)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] and data.raw["recipe-category"][category] then
    me.add_modified(recipe_name)
    data.raw.recipe[recipe_name].category = category
  end
end

-- Set recipe subgroup
function util.set_subgroup(recipe_name, subgroup)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    data.raw.recipe[recipe_name].subgroup = subgroup
  end
end

-- Set item subgroup
function util.set_item_subgroup(item, subgroup)
  if me.bypass[item] then return end
  if data.raw.item[item] and data.raw["item-subgroup"][subgroup] then
    data.raw.item[item].subgroup = subgroup
  end
end

-- Set recipe icons
function util.set_icons(recipe_name, icons)
  if me.bypass[recipe_name] then return end
  if data.raw.recipe[recipe_name] then
    me.add_modified(recipe_name)
    data.raw.recipe[recipe_name].icons = icons
    data.raw.recipe[recipe_name].icon = nil
    data.raw.recipe[recipe_name].icon_size = nil
  end
end

-- Set recipe icons
function util.set_item_icons(item_name, icons)
  if data.raw.item[item_name] then
    data.raw.item[item_name].icons = icons
    data.raw.item[item_name].icon = nil
    data.raw.item[item_name].icon_size = nil
  end
end

function util.set_to_founding(recipe)
  util.set_category(recipe, "founding")
  util.set_subgroup(recipe, "foundry-intermediate")
end

-- Add crafting category to an entity
function util.add_crafting_category(entity_type, entity, category)
   if data.raw[entity_type][entity] and data.raw["recipe-category"][category] then
      for i, existing in pairs(data.raw[entity_type][entity].crafting_categories) do
        if existing == category then
          return
        end
      end
      table.insert(data.raw[entity_type][entity].crafting_categories, category)
   end
end

function util.add_to_ingredient(recipe, ingredient, amount)
  if data.raw.recipe[recipe] then
    add_to_ingredient(data.raw.recipe[recipe], ingredient, amount)
    add_to_ingredient(data.raw.recipe[recipe].normal, ingredient, amount)
    add_to_ingredient(data.raw.recipe[recipe].expensive, ingredient, amount)
  end
end

function add_to_ingredient(recipe, it, amount)
	if recipe ~= nil and recipe.ingredients ~= nil then
		for i, ingredient in pairs(recipe.ingredients) do
			if ingredient.name == it then
        ingredient.amount = ingredient.amount + amount
        return
      end
			if ingredient[1] == it then
        ingredient[2] = ingredient[2] + amount
        return
      end
		end
	end
end

function util.add_to_product(recipe, product, amount)
  if data.raw.recipe[recipe] then
    add_to_product(data.raw.recipe[recipe], product, amount)
    add_to_product(data.raw.recipe[recipe].normal, product, amount)
    add_to_product(data.raw.recipe[recipe].expensive, product, amount)
  end
end

function add_to_product(recipe, product, amount)
  if recipe ~= nil and recipe.results ~= nil then
    if recipe.result == product then
      recipe.result_count = recipe.result_count + amount
      return
    end
    for i, result in pairs(recipe.results) do
			if result.name == product then
        result.amount = result.amount + amount
        return
      end
			if result[1] == product then
        result[2] = result[2] + amount
        return
      end
    end
  end
end

-- Adds a result to a mineable type
function util.add_minable_result(t, name, result)
  if data.raw[t] and data.raw[t][name] and data.raw[t][name].minable then
    if data.raw[t][name].minable.result and not data.raw[t][name].minable.results then
      data.raw[t][name].minable.results = {
        {data.raw[t][name].minable.result ,data.raw[t][name].minable.count}}
      data.raw[t][name].minable.result = nil
      data.raw[t][name].minable.result_count = nil
    end
    if data.raw[t][name].minable.results then
      table.insert(data.raw[t][name].minable.results, result)
    end
  end
end


local function insert(nodes, node, value)
    table.insert(node, value) -- store as parameter
    if 21 == #node then
        node = {""}
        table.insert(nodes, node)
    end
    return node
end

local function encode(data)
    local node = {""}
    local root = {node}
    local n = string.len(data)
    for i = 1,n,200 do
        local value = string.sub(data, i, i+199)
        node = insert(root, node, value)
    end
    while #root > 20 do
        local nodes,node = {},{""}
        for _, value in ipairs(root) do
            node = insert(nodes, node, value)
        end
        root = nodes
    end
    if #root == 1 then root = root[1] else
        table.insert(root, 1, "") -- no locale template
    end
    return #root < 3 and (root[2] or "") or root
end

function decode(data)
    if type(data) == "string" then return data end
    local str = {}
    for i = 2, #data do
        str[i-1] = decode(data[i])
    end
    return table.concat(str, "")
end

function util.create_list()
  if #me.list>0 then
    if not data.raw.item[me.name.."-list"] then
      data:extend({{
        type="item",
        name=me.name.."-list",
        localised_description = "",
        enabled=false,
        icon = "__core__/graphics/empty.png",
        icon_size = 1,
        stack_size = 1,
        flags = {"hidden", "hide-from-bonus-gui"}
      }})
    end

    local have = {}
    local list = {}
    for i, recipe in pairs(me.list) do
      if not have[recipe] then
        have[recipe] = true
        table.insert(list, recipe)
      end
    end

    if #list>0 then
      data.raw.item[me.name.."-list"].localised_description = 
        encode(decode(data.raw.item[me.name.."-list"].localised_description).."\n"..table.concat(list, "\n"))
    end
  end
end

return util
