
--- A model that simulates limited growth.
-- @arg data.pop The initial population.
-- @arg data.rate The growth rate of the population.
-- @arg data.capacity The maximum amount of individuals.
-- @arg data.finalTime The number of simulation steps.
-- @arg data.deltaTime A numeric value with the period to execute the changes of
-- the model. The default value is one.
-- @arg data.updateTime A numeric value with the period to update the charts.
-- The default value is one.
-- @arg data.view A table with a boolean element timeSeries (default true) indicating whether
-- a time series chart should be drawn.
-- @image limited-growth.bmp
LimitedGrowth = SysDynModel{ 
	pop    = 300,
	rate   = 0.105,
	capacity = 20000,
	finalTime = 100,
	changes = function (model)
		model.pop = model.pop + model.pop * model.rate * (1 - model.pop / model.capacity)
	end,
	graphics = { 
		timeseries = {{"pop"}}
	}
}

