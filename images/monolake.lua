
Random{seed = 12345}

import("sysdyn")

sa = MonoLake{}

sa:execute()

sa.ts:save("monolake.bmp")
clean()

