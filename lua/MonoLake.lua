--- A model for the Mono Lake problem
--- See the chapter in the "Modelling the Environment"  book, by Andrew Ford.

-- 1 KAF = 1,233,481.85 m3

--- Mono Lake first model


if not isLoaded("sci") then
	import("sci")
end

-- 1 KAF = 1,233,481.85 m3

--- Mono Lake model


-- relation btw 
waterSurface = Spline { 
    points = {  {x = 0, y = 0}, {x = 1000, y = 24.7}, 
                {x = 2000, y = 35.3}, {x = 3000, y = 48.6}, 
                {x = 4000, y = 54.3}, {x = 5000, y = 57.2}, 
                {x = 6000, y = 61.6}, {x = 7000, y = 66.0}, 
                {x = 8000, y = 69.9} },
    steps = 1000
} 

waterElevation = Spline {
    points = {{x = 0, y = 6224}, {x = 1000, y = 6335}, 
              {x = 2000, y = 6369}, {x = 3000, y = 6392}, 
              {x = 4000, y = 6412}, {x = 5000, y = 6430}, 
              {x = 6000, y = 6447}, {x = 7000, y = 6463}, 
              {x = 8000, y = 6477} },
    steps = 1000
}

precipitation = function (model)
    return waterSurface:value(model.waterInLake) * model.precRate
end

evaporation   =  function (model)
    return model.evapRate *  waterSurface:value(model.waterInLake)
end

input  = function (model, time)
    return  precipitation(model) + model.runoff + model.otherIn
end

output = function (model, time)
    return   evaporation(model) + model.export + model.otherOut
end

MonoLake = SysDynModel {
    waterInLake   = 2228.0,  --- kiloAcre * feet 
    --level         = 6337.0,
    level         = 6224,
    surf          =  0.0,
    -- input
    precRate      =   0.67,   --- feet/year
    runoff        =   150,   --- KAF/year
    otherIn       =   47.6,   --- KAF/year
    
    -- output 
    evapRate      =    3.75,   --- feet/year
    otherOut      =    33.6,    --- KAF/year
    export        =    Choice {min = 10, default = 100 },

    finalTime     =      50,
    
    changes = function (model, time)
        model.waterInLake = model.waterInLake 
                   + input (model, time) - output (model, time)
        model.level = waterElevation:value(model.waterInLake)
    end,
    
    graphics = { timeseries =  { {"level"}, {"waterInLake" }}}
}