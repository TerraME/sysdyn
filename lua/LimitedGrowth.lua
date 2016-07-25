--- A model that simulates limited growth.
-- @arg data.pop The initial population.
-- @arg data.rate The growth rate of the population.
-- @arg data.capacity The maximum amount of individuals.
-- @arg data.finalTime The number of simulation steps.
-- @image limited-growth.bmp
LimitedGrowth = Model{
	pop    = 300,
	rate   = 0.105,
	capacity = 20000,
	finalTime = 100,
	execute = function(model)
		model.pop = model.pop + model.pop * model.rate * (1 - model.pop / model.capacity)
	end,
	init = function(model)
		model.chart = Chart{
			target = model,
			select = "pop"
		}

		model.timer = Timer{
			Event{action = model},
			Event{action = model.chart}
		}
	end
}

