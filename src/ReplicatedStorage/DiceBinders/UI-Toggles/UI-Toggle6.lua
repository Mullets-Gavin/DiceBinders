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
	return 0.2
end

--[[
Return:
	each event used to disconnect the tag
--]]
return function(object)
	local originalColor
	if object:IsA('ImageButton') or object:IsA('ImageLabel') then
		originalColor = object.ImageColor3
	else
		originalColor = object.BackgroundColor3
	end
	local flag = false
	local event
	event = object.MouseButton1Click:Connect(function()
		if not flag then
			flag = true
			local inTween
			if object:IsA('ImageButton') or object:IsA('ImageLabel') then
				inTween = Services['TweenService']:Create(object,TweenInfo.new(0.1),{ImageColor3 = Color3.new(originalColor.r + Intensity(), originalColor.g + Intensity(), originalColor.b + Intensity())})
			else
				inTween = Services['TweenService']:Create(object,TweenInfo.new(0.1),{BackgroundColor3 = Color3.new(originalColor.r + Intensity(), originalColor.g + Intensity(), originalColor.b + Intensity())})
			end
			inTween:Play()
		else
			local outTween
			if object:IsA('ImageButton') or object:IsA('ImageLabel') then
				outTween = Services['TweenService']:Create(object,TweenInfo.new(0.1),{ImageColor3 = originalColor})
			else
				outTween = Services['TweenService']:Create(object,TweenInfo.new(0.1),{BackgroundColor3 = originalColor})
			end
			outTween:Play()
			outTween.Completed:Wait()
			flag = false
		end
	end)
	return event
end