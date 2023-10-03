# Trajectory
Child class of Hitbox. Used for constructing paths that the Hitbox will traverse automatically.

## Public
### Trajectory.ConstructionMode
```lua
Trajectory.ConstructionMode -- string
```
The current ConstructionMode of the Trajectory. Can be `None`, `Linear` or `Bezier`
### Trajectory.Velocity
```lua
Trajectory.Velocity -- number
```
The speed in studs per second in which the Hitbox will traverse the constructed path.
### Trajectory:Construct(ConstructionMode: string, Fields: {string: any})
```lua
Trajectory:Construct("Linear", {
    DirectionalVector = Vector3.new(0.55, -0.02, 0.4),
    Velocity = 25
})
Trajectory:Construct("Bezier", {
    BezierPoints = {
        Start = Vector3.new(),
        Control1 = Vector3.new(),
        Control2 = Vector3.new() or nil,
        End = Vector3.new()
    },
    Velocity = 25
})
Trajectory:Construct("None")
```
Construct a path using `ConstructionMode` and `Fields` as seen above. If `BezierPoints.Control2` is nil, the path will become a quadratic bezier curve. Otherwise, the path will become a cubic bezier curve. `DirectionalVector` MUST be a normalized. If `Velocity` is nil, it will use the previous Velocity. If `ConstructionMode` is `None`, deconstructs the path instead.
### Trajectory:Deconstruct()
```lua
Trajectory:Deconstruct()
```
Deconstruct any constructed path and sets `Trajectory.ConstructionMode` to `None`.

## Private
> Note: Private variables, methods and functions should not be used unless you know what you're doing.
### Trajectory._DirectionalVector
```lua
Trajectory._DirectionVector -- Vector3 or nil
```
The stored DirectionalVector from `Trajectory:Construct()`.
### Trajectory._Length
```lua
Trajectory._Length -- number
```
Stores the **approximate** length of the path only if the `ConstructionMode` is `Bezier`.
### Trajectory._Completion
```lua
Trajectory._Completion -- number
```
A normalized number which tracks how close the Hitbox is to the end of the path only if the `ConstructionMode` is `Bezier`.
### Trajectory._Points
```lua
Trajectory._Points --[[ {
                          Start = Vector3.new(),
                          Control1 = Vector3.new(),
                          Control2 = Vector3.new() or nil,
                          End = Vector3.new()
                        } --]]
```
The stored BezierPoints from `Trajectory:Construct()`.
### Trajectory:_GetBezierMode()
```lua
local mode = Trajectory:_GetBezierMode() -> string
```
Returns either `Quad` or `Cubic` based on the bezier formula used.
