-- remove rails from regular trains technology
local railway_research = data.raw["technology"]["railway"]
for k, v in pairs(railway_research.effects) do
	if v.type == "unlock-recipe" and v.recipe == "rail" then
		table.remove(railway_research.effects, k)
	end
end

-- add rails to mini trains technology
local mini_trains_research = data.raw["technology"]["mini-trains"]
mini_trains_research.prerequisites = { "logistics", "steel-processing" }
table.insert(mini_trains_research.effects, {type = "unlock-recipe",recipe = "rail"})
if mods["aai-industry"] then
	table.insert(mini_trains_research.prerequisites, "electronics")
end

-- adjust mini trains research to not require logistics science
mini_trains_research.unit =
    {
        count = 80,
        ingredients =
        {
            { "automation-science-pack", 1 },
        },
        time = 20
    }

-- place stations and signals research after mini trains, adjust research cost
local stations_research = data.raw["technology"]["automated-rail-transportation"]
stations_research.prerequisites = { "mini-trains" }
stations_research.unit =
{
  count = 100,
  ingredients =
  {
	{"automation-science-pack", 1}        
  },
  time = 20
}

railway_research.prerequisites = { "mini-trains" } -- place trains after mini trains

local fluid_wagon_research = data.raw["technology"]["fluid-wagon"]
if mods["space-age"] and (settings.startup["mtlw-move-regular-to-vulcanus"].value == true) then
	-- if space age: change unlock locomotive and wagons (both cargo and fluid) at vulcanus (tungsten plate tech)
	table.insert(railway_research.prerequisites, "tungsten-steel")
	railway_research.unit =
	{
      count = 500,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    }
	fluid_wagon_research.unit =
	{
      count = 600,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1},
        {"space-science-pack", 1}
      },
      time = 60
    }
	
	-- change recipes to include tungsten plate if yes option
	for i, ingredient in pairs(data.raw.recipe["locomotive"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.name = "tungsten-plate"
		end
	end
	for i, ingredient in pairs(data.raw.recipe["cargo-wagon"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.name = "tungsten-plate"
		end
	end
	for i, ingredient in pairs(data.raw.recipe["fluid-wagon"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.name = "tungsten-plate"
		end
	end
	
else
	-- change unlock locomotive and wagons (both cargo and fluid) at logistics-3 if no space age
	table.insert(railway_research.prerequisites, "logistics-3")
	railway_research.unit =
	{
      count = 300,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 15
    }
	fluid_wagon_research.unit =
	{
      count = 400,
      ingredients =
      {
        {"automation-science-pack", 1},
        {"logistic-science-pack", 1},
        {"chemical-science-pack", 1},
        {"production-science-pack", 1}
      },
      time = 15
    }
	
end

-- adjust production science to have mini trains as prereq instead
local PSP_techbology = data.raw["technology"]["production-science-pack"]
for i = #PSP_techbology.prerequisites, 1, -1 do
  if PSP_techbology.prerequisites[i] == "railway" then
	table.remove(PSP_techbology.prerequisites, i)
  end
end
table.insert(PSP_techbology.prerequisites, "mini-trains")

-- if AAI industry: change recipe multi cilinder engine to single-cylinder engine
if mods["aai-industry"] then
	for i, ingredient in pairs(data.raw.recipe["mini-locomotive"].ingredients) do 
		if ingredient.name == "engine-unit" then
			ingredient.name = "motor"
		end
	end
end

-- if wooden logistics and with option: add lumber to mini trains
if mods["wood-logistics"] and (settings.startup["mtlw-replace-some-steel-with-lumber"].value == true) then
	
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



-- change locos and wagons recipes to include mini trains
if (settings.startup["mtlw-add-mini-to-regular"].value == true) then
table.insert(data.raw.recipe["locomotive"].ingredients, {type="item", name="mini-locomotive", amount=1})
table.insert(data.raw.recipe["cargo-wagon"].ingredients, {type="item", name="mini-cargo-wagon", amount=1})
table.insert(data.raw.recipe["fluid-wagon"].ingredients, {type="item", name="mini-fluid-wagon", amount=1})
end