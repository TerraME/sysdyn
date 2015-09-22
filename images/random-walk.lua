
Random{seed = 12345}

import("sysdyn")

sa = RandomWalk{finalTime = 40}

sa:execute()

sa.ts:save("random-walk.bmp")
clean()

