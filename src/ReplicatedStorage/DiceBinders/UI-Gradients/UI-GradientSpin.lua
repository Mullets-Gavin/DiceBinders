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
local function Intensity()
	local findIntensity = script:FindFirstChild('Intensity')
	if findIntensity then
		return findIntensity.Value
	end
	return 5
end

--[[
Return:
	each event used to disconnect the tag
--]]
return function(object)
	local rate = 1/30
	local logged = 0
	local event
	event = Services['RunService'].Heartbeat:Connect(function(dt)
		if tick() - dt >= rate then
			local findGradient = object:FindFirstChild('UIGradient')
			if findGradient then
				findGradient.Rotation = findGradient.Rotation + Intensity()
			else
				logged = logged + 1
				if logged == 25 then
					event:Disconnect()
				end
			end
		end
	end)
	return event
end