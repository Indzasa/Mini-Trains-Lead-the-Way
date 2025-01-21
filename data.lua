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
if mods["space-age"] then
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
	-- TODO change recipe to include tungsten plate if yes option
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

if mods["wood-logistics"] then
	for i, ingredient in pairs(data.raw.recipe["mini-locomotive"].ingredients) do 
		if ingredient.name == "steel-plate" then
			ingredient.amount = 10
		end
	end
	table.insert(data.raw.recipe["mini-locomotive"].ingredients, {type="item", name="lumber", amount=5})
end

-- change recipes
--if mods["wood-logistics"] and (settings.startup["include_lumber"].value == true) then
	-- if wooden logistics and with option: add lumber to mini trains recipe (x/y steel/lumber "before" to "after")
		-- loco: 15/10 to 10/5
		-- cargo: 10/0 to 5/5
		-- fluid: 10/0 to 5/5
--end

--if (settings.startup["include_mini_trains_in_recipes"].value == true) then
	-- change locos and wagons recipes to include mini trains
--end

-- code from aai-industry
	-- remove prereq from tech
	--table.remove(tech.prerequisites, prereq)
	-- add prereq to tech
	--table.insert(data.raw.technology[tech].prerequisites, prereq)
	-- remove unneded pack from tech
	--table.remove(tech.unit.ingredients, pack)