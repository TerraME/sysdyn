-- Test file for Homeostasis.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	Homeostasis = function(unitTest)
		local h = Homeostasis{}
		h:run()
		unitTest:assertEquals(h.stock, 5, 0.1)
		unitTest:assertSnapshot(h.chart, "homeostasis.png", 0.05)
	end,
}

