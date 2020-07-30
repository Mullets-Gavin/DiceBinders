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
	return 15
end

--[[
Return:
	each event used to disconnect the tag
--]]
return function(object)
	local originalSize = object.Size
	local flag = false
	local event
	event = object.MouseButton1Down:Connect(function()
		if not flag then
			flag = true
			local inTween = Services['TweenService']:Create(object,TweenInfo.new(0.1),{Size = UDim2.new(originalSize.X.Scale, originalSize.X.Offset - Intensity(), originalSize.Y.Scale, originalSize.Y.Offset - Intensity())})
			inTween:Play()
		else
			local outTween = Services['TweenService']:Create(object,TweenInfo.new(0.1),{Size = originalSize})
			outTween:Play()
			outTween.Completed:Wait()
			flag = false
		end
	end)
	return event
end