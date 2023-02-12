local util = require("data-util");

if mods["crafting-efficiency-2"] then

  local recipes = util.me.recipes
  local eff_data = {
    ["synthetic-diamond"] = {
        max = 15,
        icon =  data.raw.item["diamond"].icon,
        crafting = { efficiency = 10 },
        research = { level = 6 },
    },
    ["diamond-processing"] = {
        max = 15,
        icon =  data.raw.item["diamond"].icon,
        crafting = { efficiency = 10 },
        research = { level = 6 },
    },
  }

  for i, recipe in pairs(recipes) do
    -- add remaining recipes with direct items to find the icons
    if data.raw.recipe[recipe] and data.raw.item[recipe] and not eff_data[recipe] then
      local research_level = 1
	  if not data.raw.recipe[recipe].enabled then
		  for tech, tbl in pairs(data.raw.technology) do
			  for _, effect in pairs(tbl.effects or {}) do
				  if effect.type == "unlock-recipe" and effect.recipe == recipe then
					  research_level = math.min(#tbl.unit.ingredients, 6)
				  end
			  end
		  end
	  end
      eff_data[recipe] = {
        max = 15,
        icon = data.raw.item[recipe].icon,
        crafting = { efficiency = 10 },
        research = { level = research_level },
      }
    end
  end
  for recipe, d in pairs(eff_data) do 
    log("Adding "..recipe.." crafting efficiency")
    d.name = recipe:gsub("^%l", string.upper).." efficiency"
    CE_Add_Recipe(d, recipe)
  end
end
