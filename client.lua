local TS = {}
ltime = storm.os.now(storm.os.SHIFT_0)
function TS:init()
	
	obj = { 
		cport=49152,
		correction=0,
		ltime = storm.os.now(storm.os.SHIFT_0),
		csock=storm.net.udpscket(cport,
			function(payload, srcip, srcport)
				correction = payload-ltime
			end),
		}
	setmetatable(obj,self)
	self._index=self
	return obj
end

function TS:sync()
	
	local curtime = storm.os.now(storm.os.SHIFT_0)	
	self.ltime = curtime+correction
end

function TS:showtime()
	
	print(storm.os.now(STORM.OS.SHIFT_0)+ self.correction)
end
