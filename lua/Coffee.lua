--- Simple model that simulates the temperature of a cup of coffee.
-- @arg data.temperature The initial temperature of the cup of coffee. The default value is 80.
-- @arg data.finalTime The final time of the simulation in minutes. The default value is 20.
-- @arg data.roomTemperature The temperature of the room. The default value is 20.
-- @image coffee.bmp
Coffee = Model{
	temperature     = 80,
	roomTemperature = 20,
	finalTime       = 20,
	execute = function(model)
		local difference = model.temperature - model.roomTemperature
		model.temperature =  model.temperature - difference * 0.1
	end,
	init = function(model)
		model.chart = Chart{
			target = model,
			select = {"temperature"}
		}

		model.timer = Timer{
			Event{action = model},
			Event{action = model.chart}
		}
	end
}

