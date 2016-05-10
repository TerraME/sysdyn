
Random{seed = 12345}

import("sysdyn")

sa = PredatorPrey{}

sa:run()

sa.chart1:save("predator-prey.bmp")
clean()

