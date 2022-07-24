local util = require("data-util");

if mods.Fluidless_Mining_and_Ore_Washing then
  -- Note: want to find a better solution, but for now, make assembler 1 handle fluid
  data.raw["assembling-machine"]["assembling-machine-1"].fluid_boxes = data.raw["assembling-machine"]["assembling-machine-2"].fluid_boxes
  util.add_crafting_category("assembling-machine", "assembling-machine-1", "crafting-with-fluid")
end
