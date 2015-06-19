
--- Template for Systems Dynamics Model
function SysDynModel(data)
	local parameters = {}

	forEachElement(data, function(idx, _, mtype)
		if mtype == "number" or mtype == "Choice" then
			parameters[idx] = true
		end
	end)

	if data.graphics then
		data.view = {}

		if data.graphics.phasespace then data.view.phaseSpace = true end
		if data.graphics.timeseries then data.view.timeSeries = true end

		forEachElement(data.graphics, function(graphic, value)
			forEachElement(value, function(_, mvalue)
				forEachElement(mvalue, function(_, mmvalue)
					if not parameters[mmvalue] then
						customError("Name '"..mmvalue.."' does not belong to the parameters.")
					end
				end)
			end)
		end)

	end

	local graphics = data.graphics
	data.graphics = nil
	data.init = function(instance)
		instance.timer = Timer{
			Event{action = function()
				instance:changes()
			end},
			Event{time = 0, priority = "low", action = function()
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
	end

	return Model(data)
end


