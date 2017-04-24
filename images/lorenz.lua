
import("sysdyn")

l = Lorenz{}

l:run()

l.chart2:save("lorenz.bmp")
clean()

