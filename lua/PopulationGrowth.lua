
PopulationGrowth = SysDynModel{
	population1 = 60,
	population2 = 20,
	growth1 = 0.5,
	growth2 = 0.9,
	growthChange = 0.8,
	finalTime = 100,
	changes = function(model)
		model.population1 = model.population1 * (1 + model.growth1)
		model.population2 = model.population2 * (1 + model.growth2)
		model.growth1 = model.growth1 * model.growthChange
		model.growth2 = model.growth2 * model.growthChange
	end,
	graphics = {
		timeseries = {{"population1", "population2"}}
	}
}

