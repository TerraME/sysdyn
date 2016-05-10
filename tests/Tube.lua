-- Test file for Tube.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Tube = function(unitTest)
		local model = Tube{}

		model:run()

		unitTest:assertSnapshot(model.chart, "tube.png")
	end,
}

