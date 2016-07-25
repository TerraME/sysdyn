--- A Model that describes a chaotic population growth.
-- @arg data.pop The initial population. The default value is 0.1.
-- @arg data.rate The rate that multiplies the population size in each time step. The degault value is 4.
-- @arg data.finalTime The final time of the simulation. The default value is 300.
-- @image chaotic-growth.bmp
ChaoticGrowth = Model{
	pop       = 0.10,
	rate      = 4.0,
	finalTime = 300,
	execute = function(model)
		model.pop = model.rate * model.pop * (1 - model.pop)
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

