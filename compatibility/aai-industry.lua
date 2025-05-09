if not mods["aai-industry"] then return end

-- change tech for aai industry
table.insert(data.raw["technology"]["mini-trains"], "electronics")

-- change mini loco recipe from iron-gear-wheel (changed before) to single-cylinder engine
for i, ingredient in pairs(data.raw.recipe["mini-locomotive"].ingredients) do 
	if ingredient.name == "iron-gear-wheel" then
		ingredient.name = "motor"
	end
end

