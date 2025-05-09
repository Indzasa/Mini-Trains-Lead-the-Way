if not mods["wood-logistics"] then return end

-- if wooden logistics and with option: add lumber to mini trains
if settings.startup["mtlw-replace-some-steel-with-lumber"] then
	-- loco: 15/10 to 10/5 steel/lumber
	for i, ingredient in pairs(data.raw.recipe["mini-locomotive"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.amount = 10
		end
	end
	table.insert(data.raw.recipe["mini-locomotive"].ingredients, {type="item", name="lumber", amount=5})
	
	-- cargo: 10/0 to 5/5 steel/lumber
	for i, ingredient in pairs(data.raw.recipe["mini-cargo-wagon"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.amount = 5
		end
	end
	table.insert(data.raw.recipe["mini-cargo-wagon"].ingredients, {type="item", name="lumber", amount=5})
	
	-- fluid: 10/0 to 5/5 steel/lumber
	for i, ingredient in pairs(data.raw.recipe["mini-fluid-wagon"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.amount = 5
		end
	end
	table.insert(data.raw.recipe["mini-fluid-wagon"].ingredients, {type="item", name="lumber", amount=5})
end

if settings.startup["wood-logistics-cargo-wagon"].value == true then
	-- don't add mini wagon to cargo wagon's recipe if there is wooden wagon involved, add it to the wooden wagon's recipe instead
	for i, ingredient in pairs(data.raw.recipe["cargo-wagon"].ingredients) do 
		if ingredient.name == "mini-cargo-wagon" then table.remove(data.raw.recipe["cargo-wagon"].ingredients, i) end
	end
	table.insert(data.raw.recipe["wood-cargo-wagon"].ingredients, {type="item", name="mini-cargo-wagon", amount=1})
	
	-- change wooden wagon (increase it's cargo capacity)
	data.raw["cargo-wagon"]["wood-cargo-wagon"].inventory_size = 30
	
	-- remove regular wagon from tungsten tech (revert it back to trains)
	if mods["space-age"] then
		for k, v in pairs(data.raw["technology"]["tungsten-steel"].effects) do
			if v.type == "unlock-recipe" and v.recipe == "cargo-wagon" then
				table.remove(data.raw["technology"]["tungsten-steel"].effects, k)
			end
		end
		table.insert(data.raw["technology"]["railway"].effects, {type = "unlock-recipe",recipe = "cargo-wagon"})
	end
	
	-- change tungsten back to iron in regular wagon's recipe if it is not on vulcanus or fulgora
	if settings.startup["mtlw-regular-trains-fate"].value == "delayed" then
		for i, ingredient in pairs(data.raw.recipe["cargo-wagon"].ingredients) do 
			if ingredient.name == "tungsten-plate" then
				ingredient.name = "iron-plate"
			end
		end
	end
	-- change back steel to iron in regular wagon's recipe if it is on vulcanus
	if settings.startup["mtlw-regular-trains-fate"].value == "vulcanus" then
		for i, ingredient in pairs(data.raw.recipe["cargo-wagon"].ingredients) do 
			if ingredient.name == "steel-plate" then
				ingredient.name = "iron-plate"
			end
		end
	end
	-- change tungsten to holmium and steel back to iron in regular wagon's recipe if it is on fulgora
	if settings.startup["mtlw-regular-trains-fate"].value == "fulgora" then
		for i, ingredient in pairs(data.raw.recipe["cargo-wagon"].ingredients) do 
			if ingredient.name == "tungsten-plate" then
				ingredient.name = "holmium-plate"
			end
			if ingredient.name == "steel-plate" then
				ingredient.name = "iron-plate"
			end
		end
	end
	
	-- move wooden wagon to mini trains from regular trains
	for k, v in pairs(data.raw["technology"]["railway"].effects) do
		if v.type == "unlock-recipe" and v.recipe == "wood-cargo-wagon" then
			table.remove(data.raw["technology"]["railway"].effects, k)
		end
	end
	table.insert(data.raw["technology"]["mini-trains"].effects, {type = "unlock-recipe",recipe = "wood-cargo-wagon"})
end

