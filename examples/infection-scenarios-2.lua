
-- @example Simulation of three instances of SIR model using
-- different infection probabilities.

import("sysdyn")

env = Environment{
	SIR{},
	SIR{probability = 0.5},
	SIR{probability = 0.125}
}

clean()

chart = Chart{
	target = env,
	select = "infected",
}

timer = Timer{
	Event{action = chart}
}

env:add(timer)

env:run(60)

