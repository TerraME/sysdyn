
Random{seed = 12345}

import("sysdyn")

sa = ChaoticGrowth{}

sa:run()

sa.chart:save("chaotic-growth.bmp")
clean()

