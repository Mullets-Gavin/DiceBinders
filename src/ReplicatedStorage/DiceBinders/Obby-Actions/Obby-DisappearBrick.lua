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
		local sources = {}
		local event
		event = object.Touched:Connect(function(hit)
			local findPlr = game.Players:GetPlayerFromCharacter(hit.Parent)
			if findPlr then
				local findHumanoid = findPlr.Character:FindFirstChild('Humanoid')
				if findHumanoid then
					if not sources[object] then
						sources[object] = true
						local changeTransparency = Services['TweenService']:Create(object,TweenInfo.new(0.5),{Transparency = 1})
						changeTransparency:Play()
						changeTransparency.Completed:Wait()
						object.CanCollide = false
						wait(2)
						local revertTransparency = Services['TweenService']:Create(object,TweenInfo.new(0.5),{Transparency = 0})
						revertTransparency:Play()
						revertTransparency.Completed:Wait()
						object.CanCollide = true
						sources[object] = false
					end
				end
			end
		end)
		return event
	end
	return false
end