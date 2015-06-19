
Homeostasis = SysDynModel{
	stock = 2.0, -- initial condition (try 0.0, 2.0, 4.0, 10.0, 100.0)
	gain = 2.0,
	rate = -0.4,
	finalTime = 30,
	changes = function (model)
		model.stock = model.stock + model.gain + model.rate * model.stock
	end,
	graphics = {
		timeseries = {{"stock"}}
	}
}

