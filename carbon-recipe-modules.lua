-- Enable prod modules for all recipes
local util = require("data-util");

recipes = {
  "graphite",
  "synthetic-diamond",

  "graphene",
  "heavy-water-graphene",
  "enriched-graphite",

  "fullerenes",
  "nanotubes",

  "diamond-synthesis-vulcanite",
  -- NOTE: Carbon black recipes do not allow prod modules
}

-- Add all *-nanotubes recipes that exist
local ending = "-nanotubes"
for i, recipe in pairs(data.raw.recipe) do
  if recipe.name:sub(-#ending) == ending then
    table.insert(recipes, recipe.name)
  end
end

for i, recipe in pairs(recipes) do
  if data.raw.recipe[recipe] then
    for j, module in pairs(data.raw.module) do
      if module.effect then
        for effect_name, effect in pairs(module.effect) do
          if effect_name == "productivity" and effect.bonus > 0 and module.limitation and #module.limitation > 0 then
            table.insert(module.limitation, recipe)
          end
        end
      end
    end
  end
end
