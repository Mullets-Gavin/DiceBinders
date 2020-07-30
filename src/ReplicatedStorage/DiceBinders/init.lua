--[[
	@Author: Gavin "Mullets" Rosenthal
	@Desc: A Binder module streamlined for UI Animations & more
--]]

--[[
[DOCUMENTATION]:
	https://github.com/Mullets-Gavin/DiceBinders
	Listed below is a quick glance on the API, visit the link above for proper documentation
	View the built-in UI animations in-game here to get a feel:
	https://www.roblox.com/games/5310533136/UI-Animations

[TAG BINDERS]:
	:Start()
	:Shutdown()
	:ConnectEvents(specific,func) -- specific = object, func = function
	:DisconnectEvents(specific) -- specific = object
	:DisconnectAllEvents(tag) -- tag = tag name

[FEATURES]:
	- an easy way to handle objects with tags
	- create a module script parented to this one for custom functions
	- no memory leaks
	- works on server and client and only works on tags the environment sees
	- comes with pre-installed UI and Obby modules
	- pre-installed tags on the modules using Tiffany's Tag Editor plugin (just import)
]]--

--// logic
local Binder = {}
Binder.TempConnects = {}
Binder.Modules = {}
Binder.Tags = {}

--// services
local Services = setmetatable({}, {__index = function(cache, serviceName)
	cache[serviceName] = game:GetService(serviceName)
	return cache[serviceName]
end})

--// functions
local function GetEvents(...)
	local events = {...}
	return events
end

function Binder:ConnectEvents(specific,func) -- specific = object, func = function
	if specific:IsA('Script') or specific:IsA('ModuleScript') or specific:IsA('LocalScript') then return end
	if not Binder.TempConnects[specific] then
		Binder.TempConnects[specific] = {}
	end
	local event = GetEvents(func(specific))
	table.insert(Binder.TempConnects[specific],event)
end

function Binder:DisconnectEvents(specific) -- specific = object
	if Binder.TempConnects[specific] then
		for index,remove in pairs(Binder.TempConnects[specific]) do
			for number,connect in pairs(remove) do
				if typeof(connect) == 'RBXScriptSignal' then
					connect:Disconnect()
				end
			end
		end
		Binder.TempConnects[specific] = nil
	end
end

function Binder:DisconnectAllEvents(tag) -- tag = tag name
	local GetCurrent = Services['CollectionService']:GetTagged(tag)
	for number,obj in pairs(GetCurrent) do
		Binder:DisconnectEvents(obj)
	end
end

function Binder:Shutdown()
	for index,module in pairs(Binder.Tags) do
		Binder:DisconnectAllEvents(index)
	end
end

function Binder:Start()
	for index,modules in pairs(script:GetDescendants()) do
		if not Binder.Tags[modules.Name] then
			if modules:IsA('ModuleScript') and modules.Name ~= 'LICENSE' then
				Binder.Tags[modules.Name] = require(modules)
			end
		end
	end
	
	for index,module in pairs(Binder.Tags) do
		local GetCurrent = Services['CollectionService']:GetTagged(index)
		for number,obj in pairs(GetCurrent) do
			Binder:ConnectEvents(obj,module)
		end
		Services['CollectionService']:GetInstanceAddedSignal(index):Connect(function(object)
			Binder:ConnectEvents(object,module)
		end)
		Services['CollectionService']:GetInstanceRemovedSignal(index):Connect(function(object)
			Binder:DisconnectEvents(object)
		end)
	end
end

return Binder