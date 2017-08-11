--- A water in the dam model.
-- @arg data.water The initial stock of water measured in m³. The initial value is 5,000,000,000.
-- @arg data.inFlow1 The flow of water into the dam each first season. The default is 2e9.
-- @arg data.population The total amount of inhabitants. The default value is 1e5.
-- @arg data.consumePerPerson The total amount of water per inhabitant. The default value is 10.
-- @arg data.kWh2cubicMeters The total amount of kWh produced by cubic meters. The default value is 100.
-- @arg data.growth The comsumption amount of kWh produced by cubic meters. The default value is 100.
-- @arg data.countYear The flag in which defines whether count or not the years . The default value is false.
-- @arg data.changedYear The year in which water values change. The default value is 1970.
-- @arg data.finalTime The final time of the simulation in months. The default value is 1000.
Dam = Model{
    water = 5e9,
    inFlow1 = 2e9,
    inFlow2 = 1.5e9,
    population = 1e5,
	consumePerPerson = 10,
    kWh2cubicMeters = 100,
    growth = 0.05,
    countYear = false,
    changedYear= 1970,
    currentYear = 1950,
    finalTime = 1000,
	execute = function(self) -- each time step
        local outFlow = self.population * self.consumePerPerson * self.kWh2cubicMeters -- update outflow
        self.water = self.water - outFlow -- update water

        if self.water <= 0 then -- water amount less than zero
			self.water = 0
        elseif self.water > 5e9 then -- water amount more than dam capacity
			self.water = 5e9
		end
        if (self.countYear == true) then
            if (self.timer:getTime()%12 == 0) then -- every each year increments current year
                self.currentYear = self.currentYear + 1
                if (self.currentYear == self.changedYear) then -- when changedYear equal to currentYear
                    self.inFlow1 = self.inFlow1/2
                    self.inFlow2 = self.inFlow2/2
                end
            end
        end
	end,
	init = function (self)
		self.chart = Chart{
			target = self,
			select = "water"
		}

		self.timer = Timer{
			Event{action = self, priority = 'high'},
			Event{period = 12, action = function()
                self.water = self.water + self.inFlow1 -- first season in first semester
			end},
			Event{start = 7, period = 12, action = function()
				self.water = self.water + self.inFlow2 -- second season in second semester
			end},
            Event{start = 12, period = 12, action = function()
				self.consumePerPerson = self.consumePerPerson*(1 + self.growth) -- every year add 5%
			end},
			Event{action = self.chart}
		}
    end
}

