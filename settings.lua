data:extend({
  {
		type = "bool-setting",
		name = "mtlw-add-mini-to-regular",
		setting_type = "startup",
		default_value = true
	},
  {
		type = "bool-setting",
		name = "mtlw-replace-some-steel-with-lumber",
		setting_type = "startup",
		default_value = true
	},
  {
		type = "bool-setting",
		name = "mtlw-nerf-mini-trains",
		setting_type = "startup",
		default_value = false
	},
})

if mods["space-age"] then
  data:extend({
    {
        type = "string-setting",
		name = "mtlw-regular-trains-fate",
		setting_type = "startup",
		default_value = "delayed",
		allowed_values = {"delayed", "vulcanus", "fulgora", "removed"},
    }
  })
else
  data:extend({
    {
        type = "string-setting",
		name = "mtlw-regular-trains-fate",
		setting_type = "startup",
		default_value = "delayed",
		allowed_values = {"delayed", "removed"},
    }
  })
end