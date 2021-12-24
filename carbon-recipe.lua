-- Graphite etc

local util = require("__bzcarbon__.data-util");

local graphite_category = "advanced-crafting"
if mods["space-exploration"] then
  graphite_category = "pulverising"
end
if mods.Krastorio2 then
  graphite_category = "crushing"
end

data:extend({
  { type = "recipe-category", name = "diamond-synthesis"},
})

data:extend({
  {
    type = "item",
    name = "graphite",
    icon = "__bzcarbon__/graphics/icons/graphite.png",
    icon_size = 128,
    pictures = {
      {filename="__bzcarbon__/graphics/icons/graphite.png", size=128, scale=0.125},
      {filename="__bzcarbon__/graphics/icons/graphite-1.png", size=128, scale=0.125},
      {filename="__bzcarbon__/graphics/icons/graphite-2.png", size=128, scale=0.125},
    },
    subgroup = "raw-material",
    order = "g[graphite]",
    stack_size = util.get_stack_size(100)
  },
  {
    type = "recipe",
    name = "graphite",
    category = graphite_category,
    order = "d[graphite]",
    icons = (mods["Krastorio2"] and
        {
          { icon = "__bzcarbon__/graphics/icons/graphite.png", icon_size = 128},
          { icon = "__bzcarbon__/graphics/icons/flake-graphite.png", icon_size = 64, icon_mipmaps = 3, scale=0.25, shift= {-8, -8}},
        } or nil),
    normal = (mods["Krastorio2"] and
        {
          enabled = false,
          energy_required = 5,
          ingredients = {{"flake-graphite", 10}},
          results = {{type="item", name= "graphite", amount=10}},
        } or
        {
          enabled = false,
          --energy_required = 128/45,
          energy_required = 0.5,
          ingredients = {{"flake-graphite", 1}},
          result = "graphite"
        }),
    expensive =
    {
      enabled = false,
      --energy_required = 256/45,
      energy_required = 1,
      ingredients = {{"flake-graphite", 2}},
      result = "graphite"
    }
  },
  {
    type = "technology",
    name = "graphite-processing",
    icon_size = 128,
    -- icon = "__bzcarbon__/graphics/technology/graphite-processing.png",
    icon = "__bzcarbon__/graphics/icons/graphite.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "graphite"
      },
    },
    unit =
    {
      count = 30,
      ingredients = 
          {
            {"automation-science-pack", 1},
          },
      time = 10,
    },
    prerequisites = {"automation"},
    order = "b-b"
  },


-- diamonds
  {
    type = "item",
    name = "diamond",
    icon = "__bzcarbon__/graphics/icons/diamond.png",
    icon_size = 128,
    subgroup = "raw-material",
    order = "g[diamond]",
    stack_size = util.get_stack_size(100)
  },
  {
    type = "recipe",
    name = "synthetic-diamond",
    category = "diamond-synthesis",
    order = "d[diamond]",
    icons = (mods["Krastorio2"] and
        {
          { icon = "__bzcarbon__/graphics/icons/diamond.png", icon_size = 128},
          { icon = "__bzcarbon__/graphics/icons/graphite-2.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
        } or nil),
    normal = (mods["Krastorio2"] and
        {
          enabled = false,
          energy_required = 20,
          ingredients = {{"graphite", 10}},
          results = {{type="item", name= "diamond", amount=1}},
        } or
        {
          enabled = false,
          energy_required = 20,
          ingredients = {{"graphite", 10}},
          result = "diamond"
        }),
    expensive =
    {
      enabled = false,
      energy_required = 30,
      ingredients = {{"graphite", 20}},
      result = "diamond"
    }
  },
  {
    type = "technology",
    name = "synthetic-diamond-processing",
    icon_size = 128,
    icon = "__bzcarbon__/graphics/icons/diamond.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "synthetic-diamond"
      },
    },
    unit =
    {
      count = 100,
      ingredients = 
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
          },
      time = 15,
    },
    prerequisites = {"chemical-science-pack"},
    order = "b-b"
  },

-- graphene
  {
    type = "item",
    name = "graphene",
    icon = "__bzcarbon__/graphics/icons/graphene.png",
    icon_size = 128,
    subgroup = "intermediate-product",
    order = "g[graphite]",
    stack_size = util.get_stack_size(200)
  },
  {
    type = "recipe",
    name = "graphene",
    category = "chemistry",
    order = "d[graphite]",
    enabled = false,
    energy_required = 6,
    ingredients = mods.Krastorio2 and {
      {type="item", name="graphite", amount=1},
      {type="fluid", name="ammonia", amount=5},
      {type="fluid", name="sulfuric-acid", amount=5},
    } or {
      {type="item", name="graphite", amount=1},
      {type="fluid", name="water", amount=10},
      {type="fluid", name="sulfuric-acid", amount=10},
    },
    result = "graphene"
  },
  {
    type = "technology",
    name = "graphene",
    icon_size = 128,
    icon = "__bzcarbon__/graphics/icons/graphene.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "graphene"
      },
    },
    unit =
    {
      count = 400,
      ingredients = mods["space-exploration"] and {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
          } or
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
          },
      time = 60,
    },
    prerequisites =  mods["space-exploration"] and {"chemical-science-pack"} or {"utility-science-pack"},
    order = "b-b"
  },
})

