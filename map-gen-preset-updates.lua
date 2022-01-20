local util = require("data-util");
if util.me.use_flake_graphite() then
  if data.raw["map-gen-presets"] and data.raw["map-gen-presets"].default then
    for name, preset in pairs(data.raw["map-gen-presets"].default) do 
      if type(preset) == "table" and 
      preset.basic_settings and 
      preset.basic_settings.autoplace_controls and 
      preset.basic_settings.autoplace_controls["iron-ore"] then
        preset.basic_settings.autoplace_controls["graphite"] = preset.basic_settings.autoplace_controls["iron-ore"]
      end
    end
  end
end
if util.me.use_rough_diamond() then
  if data.raw["map-gen-presets"] and data.raw["map-gen-presets"].default then
    for name, preset in pairs(data.raw["map-gen-presets"].default) do 
      if type(preset) == "table" and 
      preset.basic_settings and 
      preset.basic_settings.autoplace_controls and 
      preset.basic_settings.autoplace_controls["iron-ore"] then
        preset.basic_settings.autoplace_controls["diamond"] = preset.basic_settings.autoplace_controls["iron-ore"]
      end
    end
  end
end
