-- Test file for ChaoticGrowth.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	ChaoticGrowth = function(unitTest)
		local c = ChaoticGrowth{finalTime = 50}
		c:execute()
		unitTest:assertEquals(c.pop, 0.56, 0.1)
	end,
}

