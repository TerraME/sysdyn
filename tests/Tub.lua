-- Test file for Tub.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Tub = function(unitTest)
		local model = Tub{}
		model:run()

		unitTest:assertSnapshot(model.chart, "tub.png", 0.05)

		model = Tub{finalTime = 20}
		model:run()

		unitTest:assertSnapshot(model.chart, "tub-2.png", 0.05)
	end,
}

