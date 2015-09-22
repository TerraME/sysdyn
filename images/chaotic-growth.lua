
Random{seed = 12345}

import("sysdyn")

sa = ChaoticGrowth{}

sa:execute()

sa.ts:save("chaotic-growth.bmp")
clean()

