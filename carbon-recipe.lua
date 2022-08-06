local util = require("data-util");

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
          energy_required = 0.5,
          ingredients = {{"flake-graphite", 1}},
          result = "graphite"
        }),
    expensive =
    {
      enabled = false,
      energy_required = 1,
      ingredients = {{"flake-graphite", 2}},
      result = "graphite"
    }
  },
  {
    type = "technology",
    name = "graphite-processing",
    icon_size = 128,
    icon = "__bzcarbon__/graphics/icons/graphite.png",
    effects = {},
    unit =
    {
      count = 30,
      ingredients = 
          {
            {"automation-science-pack", 1},
          },
      time = 10,
    },
    prerequisites = {},
    order = "b-b"
  },
})

-- If no graphite ore, make it from coal or coke
if not util.me.use_flake_graphite() then
  if data.raw.item["coke"] then
    data:extend({
      {
        type = "recipe",
        name = "graphite",
        icon = "__bzcarbon__/graphics/icons/graphite.png", icon_size=128,
        category = mods.bzfoundry and "founding" or "advanced-crafting",
        order = "d[graphite]",
        enabled = false,
        energy_required = 0.5,
        ingredients = {{"coke", 1}},
        results = {{"graphite", 2}},
      }
    })
  else
    data:extend({
      {
        type = "recipe",
        name = "graphite",
        icon = "__bzcarbon__/graphics/icons/graphite.png", icon_size=128,
        category = mods.bzfoundry and "founding" or "advanced-crafting",
        subgroup = data.raw.item.graphite.subgroup,
        order = "d[graphite]",
        enabled = false,
        energy_required = 0.5,
        ingredients = {{"coal", 1}},
        results = {{"graphite", 1}, {type="item", name="stone", amount=1, probability=0.05}},
      }
    })
  end
  util.add_prerequisite("graphite-processing", "foundry")

  -- Increase richness of coal a bit
  local noise = require('noise');
  data.raw.resource["coal"].autoplace.richness_expression = 
      data.raw.resource["coal"].autoplace.richness_expression * noise.to_noise_expression(1.5)
end




if mods.Krastorio2 then
  util.add_prerequisite("graphite-processing", "kr-crusher")
else
  util.add_prerequisite("graphite-processing", "automation")
end



if mods["space-exploration"] and not mods.Krastorio2 then
data:extend({
  {
    type = "recipe",
    name = "graphite-se",
    category = "advanced-crafting",
    order = "d[graphite]",
    enabled = false,
    energy_required = 0.5,
    ingredients = {{"flake-graphite", 2}},
    result = "graphite"
  }
})
util.add_effect("graphite-processing", { type = "unlock-recipe", recipe = "graphite-se" })
util.add_effect("se-pulveriser", { type = "unlock-recipe", recipe = "graphite" })
else
util.add_effect("graphite-processing", { type = "unlock-recipe", recipe = "graphite" })
end

if mods["5dim_resources"] then
data:extend({
  {
    type = "recipe",
    name = "graphite-5d",
    category = "mashering",
    order = "d[graphite]",
    enabled = true,
    energy_required = 0.5,
    ingredients = {{"flake-graphite", 1}},
    results = {{"graphite", 2}},
  }
})
end

-- diamonds
data:extend({
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
  util.me.use_rough_diamond() and {
    type = "recipe",
    name = "diamond-processing",
    category = "advanced-crafting",
    subgroup = "raw-material",
    order = "d[diamond]",
    icons = (mods["Krastorio2"] and
        {
          { icon = "__bzcarbon__/graphics/icons/diamond.png", icon_size = 128},
          { icon = "__bzcarbon__/graphics/icons/rough-diamond.png", icon_size = 64, scale=0.25, shift= {-8, -8}},
        } or  {{ icon = "__bzcarbon__/graphics/icons/diamond.png", icon_size = 128}}),
    normal = (mods["Krastorio2"] and
        {
          enabled = false,
          energy_required = 20,
          ingredients = {{"rough-diamond", 1}},
          results = {
            {type="item", name= "diamond", amount=1, probability=0.8},
            {type="item", name= "stone", amount=1, probability=0.2}
          },
        } or
        {
          enabled = false,
          energy_required = 20,
          ingredients = {{"rough-diamond", 1}},
          results = {
            {type="item", name= "diamond", amount=1, probability=0.8},
            {type="item", name= "stone", amount=1, probability=0.2}
          },
        }),
    expensive =
    {
      enabled = false,
      energy_required = 40,
      ingredients = {{"rough-diamond", 1}},
      result = "diamond"
    }
  } or nil,
})
data:extend({
  {
    type = "technology",
    name = "diamond-processing",
    icon_size = 128,
    icon = "__bzcarbon__/graphics/icons/diamond.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "synthetic-diamond"
      },
      util.me.use_rough_diamond() and {
        type = "unlock-recipe",
        recipe = "diamond-processing"
      } or nil,
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
    prerequisites = {"advanced-material-processing-2"},
    order = "b-b"
  },
})
data:extend({
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
    icon_size = 64, icon_mipmaps = 3,
    subgroup = "intermediate-product",
    order = "g[graphite-carbon-black]",
    stack_size = util.get_stack_size(100),
  },
  {
    type = "recipe",
    name = "carbon-black",
    icon = "__bzcarbon__/graphics/icons/carbon-black.png",
    icon_size = 64, icon_mipmaps = 3,
    category = "chemistry",
    order = "d[graphite-carbon-black]",
    enabled = false,
    energy_required = 1,
    ingredients = {
      {type="item", name="coal", amount=1},
    },
    results = {
      {type="item", name= "carbon-black", amount=1},
    }
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

-- crucible
data:extend({
{
  type = "item",
  name = "crucible",
  icon = "__bzcarbon__/graphics/icons/crucible.png", icon_size = 128,
  subgroup = "intermediate-product",
  order = "g[crucible]",
  stack_size = 50,
},
{
  type = "recipe",
  name = "crucible",
  category = "crafting",
  order = "d[graphite]",
  enabled = false,
  energy_required = 3,
  ingredients = {
    {type="item", name="graphite", amount=5},
  },
  result = "crucible",
  result_count = 1,
},
})

-- Space exploration subgroups
if mods["space-exploration"] and string.sub(mods["space-exploration"], 1, 3) == "0.6" then
  data:extend({
  {
    type = "item-subgroup",
    name = "carbon",
    group = "resources",
    order = "a-h-z-0",
  }
  })
  util.set_item_subgroup("graphite", "carbon")
  util.set_item_subgroup("diamond", "carbon")
  util.set_item_subgroup("graphene", "carbon")
  util.set_item_subgroup("carbon-black", "carbon")
  util.set_item_subgroup("fullerenes", "carbon")
  util.set_item_subgroup("nanotubes", "carbon")
end
