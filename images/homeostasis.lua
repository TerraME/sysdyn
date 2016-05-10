
Random{seed = 12345}

import("sysdyn")

sa = Homeostasis{}

sa:run()

sa.chart:save("homeostasis.bmp")
clean()

