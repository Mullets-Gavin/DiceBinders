--[[
	@Author: Gavin "Mullets" Rosenthal
	@Desc: A generic function for Dice Binder module
--]]

--// services
local Services = setmetatable({}, {__index = function(cache, serviceName)
	cache[serviceName] = game:GetService(serviceName)
	return cache[serviceName]
end})

--// functions
--[[
Return:
	each event used to disconnect the tag
--]]
return function(object)
	if object:IsA('BasePart') then
		local timer = 0
		local event
		event = Services['RunService'].Heartbeat:Connect(function(dt)
			timer = timer + dt
			if timer >= 1/30 and object then
				timer = 0
				object.Velocity = object.CFrame.lookVector * 10
			end
		end)
		return event
	end
	return false
end