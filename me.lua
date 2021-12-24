local me = {}

me.name = "bzcarbon"

function me.use_fullerenes()
  return me.get_setting("bzcarbon-enable-fullerenes") == "yes"
end

function me.use_carbon_black()
  return me.get_setting("bzcarbon-enable-carbon-black") == "yes"
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

return me
