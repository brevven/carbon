data:extend({
  {
		type = "string-setting",
		name = "bzcarbon-recipe-bypass",
		setting_type = "startup",
		default_value = "",
    allow_blank = true,
	},
  {
		type = "string-setting",
		name = "bzcarbon-enable-fullerenes",
		setting_type = "startup",
		default_value = "yes",
    allowed_values = {"no", "yes"},
	},
  {
		type = "string-setting",
		name = "bzcarbon-enable-carbon-black",
		setting_type = "startup",
		default_value = "no",
    allowed_values = {"no", "yes"},
	},
  {
		type = "string-setting",
		name = "bzcarbon-enable-rough-diamond",
		setting_type = "startup",
    hidden = not not mods["rso-mod"],
		default_value = mods["rso-mod"] and "yes" or "no",
    allowed_values = {"no", "yes"},
	},
  {
		type = "string-setting",
		name = "bzcarbon-enable-flake-graphite",
		setting_type = "startup",
    hidden = not not mods["rso-mod"],
		default_value = "yes",
    allowed_values = {"no", "yes"},
	},
  {
		type = "bool-setting",
		name = "bzcarbon-list",
		setting_type = "startup",
    default_value = false,
	},
  {
		type = "string-setting",
		name = "bzcarbon-reuse",
		setting_type = "startup",
		default_value = "no",
    allowed_values = {"no", "yes"},
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
    },
  })
end
