--- Classic Lorenz Model to study chaos.
-- Lorenz, Edward Norton (1963). "Deterministic nonperiodic flow".
-- Journal of the Atmospheric Sciences 20 (2): 130-141.
-- The Lorenz system is a system of ordinary differential equations first studied by Edward Lorenz.
-- It is notable for having chaotic solutions for certain parameter values and initial conditions.
-- In particular, the Lorenz attractor is a set of chaotic solutions of the Lorenz system which, when plotted, resemble a butterfly or figure eight (from https://en.wikipedia.org/wiki/Lorenz_system).
-- @arg data.x The initial x value. Default is one.
-- @arg data.y The initial x value. Default is one.
-- @arg data.z The initial x value. Default is one.
-- @arg data.rho The value of ro from the differential equations. The default value is 28.
-- @arg data.beta The value of beta from the differential equations. The default value is 8/3.
-- @arg data.sigma The value of sigma from the differential equations. The default value is 10.
-- @arg data.delta The integration step (the model is non-linear). The default value is 0.01.
-- @arg data.finalTime The final simulation time. The default value is 10,000.
-- @image lorenz.bmp
Lorenz = Model{
	x  = 1.0,
	y = 1.0,
	z = 1.0,
	delta = 0.01,
	rho   = 28.0,
	sigma = 10.0,
	beta = 8.0 / 3.0,
	finalTime = 10000,
	init = function(model)
		model.chart1 = Chart{
			target = model,
			select = "y"
		}

		model.chart2 = Chart{
			target = model,
			select = "z",
			xAxis = "y"
		}

		model.timer = Timer{
			Event{action = function()
				local nx = model.sigma * (model.y - model.x)
				local ny = model.x * (model.rho - model.z) - model.y
				local nz = model.x * model.y - model.beta * model.z

				model.x = model.x + model.delta * nx
				model.y = model.y + model.delta * ny
				model.z = model.z + model.delta * nz
			end},
			Event{action = model.chart1},
			Event{action = model.chart2}
		}
	end
}

