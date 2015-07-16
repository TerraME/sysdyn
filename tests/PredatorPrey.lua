-- Test file for PredatorPrey.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	PredatorPrey = function(unitTest)
		local p = PredatorPrey{}
		p:execute()
		
		unitTest:assertEquals(p.wolves, 41, 0.1)
	end,
}

