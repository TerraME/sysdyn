
ChaoticGrowth = SysDynModel{
	pop       = 0.10,  -- initial condition 
	rate      = 4.0,
	finalTime = 300,
	changes = function(model)
		model.pop = model.rate * model.pop * (1 - model.pop)
		return model.pop
	end,
	graphics = {
		timeseries = {{"pop"}},
		cobweb = {{"pop"}}
	}
}

