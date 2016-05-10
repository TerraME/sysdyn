-- Test file for PredatorPrey.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	PredatorPrey = function(unitTest)
		local p = PredatorPrey{}
		p:run()
		
		unitTest:assertEquals(p.wolves, 41, 0.1)
		unitTest:assertSnapshot(p.chart1, "predator-prey-1.png")
		unitTest:assertSnapshot(p.chart2, "predator-prey-2.png")
	end,
}

