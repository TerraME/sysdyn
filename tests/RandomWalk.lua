-- Test file for RandomWalk.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	RandomWalk = function(unitTest)
		local r = RandomWalk{}
		r:run()

		unitTest:assertEquals(r.value, -4)
		unitTest:assertSnapshot(r.chart, "random-walk.png", 0.1)
	end,
}

