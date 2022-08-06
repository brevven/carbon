local util = require("data-util");

if util.me.use_flake_graphite() and mods["Rich-Rocks-Requiem"] then
  if data.raw.recipe["rrr-stone-processing"] then
    table.insert(data.raw.recipe["rrr-stone-processing"].results,
      {name = "flake-graphite", probability = 0.35, amount = 1}
    )
  end

  if data.raw.recipe["rrr-raw-ores-processing"] then
    table.insert(data.raw.recipe["rrr-raw-ores-processing"].results,
      {name = "flake-graphite", probability = 0.65, amount = 10}
    )
  end
end
