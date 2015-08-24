-- Test file for RoomTemperature.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	RoomTemperature = function(unitTest)
		local r = RoomTemperature{}
		r:execute()

		unitTest:assertEquals(r.inside, 11.37, 0.01)
	end,
}

