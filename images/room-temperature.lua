
Random{seed = 12345}

import("sysdyn")

sa = RoomTemperature{}

sa:run()

sa.chart:save("room-temperature.bmp")
clean()

