# Zone
Parent class of ZoneComponent, ScriptSignal and Metafunctions. Returned by `Module.newZone(Fields)`.

## Public
### Zone.CharacterResolutionEnum
```lua
Zone.CharacterResolutionEnum -- {string: string}
```
An immutable copy of `enum.CharacterResolution`. Includes `CharacterResolutionEnum.FullBody`, `CharacterResolutionEnum.Root`, `CharacterResolutionEnum.Head` and `CharacterResolutionEnum.OnePart`.
### Zone.QueryTypeEnum
```lua
Zone.QueryTypeEnum -- {string: string}
```
An immutable copy of `enum.QueryType`. Includes `QueryTypeEnum.Full` and `QueryTypeEnum.Bounds`.
### Zone.StateEnum
```lua
Zone.StateEnum -- {string: string}
```
An immutable copy of `enum.StateEnum`. Includes `StateEnum.Paused`, `StateEnum.Active` and `StateEnum.Dead`.
### Zone.PartEntered
```lua
Zone.PartEntered -- ScriptSignal
local connection = Zone.PartEntered:Connect(function(oart)
    ...
end)
```
A ScriptSignal that fires when a part enters the Zone.
### Zone.PartLeft
```lua
Zone.PartLeft -- ScriptSignal
local connection = Zone.PartLeft:Connect(function(part)
    ...
end)
```
A ScriptSignal that fires when a part leaves the Zone.
### Zone.CharacterEntered
```lua
Zone.CharacterEntered -- ScriptSignal
local connection = Zone.CharacterEntered:Connect(function(character)
    ...
end)
```
A ScriptSignal that fires when a character (including players) enter the Zone.
### Zone.CharacterLeft
```lua
Zone.CharacterLeft -- ScriptSignal
local connection = Zone.CharacterLeft:Connect(function(character)
    ...
end)
```
A ScriptSignal that fires when a character (including players) leaves the Zone.
### Zone.PlayerEntered
```lua
Zone.PlayerEntered -- ScriptSignal
local connection = Zone.PlayerEntered:Connect(function(character)
    ...
end)
```
A ScriptSignal that fires when a player enters the Zone.
### Zone.PlayerLeft
```lua
Zone.PlayerLeft -- ScriptSignal
local connection = Zone.PlayerLeft:Connect(function(character)
    ...
end)
```
A ScriptSignal that fires when a player leaves the Zone.
### Zone.Serial
```lua
Zone.Serial -- number
```
A **readonly** number which stores the serial of the Zone. **Note: Both Hitbox and Zone share the same serial incrementation.**
