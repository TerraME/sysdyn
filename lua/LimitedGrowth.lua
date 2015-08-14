
LimitedGrowth = SysDynModel{ 
    
    pop    = 300,
    rate   = 0.105,
    capacity = 20000,
    finalTime = 100,
    changes = function (model)
            model.pop = model.pop + model.pop * model.rate * ( 1 - model.pop/model.capacity)
    end,
    
    graphics = { 
		timeseries = { {"pop"},
                     }
        }
}

-- https://zoom.us/j/718763698