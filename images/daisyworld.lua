
Random{seed = 12345}

import("sysdyn")

d = Daisyworld{}

d:run()

d.chart:save("daisyworld.bmp")
clean()

