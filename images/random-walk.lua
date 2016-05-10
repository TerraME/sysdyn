
Random{seed = 12345}

import("sysdyn")

sa = RandomWalk{finalTime = 40}

sa:run()

sa.chart:save("random-walk.bmp")
clean()

