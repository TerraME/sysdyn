
--- Simple model that simulates the temperature of three rooms.
-- @arg data.temperature1 The initial temperature of the first room. The default value is 80.
-- @arg data.temperature2 The initial temperature of the second room. The default value is 20.
-- @arg data.temperature3 The initial temperature of the third room. The default value is 5.
-- @arg data.exterior The temperature outside the rooms. The default value is 20.
-- @arg data.finalTime The final time of the simulation. The default value is 100.
RoomTemperature = SysDynModel{ 
    
    tempSet     = 20.0,
    inside      = 15.0, 
    outside     =  1.0,
    hour        =    0,
    climate     = function (hour)
                    return  15 - 0.1*(hour - 12)^2   -- varies btw 1 and 15 degrees
                end,
    thermalInertia = 0.33, 
    lossToOutside  = 0.30,
    
    finalTime = 24,
    
    changes = function (model, time)
        model.outside = model.climate (time)
        local inflow  = model.thermalInertia * (model.tempSet - model.inside)
        local outflow = model.lossToOutside  * 
                          (model.inside - model.outside)
       model.inside =  model.inside + inflow - outflow
    end,
    
    graphics = { 
		timeseries = { {"inside", "tempSet", "outside"}
                     }
        }
}
