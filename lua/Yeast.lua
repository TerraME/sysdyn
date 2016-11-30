--- A yeast growth model.
-- @arg data.cells The initial number of cells. The default value is 9.6.
-- @arg data.capacity The total capacity of the environment. The default value is 665.
-- @arg data.rate The growth rate of the cells. The default value is 1.1.
-- @arg data.finalTime The final simulation time. The default value is 9.
-- @output finalCells A vector with the quantity of cells in each time step.
-- @image yeast.bmp
Yeast = Model{
	cells     = 9.6,
	capacity  = 665.0,
	rate      = Choice{min = 0, max = 3.5, default = 1.1},
	finalTime = 9,
	init = function(model)
		model.chart = Chart{
			target = model,
			select = {"cells"}
		}

		model.finalCells = {[0] = model.cells}

		model.timer = Timer{
			Event{action = function(event)
				model.cells = model.cells + model.cells * model.rate * (1 - model.cells / model.capacity)

				if model.cells > model.capacity then
					model.cells = model.capacity
				end

				table.insert(model.finalCells, model.cells)
			end},
			Event{action = model.chart}
		}
	end
}

