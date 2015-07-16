-- Test file for SysDyn.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	SysDynModel = function(unitTest)
		local r = SysDynModel{
			value = 10,
			finalTime = 10,
			changes = function(model)
				model.value = model.value - 1
			end,
			graphics = {
				timeseries = {{"value"}}
			} 
		}

		local result = r:execute()
		unitTest:assertEquals(result.value, 0)

		local p = PredatorPrey{}
	end,
}

