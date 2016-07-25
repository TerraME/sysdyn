-- Test file for PopulationGrowth.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	PopulationGrowth = function(unitTest)
		local p = PopulationGrowth{}
		p:run()
		unitTest:assertEquals(p.growthChange, 1, 0.01)
		unitTest:assertSnapshot(p.chart, "population-growth.png")
	end,
}

