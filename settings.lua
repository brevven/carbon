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
})
