local util = require("data-util")
local cutil = require("carbon-util")
if mods.Krastorio2 then
  if util.me.use_fullerenes() then
    -- Add extra nanotube recipes.
    -- This could be moved to data-updates in future if necessary
    cutil.nanotube_recipe("imersium-plate")
    cutil.nanotube_recipe("kr-s-c-imersium-beam", "imersium-beam")
    cutil.nanotube_recipe("kr-s-c-imersium-gear-wheel", "imersium-gear-wheel")
  end
end
