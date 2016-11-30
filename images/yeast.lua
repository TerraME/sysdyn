
Random{seed = 12345}

import("sysdyn")

y = Yeast{}

y:run()

y.chart:save("yeast.bmp")
clean()

