
-- @example Three scenarios for the Coffee model. One starts with
-- temperature above the room's temperature, one with the temperature
-- equals to the room, end the last one starts with temperature below
-- the room.

import("sysdyn")

env = Environment{
	Coffee{},
	Coffee{temperature = 20},
	Coffee{temperature = 5}
}

clean()

chart = Chart{
	target = env,
	select = "temperature"
}

env:add(Event{action = chart})

env:run()

