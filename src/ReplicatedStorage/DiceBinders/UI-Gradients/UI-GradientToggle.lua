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
	return 180
end

--[[
Return:
	each event used to disconnect the tag
--]]
return function(object)
	local originalSize = object.Size
	local flag = false
	local event
	event = object.MouseButton1Click:Connect(function()
		if not flag then
			flag = true
			local findGradient = object:FindFirstChildWhichIsA('UIGradient')
			if findGradient then
				findGradient.Rotation = findGradient.Rotation + Intensity()
			end
		else
			local findGradient = object:FindFirstChildWhichIsA('UIGradient')
			if findGradient then
				findGradient.Rotation = findGradient.Rotation - Intensity()
			end
			flag = false
		end
	end)
	return event
end