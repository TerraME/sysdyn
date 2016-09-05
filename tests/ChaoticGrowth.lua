-- Test file for ChaoticGrowth.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	ChaoticGrowth = function(unitTest)
		local c = ChaoticGrowth{finalTime = 50}
		c:run()
		unitTest:assertEquals(c.pop, 0.56, 0.1)
		unitTest:assertSnapshot(c.chart, "chaotic-growth.png", 0.05)
	end,
}

