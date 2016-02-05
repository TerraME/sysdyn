
-- @example Simulation of two instances of PopulationGrowth model.
-- The first one uses the default values and the second one starts
-- with a population of 20 with a growth of 90% each time step.

import("sysdyn")

pg = PopulationGrowth{}

pg:execute()

pg2 = PopulationGrowth{
	population = 20,
	growth = 0.9
}

pg2:execute()

