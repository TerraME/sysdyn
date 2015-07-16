-- Test file for RandomWalk.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	RandomWalk = function(unitTest)
		local r = RandomWalk{}
		r:execute()
		
		unitTest:assertEquals(r.value, 2)
	end,
}

