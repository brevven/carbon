local util = require("__bzcarbon__.data-util");

if mods.Krastorio2 then

-- HCL graphite processing
if util.me.use_flake_graphite() then
data:extend({
  {
    type = "recipe",
    name = "enriched-graphite",
    main_product = "graphite",
    icons = {
          { icon = "__bzcarbon__/graphics/icons/graphite.png", icon_size = 128},
          { icon = util.k2assets().."/icons/fluids/hydrogen-chloride.png", icon_size = 64, scale=0.25,  icon_mipmaps = 3, shift= {-8, -8}},
        },
    category = "chemistry",
    subgroup = "raw-material",
    order = "g[graphite]",
    enabled = false,
    energy_required = 6,
		crafting_machine_tint =
		{
			primary = {r = 0.2, g = 0.2, b = 0.2, a = 0.6},
			secondary = {r = 0.2, g = 0.2, b = 0.2, a = 0.9},
			tertiary = {r = 0.2, g = 0.2, b = 0.2, a = 0.9},
			quaternary = {r = 0.2, g = 0.2, b = 0.2, a = 0.9},
		},
    ingredients = {
      {type="item", name="flake-graphite", amount=10},
      {type="fluid", name="water", amount=25, catalyst_amount=25},
      {type="fluid", name="hydrogen-chloride", amount=25},
    },
    results = {
      {type="item", name="graphite", amount=18},
      {type="fluid", name="dirty-water", amount=25, catalyst_amount=25},
    },
  },
	{
		type = "recipe",
		name = "dirty-water-filtration-graphite",
		category = "fluid-filtration",
		icons =
		{
			{
				icon = data.raw.fluid["dirty-water"].icon,
				icon_size = data.raw.fluid["dirty-water"].icon_size
			},
			{
				icon = data.raw.item["flake-graphite"].icon,
				icon_size =	data.raw.item["flake-graphite"].icon_size,
				scale = 0.20 * (data.raw.fluid["dirty-water"].icon_size/data.raw.item["flake-graphite"].icon_size),
				shift = {0, 4}
			}
		},
		energy_required = 2,
		enabled = false,
		allow_as_intermediate = false,
		always_show_made_in = true,
		always_show_products = true,
		ingredients =
		{
			{type = "fluid", name = "dirty-water", amount = 100, catalyst_amount = 100},
		},
		results =
		{
			{type = "fluid", name = "water", amount = 90, catalyst_amount = 90},
			{type = "item",  name = "stone", probability = 0.30, amount = 1},
			{type = "item",  name = "flake-graphite", probability = 0.05, amount = 1},
		},
		crafting_machine_tint =
		{
			primary = {r = 0.2, g = 0.2, b = 0.2, a = 0.6},
			secondary = {r = 0.2, g = 0.2, b = 0.2, a = 0.9}
		},
		subgroup = "raw-material",
		order = "w013[dirty-water-filtration-graphite]"
	},
  {
      type = "technology",
      name = "enriched-graphite",
      icons =
      {
        {
          icon = "__bzcarbon__/graphics/icons/graphite.png",
          icon_size = 128,
        },
        {
          icon = util.k2assets().."/icons/fluids/hydrogen-chloride.png",
          icon_size = 64, icon_mipmaps = 3,
          shift = {-32,-32},
        }
      },
      effects =
      {
        {
          type = "unlock-recipe",
          recipe = "enriched-graphite"
        },
        {
          type = "unlock-recipe",
          recipe = "dirty-water-filtration-graphite",
        }
      },
      prerequisites = {"kr-enriched-ores"},
      unit =
      {
        count = 50,
        ingredients = 
        {
                  {"automation-science-pack", 1},
                  {"logistic-science-pack", 1},
                  {"chemical-science-pack", 1}
        },
        time = 30
      }
  },
})
end



-- heavy water
data:extend({
{
    type = "recipe",
    name = "heavy-water-graphene",
    icons = {
          { icon = util.k2assets().."/icons/fluids/heavy-water.png", icon_size = 64, icon_mipmaps = 3,},
          { icon = "__bzcarbon__/graphics/icons/graphene.png", icon_size = 128,  scale=0.25, shift= {-8, -8}},
        },
    category = "electrolysis",
    subgroup = "fluid-recipes",
    order = "y06[heavy-water]",
    enabled = false,
    energy_required = 60,
    ingredients = {
      {type="item", name="graphene", amount=1, catalyst_amount=1},
      {type="fluid", name="water", amount=500},
    },
    results = {
      {type="item", name="graphene", amount=1, probability=.8, catalyst_amount=1},
      {type="fluid", name="heavy-water", amount=40},
    },
  }
})
util.add_effect("graphene", {type="unlock-recipe", recipe="heavy-water-graphene"})
util.add_prerequisite("fullerenes", "kr-atmosphere-condensation")
end
