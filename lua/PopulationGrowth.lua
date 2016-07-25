--- Simple model that simulates the growth of two populations.
-- @arg data.population The initial size of the first population. The default value is 60.
-- @arg data.growth The growth rate of the first population. The default value is 0.5, growing
-- fifty percent in each time step.
-- @arg data.growthChange The change of the growth rate. The growth
-- rate is multiplied by this value in each time step. The default value is 1, meaning
-- that growth rate does not change.
-- @arg data.finalTime The final time of the simulation. The default value is 100.
-- @image population-growth.bmp
PopulationGrowth = Model{
	population = 60,
	growth = 0.5,
	growthChange = 1,
	finalTime = 7,
	execute = function(model)
		model.population = model.population * (1 + model.growth)
		model.growth = model.growth * model.growthChange
	end,
	init = function(model)
		model.chart = Chart{
			target = model,
			select = "population"
		}

		model.timer = Timer{
			Event{action = model},
			Event{action = model.chart}
		}
	end
}

