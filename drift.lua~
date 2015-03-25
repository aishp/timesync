require "cord"

	curtime = storm.os.now(storm.os.SHIFT_0)
	cport = 49152
	correction = 0
--	fd = io.open("drift.txt", "w")
--	io.output(file)
	csock = storm.net.udpsocket(cport, function (payload, srcip, srcport) 
        curtime= storm.os.now(storm.os.SHIFT_0) + correction 
	mtime = tonumber(payload)
	--print("Before Correction:".. curtime)
	--print("Master time:"..mtime)
	if(curtime < mtime) then
		extra = mtime-curtime
        	correction = correction + extra
	--	print("Drift :"..extra)
	else 
 
		extra = curtime-mtime
        	correction = correction - extra
		
	--	print("Drift :"..extra)
	end
	extra = extra/storm.os.MILLISECOND
	io.write(extra)
		--print("correction: "..correction)
		print("")
	end) 
	
	cord.enter_loop()
