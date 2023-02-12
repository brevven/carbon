data:extend({
  {
		type = "string-setting",
		name = "bzcarbon-recipe-bypass",
		setting_type = "startup",
		default_value = "",
    allow_blank = true,
    order = "a",
	},
  {
		type = "string-setting",
		name = "bzcarbon-enable-fullerenes",
		setting_type = "startup",
		default_value = "yes",
    allowed_values = {"no", "yes"},
    order = "b1",
	},
  {
		type = "string-setting",
		name = "bzcarbon-enable-carbon-black",
		setting_type = "startup",
		default_value = "no",
    allowed_values = {"no", "yes"},
    order = "b2",
	},
  {
		type = "string-setting",
		name = "bzcarbon-enable-rough-diamond",
		setting_type = "startup",
    hidden = not not mods["rso-mod"],
		default_value = mods["rso-mod"] and "yes" or "no",
    allowed_values = {"no", "yes"},
    order = "d1",
	},
  {
		type = "string-setting",
		name = "bzcarbon-enable-flake-graphite",
		setting_type = "startup",
    hidden = not not mods["rso-mod"],
		default_value = "yes",
    allowed_values = {"no", "yes"},
    order = "d2",
	},
  {
		type = "string-setting",
		name = "bzcarbon-reuse",
		setting_type = "startup",
		default_value = "no",
    allowed_values = {"no", "yes"},
    order = "e",
	},
  {
		type = "bool-setting",
		name = "bzcarbon-list",
		setting_type = "startup",
    default_value = false,
    order = "f",
	},
})

if mods.bzchlorine then
  data:extend({
    {
      type = "string-setting",
      name = "bzcarbon-enable-carbon-fiber",
      setting_type = "startup",
      default_value = "yes",
      allowed_values = {"no", "yes"},
      order = "b3",
    },
  })
end
