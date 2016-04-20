--- A model to show homeostasis taking place.
-- @arg data.stock The initial stock. The default value is 0.
-- @arg data.gain The fixed increment in the stock in each time step. The default value is 2.0.
-- @arg data.rate The rate that multiplies the stock in each time step. The default value is -0.4.
-- @arg data.finalTime The final time of the simulation. The default value is 30.
-- @image homeostasis.bmp
Tube = Model{
	water = 20,
	flow = 1,
	finalTime = 20,
	execute = function(model)
		model.water = model.water - model.flow
	end,
	init = function (model)
		model.chart = Chart{
			target = model,
			select = "water"
		}

		model.timer = Timer{
			Event{action = model},
			Event{action = model.chart}
		}
	end
}

