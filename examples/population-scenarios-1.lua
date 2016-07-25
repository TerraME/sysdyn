
-- @example Simulation of two instances of PopulationGrowth model.
-- The first one uses the default values and the second one starts
-- with a population of 20 with a growth of 90% each time step.

import("sysdyn")

env = Environment{
	PopulationGrowth{},
	PopulationGrowth{
		population = 20,
		growth = 0.9
	}
}

clean()

chart = Chart{
	target = env,
	select = "population"
}

env:add(Event{action = chart})

env:run()

