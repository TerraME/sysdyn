-- Test file for SIR.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	SIR = function(unitTest)
		local model = SIR{}
		model:run()

		unitTest:assertSnapshot(model.chart, "SIR-chart-1.bmp", 0.1)

		model = SIR{maximum = 1000}
		model:run()

		unitTest:assertSnapshot(model.chart, "SIR-chart-2.bmp", 0.1)
	end,
}

