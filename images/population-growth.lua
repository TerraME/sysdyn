
Random{seed = 12345}

import("sysdyn")

sa = PopulationGrowth{}

sa:execute()

sa.ts:save("population-growth.bmp")
clean()

