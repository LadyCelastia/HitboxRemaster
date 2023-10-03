# ScriptConnection
A class returned by `ScriptSignal:Connect()` and `ScriptSignal:Once()`.

## Public
### ScriptConnection.StateEnum
``` lua
ScriptConnection.StateEnum -- {string: string}
```
A mutable copy of `enum.StateEnum`. Includes `StateEnum.Paused`, `StateEnum.Active` and `StateEnum.Dead`.
### ScriptConnection:GetIdentifier()
``` lua
local identifier = ScriptConnection:GetIdentifier() -> string
```
Return the ScriptConnection's unique identifier as a string.
### ScriptConnection:Disconnect()
``` lua
ScriptConnection:Disconnect()
```
Disconnect the ScriptConnection, clean the entire object to be garbage collected except for ScriptConnection._State. Set ScriptConnection._State to "Dead".

## Private
> Note: Private variables, methods and functions should not be used unless you know what you're doing.
### ScriptConnection._Connected
``` lua
ScriptConnection._Connected -- boolean
```
Whether the ScriptConnection is connected or not.
### ScriptConnection._Once
``` lua
ScriptConnect._Once -- boolean
```
If `true`, automatically disconnects the ScriptConnection immediately when being fired the next time.
### ScriptConnection._Identifier
``` lua
ScriptConnection._Identifier -- string
```
The assigned unique identifier of the ScriptConnection.
### ScriptConnection._State
``` lua
ScriptConnection._State -- string
```
The current state of the ScriptConnection. Can be `Active`, `Paused` or `Dead`. If the state is `Dead`, the ScriptConnection should not be referenced anymore.
### ScriptConnection._Signal
```lua
ScriptConnection._Signal -- ScriptSignal
```
A pointer to the parent ScriptSignal.
### ScriptConnection._Function
``` lua
ScriptConnection._Function -- function
```
The function that will be fired when the ScriptConnection is fired.
### ScriptConnection._Fire(...)
``` lua
ScriptConnection._Fire(...)
```
An internal function to fire the ScriptConnection. Passes the arguments to the fired function.

**The main enum is intended to be completely private. You are not meant to access it.**
