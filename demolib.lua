local D={}

function D:init(memval)
	obj = { mem=memval,
	val = 0, }
	setmetatable(obj,self)
	self.__index=self
	obj.val = 2
	return self
end

function D:incmem()

	self.mem= self.mem+1
	print("Mem:"..self.mem)

end


function D:incval()

	self.val= self.val+1
	print("Mem:"..self.val)

end
