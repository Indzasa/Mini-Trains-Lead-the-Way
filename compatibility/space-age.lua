if not mods["space-age"] then return end

local railway_research = data.raw["technology"]["railway"]

-- vulcanus option
if settings.startup["mtlw-regular-trains-fate"].value == "vulcanus" then
	-- move railway tech to vulcanus (place after tungsten steel)
	for i = #railway_research.prerequisites, 1, -1 do
	  if railway_research.prerequisites[i] == "logistics-3" then
		table.remove(railway_research.prerequisites, i)
	  end
	end
	table.insert(railway_research.prerequisites, "tungsten-steel")
	-- change recipes to include tungsten plate
	for i, ingredient in pairs(data.raw.recipe["locomotive"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.name = "tungsten-plate"
		end
	end	
	-- check for wooden logistics cos they can add tungsten too and it will cause an error if added twice
	if mods["wood-logistics"] then 
		if settings.startup["wood-logistics-cargo-wagon"].value == false  then
			for i, ingredient in pairs(data.raw.recipe["cargo-wagon"].ingredients) do 
				if ingredient.name == "steel-plate" then
					ingredient.name = "tungsten-plate"
				end
			end
		end
	else
		for i, ingredient in pairs(data.raw.recipe["cargo-wagon"].ingredients) do 
			if ingredient.name == "steel-plate" then
				ingredient.name = "tungsten-plate"
			end
		end
	end
	for i, ingredient in pairs(data.raw.recipe["fluid-wagon"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.name = "tungsten-plate"
		end
	end
end

-- fulgora option
if settings.startup["mtlw-regular-trains-fate"].value == "fulgora" then
	-- move railway tech to fulgora (place after holmium processing)
	for i = #railway_research.prerequisites, 1, -1 do
	  if railway_research.prerequisites[i] == "logistics-3" then
		table.remove(railway_research.prerequisites, i)
	  end
	end
	table.insert(railway_research.prerequisites, "holmium-processing")
	-- change recipes to include holmium plate
	for i, ingredient in pairs(data.raw.recipe["locomotive"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.name = "holmium-plate"
		end
	end	
	-- check for wooden logistics cos they can add tungsten and it will be strange if we add holmium also
	if mods["wood-logistics"] then 
		if settings.startup["wood-logistics-cargo-wagon"].value == false then
			for i, ingredient in pairs(data.raw.recipe["cargo-wagon"].ingredients) do 
				if ingredient.name == "steel-plate" then
					ingredient.name = "holmium-plate"
				end
			end
		end
	else
		for i, ingredient in pairs(data.raw.recipe["cargo-wagon"].ingredients) do 
			if ingredient.name == "steel-plate" then
				ingredient.name = "holmium-plate"
			end
		end
	end
	for i, ingredient in pairs(data.raw.recipe["fluid-wagon"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.name = "holmium-plate"
		end
	end
end