
-- @example Two scenarios for the Tub model. One uses the model
-- with the default parameters, while the other adds an inflow
-- of 40 gallons of water each ten time steps.

import("sysdyn")

env = Environment{
	scenario1 = Tub{},
	scenario2 = Tub{inFlow = 40, finalTime = 50}
}

env:run()

