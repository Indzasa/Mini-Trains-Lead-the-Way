function replace_ingredient(recipe, old, new, amount, multiply)
	if recipe ~= nil and recipe.ingredients ~= nil then
    for i, existing in pairs(recipe.ingredients) do
      if existing.name == new then
        return
      end
    end
		for i, ingredient in pairs(recipe.ingredients) do 
			if ingredient.name == old then 
        ingredient.name = new 
        if amount then
          if multiply then
            ingredient.amount = amount * ingredient.amount
          else
            ingredient.amount = amount
          end
        end
      end
		end
	end
end


if mods["aai-industry"] then
	-- change recipe multi cilinder engine to single-cylinder engine 1:1 ratio?
	-- if AAI industry: change recipe multi cilinder engine to single-cylinder engine
	replace_ingredient("mini-locomotive", "engine-unit", "motor")
end