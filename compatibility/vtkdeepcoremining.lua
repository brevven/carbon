local util = require("data-util");

if mods["vtk-deep-core-mining"] then
  if util.me.use_rough_diamond() then
    local amt = 0
    if data.raw.recipe["vtk-deepcore-mining-ore-chunk-refining"] then
      for i, product in pairs(data.raw.recipe["vtk-deepcore-mining-ore-chunk-refining"].results) do
        if product.name == "vtk-deepcore-mining-rough-diamond-chunk" then
          amt = product.amount - 1
        end
        if product[1] == "vtk-deepcore-mining-rough-diamond-chunk" then
          amt = product[2] - 1
        end
      end
      util.add_to_product("vtk-deepcore-mining-ore-chunk-refining",
                          "vtk-deepcore-mining-rough-diamond-chunk", 0-amt)
      util.add_to_product("vtk-deepcore-mining-ore-chunk-refining",
                          "vtk-deepcore-mining-flake-graphite-chunk", amt)
    end
    amt = 0
    if data.raw.recipe["vtk-deepcore-mining-ore-chunk-refining-no-uranium"] then
      for i, product in pairs(data.raw.recipe["vtk-deepcore-mining-ore-chunk-refining-no-uranium"].results) do
        if product.name == "vtk-deepcore-mining-rough-diamond-chunk" then
          amt = product.amount - 1
        end
        if product[1] == "vtk-deepcore-mining-rough-diamond-chunk" then
          amt = product[2] - 1
        end
      end
      util.add_to_product("vtk-deepcore-mining-ore-chunk-refining-no-uranium",
                          "vtk-deepcore-mining-rough-diamond-chunk", 0-amt)
      util.add_to_product("vtk-deepcore-mining-ore-chunk-refining-no-uranium",
                          "vtk-deepcore-mining-flake-graphite-chunk", amt)
    end
  end


  -- deepcore mining was not adding required fluid, add if it doesn't have
  for i, resource in pairs({"flake-graphite-patch", "flake-graphite-patch-chunk", "flake-graphite-patch-ore"}) do
    if data.raw.resource[resource] and
    data.raw.resource[resource].minable and
    not data.raw.resource[resource].minable.required_fluid then
      data.raw.resource[resource].minable.required_fluid = "steam"
      data.raw.resource[resource].minable.fluid_amount = 1
    end
  end

end

