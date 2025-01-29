local util = require("data-util");

if mods["any-planet-start"] and util.me.get_setting("aps-planet") ~= "nauvis" then
  util.set_prerequisite("graphite-processing", {})
end
if mods["any-planet-start"] and util.me.get_setting("aps-planet") == "vulcanus" then
  util.set_tech_trigger("graphite-processing", {type="mine-entity", entity="huge-volcanic-rock"})
elseif mods["any-planet-start"] and util.me.get_setting("aps-planet") == "fulgora" then
  util.set_tech_trigger("graphite-processing", {type="craft-item", item="graphite", count=5})
  util.remove_prerequisite("electronics", "graphite-processing")
  util.set_prerequisite("electric-mining-drill", {})
  util.set_tech_trigger("electric-mining-drill", {type="craft-item", item="medium-electric-pole", count=5}) 
elseif mods["any-planet-start"] and util.me.get_setting("aps-planet") == "gleba" then
  util.set_tech_trigger("graphite-processing", {type="mine-entity", entity="gleba-rock"})
end
