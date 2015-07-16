-- Test file for Homeostasis.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Homeostasis = function(unitTest)
		local h = Homeostasis{}
		h:execute()
		unitTest:assertEquals(h.stock, 5, 0.1)
	end,
}

