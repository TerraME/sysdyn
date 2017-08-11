-- Test file for Dam.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Dam = function(unitTest)
		local model = Dam{}

		model:run()

		unitTest:assertSnapshot(model.chart, "Dam-chart-1.bmp")

		model = Dam{countYear = true}

		model:run()

		unitTest:assertSnapshot(model.chart, "Dam-chart-2.bmp")

	end,
}

