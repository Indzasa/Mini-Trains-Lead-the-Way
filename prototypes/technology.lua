-- remove rails and iron sticks from regular trains technology
local railway_research = data.raw["technology"]["railway"]
for k, v in pairs(railway_research.effects) do
	if v.type == "unlock-recipe" and v.recipe == "rail" then
		table.remove(railway_research.effects, k)
	end
	if v.type == "unlock-recipe" and v.recipe == "iron-stick" then
		table.remove(railway_research.effects, k)
	end
end

-- add rails and iron sticks to mini trains technology
local mini_trains_research = data.raw["technology"]["mini-trains"]
mini_trains_research.prerequisites = { "logistics", "steel-processing" }
table.insert(mini_trains_research.effects, {type = "unlock-recipe",recipe = "rail"})
table.insert(mini_trains_research.effects, {type = "unlock-recipe",recipe = "iron-stick"})

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

-- change unlock locomotive and cargo wagons at logistics-3 if no space age
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

-- Changes for fluid wagons:
local fluid_wagon_research = data.raw["technology"]["fluid-wagon"]

-- adjust fluid wagon research to require mini trains technology instead of regular trains
for i = #fluid_wagon_research.prerequisites, 1, -1 do
  if fluid_wagon_research.prerequisites[i] == "railway" then
	table.remove(fluid_wagon_research.prerequisites, i)
  end
end
table.insert(fluid_wagon_research.prerequisites, "mini-trains")

-- change fluid wagon research to unlock mini fluid wagon instead of regular fluid wagon
for k, v in pairs(fluid_wagon_research.effects) do
	table.insert(fluid_wagon_research.effects, {type = "unlock-recipe",recipe = "mini-fluid-wagon"})	
	if v.type == "unlock-recipe" and v.recipe == "fluid-wagon" then
		table.remove(fluid_wagon_research.effects, k)
	end
end

-- remove mini fluid wagon from mini trains research
local mini_trains_research = data.raw["technology"]["mini-trains"]
for k, v in pairs(mini_trains_research.effects) do
	if v.type == "unlock-recipe" and v.recipe == "mini-fluid-wagon" then
		table.remove(mini_trains_research.effects, k)
	end
end

-- add fuild wagon to regular trains research
table.insert(railway_research.effects, {type = "unlock-recipe",recipe = "fluid-wagon"})

-- adjust fluid wagon research cost to require just automation and logistic science
fluid_wagon_research.unit =
{
  count = 120,
  ingredients =
  {
	{"automation-science-pack", 1},
	{"logistic-science-pack", 1},
  },
  time = 20
}

-- adjust production science to have mini trains as prereq instead
local PSP_technology = data.raw["technology"]["production-science-pack"]
for i = #PSP_technology.prerequisites, 1, -1 do
  if PSP_technology.prerequisites[i] == "railway" then
	table.remove(PSP_technology.prerequisites, i)
  end
end
table.insert(PSP_technology.prerequisites, "mini-trains")

-- adjust braking force technologies
local brake1_technology = data.raw["technology"]["braking-force-1"]
local brake3_technology = data.raw["technology"]["braking-force-3"]
for i = #brake1_technology.prerequisites, 1, -1 do
  if brake1_technology.prerequisites[i] == "railway" then
	table.remove(brake1_technology.prerequisites, i)
  end
end
table.insert(brake1_technology.prerequisites, "mini-trains")
table.insert(brake3_technology.prerequisites, "railway")
