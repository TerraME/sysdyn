
Random{seed = 12345}

import("sysdyn")

sa = LimitedGrowth{}

sa:execute()

sa.ts:save("limited-growth.bmp")
clean()

