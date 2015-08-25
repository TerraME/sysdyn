-- Test file for RandomWalk.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	MonoLake = function(unitTest)
		local m = MonoLake{}
		m:execute()
		
		unitTest:assertEquals(m.level, 6328.17, 0.01)
		unitTest:assertEquals(m.waterInLake, 914.38, 0.01)
	end,
}

