require "cord"

	curtime = storm.os.now(storm.os.SHIFT_0)
	cport = 49152
	correction = 0
--	fd = io.open("drift.txt", "w")
--	io.output(file)
	first = 1
	csock = storm.net.udpsocket(cport, function (payload, srcip, srcport) 
	curtime= (storm.os.now(storm.os.SHIFT_0))/storm.os.MILLISECOND 
	mtime = (tonumber(payload))/storm.os.MILLISECOND
	if (first ==1) then
		if(curtime> mtime) then
		extra =(curtime-mtime)
		 
		else
		extra = mtime - curtime 
		
		end
		
		first = 0
	end
	if((curtime+extra) <  mtime) then 	
	drift = mtime-(curtime+extra)
	else
	drift = (curtime + extra) - mtime
	io.write(curtime .. " " ..drift) 
	print ("")
	end
	end)
	
	cord.enter_loop()
