
local function consistencyCheck(data)
	local parameters = {}
	forEachElement(data, function(idx, _, mtype)
		if mtype == "number" or mtype == "Choice" then
			parameters[idx] = true
		end
	end)

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

--- Template for Systems Dynamics Model.
-- @arg data.changes A function that describes how the system changes in each
-- time step.
-- @arg data.graphics A table with internal tables describing how the parameters
-- of the model will be drawn in the screen. It can have three values:
-- @tabular graphics
-- Graphics  & Description \
-- "timeseries" & A table with internal tables describing sets of attributes to be
-- drawn with time as x axis. \
-- "cobweb" &  Draw a cobweb plot. Not implemented yet. \
-- "phasespace" & A table with internal tables with the attributes to be drawn
-- as a phase space. The first attribute of every internal table will be used as
-- @arg data.deltaTime A numeric value with the period to execute the changes of
-- the model. The default value is one.
-- @arg data.updateTime A numeric value with the period to update the charts.
-- The default value is one.
-- x axis.
-- @arg data.... Any other value that can be used as parameter for the Model.
-- @usage Tube = SysDynModel{
--     water = 20,
--     changes = function(model)
--         model.water = model.water - 1
--     end,
--     graphics = {
--         timeseries = {{"water"}},
--     }
-- }
function SysDynModel(data)
	verify(data.graphics, "System Dynamics 'graphics' must be provided")
	verify(data.changes, "System Dynamics 'changes()' must be provided")

	consistencyCheck(data)

	defaultTableValue(data, "deltaTime", 1)
	defaultTableValue(data, "updateTime", 1)

	data.view = {}

	if data.graphics.phasespace then data.view.phaseSpace = true end
	if data.graphics.timeseries then data.view.timeSeries = true end
	if data.graphics.cobweb     then data.view.cobweb     = true end

	forEachElement(data.graphics, function(idx)
		if type(idx) ~= "string" then
			customError("Argument 'graphics' should have only string indexes, got "..type(idx)..".")
		elseif not belong(idx, {"phasespace", "timeseries", "cobweb"}) then
			customError("Invalid name for graphics: "..idx..".")
		end 
	end)
	data.start = data.init

	if not data.start then data.start = function() end end

	local graphics = data.graphics
	data.graphics = nil

	data.init = function(instance)
		if instance.deltaTime  == 1 then instance.deltaTime  = nil end
		if instance.updateTime == 1 then instance.updateTime = nil end

		instance.timer = Timer{
			Event{priority = "high", action = function (ev)
				instance:start()
				return false
			end},
			Event{period = instance.deltaTime, action = function (ev)
				instance:changes(ev:getTime())
				-- update the cobweb plot here?
			end},
			Event{start = 0, period = instance.updateTime, priority = "low", action = function()
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

