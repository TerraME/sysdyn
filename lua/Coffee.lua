--- Simple model that simulates the temperature of three rooms.
-- @arg data.temperature1 The initial temperature of the first room. The default value is 80.
-- @arg data.temperature2 The initial temperature of the second room. The default value is 20.
-- @arg data.temperature3 The initial temperature of the third room. The default value is 5.
-- @arg data.exterior The temperature outside the rooms. The default value is 20.
-- @arg data.finalTime The final time of the simulation. The default value is 100.
-- @arg data.outside The temperature outside the room. The default value is 1.
-- @arg data.inside The temperature inside the room. The default initial value is 15.
-- @arg data.tempSet The selected temperature in the thermostat. The default value is 20.
-- @arg data.lossToOutside The percentage of heat loss every time step according to the
-- difference between the temperature inside and outside the room. The default value is 0.3.
-- @arg data.thermalInertia The percentage of input heat every time step according to the
-- difference between the temperature inside the room and the one selected in the thermostat.
-- The default value is 0.3.
-- @arg data.view A table with a boolean element timeSeries (default true) indicating whether
-- a time series chart should be drawn.
-- @image room-temperature.bmp
RoomTemperature = Model{
	tempSet     = 20.0,
	inside      = 15.0, 
	outside     =  1.0,
	climate     = function(hour)
		return  15 - 0.1 * (hour - 12) ^ 2   -- varies btw 1 and 15 degrees
	end,
	thermalInertia = 0.33, 
	lossToOutside  = 0.30,
	finalTime = 24,
	execute = function(model, event)
		local time = event:getTime()

		model.outside = model.climate(time)
		local inflow  = model.thermalInertia * (model.tempSet - model.inside)
		local outflow = model.lossToOutside  * (model.inside - model.outside)
		model.inside =  model.inside + inflow - outflow
	end,
	init = function(model)
		model.chart = Chart{
			target = model,
			select = {"inside", "tempSet", "outside"}
		}

		model.timer = Timer{
			Event{action = model},
			Event{action = model.chart}
		}
	end
}

