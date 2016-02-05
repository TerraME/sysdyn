--- A Model that describes a chaotic population growth.
-- @arg data.pop The initial population. The default value is 0.1.
-- @arg data.rate The rate that multiplies the population size in each time step. The degault value is 4.
-- @arg data.deltaTime A numeric value with the period to execute the changes of
-- the model. The default value is one.
-- @arg data.updateTime A numeric value with the period to update the charts.
-- The default value is one.
-- @arg data.finalTime The final time of the simulation. The default value is 300.
-- @arg data.view A table with two boolean elements, timeSeries and cobWeb (default true),
-- indicating whether a time series charts should be drawn.
-- @image chaotic-growth.bmp
ChaoticGrowth = Model{
	pop       = 0.10,
	rate      = 4.0,
	finalTime = 300,
	init = function(model)
		model.step = function()
			model.pop = model.rate * model.pop * (1 - model.pop)
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

