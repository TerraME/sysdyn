
--- Simple model that simulates the growth of two populations.
-- @arg data.population1 The initial size of the first population. The default value is 60.
-- @arg data.population2 The initial size of the second population. The default value is 20.
-- @arg data.growth1 The growth rate of the first population. The default value is 0.5, growing
-- fifty percent in each time step.
-- @arg data.growth2 The growth rate of the second population. The default value is 0.9, growing
-- ninety percent in each time step.
-- @arg data.growthChange The change of the growth rate. The growth
-- rate is multiplied by this value in each time step.
-- @arg data.finalTime The final time of the simulation. The default value is 100.
-- @arg data.deltaTime A numeric value with the period to execute the changes of
-- the model. The default value is one.
-- @arg data.updateTime A numeric value with the period to update the charts.
-- The default value is one.
-- @arg data.view A table with a boolean element timeSeries (default true) indicating whether
-- a time series chart should be drawn.
-- @image population-growth.bmp
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

