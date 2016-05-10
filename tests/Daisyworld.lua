-- Test file for Daisyworld.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Daisyworld = function(unitTest)
		local model = Daisyworld{}

		model:run()
		unitTest:assertSnapshot(model.chart, "daisyworld.png")
	end,
}

