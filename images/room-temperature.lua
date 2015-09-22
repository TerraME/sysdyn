
Random{seed = 12345}

import("sysdyn")

sa = RoomTemperature{}

sa:execute()

sa.ts:save("room-temperature.bmp")
clean()

