-- Test file for Tub.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Tub = function(unitTest)
		local model = Tub{}

		model:run()

		unitTest:assertSnapshot(model.chart, "tub.png")
	end,
}

