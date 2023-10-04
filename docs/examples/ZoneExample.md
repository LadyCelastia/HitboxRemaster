Client-sided Zone example:
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HitboxRemaster = require(modules:WaitForChild("HitboxRemaster"))
local QueryFunction = ReplicatedStorage:WaitForChild("QueryFunction")
local partList = workspace.ZoneTest:GetChildren() -- All members of partList MUST be BasePart!

local Zone = HitboxRemaster.newZone({
	["CharacterResolution"] = "OnePart",
	["QueryType"] = "Full"
})
Zone:AddMemberBulk(partList)

Zone.PartEntered:Connect(function(part)
	print("Part entered! " .. part.Name)
	end)

Zone.PartLeft:Connect(function(part)
	print("Part left! " .. part.Name)
end)

Zone.CharacterEntered:Connect(function(char)
	print("Character entered! " .. char.Name)
end)

Zone.CharacterLeft:Connect(function(char)
	print("Character left! " .. char.Name)
end)

Zone.PlayerEntered:Connect(function(char)
	print("Player entered! " .. char.Name)
end)

Zone.PlayerLeft:Connect(function(char)
	print("Player left! " .. char.Name)
end)

Zone:Activate()

QueryEvent.OnClientInvoke = function()
    return Zone:GetCharactersInside()
end
```
**Note: Zone can be used the same way in both server and client.**