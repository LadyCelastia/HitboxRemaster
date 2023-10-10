# Hitbox
The main Hitbox class returned by `Module.newHitbox(Fields)`.

### Module.newHitbox(Fields: {string: any})
```lua
local hitbox = Module.newHitbox({
    Attachment = attachment or nil,
    Shape = ("Box" or "Sphere") or "Box",
    Position = Vector3 or Vector3.new(0, 0, 0),
    Debounce = number or 5,
    Pierce = number or 1,
    LifeTime = number or 1,
    Orientation = Vector3 or nil,
    CopyCFrame = BasePart or nil,
    Radius = number or 3,
    Size = Vector3 or Vector3.new(3, 3, 3),
    FilterType = Enum.RaycastFilterType or Enum.RaycastFilterType.Exclude,
    FilterDescendantsInstances = {Instance} or {},
    RespectCanCollide = boolean or false,
    MaxParts = number or 0
}) -> Hitbox
```
Create a new Hitbox object. Fields are optional.

## Public
### Hitbox.ShapeEnum
```lua
Hitbox.ShapeEnum -- {string: string}
```
An immutable copy of `enum.Shape`. Includes `ShapeEnum.Box` and `ShapeEnum.Sphere`.
### Hitbox.ModeEnum
```lua
Hitbox.ModeEnum -- {string: string}
```
An immutable copy of `enum.HitboxMode`. Includes `ModeEnum.None`, `ModeEnum.Attachment`, `ModeEnum.Linear`, `ModeEnum.Bezier`, `ModeEnum.Orientation` and `ModeEnum.Copying`
### Hitbox.StateEnum
```lua
Hitbox.StateEnum -- {string: string}
```
An immutable copy of `enum.StateEnum`. Includes `StateEnum.Paused`, `StateEnum.Active` and `StateEnum.Dead`.
### Hitbox.ConstructionEnum
```lua
Hitbox.ConstructionEnum -- {string: string}
```
An immutable copy of `enum.ConstructionMode`. Includes `ConstructionEnum.None`, `ConstructionEnum.Linear` and `ConstructionEnum.Bezier`.
### Hitbox.BezierEnum
```lua
Hitbox.BezierEnum -- {string: string}
```
An immutable copy of `enum.BezierMode`. Includes `BezierEnum.Quadratic` and `BezierEnum.Cubic`.
### Hitbox.Serial
```lua
Hitbox.Serial -- number
```
A **readonly** number that is the Hitbox's unique serial. **WARNING: Do NOT change under any circumstance.**
### Hitbox.Shape
```lua
Hitbox.Shape -- string
```
The current shape of the Hitbox. Can be `Box` or `Sphere`.
### Hitbox.Position
```lua
Hitbox.Position -- Vector3
```
The current center position of the Hitbox. **Note: Any changes will be prevented if the Hitbox is currently using a bezier path.**
### Hitbox.Pierce
```lua
Hitbox.Pierce -- number
```
How many Humanoids can the Hitbox hit in total.
### Hitbox.Debounce
```lua
Hitbox.Debounce -- number
```
How many seconds have to pass before the Hitbox can hit the same Humanoid again.
### Hitbox.LifeTime
```lua
Hitbox.LifeTime -- number
```
How many seconds the Hitbox has left before it automatically cleans and garbage collects itself. Only counts down while the Hitbox is activated. **Note: This property does not countdown if the Hitbox is currently using a bezier path. The Hitbox will clean itself when it reaches the end of the bezier path instead.**
### Hitbox.Orientation
```lua
Hitbox.Orientation -- Vector3
```
The orientation of the Hitbox. **Note: CopyCFrame overrides this property.**
### Hitbox.CopyCFrame
```lua
Hitbox.CopyCFrame -- BasePart
```
A part which the Hitbox will copy Position, Size and Orientation from. **WARNING: Overrides orientation and all constructed paths. Does NOT override `Hitbox.Shape`**
### Hitbox.OverlapParams
```lua
Hitbox.OverlapParams -- OverlapParams
```
The `OverlapParams` that's used for spatial query.
### Hitbox.Active
```lua
Hitbox.Active -- boolean
```
A **readonly** boolean that displays whether the Hitbox is currently active or not. **Note: You should change this with `Hitbox:Activate()` and `Hitbox:Deactivate()` instead.**
### Hitbox.Radius
```lua
Hitbox.Radius -- number
```
The radius of the Hitbox. Used if `Hitbox.Shape` is `Sphere`. **Note: CopyCFrame overrides this property.**
### Hitbox.Size
```lua
Hitbox.Size -- Vector3
```
The size of the Hitbox. Used if `Hitbox.Shape` is `Box`. **Note: CopyCFrame overrides this property.**
### Hitbox.Trajectory
```lua
Hitbox.Trajectory -- Trajectory
```
The child Trajectory class of the Hitbox. Used for path construction.
### Hitbox.Hit
```lua
Hitbox.Hit -- ScriptSignal
Hitbox.Hit:Connect(function(Humanoid, HitPart, HitboxDataBundle)
    ...
end)
```
The child ScriptSignal class of the Hitbox. It is fired whenever the Hitbox hits a Humanoid that does not have a ForceField, is not on Debounce and is not dead.
### Hitbox:Activate()
```lua
Hitbox:Activate()
```
Activates the Hitbox. **Note: When a new Hitbox is created, it is deactivated by default. You need to activate it after configuration.**
### Hitbox:Deactivate()
```
Hitbox:Deactivate()
```
Deactivates the Hitbox, pausing all operations.
### Hitbox:AddIgnore(object: Instance)
```
local success = Hitbox:AddIgnore(game.Players.Player1.Character) -> boolean
```
Add `object` to FilterDescendentsInstances table of `OverlapParams`. Returns boolean Success.
### Hitbox:RemoveIgnore(object: Instance)
```lua
local numOfItemsRemoved = Hitbox:RemoveIgnore(game.Players.Player1.Character) -> number
```
Remove `object` from FilterDescendentsInstances table of `OverlapParams`. Returns number NumberOfItemsRemoved. **Note: The returned number is 0 on an unsuccessful remove, 1 or more on a successful remove.
### Hitbox:GetVelocity()
```lua
local velocity = Hitbox:GetVelocity() -> number
```
Returns the Velocity of the Hitbox's constructed path.
### Hitbox:SetVelocity()
```lua
Hitbox:SetVelocity(velocity: number)
```
Sets the Velocity of the Hitbox's constructed path to `velocity`.
### Hitbox:ChangeAttachment(attachment: Attachment?)
```lua
Hitbox:ChangeAttachment(attachment)
```
Changes the Hitbox's Attachment to `attachment`. If `attachment` is nil, remove Attachment from Hitbox.
### Hitbox:IsHitboxBackstab(Part: BasePart, DataBundle: HitboxDataBundle, Margin: number?)
```lua
local isBackstab = Hitbox:IsHitboxBackstab(HitPart, HitboxDataBundle, 0.2) -> boolean
```
Determine if the data described by HitboxDataBundle is a backstab on HitPart. Returns boolean. Margin is an optional number ranging from 0 to 0.5, which determines how lenient the backstab detection is. 0.5 would allow for side-stabs to count as backstabs while 0.1 would require basically perfect alignment. Defaults to 0.32. **Note: The detection position originates from the Hitbox's recorded center position.**
### Hitbox:IsBackstab(Part: BasePart, Character: Model, Margin: number?)
```lua
local isBackstab = Hitbox:IsBackstab(Part, Character, 0.4) -> boolean
```
Determine if `Character` backstabs `Part`. Returns boolean. Margin is an optional number ranging from 0 to 0.5, which determines how lenient the backstab detection is. 0.5 would allow for side-stabs to count as backstabs while 0.1 would require basically perfect alignment. Defaults to 0.32. **Note: The detection position originates from the provided character's root. Recommended to use this over Hitbox:IsHitboxBackstab() if used in tools of a character.**
### Hitbox:GetCurrentSerial()
```lua
local highestSerial = Hitbox:GetCurrentSerial() -> number
```
Get the currently highest serial. Returns number.
### Hitbox:GetConstructionMode()
```lua
local mode = Hitbox:GetConstructionMode() -> string
```
Returns the Hitbox's Trajectory's ConstructionMode.
### Hitbox:GetCurrentMode()
```lua
local mode = Hitbox:GetCurrentMode() -> string
```
Get the current behavior of the Hitbox. See `Hitbox.ModeEnum`.
### Hitbox:Visualize()
```lua
local part = Hitbox:Visualize() -> BasePart or nil
```
Visualizes the Hitbox and returns the visualization part if the Hitbox wasn't already visualizing. **WARNING: The visualization only updates once every 5 frames and is UNOPTIMIZED. This should only be used for testing purposes.**
### Hitbox:Unvisualize(doNotWarn: boolean?)
```lua
Hitbox:Unvisualize()
```
Unvisualizes the Hitbox. Throws a warn if `doNotWarn` isn't `true` and the Hitbox wasn't visualizing.
### Hitbox:Destroy()
```lua
Hitbox:Destroy()
```
Immediately clean and garbage collect Hitbox and all its children. Hitbox should be dereferenced after this operation.

## Private
> Note: Private variables, methods and functions should not be used unless you know what you're doing.
### Hitbox._Attachment
```lua
Hitbox._Attachment -- Attachment or nil
```
Internal store for the Hitbox's Attachment, if one exists. **Note: You should use `Hitbox:ChangeAttachment(attachment)` instead.**
### Hitbox._CurrentFrame
```lua
Hitbox._CurrentFrame -- number
```
The current frame of the Hitbox in the Hitbox's frame cycle. **Note: Not strictly readonly, but it's a good idea to keep this readonly.**
### Hitbox._CanWarn
```lua
Hitbox._CanWarn -- boolean
```
An internal variable that acts as throttle to prevent console spam.
### Hitbox._Visual
```lua
Hitbox._Visual -- BasePart
```
The part used for the Hitbox's visualization. **WARNING: STRICTLY readonly. Use `Hitbox:Visualize()` and `Hitbox:Unvisualize()` instead.**
### Hitbox._Destroying
```lua
Hitbox._Destroying -- boolean
```
Whether the Hitbox is being garbage collected currently or not. **WARNINNG: Readonly. The Hitbox should be dereferenced if this value is `true`.**

**The main enum is intended to be completely private. You are not meant to access it.**
