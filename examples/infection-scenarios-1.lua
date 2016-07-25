
-- @example Simulation of three instances of SIR model using
-- different infection durations.

import("sysdyn")

env = Environment{
	SIR{},
	SIR{duration = 4},
	SIR{duration = 8}
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

env:run()

