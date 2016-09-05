-- Test file for Coffee.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Coffee = function(unitTest)
		local model = Coffee{}

		model:run()

		unitTest:assertSnapshot(model.chart, "Coffee-chart-1.bmp", 0.05)
	end,
}