-- fullerenes
if util.me.use_fullerenes() then
function lds_recipe() 
  if mods.bztitanium then
    if mods.bzzirconium then
      return {
        {type="item", name="titanium-plate", amount=2},
        {type="item", name="nanotubes", amount=2},
        {type="item", name="plastic-bar", amount=2},
        {type="item", name="zirconia", amount=2},
        {type="item", name="diamond", amount=1},
      }
    end
    return {
      {type="item", name="titanium-plate", amount=2},
      {type="item", name="nanotubes", amount=5},
      {type="item", name="plastic-bar", amount=5},
      {type="item", name="diamond", amount=1},
    }
  elseif mods.bzzirconium then
    return {
      {type="item", name="zirconia", amount=5},
      {type="item", name="copper-plate", amount=5},
      {type="item", name="nanotubes", amount=5},
      {type="item", name="plastic-bar", amount=2},
      {type="item", name="diamond", amount=1},
    }
  else
    return {
      {type="item", name="copper-plate", amount=10},
      {type="item", name="nanotubes", amount=5},
      {type="item", name="plastic-bar", amount=5},
      {type="item", name="diamond", amount=1},
    }
  end
end

data:extend({
  {
    type = "item",
    name = "fullerenes",
    icon = "__bzcarbon__/graphics/icons/Fullerene.png",
    icon_size = 128,
    subgroup = "intermediate-product",
    order = "g[graphite-fullerenes]",
    stack_size = util.get_stack_size(200),
  },
  {
    type = "recipe",
    name = "fullerenes",
    category = "chemistry",
    order = "d[graphite-fullerenes]",
    enabled = false,
    energy_required = 1,
    ingredients = mods.Krastorio2 and
    {
      {type="item", name="graphite", amount=2},
      {type="fluid", name="nitrogen", amount=2},
    } or
    {
      {type="item", name="graphite", amount=2},
    },
    result = "fullerenes",
    result_count = 20,
  },
  {
    type = "technology",
    name = "fullerenes",
    icon_size = 128,
    icon = "__bzcarbon__/graphics/icons/Fullerene.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "fullerenes",
      },
    },
    unit =
    {
      count = 100,
      ingredients = {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
      },
      time = 60,
    },
    prerequisites = {"oil-processing", "chemical-science-pack"},
    order = "b-b"
  },
  -- nanotubes
  {
    type = "item",
    name = "nanotubes",
    icon = "__bzcarbon__/graphics/icons/nanotube.png",
    icon_size = 128,
    subgroup = "intermediate-product",
    order = "g[graphite-nanotubes]",
    stack_size = util.get_stack_size(200),
  },
  {
    type = "recipe",
    name = "nanotubes",
    icon = "__bzcarbon__/graphics/icons/nanotube.png",
    icon_size = 128,
    category = "chemistry",
    subgroup = "intermediate-product",
    order = "d[graphite-nanotubes]",
    enabled = false,
    energy_required = 20,
    ingredients = {
      {type="item", name="fullerenes", amount=1},
      {type="item", name="iron-plate", amount=1, catalyst_amount=1},
      {type="fluid", name="sulfuric-acid", amount=10, catalyst_amount=10},
    },
    results = {
      {type="item", name="nanotubes", amount=1},
      {type="item", name="iron-plate", amount=1, probability=0.95, catalyst_amount=1},
      {type="fluid", name="sulfuric-acid", amount=9, catalyst_amount=9},
      mods.Krastorio2 and {type="fluid", name="dirty-water", amount=1, catalyst_amount=1} or nil,
    },
  },
  {
    type = "recipe",
    name = "low-density-structure-nanotubes",
    icons = {
      { icon = "__base__/graphics/icons/low-density-structure.png", icon_size = 64, icon_mipmaps = 4},
      { icon = "__bzcarbon__/graphics/icons/nanotube.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
    },
    category = "advanced-crafting",
    order = "o[low-density-structure-nanotubes]",
    enabled = false,
    energy_required = 20,
    ingredients = lds_recipe(),
    result = "low-density-structure",
    result_count = 1,
  },
  {
    type = "technology",
    name = "nanotubes",
    icon_size = 128,
    icon = "__bzcarbon__/graphics/icons/nanotube.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "nanotubes",
      },
      {
        type = "unlock-recipe",
        recipe = "low-density-structure-nanotubes",
      },
    },
    unit =
    {
      count = 1000,
      ingredients = 
      (mods.Krastorio2 and not mods["space-exploration"] and
      {
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1},
            {"matter-tech-card", 1},
            {"advanced-tech-card", 1},
      }) or
      {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
            {"space-science-pack", 1},
      },
      time = 60,
    },
    prerequisites = {"space-science-pack"},
    order = "b-b"
  },
})
end

-- carbon black
if util.me.use_carbon_black() then
data:extend({
  {
    type = "item",
    name = "carbon-black",
    icon = "__bzcarbon__/graphics/icons/carbon-black.png",
    icon_size = 64,
    icon_mipmaps = 3,
    subgroup = "intermediate-product",
    order = "g[graphite-carbon-black]",
    stack_size = util.get_stack_size(100),
  },
  {
    type = "recipe",
    name = "carbon-black",
    category = "chemistry",
    order = "d[graphite-carbon-black]",
    enabled = false,
    energy_required = 1,
    ingredients = {
      {type="item", name="coal", amount=1},
    },
    result = "carbon-black",
    result_count = 1,
  },
  {
    type = "recipe",
    name = "graphite-carbon-black",
    icons = {
      { icon = "__bzcarbon__/graphics/icons/carbon-black.png", icon_size = 64, icon_mipmaps = 3},
      { icon = "__bzcarbon__/graphics/icons/graphite.png", icon_size = 128},
    },
    category = "chemistry",
    order = "d[graphite]",
    enabled = false,
    energy_required = 1,
    ingredients = {
      {type="item", name="carbon-black", amount=10},
    },
    result = "graphite",
    result_count = 1,
  },
})
end


