-- Test file for PopulationGrowth.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	PopulationGrowth = function(unitTest)
		local p = PopulationGrowth{}
		p:execute()
		unitTest:assertEquals(p.growthChange, 0.8, 0.01)
	end,
}

