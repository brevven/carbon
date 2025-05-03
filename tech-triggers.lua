local util = require("data-util");

util.set_tech_trigger("fluid-mining", {type="craft-fluid", fluid="steam", amount=500})
util.set_prerequisite("fluid-mining", {"steam-power"})
util.add_unlock("steam-power", "copper-cable")
util.add_unlock("steam-power", "small-electric-pole")
util.set_prerequisite("electric-mining-drill", {"steam-power"})
util.set_tech_trigger("electric-mining-drill", {type="craft-item", item="small-electric-pole", count=10})
util.set_prerequisite("graphite-processing", {"fluid-mining", "electric-mining-drill"})
