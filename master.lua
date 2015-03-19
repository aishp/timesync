require "cord"


	sport = 49151
	cport = 49152
	ssock = storm.net.udpsocket(sport, function (payload, srcip, srcport)   end)
	storm.os.invokePeriodically(1 * storm.os.SECOND, function()
	storm.net.sendto(ssock, storm.os.now(storm.os.SHIFT_0), "ff02::1", cport)
	end)
	cord.enter_loop()

