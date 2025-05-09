-- change engine unit to iron gear wheel so it will be available at automation science
for i, ingredient in pairs(data.raw.recipe["mini-locomotive"].ingredients) do 
	if ingredient.name == "engine-unit" then
		ingredient.name = "iron-gear-wheel"
		ingredient.amount = 10
	end
end

-- change locos and wagons recipes to include mini trains
if (settings.startup["mtlw-add-mini-to-regular"].value == true) then
	table.insert(data.raw.recipe["locomotive"].ingredients, {type="item", name="mini-locomotive", amount=1})
	table.insert(data.raw.recipe["cargo-wagon"].ingredients, {type="item", name="mini-cargo-wagon", amount=1})
	table.insert(data.raw.recipe["fluid-wagon"].ingredients, {type="item", name="mini-fluid-wagon", amount=1})
	end

-- Makes Mini Trains a little slower with both max speed and acceleration
if (settings.startup["mtlw-nerf-mini-trains"].value == true) then
	data.raw["locomotive"]["mini-locomotive"].max_speed = 0.6
	data.raw["locomotive"]["mini-locomotive"].max_power = "210kW"
end