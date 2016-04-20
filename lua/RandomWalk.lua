--- Simple random walk model, where a given value can be added by one
-- or subtracted by one randomly.
-- @arg data.value The initial value. The default value is zero.
-- @arg data.prob The probability of adding one to the value in each
-- time step. The available values are 0, 0.3, 0.5 (default), 0.7, 0.95, and 1.
-- @arg data.finalTime The final time of the simulation. It should be
-- at least 10. The default value is 100.
-- @arg data.deltaTime A numeric value with the period to execute the changes of
-- the model. The default value is one.
-- @arg data.updateTime A numeric value with the period to update the charts.
-- The default value is one.
-- @arg data.view A table with a boolean element timeSeries (default true) indicating whether
-- a time series chart should be drawn.
-- @image random-walk.bmp
RandomWalk = Model{
	value = 0,
	prob  = Choice{0, 0.3, 0.5, 0.7, 0.95, 1, default = 0.5},
	finalTime = Choice{min = 10, default = 100},
	execute = function(model)
		if Random():number(0, 1) <= model.prob then
			model.value = model.value + 1
		else
			model.value = model.value - 1
		end
	end,
	init = function(model)
		model.chart = Chart{
			target = model,
			select = "value"
		}

		model.timer = Timer{
			Event{action = model},
			Event{action = model.chart}
		}
	end
}

