
Random{seed = 12345}

import("sysdyn")

sa = PopulationGrowth{}

sa:run()

sa.chart:save("population-growth.bmp")
clean()

