
Random{seed = 12345}

import("sysdyn")

sa = MonoLake{}

sa:run()

sa.chart1:save("monolake.bmp")
clean()

