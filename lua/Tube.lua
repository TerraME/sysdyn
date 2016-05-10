--- A simple water in the tube model.
-- @arg data.water The initial stock of water. The default value is 20.
-- @arg data.flow The flow of water outside the tube each time step. The default is one.
-- @arg data.finalTime The final time of the simulation. The default value is 30.
-- @image tube.bmp
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

