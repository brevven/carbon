local util = require("data-util");
local item_sounds = require('__base__.prototypes.item_sounds')

local graphite_category = "crafting"
if mods["space-exploration"] then
  graphite_category = "pulverising"
end
if mods["space-age"] then
  graphite_category = "basic-crushing"
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
      {filename="__bzcarbon__/graphics/icons/graphite.png", size=128, scale=0.25},
      {filename="__bzcarbon__/graphics/icons/graphite-1.png", size=128, scale=0.25},
      {filename="__bzcarbon__/graphics/icons/graphite-2.png", size=128, scale=0.25},
    },
    inventory_move_sound = item_sounds.sulfur_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.sulfur_inventory_move,
    subgroup = "raw-material",
    order = "g[graphite]",
    weight = 1*kg,
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
          { icon = "__bzcarbon__/graphics/icons/flake-graphite.png", icon_size = 128, icon_mipmaps = 3, scale=0.25, shift= {-8, -8}},
        } or nil),
    -- normal = (mods["Krastorio2"] and
    --     {
    --       enabled = false,
    --       energy_required = 5,
    --       ingredients = {util.item("flake-graphite", 10)},
    --       results = {{type="item", name= "graphite", amount=10}},
    --     } or
    
    enabled = false,
    allow_productivity=true,
    energy_required = 0.5,
    ingredients = {util.item("flake-graphite", 1)},
    results = {util.item("graphite")},
    -- expensive =
    -- {
    --   enabled = false,
    --   energy_required = 1,
    --   ingredients = {util.item("flake-graphite", 2)},
    --   result = "graphite"
    -- }
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
        category = mods.bzfoundry and "founding" or "crafting",
        order = "d[graphite]",
        enabled = false,
        energy_required = 0.5,
        ingredients = {util.item("coke", 1)},
        results = {util.item("graphite", 2)},
      }
    })
  else
    data:extend({
      {
        type = "recipe",
        name = "graphite",
        icon = "__bzcarbon__/graphics/icons/graphite.png", icon_size=128,
        category = mods.bzfoundry and "founding" or "crafting",
        subgroup = data.raw.item.graphite.subgroup,
        order = "d[graphite]",
        enabled = false,
        energy_required = 0.5,
        ingredients = {util.item("coal", 1)},
        results = {util.item("graphite", 1), {type="item", name="stone", amount=1, probability=0.05}},
      }
    })
  end
  util.add_prerequisite("graphite-processing", "foundry")

  -- Increase richness of coal a bit
  data.raw.resource["coal"].autoplace.richness_expression = data.raw.resource["coal"].autoplace.richness_expression.." * 1.5"
end




if mods.Krastorio2 then
  util.add_prerequisite("graphite-processing", "kr-crusher")
else
  -- util.add_prerequisite("graphite-processing", "automation")
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
    ingredients = {util.item("flake-graphite", 2)},
    results = {util.item("graphite")},
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
    ingredients = {util.item("flake-graphite", 1)},
    results = {util.item("graphite", 2)},
  }
})
end

