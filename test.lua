require "cord"

storm.os.invokePeriodically(storm.os.SECOND, function()
print("Hello") end)

cord.enter_loop()

