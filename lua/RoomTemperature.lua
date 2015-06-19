
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

