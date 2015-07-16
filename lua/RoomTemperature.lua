
--- Simple model that simulates the temperature of three rooms.
-- @arg data.temperature1 The initial temperature of the first room. The default value is 80.
-- @arg data.temperature2 The initial temperature of the second room. The default value is 20.
-- @arg data.temperature3 The initial temperature of the third room. The default value is 5.
-- @arg data.exterior The temperature outside the rooms. The default value is 20.
-- @arg data.finalTime The final time of the simulation. The default value is 100.
-- @usage r = RoomTemperature{
--     exterior = 30
-- }
--
-- r:execute()
RoomTemperature = SysDynModel{
	temperature1 = 80,
	temperature2 = 20,
	temperature3 = 5,
	exterior = 20,
	finalTime = 100,
	changes = function(model)
		model.temperature1 = model.temperature1 - (model.temperature1 - model.exterior) / 10
		model.temperature2 = model.temperature2 - (model.temperature2 - model.exterior) / 10
		model.temperature3 = model.temperature3 - (model.temperature3 - model.exterior) / 10
	end,
	graphics = {
		timeseries = {{"temperature1", "temperature2", "temperature3"}}
	}
}

