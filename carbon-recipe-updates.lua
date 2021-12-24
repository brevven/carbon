local util = require("__bzcarbon__.data-util");

-- TECHS
util.add_prerequisite("steel-processing", "graphite-processing")

util.add_prerequisite("low-density-structure", "synthetic-diamond-processing")
util.add_prerequisite("advanced-electronics-2", "synthetic-diamond-processing")
util.add_prerequisite("production-science-pack", "synthetic-diamond-processing")
util.add_prerequisite("uranium-processing", "synthetic-diamond-processing")

util.add_prerequisite("power-armor-mk2", "graphene")
util.add_prerequisite("rocket-control-unit", "graphene")


-- fullerenes & nanotubes
if util.me.use_fullerenes() then
  util.add_prerequisite("graphene", "fullerenes")
  util.add_prerequisite("military-3", "fullerenes")
  util.replace_some_ingredient("poison-capsule", "coal", 9, "fullerenes", 90)
  util.replace_some_ingredient("slowdown-capsule", "coal", 4, "fullerenes", 40)
  -- K2
  util.add_ingredient("kr-biter-virus", "fullerenes", 100)
  util.add_ingredient("kr-creep-virus", "fullerenes", 100)
  util.replace_some_ingredient("kr-biomass-growing", "petroleum-gas", 25, "fullerenes", 25)
  -- SE
  util.add_ingredient("se-vitalic-reagent", "fullerenes", 4)
  util.add_ingredient("se-medpack-2", "fullerenes", 100)
end


-- carbon black
if util.me.use_carbon_black() then

  -- Plastic from carbon black, carbon black from oil processing
  util.replace_ingredient("plastic-bar", "coal", "carbon-black")
  util.add_product("basic-oil-processing", {"carbon-black", 1})
  util.add_product("advanced-oil-processing", {"carbon-black", 1})
  util.add_product("light-oil-cracking", {"carbon-black", 1})
  util.add_product("heavy-oil-cracking", {"carbon-black", 1})

  --K2
  if mods.bztitanium then
    util.add_ingredient("kr-black-reinforced-plate", "carbon-black", 5)
    util.add_ingredient("kr-white-reinforced-plate", "titanium-plate", 1)
  end

  util.add_effect("plastics", {type="unlock-recipe", recipe="carbon-black"})
  util.add_effect("plastics", {type="unlock-recipe", recipe="graphite-carbon-black"})

end


util.replace_some_ingredient("electronic-circuit", "copper-cable", 1, "graphite", 1)
util.add_ingredient("battery", "graphite", 1)
util.add_ingredient("pump", "graphite", 2)
if mods.bzzirconium then 
-- TODO CRUCIBLE RECIPE HERE
else
  util.add_ingredient("electric-furnace", "graphite", 5)
end

util.add_ingredient("speed-module-2", "diamond", 4)
util.add_ingredient("effectivity-module-2", "diamond", 4)
util.add_ingredient("productivity-module-2", "diamond", 4)
util.add_ingredient("assembling-machine-3", "diamond", 4)
util.add_ingredient("low-density-structure", "diamond", 1)
util.add_ingredient("centrifuge", "diamond", 10)

if mods.Krastorio2 then
  util.replace_some_ingredient("steel-plate", "iron-plate", 2, "graphite", 4)
  util.add_ingredient("tungsten-carbide", "graphite", 4)
elseif mods.bzfoundry then
  util.replace_some_ingredient("steel-plate", "iron-plate", 1, "graphite", 1)
  util.replace_some_ingredient("tungsten-carbide", "tungsten-plate", 1, "graphite", 1)
end

util.multiply_recipe("lubricant", 2)
util.replace_some_ingredient("lubricant", "heavy-oil", 10, "graphite", 1)

util.add_ingredient("nuclear-reactor", "graphite", 500)

util.add_ingredient("power-armor-mk2", "graphene", 30)
util.add_ingredient("rocket-control-unit", "graphene", 1)
util.add_ingredient("satellite", "graphene", 100)

-- K2
util.add_ingredient("empty-dt-fuel", "graphite", 1)
util.add_ingredient("kr-steel-pump", "graphite", 2)

util.add_ingredient("kr-electrolysis-plant", "graphite", 10)
util.add_ingredient("kr-fusion-reactor", "graphite", 350)
util.add_ingredient("kr-antimatter-reactor", "graphite", 350)
util.add_ingredient("kr-electric-mining-drill-mk3", "diamond", 5)
util.add_ingredient("kr-quarry-drill", "diamond", 20)
util.add_ingredient("advanced-exoskeleton-equipment", "diamond", 10)

util.add_ingredient("improved-pollution-filter", "graphene", 1)
util.add_ingredient("lithium-sulfur-battery", "graphene", 1)
util.add_ingredient("matter-research-data", "graphene", 5)
util.add_ingredient("kr-advanced-solar-panel", "graphene", 5)
util.add_ingredient("imersite-solar-panel-equipment", "graphene", 5)
util.add_ingredient("kr-advanced-chemical-plant", "graphene", 20)
util.add_ingredient("empty-antimatter-fuel-cell", "graphene", 10)

