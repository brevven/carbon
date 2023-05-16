local me = {}

me.name = "bzcarbon"
me.list = {}

me.recipes = {  -- recipes that allow productivity
  "graphite",
  "synthetic-diamond",
  "diamond-processing",

  "graphene",
  "heavy-water-graphene",
  "enriched-graphite",

  "fullerenes",
  "nanotubes",

  "carbon-fiber",
  "polyacrylonitrile",

  "diamond-synthesis-vulcanite",
  -- NOTE: Carbon black recipes do not allow prod modules
}

function me.py()
  return mods and (mods.pyhightech or mods.pyrawores or mods.pyfusionenergy)
end


function me.use_fiber()
  if me.get_setting("bz-all-intermediates") then return true end
  return me.get_setting("bzcarbon-enable-carbon-fiber") == "yes" and not me.py()
end

function me.use_fullerenes()
  if me.get_setting("bz-all-intermediates") then return true end
  return me.get_setting("bzcarbon-enable-fullerenes") == "yes" and not me.py()
end

function me.reuse()
  return me.get_setting("bzcarbon-reuse") == "yes"
end


function me.use_carbon_black()
  if me.get_setting("bz-all-intermediates") then return true end
  return me.get_setting("bzcarbon-enable-carbon-black") == "yes" and not me.py()
end

function me.use_rough_diamond()
  return mods["rso-mod"] or me.get_setting("bzcarbon-enable-rough-diamond") == "yes"
end

function me.use_flake_graphite()
  return mods["rso-mod"] or me.get_setting("bzcarbon-enable-flake-graphite") == "yes"
end

function me.foundry_enable()
  return not me.get_setting("bzfoundry-minimal")
end

function me.get_setting(name)
  if settings.startup[name] == nil then
    return nil
  end
  return settings.startup[name].value
end

me.bypass = {}
if me.get_setting(me.name.."-recipe-bypass") then 
  for recipe in string.gmatch(me.get_setting(me.name.."-recipe-bypass"), '[^",%s]+') do
    me.bypass[recipe] = true
  end
end

function me.add_modified(name) 
  if me.get_setting(me.name.."-list") then 
    table.insert(me.list, name)
  end
end

me.crucible = "crucible"
me.crucible_ingredients = {"tungsten-plate", "zirconia", "silica"}
if me.py() then
  me.crucible = "industrial-crucible" 
  me.crucible_ingredients = {"tungsten-plate", "zirconia", "silica", "ceramic"}
end

if (mods and mods.bzaluminum) or (game and game.active_mods and game.active_mods.bzaluminum) then
  table.insert(me.crucible_ingredients, "alumina")
else
  table.insert(me.crucible_ingredients, "stone-brick")
end

me.furnaces =  {
  "electric-furnace",
  "electric-foundry",     -- BZ
  "industrial-furnace",   -- AAI
  "se-casting-machine",   -- SE
  "kr-advanced-furnace",  -- K2
  "electric-furnace-mk2", -- FE+
  "electric-furnace-mk3", -- FE+
  "mega-furnace",         -- Mega furnace
  "advanced-electric-furnace-rampant-industrial",
  "5d-electric-furnace-02",
  "5d-electric-furnace-03",
  "5d-electric-furnace-04",
  "5d-electric-furnace-05",
  "5d-electric-furnace-06",
  "5d-electric-furnace-07",
  "5d-electric-furnace-08",
  "5d-electric-furnace-09",
  "5d-electric-furnace-10",
  "5d-industrial-furnace",

  -- py
  "advanced-foundry-mk02",
  "smelter-mk02",
  "hpf-mk02", -- high pressure furnace
  "eaf-mk01", -- electric arc furnace
  "bof-mk01", -- basic oxygen furnace
  "sinter-unit",
}


return me
