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
	return 10
end

--[[
Return:
	each event used to disconnect the tag
--]]
return function(object)
	local originalPosition = object.Position
	local flag = false
	local event1,event2
	event1 = object.MouseEnter:Connect(function()
		if not flag then
			flag = true
			local inTween = Services['TweenService']:Create(object,TweenInfo.new(0.1),{Position = UDim2.new(originalPosition.X.Scale, originalPosition.X.Offset, originalPosition.Y.Scale, originalPosition.Y.Offset + Intensity())})
			inTween:Play()
		end
	end)
	event2 = object.MouseLeave:Connect(function()
		if flag then
			local outTween = Services['TweenService']:Create(object,TweenInfo.new(0.1),{Position = originalPosition})
			outTween:Play()
			outTween.Completed:Wait()
			flag = false
		end
	end)
	return event1,event2
end