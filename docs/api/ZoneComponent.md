# ZoneComponent
Child class of Zone. Represents a part in a Zone.

## Public
### ZoneComponent.Shape
```lua
ZoneComponent.Shape -- Enum.PartType
```
The shape of the ZoneComponent.
### ZoneComponent.CFrame
```lua
ZoneComponent.CFrame -- CFrame
```
The CFrame of the ZoneComponent.
### ZoneComponent.Size
```lua
ZoneComponent.Size -- Vector3
```
The Size of the ZoneComponent.
### ZoneComponent:Query(QueryType: string, Params: OverlapParams)
```lua
local PartList = ZoneComponent:Query("Full", OverlapParams) -> {BasePart}
```
QueryType can be `Full` or `Bounds`. Returns an array of `BasePart` inside the ZoneComponent.
### ZoneComponent:GetCharacters(CharacterResolution: string, QueryType: string, Params: OverlapParams)
```lua
local CharacterList = ZoneComponent:GetCharacters("OnePart", "Bounds", OverlapParams) -> {Model}
```
CharacterResolution can be `FullBody` or `Root` or `Head` or `OnePart`. QueryType can be `Full` or `Bounds`. Returns an array of Characters inside the ZoneComponent.
### ZoneComponent:GetPlayers(CharacterResolution: string, QueryType: string, Params: OverlapParams)
```lua
local PlayerCharacterList = ZoneComponent:GetPlayers("OnePart", "Bounds", OverlapParams) -> {Model}
```
CharacterResolution can be `FullBody` or `Root` or `Head` or `OnePart`. QueryType can be `Full` or `Bounds`. Returns an array of PlayerCharacters inside the ZoneComponent.
### ZoneComponent:Destroy()
```lua
ZoneComponent:Destroy()
```
Clean and garbage collect the ZoneComponent immediately. **WARNING: Do NOT call when the ZoneComponent is a child of a Zone.**

## Private
### ZoneComponent._Part
```lua
ZoneComponent._Part -- BasePart or nil
```
An internal pointer. **WARNING: STRICTLY readonly.**
### ZoneComponent._State
```lua
ZoneComponent._State -- string
```
The current state of the ZoneComponent. Can be `Active`, `Paused` or `Dead`. If the state is `Dead`, the ZoneComponent should not be referenced anymore.
### ZoneComponent:_NewPart()
```lua
ZoneComponent:_NewPart()
```
An internal method. **WARNING: Do NOT call under any circumstance.**
