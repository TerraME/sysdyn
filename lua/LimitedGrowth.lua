--- A model that simulates limited growth.
-- @arg data.pop The initial population.
-- @arg data.rate The growth rate of the population.
-- @arg data.capacity The maximum amount of individuals.
-- @arg data.finalTime The number of simulation steps.
-- @arg data.view A table with a boolean element timeSeries (default true) indicating whether
-- a time series chart should be drawn.
-- @image limited-growth.bmp
LimitedGrowth = Model{
	pop    = 300,
	rate   = 0.105,
	capacity = 20000,
	finalTime = 100,
	init = function(model)
		model.step = function()
			model.pop = model.pop + model.pop * model.rate * (1 - model.pop / model.capacity)
		end

		model.timer = Timer{
			Event{action = model}
		}

		model.chart = Chart{
			target = model,
			select = "pop"
		}
	end
}

