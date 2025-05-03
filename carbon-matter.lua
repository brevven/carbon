-- Matter recipes for Krastorio2
if mods["Krastorio2"] then
local util = require("data-util");

data:extend(
{
  {
    type = "technology",
    name = "carbon-matter-processing",
    icons =
    {
      {
        icon = util.k2assets().."/technologies/matter-coal.png",
        icon_size = 256,
      },
      {
        icon = "__bzcarbon__/graphics/icons/diamond.png",
        icon_size = 128,
        scale = 1.4,
      }
    },
    effects = {},
    prerequisites = {"kr-matter-processing"},
    unit =
  	{
      count = 350,
      ingredients =
      {
        {"production-science-pack", 1},
        {"utility-science-pack", 1},
        {"kr-matter-tech-card", 1}
      },
      time = 45
    }
  },
})

util.k2matter({
	k2matter = {
    material = {
      name = "flake-graphite",
      type = "item",
      amount = 10,
    },
    matter_count = 5,
    energy_required = 1,
    needs_stabilizer = false,
    allow_productivity = true,
    unlocked_by = "carbon-matter-processing"
	}
})

util.k2matter({
	k2matter = {
    material = {
      name = "graphite",
      type = "item",
      amount = 10,
    },
    matter_count = 7.5,
    energy_required = 2,
    needs_stabilizer = true,
    allow_productivity = true,
    only_deconversion = true,
    unlocked_by = "carbon-matter-processing"
	}
})

util.k2matter({
	k2matter = {
    material = {
      name = "diamond",
      type = "item",
      amount = 1,
    },
    matter_count = 8,
    energy_required = 2,
    needs_stabilizer = true,
    allow_productivity = true,
    only_deconversion = true,
    unlocked_by = "carbon-matter-processing"
	}
})

end
