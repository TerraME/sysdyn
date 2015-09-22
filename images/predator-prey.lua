
Random{seed = 12345}

import("sysdyn")

sa = PredatorPrey{}

sa:execute()

sa.ps:save("predator-prey.bmp")
clean()

