-- Test file for LimitedGrowth.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	LimitedGrowth = function(unitTest)
		local l = LimitedGrowth{}
		l:run()

		unitTest:assertEquals(l.pop, 19968, 0.02)
		unitTest:assertEquals(l.rate, 0.1, 0.01)
		unitTest:assertSnapshot(l.chart, "limited-growth.png", 0.05)
	end,
}

