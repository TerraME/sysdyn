-- Test file for PredatorPrey.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	PredatorPrey = function(unitTest)
		local p = PredatorPrey{finalTime = 200}
		p:run()
		
		unitTest:assertEquals(p.predator, 65.6, 0.1)
		unitTest:assertSnapshot(p.chart1, "predator-prey-1.png", 0.1)
		unitTest:assertSnapshot(p.chart2, "predator-prey-2.png", 0.1)
	end,
}

