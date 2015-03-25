require "cord"
	
	device ={}
	last_recd= 0
	sport = 49151
	regport = 49150
	cport = 49152
	ssock = storm.net.udpsocket(sport, function (payload, srcip, srcport) 
					for k,v in device do
					        
						if k= srcip then device[k]= payload end

					end --end for loop
				end)--end callback for ssock
	
	rsock = storm.net.udpsocket(regport, function(payload, srcip, srcport) 
						if(payload = "Register") then
							device[srcip] = storm.os.now(storm.os.SHIFT_0)	
						end
					     end)

function send()

	curtime= storm.os.now(storm.os.SHIFT_0)
	storm.net.sendto(ssock, curtime, "ff02::1", cport)
	cord.await(storm.os.invokeLater, 10*storm.os.SECOND)
	
	for k,v in device do
		if v~=curtime then send() end

end

storm.os.invokePeriodically(10*storm.os.SECOND, send())
	cord.enter_loop()

