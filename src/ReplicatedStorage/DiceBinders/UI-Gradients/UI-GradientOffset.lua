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
		return findIntensity.Value/10
	end
	return 0.5
end

--[[
Return:
	each event used to disconnect the tag
--]]
return function(object)
	local originalOffset
	local flag = false
	local event1,event2
	event1 = object.MouseEnter:Connect(function()
		if not flag then
			flag = true
			local findGradient = object:FindFirstChildWhichIsA('UIGradient')
			if findGradient then
				if not originalOffset then
					originalOffset = findGradient.Offset
				end
				local inTween = Services['TweenService']:Create(findGradient,TweenInfo.new(0.1),{Offset = Vector2.new(originalOffset.X, Intensity())})
				inTween:Play()
			end
		end
	end)
	event2 = object.MouseLeave:Connect(function()
		if flag then
			local findGradient = object:FindFirstChildWhichIsA('UIGradient')
			if findGradient and originalOffset then
				local outTween = Services['TweenService']:Create(findGradient,TweenInfo.new(0.1),{Offset = originalOffset})
				outTween:Play()
				outTween.Completed:Wait()
			end
			flag = false
		end
	end)
	return event1,event2
end