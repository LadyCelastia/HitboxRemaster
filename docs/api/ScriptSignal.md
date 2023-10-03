# ScriptSignal
A member class of Hitbox and Zone. Also returned by `Module.newSignal()`.

## Public
### ScriptSignal.StateEnum
```lua
ScriptSignal.StateEnum -- string
```
A mutable copy of `enum.StateEnum`. Includes `StateEnum.Paused`, `StateEnum.Active` and `StateEnum.Dead`.
### ScriptSignal:Connect(func: function, connectImmediately: boolean?)
```lua
local Connection = ScriptSignal:Connect(function()
    ...
end, false) -> ScriptConnection
```
Creates a new `ScriptConnection`. If `connectImmediately` is `true` or `nil`, the ScriptConnection is then immediately connected to the ScriptSignal.
### ScriptSignal:Once(func: function)
```lua
local Connection = ScriptSignal:Once(function()
    ...
end)
```
Creates a new connected `ScriptConnection`. The ScriptConnection will clean and garbage collect itself when it is fired for the first time.
### ScriptSignal:DisconnectAll()
```lua
ScriptSignal:DisconnectAll()
```
Disconnect and garbage collect all of ScriptSignal's ScriptConnections.
### ScriptSignal:DisconnectOne(identifier: string)
```lua
ScriptSignal:DisconnectOne("GH4X-K93A-3914-FD3P-MN0O")
```
Disconnect any ScriptConnection connected to ScriptSignal with `identifier` as its identifier.
### ScriptSignal:Fire(...)
```lua
ScriptSignal:Fire(...)
```
Fire all of ScriptSignal's ScriptConnections and passes `...` as arguments.
### ScriptSignal:FireOne(identifier: string, args: {...})
```lua
ScriptSignal:FireOne("GH4X-K93A-3914-FD3P-MN0O", {...})
```
Fire any ScriptConnection connected to ScriptSignal with `identifier` as its identifier. Passes an unpacked version of `args` as arguments.
### ScriptSignal:GetState()
```lua
local state = ScriptSignal:GetState() -> string
```
Get the current state of the ScriptSignal. **WARNING: Calling this method while the ScriptSignal is Dead will throw an error.**
### ScriptSignal:Destroy()
```lua
ScriptSignal:Destroy()
```
Immediately clean and garbage collect ScriptSignal and all its children. ScriptSignal should be dereferenced after this operation.

## Private
> Note: Private variables, methods and functions should not be used unless you know what you're doing.
### ScriptSignal._State
```lua
ScriptSignal._State -- string
```
The current state of the ScriptSignal. Can be `Active`, `Paused` or `Dead`. If the state is `Dead`, the ScriptSignal should not be referenced anymore.
### ScriptSignal._ActiveRunner
```lua
ScriptSignal._ActiveRunner -- ConnectionRunner
```
The active ConnectionRunner middleware of the ScriptSignal. **WARNING: ConnectionRunner is intended to be completely private. You should not perform any operation on it.**
