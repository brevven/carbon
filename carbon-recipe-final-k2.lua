local util = require("data-util")
local cutil = require("carbon-util")
if util.k2() then
  if util.me.use_fullerenes() then
    -- Add extra nanotube recipes.
    -- This could be moved to data-updates in future if necessary
    cutil.nanotube_recipe("kr-imersium-plate")
    cutil.nanotube_recipe("kr-s-c-imersium-beam", "kr-imersium-beam")
    cutil.nanotube_recipe("kr-s-c-imersium-gear-wheel", "kr-imersium-gear-wheel")
  end
end
