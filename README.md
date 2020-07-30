<div align="center">
<h1>Dice Binders</h1>

By [Mullet Mafia Dev](https://www.roblox.com/groups/5018486/Mullet-Mafia-Dev#!/about) | [Download](https://www.roblox.com/library/5462736550/Dice-Binders) | [Source](https://github.com/Mullets-Gavin/DiceBinders)
</div>

Dice Binders is an elegant and easy solution to creating tag-based UI animations, functions, and events in your game. Inspired by Quenty's RDC 2020 talk on Binders, I realized I had been using that for animations & much more for a bit now, so it only makes sense to compile every animation I have ever created and put them in this module as an easy route for people to create UI animations seamlessly. Dice Binders allows you to simply apply your own functions as well! You can create an event that fires whenever a new tag is added or cloned on a part to execute code. I created the UI Animations based on my own previous experience on Roblox UI, and open sourcing them with my Binders module makes it easier than ever to slip in quick animations that can make your interface sharp.

## Why Dice Binders?
Dice Binders was created as an easy way to run code with tags. This handles everything you need and keeps the code nice and clean. This works exceptionally well with Roblox UI, since you can apply the pre-made tags to your UI and watch it animate. Dice Binders handles memory and prevents leaks when you remove a tag or an object with a tag. Who doesn't like being able to tag elements and watch them run right away?

## Installation
You can [grab the Roblox model here](https://www.roblox.com/library/5462736550/Dice-Binders). To download from GitHub, [go to this link](https://github.com/Mullets-Gavin/DiceBinders/releases/tag/dicebinder-v1.0) and download the most recent version. Afterwards, place the module into `ReplicatedStorage` so both the client and server can access it.

## Pre-installed Modules
**User Interface [UI]:**
Over 20+ pre-installed UI Animations you can use for click events, mouse hovering, gradient designs, and more! Check out all of the animations in my test game here:
https://www.roblox.com/games/5310533136/UI-Animations

**Obby Actions:**
To showcase my Binders module more, I included 3 Obby modules that you can use to assign tags to parts that kill a player, make the player shoot forward, or even hide the part the player jumps on!

---

**Installing the Tags:**
I tagged every module (UI/Obby) so all you have to do is make sure you have [Tiffany's Tag Editor](https://www.roblox.com/library/948084095/Tag-Editor) installed and you should be able to select the module and hit "Import" to add the tag to your editor so you can then tag your parts or UI.

## Documentation

### DiceBinders:Start
```
:Start()
```
Initialize the module in the environment called in to start tracking and watching tags.

### DiceBinders:Shutdown
```
:Shutdown()
```
Shutdown the module and disable all tags and disconnect all events.

### DiceBinders:ConnectEvents
```
:ConnectEvents(specific,func) -- specific = object, func = function
```
Connect an object with the given tag that is a descendant of the `DataModel` to a tag function in the second parameter.  A tag function is the modules that are descendants of DiceBinders with the same name as the tag given that returns a function passed with the parameters of the object to fire and connect events.

*Example:*
```lua
DiceBinders:ConnectEvents(workspace.Baseplate,function(object)
	local event
	event = object.Touched:Connect(function(hit)
		print(hit.Name,'touched',object.Name,'!')
	end)
	return event
end)
```

### DiceBinders:DisconnectEvents
```
:DisconnectEvents(specific) -- specific = object
```
Disconnect all events tied to an object which was or is parented to the `DataModel`, passed in the function `:ConnectEvents`.

### DiceBinders:DisconnectAllEvents
```
:DisconnectAllEvents(tag) -- tag = tag name
```
Disconnect all the events on a specific tag name.

### Initialize
To initialize the binder, require the module and run `:Start()` to enable the binder in the environment called.
```lua
local DiceBinders = require(game:GetService('ReplicatedStorage'):WaitForChild('DiceBinders'))
DiceBinders:Start()
```

That's it! Now you can create module scripts in the Binders module that return a function with an event to fire whenever the tag is interacted with in your game. All you have to do is name the module the same name as your tag and you should be good to go. Some example module code looks like this:
```lua
-- Obby-KillBrick.lua
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
```
---
Made with ♥ by Mullets_Gavin & Mullet Mafia Dev
