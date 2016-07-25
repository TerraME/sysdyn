
-- @example Simulation of two instances of SIR model using
-- an educational campaign.

import("sysdyn")

env = Environment{
	SIR{maximum = 1000},
	SIR{maximum = 2000}
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

