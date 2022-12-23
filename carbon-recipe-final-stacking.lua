-- Deadlock stacking recipes

local util = require("data-util");

if deadlock then
  deadlock.add_stack("flake-graphite",  "__bzcarbon__/graphics/icons/stacked/flake-graphite-stacked.png", "deadlock-stacking-1", 64)
  deadlock.add_stack("graphite",  "__bzcarbon__/graphics/icons/stacked/graphite-stacked.png", "deadlock-stacking-1", 128)
  deadlock.add_stack("diamond", "__bzcarbon__/graphics/icons/stacked/diamond-stacked.png" , "deadlock-stacking-2", 128)
  deadlock.add_stack("graphene", "__bzcarbon__/graphics/icons/stacked/graphene-stacked.png" , "deadlock-stacking-2", 128)
  deadlock.add_stack("crucible", "__bzcarbon__/graphics/icons/stacked/crucible-stacked.png" , "deadlock-stacking-2", 128)
  if util.me.use_fullerenes() then
    deadlock.add_stack("fullerenes",  "__bzcarbon__/graphics/icons/stacked/fullerene-stacked.png", "deadlock-stacking-2", 128)
    deadlock.add_stack("nanotubes",  "__bzcarbon__/graphics/icons/stacked/nanotube-stacked.png", "deadlock-stacking-2", 128)
  end
  if util.me.use_carbon_black() then
    deadlock.add_stack("carbon-black",  "__bzcarbon__/graphics/icons/stacked/carbon-black-stacked.png", "deadlock-stacking-2", 64)
  end
  if util.me.use_rough_diamond() then
    deadlock.add_stack("rough-diamond", "__bzcarbon__/graphics/icons/stacked/rough-diamond-stacked.png" , "deadlock-stacking-2", 64)
  end
end

-- Deadlock crating recipes
if deadlock_crating then
  deadlock_crating.add_crate("flake-graphite", "deadlock-crating-1")
  deadlock_crating.add_crate("graphite", "deadlock-crating-1")
  deadlock_crating.add_crate("diamond", "deadlock-crating-2")
  deadlock_crating.add_crate("graphene", "deadlock-crating-2")
  deadlock_crating.add_crate("crucible", "deadlock-crating-2")
  if util.me.use_fullerenes() then
    deadlock_crating.add_crate("fullerenes", "deadlock-crating-2")
    deadlock_crating.add_crate("nanotubes", "deadlock-crating-2")
  end
  if util.me.use_carbon_black() then
    deadlock_crating.add_crate("carbon-black", "deadlock-crating-2")
  end
end

