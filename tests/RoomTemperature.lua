-- Test file for RoomTemperature.lua
-- Author: Gilberto Camara and Pedro R. Andrade

return{
	RoomTemperature = function(unitTest)
		local r = RoomTemperature{}
		r:run()

		unitTest:assertEquals(r.inside, 11.37, 0.01)
		unitTest:assertSnapshot(r.chart, "room-temperature.png", 0.05)
	end,
}

