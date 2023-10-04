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
### Zone.CharacterResolution
```lua
Zone.CharacterResolution -- string
```
What part(s) of a character must be present within the Zone in order for it to be fired in CharacterEntered, CharacterLeft, PlayerEntered and PlayerLeft. Can be `FullBody`, `Root`, `Head` or `OnePart`.
### Zone.QueryType
```lua
Zone.QueryType -- string
```
Determines the type of spatial query. Can be `Full` or `Bounds`.
### Zone.Rate
```lua
Zone.Rate -- number
```
How many times a second the Zone queries. Default 10.
### Zone.OverlapParams
```lua
Zone.OverlapParams -- OverlapParams
```
The `OverlapParams` used in spatial query.
### Zone.Active
```lua
Zone.Active -- boolean
```
A **readonly** boolean which indicates whether the Zone is activated or not. **Note: You should use `Zone:Activate()` and `Zone:Deactivate()` instead.**
### Zone:AddMemberBulk(partList: {BasePart})
```lua
Zone:AddMemberBulk({part1, part2})
```
Add a list of `BaseParts` into the Zone, automatically intiating their own ZoneComponents and Metafunctions.
### Zone:AddMember(part: BasePart, Metafunctions: {string: function})
```lua
Zone:AddMember(part, metafunctions)
```
Add a `BasePart` into the Zone, automatically initiating a ZoneComponent for it. Metafunctions must be provided. **Note: Use `Zone:TranslateToMetafunction(part)` to generate a basic Metafunction that you can use.**
### Zone:TranslateToMetafunction(part: BasePart)
```lua
local metafunctions = Zone:TranslateToMetafunction(part) -> {string: function}
```
Generate a basic metafunction from `part`.
### Zone:RemoveMember(part: BasePart)
```lua
Zone:RemoveMember(part)
```
Remove `part` from the Zone if it exists, also removing all its associated ZoneComponents and Metafunctions.
### Zone:AddComponent(component: ZoneComponent)
```lua
local serial = Zone:AddComponent(component) -> number or nil
```
Add a `ZoneComponent` to the Zone directly, without the need for a `BasePart`. Returns the serial of the `ZoneComponent` if added successfully. **Note: Methods dealing with ZoneComponents directly are for advanced use-cases. Do not use unless you know what you're doing.**
### Zone:RemoveComponent(serial: number)
```lua
Zone:RemoveComponent(index: BasePart or number)
```
Remove `ZoneComponent` with `index` from the Zone. `ZoneComponent` generated from `Zone:AddMember()` and `Zone:AddMemberBulk()` have a BasePart index, while `ZoneComponent` generated from `Zone:AddComponent()` have a number index (same as its serial).
### Zone:Update()
```lua
Zone:Update()
```
Manually trigger an update of the Zone. **Note: You should call this if you change the Zone's properties or its ZoneComponents without using a built-in method.**
### Zone:Activate()
```lua
Zone:Activate()
```
Activates the Zone, resuming all spatial queries. **Note: Zones are deactivated by default when created. You must call this method for the Zone to work.**
### Zone:Deactivate()
```lua
Zone:Deactivate()
```
Deactivates the Zone, pausing all spatial queries.
### Zone:IsPartInside(part: BasePart)
```lua
local isInside = Zone:IsPartInside(part) -> boolean
```
Returns whether `part` is inside the Zone or not based on the Zone's query rules.
### Zone:IsCharacterInside(character: Model)
```lua
local isInside = Zone:IsCharacterInside(character) -> boolean
```
Returns whether `character` is inside the Zone or not based on the Zone's query rules.
### Zone:IsPlayerInside(character: Model)
```lua
local isInside = Zone:IsPlayerInside(character) -> boolean
```
Returns whether `character` is inside the Zone or not based on the Zone's query rules.
### Zone:GetPartsInside()
```lua
local partList = Zone:GetPartsInside -> {BasePart}
```
Returns a list of **all** parts inside the Zone based on the Zone's query rules. **Note: May or may not include member parts of the Zone.**
### Zone:GetCharactersInside()
```lua
local characterList = Zone:GetCharactersInside() -> {Model}
```
Returns a list of characters inside the Zone based on the Zone's query rules.
### Zone:GetPlayersInside()
```lua
local playerCharacterList = Zone:GetPlayersInside() -> {Model}
```
Returns a list of player characters inside the Zone based on the Zone's query rules.
### Zone:Destroy()
```lua
Zone:Destroy()
```
Immediately clean and garbage collect the Zone, along with all its child ZoneComponents, ScriptSignals and Metafunctions. **Note: The Zone should be dereferenced after calling this method.**

## Private
### Zone._CurrentFrame
```lua
Zone._CurrentFrame -- number
```
An internal counter of the Zone's frame cycle. **Note: This should be kept readonly.**
### Zone._CanWarn
```lua
Zone._CanWarn -- boolean
```
An internal variable that acts as throttle to prevent console spam.
### Zone._Visual
```lua
Zone._Visual -- BasePart or nil
```
**WARNING: This is STRICTLY readonly and internal. This should not be used under any circumstance.**
### Zone._MemberParts
```lua
Zone._MemberParts -- {BasePart}
```
An internal store for the Zone's member parts.
### Zone._MemberComponents
```lua
Zone._MemberComponents -- {BasePart or number: ZoneComponent}
```
An internal store for the Zone's ZoneComponents.
### Zone._PartsInside
```lua
Zone._PartsInside -- {BasePart}
```
An internal cache.
### Zone._CharactersInside
```lua
Zone._CharactersInside -- {Model}
```
An internal cache.
### Zone._PlayersInside
```lua
Zone._PlayersInside -- {Model}
```
An internal cahce.
### Zone._Destroying
```lua
Zone._Destroying -- boolean
```
An internal indicator indicating whether the Zone is being garbage collected or not. **Note: The Zone should be dereferenced if this value is `true`.**
### Zone._FirstQuery
```lua
Zone._FirstQuery -- boolean
```
An internal value. If `true`, the next query will not trigger `PartEntered`, `PartLeft`, `CharacterEntered`, `CharacterLeft`, `PlayerEntered` and `PlayerLeft`, then the value becomes `false`.

**The main enum and Metafunctions are intended to be completely private. You are not meant to access them.**