util.add_prerequisite("kr-lithium-sulfur-battery", "graphene")
util.set_tech_recipe("kr-lithium-sulfur-battery", 
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
          })
util.set_tech_recipe("kr-robot-battery", 
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
          })
util.set_tech_recipe("kr-battery-mk3-equipment",
          {
            {"automation-science-pack", 1},
            {"logistic-science-pack", 1},
            {"chemical-science-pack", 1},
            {"production-science-pack", 1},
            {"utility-science-pack", 1},
          })



-- AAI Industry
util.add_ingredient("area-mining-drill", "diamond", 8)

-- Space Exploration
util.add_ingredient("se-material-testing-pack", "graphite", 1)
util.add_ingredient("se-space-particle-accelerator", "graphite", 10)
util.add_ingredient("se-space-particle-collider", "graphite", 10)
util.add_ingredient("se-canister", "graphite", 1)
util.add_ingredient("se-naquium-ingot", "graphite", 1)
util.replace_some_ingredient("se-naquium-powder", "se-vitalic-acid", 2, "graphene", 2)

util.add_ingredient("se-quantum-processor", "graphene", 1)
util.add_ingredient("se-space-solar-panel-2", "graphene", 4)
util.add_ingredient("se-biochemical-resistance-data", "graphene", 1)
util.add_ingredient("se-tensile-strength-data", "graphene", 1)
util.add_ingredient("se-space-biochemical-facility", "graphene", 4)
util.add_ingredient("se-space-genetics-facility", "graphene", 20)
util.add_ingredient("se-space-growth-facility", "graphene", 4)
util.add_ingredient("se-nanomaterial", "graphene", 1)
util.add_ingredient("se-void-probe", "graphene", 100)

util.add_ingredient("se-space-radiator-2", "diamond", 16)
util.add_ingredient("se-rigidity-data", "diamond", 1)
util.add_to_product("se-rigidity-data", "se-rigidity-data", 1)
util.add_ingredient("se-hot-thermodynamics-data", "diamond", 1)
util.add_to_product("se-hot-thermodynamics-data", "se-hot-thermodynamics-data", 1)
util.add_ingredient("se-compressive-strength-data", "diamond", 1)
util.add_to_product("se-compressive-strength-data", "se-compressive-strength-data", 1)




-- Realistic Reactors
util.add_ingredient("realistic-reactor", "graphite", 100)
util.add_ingredient("breeder-reactor", "graphite", 100)

-- Plutonium Energy
util.add_ingredient("MOX-reactor", "graphite", 400)

-- RFP
util.add_ingredient("rfp-reactor", "graphite", 1000)
util.add_ingredient("rfp-aneutronic-reactor", "graphite", 5000)


-- vortik's deep core mining
util.add_ingredient("vtk-deepcore-mining-moho", "diamond", 10)
util.add_ingredient("vtk-deepcore-mining-drone", "diamond", 1)
util.add_ingredient("vtk-deepcore-mining-drill", "diamond", 20)
util.add_ingredient("vtk-deepcore-mining-drill-advanced", "diamond", 50)

-- Advanced Mining Drills
util.add_ingredient("elite-mining-drill", "diamond", 5)
util.add_ingredient("ultimate-mining-drill", "diamond", 10)

-- Skandragon
util.add_ingredient("skan-elite-mining-drill", "diamond", 4)
util.add_ingredient("skan-ultimate-mining-drill", "diamond", 4)

-- Hiladdar
util.add_ingredient("hsmd-electric-mining-drill-mk3", "diamond", 3)
util.add_ingredient("hsmd-electric-mining-drill-mk4", "diamond", 3)
util.add_ingredient("hsmd-electric-mining-drill-mk5", "diamond", 3)
util.add_ingredient("hsmd-electric-mining-drill-mk6", "diamond", 3)

-- Zombies
util.add_ingredient("electric-mining-drill-mk2", "diamond", 2)
util.add_ingredient("edrill-1to2", "diamond", 2)
util.add_ingredient("electric-mining-drill-mk3", "diamond", 2)
util.add_ingredient("electric-mining-drill-mk4", "diamond", 2)
util.add_ingredient("electric-mining-drill-mk5", "diamond", 2)
util.add_ingredient("electric-mining-drill-mk6", "diamond", 2)
if not mods["zombiesextended-core"] then
  util.add_ingredient("electric-mining-drill-mk1", "tungsten-carbide", 5)
end

-- Tiny
util.add_ingredient("tiny-electric-mining-drill-3", "diamond", 2)
util.add_ingredient("tiny-electric-mining-drill-5", "diamond", 3)

-- TA Miners
util.add_ingredient("moho_extractor", "diamond", 50)
util.add_ingredient("mantle_extractor", "diamond", 100)

-- other mining drills
util.add_ingredient("electric-mining-drill-lv2", "diamond", 5)
util.add_ingredient("advanced-electric-mining-drill", "diamond", 5)
util.add_ingredient("omega-drill", "diamond", 15)
util.add_ingredient("omega-drill-mk2", "diamond", 30)
util.add_ingredient("passive-furnace", "diamond", 2)
util.add_ingredient("quarry-mk3", "diamond", 10)

-- FastFurnaces
util.add_ingredient("reika-fast-electric-mining-drill", "diamond", 1)
