-- Test file for Lorenz.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Lorenz = function(unitTest)
		local model = Lorenz{finalTime = 100}

		model:run()

		unitTest:assertSnapshot(model.chart1, "Lorenz-chart-1.bmp", 0.1)
		unitTest:assertSnapshot(model.chart2, "Lorenz-chart-2.bmp", 0.1)
	end,
}

