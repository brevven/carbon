local util = require("data-util");
local cutil = require("carbon-util")

if util.me.use_fullerenes() then
  cutil.nanotube_recipe("low-density-structure")
end
