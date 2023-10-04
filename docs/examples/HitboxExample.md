Simple melee weapon (server):
```lua
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HitboxRemaster = require(modules:WaitForChild("HitboxRemaster"))
local Tool = script.Parent
local Handle = Tool:WaitForChild("Handle")
local Debounce = true

Tool.Activated:Connect(function()
    if Debounce == false then
        return
    end
    Debounce = false
    task.delay(1, function()
        Debounce = true
    end)
    local Hitbox = HitboxRemaster.newHitbox({
		["Pierce"] = 3
	})
    Hitbox.CopyCFrame = Handle
    Hitbox.Hit:Connect(function(Humanoid, HitPart, DataBundle)
        if Hitbox:IsHitboxBackstab(HitPart, DataBundle) == true then
            Humanoid:TakeDamage(20)
        else
            Humanoid:TakeDamage(10)
        end
    end)
    Hitbox:Activate()
end)
```
**Note: Hitbox can also be used on client.**