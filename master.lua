require "cord"
	
ack=0
count = 0
rv = 0
delay = 0

device ={}
last_recd= 0
sport = 49151
regport = 49150
cport = 49152

ssock = storm.net.udpsocket(sport, function (payload, srcip, srcport) 				
	for k,v in device do
		if v = srcip then 
			if payload == last_recd then
				ack= ack+1
			end
		end
	end --end for loop
	end)--end callback for ssock
	
rsock = storm.net.udpsocket(regport, function(payload, srcip, srcport) 
	if(device[payload] == nil) then		
		device[payload] = srcip
		count = count+1
	end
     end)--end of rsock callback

function send()

	while(ack ~= count) do
		ack = 0
		curtime= storm.os.now(storm.os.SHIFT_0)
		storm.net.sendto(ssock, curtime, "ff02::1", cport)
		last_recd = curtime
		cord.new(function()
			cord.await(storm.os.invokeLater, 10*storm.os.SECOND)
			delay = 1
		end)
	
		print("Syncing devices")
		while delay ~=1 do print(".")  end 
		delay = 0 -- finished cord.await 
	end --end of while loop
end

cord.enter_loop()