-- diamonds
data:extend({
  {
    type = "item",
    name = "diamond",
    icon = "__bzcarbon__/graphics/icons/diamond.png",
    inventory_move_sound = item_sounds.brick_inventory_move,
    pick_sound = item_sounds.brick_inventory_pickup,
    drop_sound = item_sounds.brick_inventory_move,
    icon_size = 128,
    subgroup = "raw-material",
    order = "g[diamond]",
    weight = 4*kg,
    stack_size = util.get_stack_size(100)
  },
  {
    type = "recipe",
    name = "synthetic-diamond",
    category = "diamond-synthesis",
    order = "d[diamond]",
    icons = (util.me.use_rough_diamond() and
        {
          { icon = "__bzcarbon__/graphics/icons/diamond.png", icon_size = 128},
          { icon = "__bzcarbon__/graphics/icons/graphite-2.png", icon_size = 128, scale=0.125, shift= {-8, -8}},
        } or nil),
    allow_productivity=true,
    enabled = false,
    energy_required = 20,
    ingredients = {util.item("graphite", mods["space-age"] and 20 or 10)},
    results = {util.item("diamond")},
    -- expensive =
    -- {
    --   enabled = false,
    --   energy_required = 30,
    --   ingredients = {util.item("graphite", 20)},
    --   result = "diamond"
    -- }
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
    -- normal = (mods["Krastorio2"] and
    --     {
    --       enabled = false,
    --       energy_required = 20,
    --       ingredients = {util.item("rough-diamond", 1)},
    --       results = {
    --         {type="item", name= "diamond", amount=1, probability=0.8},
    --         {type="item", name= "stone", amount=1, probability=0.2}
    --       },
    --    } or
    enabled = false,
    allow_productivity=true,
    energy_required = 20,
    ingredients = {util.item("rough-diamond", 1)},
    results = {
      {type="item", name= "diamond", amount=1, probability=0.8},
      {type="item", name= "stone", amount=1, probability=0.2}
    },
    -- expensive =
    -- {
    --   enabled = false,
    --   energy_required = 40,
    --   ingredients = {util.item("rough-diamond", 1)},
    --   result = "diamond"
    -- }
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
      util.me.use_rough_diamond() and not mods["space-age"] and {
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
    inventory_move_sound = item_sounds.plastic_inventory_move,
    pick_sound = item_sounds.plastic_inventory_pickup,
    drop_sound = item_sounds.plastic_inventory_move,
    subgroup = "intermediate-product",
    order = "g[graphite]",
    weight = 2*kg,
    stack_size = util.get_stack_size(200)
  },
  {
    type = "recipe",
    name = "graphene",
    category = "chemistry",
    order = "d[graphite]",
    enabled = false,
    allow_productivity=true,
    energy_required = 5,
    ingredients = (mods["space-age"] or mods.Krastorio2) and {
      {type="item", name="graphite", amount=1},
      {type="fluid", name="ammonia", amount=5},
      {type="fluid", name="sulfuric-acid", amount=5},
    } or {
      {type="item", name="graphite", amount=1},
      {type="fluid", name="water", amount=10},
      {type="fluid", name="sulfuric-acid", amount=10},
    },
    results = {util.item("graphene")},
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
if mods["space-age"] then
  util.set_prerequisite("graphene", {"agricultural-science-pack"})
  util.set_tech_recipe("graphene", {
    {"automation-science-pack", 1},
    {"logistic-science-pack", 1},
    {"chemical-science-pack", 1},
    {"agricultural-science-pack", 1},
  })
end


-- fullerenes
if util.me.use_fullerenes() then
data:extend({
  {
    type = "item",
    name = "fullerenes",
    icon = "__bzcarbon__/graphics/icons/Fullerene.png",
    icon_size = 128,
    inventory_move_sound = item_sounds.plastic_inventory_move,
    pick_sound = item_sounds.plastic_inventory_pickup,
    drop_sound = item_sounds.plastic_inventory_move,
    subgroup = "intermediate-product",
    order = "g[graphite-fullerenes]",
    weight = 2*kg,
    stack_size = util.get_stack_size(200),
  },
  {
    type = "recipe",
    name = "fullerenes",
    category = mods["space-age"] and "electronics-or-assembling" or "advanced-crafting",
    order = "d[graphite-fullerenes]",
    enabled = false,
    allow_productivity=true,
    energy_required = 1,
    ingredients = mods.Krastorio2 and
    {
      {type="item", name="graphite", amount=2},
      {type="fluid", name="nitrogen", amount=2},
    } or
    {
      {type="item", name="graphite", amount=2},
    },
    results = {util.item("fullerenes", 20)},
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
    inventory_move_sound = item_sounds.plastic_inventory_move,
    pick_sound = item_sounds.plastic_inventory_pickup,
    drop_sound = item_sounds.plastic_inventory_move,
    subgroup = "intermediate-product",
    order = "g[graphite-nanotubes]",
    weight = 2*kg,
    stack_size = util.get_stack_size(200),
  },
  {
    type = "recipe",
    name = "nanotubes",
    main_product = "nanotubes",
    icon = "__bzcarbon__/graphics/icons/nanotube.png",
    icon_size = 128,
    category = "chemistry",
    subgroup = "intermediate-product",
    order = "d[graphite-nanotubes]",
    enabled = false,
    allow_productivity=true,
    energy_required = 20,
    ingredients = {
      {type="item", name="fullerenes", amount=1},
      {type="item", name="iron-plate", amount=1, ignored_by_stats=1, ignored_by_productivity=1},
      {type="fluid", name="sulfuric-acid", amount=10, ignored_by_stats=10, ignored_by_productivity=10},
    },
    results = {
      {type="item", name="nanotubes", amount=1},
      {type="item", name="iron-plate", amount=1, probability=0.95, ignored_by_stats=1, ignored_by_productivity=1},
      {type="fluid", name="sulfuric-acid", amount=9, ignored_by_stats=9, ignored_by_productivity=9},
      mods.Krastorio3 and {type="fluid", name="dirty-water", amount=1, ignored_by_stats=1, ignored_by_productivity=1} or nil,
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
    inventory_move_sound = item_sounds.sulfur_inventory_move,
    pick_sound = item_sounds.resource_inventory_pickup,
    drop_sound = item_sounds.sulfur_inventory_move,
    subgroup = "intermediate-product",
    order = "g[graphite-carbon-black]",
    weight = 1*kg,
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
    allow_productivity=true,
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
    allow_productivity=true,
    energy_required = 1,
    ingredients = {
      {type="item", name="carbon-black", amount=10},
    },
    results = {util.item("graphite", 1)},
  },
})
end

-- crucible
data:extend({
{
  type = "item",
  name = "crucible",
  icon = "__bzcarbon__/graphics/icons/crucible.png", icon_size = 128,
  inventory_move_sound = item_sounds.brick_inventory_move,
  pick_sound = item_sounds.brick_inventory_pickup,
  drop_sound = item_sounds.brick_inventory_move,
  subgroup = "intermediate-product",
  order = "g[crucible]",
  weight = 4*kg,
  stack_size = 50,
},
{
  type = "recipe",
  name = "crucible",
  category = "crafting",
  order = "d[graphite]",
  enabled = false,
  allow_productivity=true,
  energy_required = 3,
  ingredients = {
    {type="item", name="graphite", amount=5},
  },
  results = {util.item("crucible", 1)},
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

-- Set early tech tree
if util.me.use_flake_graphite() then
  util.set_tech_trigger("graphite-processing", {type = "mine-entity", entity = "graphite"})
else
  util.set_tech_trigger("graphite-processing", {type = "mine-entity", entity = "coal"})
end
util.add_prerequisite("graphite-processing", "steam-power")

if mods["space-age"] then
  data:extend({
  {
    type = "surface-property",
    name = "oxygen",
    default_value = 19,
  },
  -- make graphite from diamonds on some surfaces
  {
    type = "recipe",
    name = "graphitization",
    icons = {
      {icon = "__bzcarbon__/graphics/icons/graphite.png", icon_size = 128},
      {icon = "__bzcarbon__/graphics/icons/rough-diamond.png", icon_size = 128, scale = 0.125, shift={-8,-8}},
    },
    category = "smelting",
    order = "d[graphite]",
    enabled = false,
    allow_productivity=true,
    energy_required = 16,
    surface_conditions = {
      {property = "oxygen", max = 20},
    },
    ingredients = {
      {type="item", name="rough-diamond", amount=1},
    },
    show_amount_in_title = false,
    results = {util.item("graphite", 10)},
  },
  {
    type = "technology",
    name = "diamond-processing-2",
    icon_size = 128,
    icon = "__bzcarbon__/graphics/icons/diamond.png",
    effects =
    {
      {
        type = "unlock-recipe",
        recipe = "graphitization"
      },
      {
        type = "unlock-recipe",
        recipe = "diamond-processing"
      },
    },
    research_trigger = {
      type = "mine-entity",
      entity = "diamond",
    },
    prerequisites = {"planet-discovery-vulcanus"},
    order = "b-b"
  },
  -- Graphite from spoilage via carbon
  {
    type = "recipe",
    name = "graphite-synthesis",
    category = "organic-or-chemistry",
    order = "d[graphite]",
    enabled = false,
    allow_productivity=true,
    energy_required = 8/3,
    ingredients = {
      {type="item", name="carbon", amount=1},
    },
    results = {util.item("graphite", 1)},
  },
  })
  util.add_unlock("biochamber", "graphite-synthesis")
  util.set_recipe_time("burnt-spoilage", 4)
  util.set_surface_property("nauvis", "oxygen", 21)
  util.set_surface_property("gleba", "oxygen", 30)
  util.set_surface_property("fulgora", "oxygen", 15)
  util.set_surface_property("vulcanus", "oxygen", 12)
  util.set_surface_property("aquilo", "oxygen", 10)
  util.set_surface_property("space-platform", "oxygen", 0)
end
