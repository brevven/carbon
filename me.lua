local me = {}

me.name = "bzcarbon"
me.resources = {} -- see end of file

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

function has_mod(name) 
  if mods then return mods[name] end
  if script.active_mods then return script.active_mods[name] end
end

function me.use_fiber()
  return mods["space-age"] or me.get_setting("bzcarbon-enable-carbon-fiber") == "yes"
end

function me.use_fullerenes()
  if me.get_setting("bz-all-intermediates") then return true end
  return me.get_setting("bzcarbon-enable-fullerenes") == "yes"
end

function me.reuse()
  return me.get_setting("bzcarbon-reuse") == "yes"
end


function me.use_carbon_black()
  if me.get_setting("bz-all-intermediates") then return true end
  return me.get_setting("bzcarbon-enable-carbon-black") == "yes"
end

function me.use_rough_diamond()
  return has_mod("rso-mod") or has_mod("space-age") or me.get_setting("bzcarbon-enable-rough-diamond") == "yes"
end

function me.use_flake_graphite()
  return has_mod("rso-mod") or me.get_setting("bzcarbon-enable-flake-graphite") == "yes"
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

me.crucible_ingredients = {"zirconia", "silica", "stone-brick"}

me.furnaces =  {
  "electric-furnace",
  "foundry",              -- Space Age
  "basic-foundry",        -- BZ Tin
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
}

if me.use_flake_graphite() then 
  table.insert(me.resources, {"graphite", "nauvis"})
end
if me.use_rough_diamond() then 
  if has_mod("space-age") then
    table.insert(me.resources, {"diamond", "vulcanus"})
  else
    table.insert(me.resources, {"diamond", "nauvis"})
  end
end

return me
