-- Test file for Yeast.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Yeast = function(unitTest)
		local model = Yeast{}

		model:run()

		unitTest:assertSnapshot(model.chart, "Yeast-chart-1.bmp", 0.05)
	end,
}

