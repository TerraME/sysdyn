--- A model to show homeostasis taking place.
-- @arg data.stock The initial stock. The default value is 0.
-- @arg data.gain The fixed increment in the stock in each time step. The default value is 2.0.
-- @arg data.rate The rate that multiplies the stock in each time step. The default value is -0.4.
-- @arg data.finalTime The final time of the simulation. The default value is 30.
-- @image homeostasis.bmp
Homeostasis = Model{
	stock = Choice{0.0, 2.0, 4.0, 10.0, 100.0},
	gain = 2.0,
	rate = -0.4,
	finalTime = 30,
	init = function (model)
		model.step = function()
			model.stock = model.stock + model.gain + model.rate * model.stock
		end

		model.timer = Timer{
			Event{action = model}
		}

		model.chart = Chart{
			target = model,
			select = "stock"
		}
	end
}

