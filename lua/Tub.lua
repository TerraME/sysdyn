--- A simple water in the tub model.
-- @arg data.water The initial stock of water measured in gallons. The default value is 40.
-- @arg data.outFlow The flow of water outside the tub each minute. The default is 5.
-- @arg data.inFlow The flow of water into the tub each ten minutes. The default is zero.
-- @arg data.finalTime The final time of the simulation in minutes. The default value is 8.
-- @image tub.bmp
Tub = Model{
	water = 40,
	outFlow = 5,
	inFlow = 0,
	finalTime = 8,
	execute = function(model)
		model.water = model.water - model.outFlow

		if model.water < 0 then
			model.water = 0
		end
	end,
	init = function (model)
		model.chart = Chart{
			target = model,
			select = "water"
		}

		model.timer = Timer{
			Event{action = model},
			Event{start = 10, period = 10, action = function()
				model.water = model.water + model.inFlow
			end},
			Event{action = model.chart}
		}
	end
}

