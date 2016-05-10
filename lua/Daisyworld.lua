--[[
 Author:      Gilberto Camara
 Model name:  Daisyworld
 Date:        22.11.2015
]]--

--[[
Daisy growth rate function is a function of temperature. Maximum growth 
occurs at 22.5 degrees Celsius, and daisies grow from a minimum of 5 C to 
a maximum of 40 C.
--]]

---------------------------------------------------------------------------------------
local function daisyGrowthRate(tempK) -- daisyGrowthRate as function of temperature
	local gr = 0.0
	local temp = tempK - 273
	if temp > 5.0 and temp < 40.0 then 
		gr = 1 - 0.003265 * (22.5 - temp)^2
	end  
	return gr
end

--[[ 
Calculates the average planet temperature using Boltzmann's law 

"The amount of thermal radiation emitted increases rapidly and the principal frequency of the radiation becomes higher with increasing temperatures" -- 

TempK^4 = average solar flux * luminosity (1 - albedo)

 Watson and Lovelock used 3668 watts per square meter as the solar flux,
 which is much higher than the average solar flux incident on the Earth today, 
 because the Earth has a relatively low planetary albedo and 
 a significant greenhouse effect. 
]]

local SIGMA = 5.67E-08    -- Joules / per sec * square meters * TempK^^4 -- Stephen Boltzmann constant
local SOLAR_FLUX = 3668   -- Watts/square meter

local function calcTemp(lum, albedo)
	local tempK = (lum * SOLAR_FLUX * (1 - albedo) / (4*SIGMA)) ^0.25
	return tempK 
end

--[[
Calculates the temperatures near the daisies

The local temperatures Tw and Tb are defined by making a simplifying assumption about 
the heat transfer: a linearization of a diffusion term. 
A parameter q is defined as the heat transfer coefficient, 
thereby defining the local temperatures as

TempK^4 (daisy) = q (planet_albedo - daisy_albedo) + tempK^4 (planet)
--]]

local HEAT_TRANSFER_COEF = 2.06E09  -- Kelvins^4  -- used by Watson and Lovelock

local function tempNearDaisy(planet_temp, planet_albedo, daisy_albedo)
	local temp_daisy = (HEAT_TRANSFER_COEF * (planet_albedo - daisy_albedo) +
		planet_temp ^ 4 ) ^ 0.25
	return temp_daisy
end

--[[
-- actual growthRate is constained by the empty area of the planet 
--]]
local function growthReduction(baseRate, emptyArea)
	local newRate = baseRate * emptyArea
	return newRate
end

--- An implementation of the daisy world model.
-- Wood, A. J., G. J. Ackland, J. G. Dyke, H. T. P. Williams, and T. M. Lenton (2008), 
-- Daisyworld: A review, Rev. Geophys., 46.
-- Daisyworld consists of two different types of daisy, which may be considered distinct species
-- (because there is no possibility of mixed replication of the types) or, alternatively, as
-- distinct phenotypes of the same species. The two types are identified as either black or
-- white according to their reflectivity or albedo.
-- @arg data.sunLuminosity Sun luminosity (this is the main variable of the model).
-- Values beteween 0.70 and 1.6  support life in Daisyworld.
-- @arg data.planetArea The total area of the planet. The sum of the arguments
-- whiteArea, blackArea, and emptyArea should be equals to this value. The default value is 1.
-- @arg data.whiteArea The initial area of white daisies. The default value is 0.4.
-- @arg data.blackArea The initial area of black daisies. The default value is 0.273.
-- @arg data.emptyArea The initial empty area. The default value is 0.327.
-- @arg data.whiteAlbedo The albedo of white area. The default value is 0.75.
-- @arg data.blackAlbedo The albedo of black area. The default value is 0.25.
-- @arg data.soilAlbedo The albedo of empty area. The default value is 0.5.
-- @arg data.decayRate The death rate for all daisies.
-- @arg data.finalTime The final time of the simulation. The default value is 100.
-- @image daisyworld.bmp
Daisyworld = Model {
	sunLuminosity         = 0.7, 

	-- variables 
	-- default values are approximate equilibrium values 
	-- when sun luminosity is equal to 1.0
	-- hint: change the starting conditions when changing the sun luminosity
	-- increase the white area for a strong sun
	-- increase the black area for a faint sun
	planetArea           = 1.0,
	whiteArea            = 0.40, 
	blackArea            = 0.273, 
	emptyArea            = 0.327,

	-- params (fixed assumptions)
	whiteAlbedo          = 0.75,
	blackAlbedo          = 0.25, 
	soilAlbedo           = 0.50, 
	decayRate            = 0.3,

	-- simulation time
	finalTime = 100,
	execute = function(model)
		-- gets the average albedo of the planet
		model.planetAlbedo = model.whiteArea * model.whiteAlbedo + 
			model.blackArea * model.blackAlbedo +
			model.emptyArea * model.soilAlbedo 

		-- function that calculates the planet Temperature
		model.aveTemp = calcTemp (model.sunLuminosity, model.planetAlbedo)

		-- temperature near he white daisies
		model.tempNearWhite = tempNearDaisy (model.aveTemp, 
			model.planetAlbedo, model.whiteAlbedo)

		-- indicated growth rate for the white daisies
		model.indWhiteGrowthRate = daisyGrowthRate (model.tempNearWhite)

		-- actual growthRate is constained by the empty area of the planet
		model.whiteGrowthRate = growthReduction 
			(model.indWhiteGrowthRate, model.emptyArea)
		-- white area
		model.whiteArea = model.whiteArea + model.whiteArea * 
			(model.whiteGrowthRate - model.decayRate)

		-- temperature near the black daisies
		model.tempNearBlack = tempNearDaisy (model.aveTemp, model.planetAlbedo,
			model.blackAlbedo)

		-- indicated growth rate for the white daisies
		model.indBlackGrowthRate = daisyGrowthRate (model.tempNearBlack)

		-- actual growthRate is constained by the empty area of the planet

		model.blackGrowthRate = growthReduction 
			(model.indBlackGrowthRate, model.emptyArea)
		-- white area
		model.blackArea = model.blackArea + model.blackArea * 
			(model.blackGrowthRate - model.decayRate)

		model.emptyArea = model.planetArea - (model.blackArea + model.whiteArea)
	end,
	init = function(model)
		model.chart = Chart{
			target = model,
			select = {"blackArea", "whiteArea", "emptyArea"}
		}

		model.timer = Timer{
			Event{action = model},
			Event{action = model.chart}
		}
--[[
	graphics = { timeseries = {
		{"planetAlbedo"},
		{"sunLuminosity"},
	}}
--]]
	end
}

