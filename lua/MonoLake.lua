if not isLoaded("sci") then
	import("sci") -- SKIP
end

-- relation btw 
local waterSurface = Spline{ 
	points = {
		{x = 0,    y = 0},
		{x = 1000, y = 24.7}, 
		{x = 2000, y = 35.3},
		{x = 3000, y = 48.6}, 
		{x = 4000, y = 54.3},
		{x = 5000, y = 57.2}, 
		{x = 6000, y = 61.6},
		{x = 7000, y = 66.0}, 
		{x = 8000, y = 69.9}
	},
	steps = 1000
} 

local waterElevation = Spline{
	points = {
		{x = 0,    y = 6224},
		{x = 1000, y = 6335}, 
		{x = 2000, y = 6369},
		{x = 3000, y = 6392}, 
		{x = 4000, y = 6412},
		{x = 5000, y = 6430}, 
		{x = 6000, y = 6447},
		{x = 7000, y = 6463}, 
		{x = 8000, y = 6477}
	},
	steps = 1000
}

local function precipitation(model)
	return waterSurface:value(model.waterInLake) * model.precRate
end

local function evaporation(model)
	return model.evapRate *  waterSurface:value(model.waterInLake)
end

local function input(model, time)
	return precipitation(model) + model.runoff + model.otherIn
end

local function output(model, time)
	return evaporation(model) + model.export + model.otherOut
end

--- A model for the Mono Lake problem.
-- See the chapter in the "Modelling the Environment"  book, by Andrew Ford.
-- This is the implementation of Mono Lake's first model.
-- @arg data.export The amount of water taken out from the lake in KAF/year.
-- 1 KAF = 1,233,481.85 m3.
-- @arg data.waterInLake The amount of water in the lake in the beginning of the
-- simulation.
-- @arg data.level The initial level of the lake. It is updated every time step
-- according to the amount of water in the lake.
-- @arg data.precRate The precipitation rate in feet/year.
-- @arg data.runoff The amount of water that gets in the lake by runoff in KAF/year.
-- @arg data.otherIn Other inputs of water to the lake in KAF/year.
-- @arg data.evapRate The evaporation rate in feet/year.
-- @arg data.otherOut Other output of water from the lake in KAF/year.
-- @arg data.finalTime The final time of the simulation. The default value is 50.
-- @arg data.view A table with a boolean element timeSeries (default true) indicating whether
-- a time series chart should be drawn.
-- @image monolake.bmp
MonoLake = Model{
	waterInLake   = 2228.0,  -- kiloAcre * feet 
	level         = 6224,
	-- input
	precRate      = 0.67,    -- feet/year
	runoff        = 150,     -- KAF/year
	otherIn       = 47.6,    -- KAF/year

	-- output 
	evapRate      = 3.75,    -- feet/year
	otherOut      = 33.6,    -- KAF/year
	export        = Choice {min = 10, default = 100},

	finalTime     = 50,

	init = function(model)
		model.step = function(model, event)
			local time = event:getTime()
			model.waterInLake = model.waterInLake 
				+ input(model, time) - output(model, time)
			model.level = waterElevation:value(model.waterInLake)
		end

		model.timer = Timer{
			Event{action = model}
		}

		model.chart1 = Chart{
			target = model,
			select = "level"
		}

		model.chart2 = Chart{
			target = model,
			select = "waterInLake"
		}
	end
}

