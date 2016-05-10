
Random{seed = 12345}

import("sysdyn")

sa = LimitedGrowth{}

sa:run()

sa.chart:save("limited-growth.bmp")
clean()

