
import("sysdyn")

sir = SIR{}

sir:run()

sir.chart:save("sir.bmp")
clean()

