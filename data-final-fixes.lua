-- remove the train recipes unlocks from the tech
if settings.startup["mtlw-regular-trains-fate"].value == "removed" then
  local railway_research = data.raw["technology"]["railway"]
  if railway_research and railway_research.effects then
    for i = #railway_research.effects, 1, -1 do
      local effect = railway_research.effects[i]
      if effect.type == "unlock-recipe" and 
         (effect.recipe == "locomotive" or effect.recipe == "cargo-wagon" or effect.recipe == "fluid-wagon") then
        table.remove(railway_research.effects, i)
      end
    end
  end
end