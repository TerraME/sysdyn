
RandomWalk = SysDynModel{
	value = 0,   -- initial condition
	prob  = 0.5, -- try 0.0 0.30 0.50 0.70 0.95 1.00
	finalTime = 100,
	changes = function (model)
		if  Random():number(0, 1) > model.prob then
			model.value = model.value + 1
		else
			model.value = model.value - 1
		end
	end,
	graphics = { timeseries = {{"value"}} }
}

