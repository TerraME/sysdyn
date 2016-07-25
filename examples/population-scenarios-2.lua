
-- @example Simulation of two instances of PopulationGrowth model using
-- a negative feedback in the growth change.

import("sysdyn")

env = Environment{
	PopulationGrowth{growthChange = 0.8},
	PopulationGrowth{
		population = 20,
		growth = 0.9,
		growthChange = 0.8
	}
}

clean()

chart = Chart{
	target = env,
	select = "population"
}

env:add(Event{action = chart})

env:run(30)

