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
		local event
		event = object.Touched:Connect(function(hit)
			local findPlr = game.Players:GetPlayerFromCharacter(hit.Parent)
			if findPlr then
				local findHumanoid = findPlr.Character:FindFirstChild('Humanoid')
				if findHumanoid then
					findHumanoid:TakeDamage(findHumanoid.MaxHealth)
				end
			end
		end)
		return event
	end
	return false
end