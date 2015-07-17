
--- Template for Systems Dynamics Model.
-- @arg data.changes A function that describes how the system changes in each
-- time step.
-- @arg data.graphics A table with internal tables describing how the parameters
-- of the model will be drawn in the screen. It can have three values:
-- @tabular graphics
-- Graphics  & Description \
-- "timeseries" & Draw a time series. \
-- "cobweb" &  Draw a cobweb plot. \
-- "phasespace" & Draw a phase state plot.\
-- @arg data.... Any other value that can be used as parameter for the Model.
-- @usage Tube = SysDynModel{
--     water = 20,
--     changes = function(model)
--         model.water = model.water - 1
--     end
-- }
function SysDynModel(data)
	local parameters = {}

	forEachElement(data, function(idx, _, mtype)
		if mtype == "number" or mtype == "Choice" then
			parameters[idx] = true
		end
	end)

    verify(data.graphics, "System Dynamics 'graphics' must be provided")
    verify(data.changes, "System Dynamics 'changes()' must be provided")

	data.view = {}

	if data.graphics.phasespace then data.view.phaseSpace = true end
	if data.graphics.timeseries then data.view.timeSeries = true end
	if data.graphics.cobweb     then data.view.cobweb     = true end

	-- checkUnnecessaryArguments(data.graphics, {"timeseries", "phasespace", "cobweb"})

	forEachElement(data.graphics, function(graphic, value)
		forEachElement(value, function(_, mvalue)
			forEachElement(mvalue, function(_, mmvalue)
				if not parameters[mmvalue] then
					customError("Name '"..mmvalue.."' does not belong to the parameters.")
				end
			end)
		end)
	end)

	local graphics = data.graphics
	data.graphics = nil

	data.init = function(instance)
		instance.timer = Timer{
			Event{action = function()
				instance:changes()
				-- update the cobweb plot here?
			end},
			Event{start = 0, priority = "low", action = function()
				instance:notify()
			end}
		}

		if instance.view.timeSeries then
			forEachElement(graphics.timeseries, function(idx, value)
				Chart{
					target = instance,
					select = value
				}
			end)
		end

		if instance.view.phaseSpace then
			forEachElement(graphics.phasespace, function(idx, value)
				local xaxis = value[1]
				table.remove(value, 1)
	
				Chart{
					target = instance,
					select = value,
					xAxis = xaxis,
					title = "Phase Space Plot"
				}
			end)
		end

		if instance.view.cobweb then
			-- create cobweb Chart here
		end
	end

	return Model(data)
end

