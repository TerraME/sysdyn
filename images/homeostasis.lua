
Random{seed = 12345}

import("sysdyn")

sa = Homeostasis{}

sa:execute()

sa.ts:save("homeostasis.bmp")
clean()

