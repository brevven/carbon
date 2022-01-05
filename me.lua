local me = {}

me.name = "bzcarbon"
me.list = {}

function me.use_fullerenes()
  return me.get_setting("bzcarbon-enable-fullerenes") == "yes"
end

function me.use_carbon_black()
  return me.get_setting("bzcarbon-enable-carbon-black") == "yes"
end

function me.use_rough_diamond()
  return mods["rso-mod"] or me.get_setting("bzcarbon-enable-rough-diamond") == "yes"
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

me.crucible_ingredients = {"tungsten-plate", "zirconia", "stone-brick", "silica"}
me.furnaces =  {
  "electric-furnace",
  "electric-foundry",     -- BZ
  "industrial-furnace",   -- AAI
  "kr-advanced-furnace",  -- K2
  "electric-furnace-mk2", -- FE+
  "electric-furnace-mk3", -- FE+
  "mega-furnace",         -- Mega furnace
  "advanced-electric-furnace-rampant-industrial",
}


return me
