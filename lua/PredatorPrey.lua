--- Model that implements predatory-prey dynamics.
-- @arg data.predator A number between 10 and 40 with the initial number of predators.
-- @arg data.prey A number between 100 and 1000 with the initial number of preys.
-- @arg data.preyGrowth A number between 0.01 and 1 with the probability of a prey
-- to reproduce. The default value is 0.08.
-- @arg data.preyDeathPred A number between 0.0001 and 0.01 with the probability of a prey
-- to be killed by a predator. The default value is 0.001.
-- @arg data.predDeath A number between 0.001 and 0.5 with the probability of a predator
-- to die. The default value is 0.02.
-- @arg data.predGrowthKills A number between 0 and 0.01 with the increase in the size of the
-- predator population per eack prey killed. The default value is 0.00002.
-- @arg data.finalTime The final time of the simulation. The minimum value is 50 and the
-- default value is 500.
-- @arg data.period The time interval where the number of predators and preys are updated.
-- The observation of the model occurs at one time step, therefore if this value is 0.1 then
-- it will update the populations ten times for each update in the charts.
-- @image predator-prey.bmp
PredatorPrey = Model{
	predator        = Choice{min = 1,                   default = 40},
	prey            = Choice{min = 1,                   default = 1000},
	preyGrowth      = Choice{min = 0.000001, max = 1,   default = 0.08},
	preyDeathPred   = Choice{min = 0.000001, max = 0.5, default = 0.001},
	predDeath       = Choice{min = 0.000001, max = 0.5, default = 0.02},
	predGrowthKills = Choice{min = 0,        max = 0.5, default = 0.00002},
	finalTime       = Choice{min = 5,                   default = 500},
	period          = Choice{min = 0.0001,              default = 1},
	execute = function(model)
		model.prey = model.prey + model.preyGrowth * model.prey
		                - model.preyDeathPred * model.prey * model.predator

		model.predator = model.predator - model.predDeath * model.predator
		              + model.predGrowthKills * model.prey * model.predator
	end,
	init = function(model)
		model.chart1 = Chart{
			target = model,
			select = {"prey", "predator"}
		}

		model.chart2 = Chart{
			target = model,
			select = "predator",
			xAxis = "prey"
		}

		if model.period == 1 then model.period = nil end

		model.timer = Timer{
			Event{action = model, period = model.period},
			Event{action = model.chart1},
			Event{action = model.chart2}
		}
	end
}

