-- Test file for Daisyworld.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Daisyworld = function(unitTest)
		local model = Daisyworld{finalTime = 40}

		model:run()

		unitTest:assertSnapshot(model.chart1, "Daisyworld-chart-1.bmp", 0.1)
		unitTest:assertSnapshot(model.chart2, "Daisyworld-chart-2.bmp", 0.1)
		unitTest:assertSnapshot(model.chart3, "Daisyworld-chart-3.bmp", 0.1)
		unitTest:assertSnapshot(model.chart4, "Daisyworld-chart-4.bmp", 0.1)
	end,
}

