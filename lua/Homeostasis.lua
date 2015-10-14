
--- A model to show homeostasis taking place.
-- @arg data.stock The initial stock. The default value is 0.
-- @arg data.gain The fixed increment in the stock in each time step. The default value is 2.0.
-- @arg data.rate The rate that multiplies the stock in each time step. The default value is -0.4.
-- @arg data.finalTime The final time of the simulation. The default value is 30.
-- @arg data.deltaTime A numeric value with the period to execute the changes of
-- the model. The default value is one.
-- @arg data.updateTime A numeric value with the period to update the charts.
-- The default value is one.
-- @arg data.view A table with a boolean element timeSeries (default true) indicating whether
-- a time series chart should be drawn.
-- @image homeostasis.bmp
Homeostasis = SysDynModel{
	stock = Choice{0.0, 2.0, 4.0, 10.0, 100.0},
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

