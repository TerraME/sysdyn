-- Test file for RandomWalk.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	MonoLake = function(unitTest)
		local m = MonoLake{}
		m:run()
		
		unitTest:assertEquals(m.level, 6328.17, 0.01)
		unitTest:assertEquals(m.waterInLake, 914.38, 0.01)
		unitTest:assertSnapshot(m.chart1, "monolake-1.png")
		unitTest:assertSnapshot(m.chart2, "monolake-2.png")
	end,
}

