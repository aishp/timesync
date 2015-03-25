local TS = {}
function TS:init()
	
	obj = { 
		sign = 1, --1 to add correction, 0 to subtract correction
		cport=49152,
		correction=0,
		ltime = storm.os.now(storm.os.SHIFT_0),
		csock = nil,
		}
	setmetatable(obj,self)
	self.__index=self
--	print("Init time:"..obj.ltime)
	obj.csock=storm.net.udpsocket(obj.cport,
			function(payload, srcip, srcport)
--				print("Received Master time:"..payload)
				if(tonumber(payload) > storm.os.now(storm.os.SHIFT_0)) then 
					obj.correction = tonumber(payload) - storm.os.now(storm.os.SHIFT_0)
					sign = 1
				else
					obj.correction = storm.os.now(storm.os.SHIFT_0) - tonumber(payload)
					sign = 0
				end
			end)
	return obj
end

function TS:sync()
	
	local curtime = storm.os.now(storm.os.SHIFT_0)	
	
	if(sign == 1) then
--	print("Current time after sync:"..curtime+self.correction)
		self.ltime = curtime + self.correction
	else
		self.ltime = curtime - self.correction
	end
end

function TS:showtime()
	
	if(sign == 1) then 
	print(storm.os.now(storm.os.SHIFT_0)+ self.correction)
	else
	print(storm.os.now(storm.os.SHIFT_0)- self.correction)
	end
end

return TS
