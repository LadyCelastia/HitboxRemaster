--[[
	LadyCelestia 9/23/2023
	A complete overhaul of HitboxMaster. Type-safe with generic and lambda support.
--]]

--[[
    @define
    @type
    Type definitions
--]]
type enumPair<T> = {string: T}
type Pair<k,v> = {k: v}
type BezierPoints = {
	Start: Vector3,
	Control1: Vector3,
	Control2: Vector3?,
	End: Vector3
}
type LerpValue = Vector3 | Vector2 | CFrame | number | UDim2 | UDim | Color3
export type ScriptConnection = {
	_Connected: boolean,
	_Signal: ScriptSignal,
	_Function: (any) -> (any),
	_Identifier: string,
	_Once: boolean,
	_State: string,
	_Fire: (any) -> (),

	new: (signal: ScriptSignal, func: (any), once: boolean?) -> (ScriptConnection),
	StateEnum: {enumPair<string>},
	GetIdentifier: () -> (string),
	Disconnect: () -> ()
}
export type ConnectionRunner = {
	_Connections: {ScriptConnection},
	_State: string,
	_AddConnection: (Cn: ScriptConnection) -> (),
	_RemoveConnection: (identifier: string) -> (),
	_CleanUp: () -> (),
	_GetConnections: () -> (Pair<number, ScriptConnection>),
	_FireOne: (identifier: string, args: {any}) -> (),
	_FireAll: (any) -> (),

	new: () -> (ConnectionRunner),
	Destroy: () -> ()
}
export type ScriptSignal = {
	_ActiveRunner: ConnectionRunner,
	_State: string,

	new: () -> (ScriptSignal),
	StateEnum: {enumPair<string>},
	Connect: (func: (any) -> (any), connectImmediately: boolean?) -> (ScriptConnection),
	DisconnectAll: () -> (),
	DisconnectOne: (identifier: string) -> (),
	Once: (func: (any)) -> (ScriptConnection),
	Fire: (any) -> (),
	FireOne: (identifier: string, args: {any}) -> (),
	GetState: () -> (string),
	Destroy: () -> ()
}
export type TrajectoryType = {
	_DirectionalVector: Vector3?,
	_Length: number,
	_Completion: number,
	_Points: Pair<string, Vector3>,
	_GetBezierMode: () -> (string),

	new: (Fields: Pair<string, any>) -> (TrajectoryType),
	Construct: (Mode: string, Fields: Pair<string, any>) -> (boolean),
	Deconstruct: () -> (),
	Destroy: () -> (),
	ConstructionMode: string,
	Velocity: number
}
export type HitboxType = {
	_Attachment: Attachment?,
	_CurrentFrame: number,
	_CanWarn: boolean,
	_Visual: BasePart?,
	_Destroying: boolean,

	new: (Fields: Pair<string, any>) -> (HitboxType),
	Visualize: () -> (BasePart?),
	Unvisualize: (doNotWarn: boolean?) -> (),
	Activate: () -> (),
	Deactivate: () -> (),
	GetCurrentSerial: () -> (number),
	GetConstructionMode: () -> (string),
	GetCurrentMode: () -> (string),
	GetVelocity: () -> (number),
	SetVelocity: (velocity: number) -> (),
	AddIgnore: (object: Instance) -> (boolean),
	RemoveIgnore: (object: Instance) -> (number),
	IsHitboxBackstab: (Part: BasePart, DataBundle: HitboxDataBundle) -> (boolean),
	IsBackstab: (Part: BasePart, Character: Model) -> (boolean),
	Destroy: () -> (),
	ShapeEnum: enumPair<string>,
	ModeEnum: enumPair<string>,
	StateEnum: enumPair<string>,
	ConstructionEnum: enumPair<string>,
	BezierEnum: enumPair<string>,
	Hit: ScriptSignal,
	Trajectory: TrajectoryType,
	Serial: number,
	Shape: string,
	Position: Vector3,
	Pierce: number,
	Debounce: number,
	LifeTime: number,
	Orientation: Vector3,
	CopyCFrame: BasePart,
	OverlapParams: OverlapParams,
	Active: boolean,
	Radius: number,
	Size: Vector3,
}
export type HitboxDataBundle = {
	Serial: number,
	Position: Vector3,
	Radius: number,
	Size: Vector3
}
export type MetatableType = {
	_Members: {
		Instance: Instance,
		Connections: {Pair<string, RBXScriptConnection>}
	},
	_State: string,
	_CleanUp: () -> (),
	_Add: (Value: Instance, Metafunctions: Pair<string, (any)>?) -> (),
	_Remove: (Value: Instance, Metafunctions: Instance) -> (),
	_AddMetafunction: (Value: Instance, Metafunctions: Pair<string, (any)>) -> (),
	_RemoveMetafunction: (Value: Instance, Metafunctions: {string}) -> (),
	_IsMember: (Value: Instance) -> (boolean),
	_GetMembers: () -> ({BasePart}),

	new: (Members: {any}?) -> (MetatableType),
	Destroy: () -> ()
}
export type ZoneComponentType = {
	_Part: BasePart?,
	_State: string,
	_NewPart: () -> (),

	new: (Fields: Pair<string, any>?) -> (ZoneComponentType),
	Shape: string,
	CFrame: CFrame,
	Size: Vector3,
	Query: (QueryType: string, Params: OverlapParams) -> (BasePart),
	GetCharacters: (CharacterResolution: string, QueryType: string, Params: OverlapParams) -> ({Model}),
	GetPlayers: (CharacterResolution: string, QueryType: string, Params: OverlapParams) -> ((Model)),
	Destroy: () -> ()
}
export type ZoneType = {
	_CurrentFrame: number,
	_CanWarn: boolean,
	_Visual: BasePart?,
	_MemberParts: MetatableType,
	_MemberComponents: Pair<BasePart | number, ZoneComponentType>,
	_PartsInside: {BasePart},
	_CharactersInside: {Model},
	_PlayersInside: {Model},
	_Destroying: boolean,

	new: (Fields: Pair<string, any>) -> (ZoneType),
	CharacterResolutionEnum: enumPair<string>,
	QueryTypeEnum: enumPair<string>,
	StateEnum: enumPair<string>,
	CharacterEntered: ScriptSignal,
	CharacterLeft: ScriptSignal,
	PlayerEntered: ScriptSignal,
	PlayerLeft: ScriptSignal,
	PartEntered: ScriptSignal,
	PartLeft: ScriptSignal,
	Serial: number,
	Shape: string,
	CharacterResolution: string,
	QueryType: string,
	Rate: number,
	OverlapParams: OverlapParams,
	Active: boolean,
	Update: () -> (),
	Relocate: (newCFrame: CFrame) -> (),
	AddMember: (part: BasePart, Metafunctions: Pair<string, (any)>?) -> (),
	RemoveMember: (part: BasePart) -> (),
	AddComponent: (Component: ZoneComponentType) -> (number?),
	RemoveComponent: (index: BasePart | number) -> (),
	IsPartInside: (part: BasePart) -> (boolean),
	IsCharacterInside: (Character: Model) -> (boolean),
	IsPlayerInside: (Character: Model) -> (boolean),
	GetPartsInside: () -> ({BasePart}),
	GetCharactersInside: (PartList: {BasePart}?) -> ({Model}),
	GetPlayersInside: (PartList: {BasePart}?) -> ({Model}),
	Activate: () -> (),
	Deactivate: () -> (),
	Destroy: () -> ()
}

--[[
    @define
    Definitions
--]]
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")
local DebugMode = true
local HitboxSerial = 0
local ActiveHitboxes = {}
local ActiveZones = {}
local ZoneFolder = workspace:FindFirstChild("ZoneFolder") or Instance.new("Folder", workspace)
ZoneFolder.Name = "ZoneFolder"

--[[
    @function
    Universal functions
--]]
-- Debug mode for stack tracer
local function getStackLevel(): number
	if DebugMode == true then
		return 1
	end
	return 2
end

-- Concatenate string prefix for console output
local function concatPrint(String: string): string
	return "[" .. script.Name .. "]: " .. String
end

-- Find an index/value or index-value pair in Table and all its children tables
local function DeepFind(Table: {any}, Row: {any}): {any}?
	if #Row ~= 1 then
		error(concatPrint("Row argument of function DeepFind may only have one key-value pair."), getStackLevel())
	end
	for i,v in pairs(Table) do
		if typeof(v) ~= "table" then
			if Row[i] ~= nil then
				return {i = v}
			else
				for _,v2 in pairs(Row) do
					if v == v2 then
						return {i = v}
					end
				end
			end
		else
			local RecursiveResult = DeepFind(v, Row)
			if RecursiveResult ~= nil then
				return RecursiveResult
			end
		end
	end
	return nil
end

-- table.remove en mass
local function CullTable(TableToCull: Pair<any, any>, CullingList: Pair<number, any>): Pair<any, any>
	for i = 1, #TableToCull do
		local target = CullingList[i]
		if TableToCull[target] then
			table.remove(TableToCull, target)
			for i2, v in ipairs(CullingList) do
				if v > target then
					CullingList[i2] -= 1
				end
			end
		end
	end
	return TableToCull
end

-- Find the highest numeral index in an any-pair table
local function FindHighestIndex(Table: {any}): number
	local HighestIndex = 0
	for i,_ in pairs(Table) do
		if typeof(i) == "number" and i > HighestIndex then
			HighestIndex = i
		end
	end
	return HighestIndex
end

-- Compare the values of two any-pair tables, return an ipair table of exclusive values
local function CompareTableValues(Table1: {any}, Table2: {any}): {any} & {any}
	local Table1Exclusives = {}
	for _,v in pairs(Table1) do
		local IsInTable = false
		for _,v2 in pairs(Table2) do
			if v == v2 then
				IsInTable = true
				break
			end
		end
		if IsInTable == false then
			Table1Exclusives[v] = true
		end
	end
	local Table2Exclusives = {}
	for _,v in pairs(Table2) do
		if Table1Exclusives[v] == nil then
			local IsInTable = false
			for _,v2 in pairs(Table2) do
				if v == v2 then
					IsInTable = true
					break
				end
			end
			if IsInTable == false then
				Table2Exclusives[v] = true
			end
		end
	end
	local ReturnTable1 = {}
	for i,_ in pairs(Table1Exclusives) do
		table.insert(ReturnTable1, i)
	end
	local ReturnTable2 = {}
	for i,_ in pairs(Table2Exclusives) do
		table.insert(ReturnTable2, i)
	end
	return ReturnTable1, ReturnTable2
end

-- Check if method/variable is private
local function IsPrivate(String: string): boolean
	if string.match(String, "_%a+") ~= nil then
		return true
	end
	return false
end

-- Factorized quadratic bezier equation
local function quadbez(a: LerpValue, b: LerpValue, c:LerpValue, t: number): LerpValue
	return (1 - t)^2*a + 2*(1 - t)*t*b + t^2*c
end

-- Factorized cubic bezier equation
local function cubicbez(a: LerpValue, b: LerpValue, c: LerpValue, d: LerpValue, t: number): LerpValue
	return (1 - t)^3*a + 3*(1 - t)^2*t*b + 3*(1 - t)*t^2*c + t^3+d
end

-- Return the combined length of segments
local function seglen(segments: {Vector3}): number
	local length = 0
	for i = 1, #segments do
		local current, next = segments[i], segments[i + 1]
		if not next then
			continue
		end
		length += (current - next).Magnitude
	end
	return length
end

-- Return a rough estimated total length of a quadratic bezier curve
local function quadbezlen(startPoint: Vector3, controlPoint: Vector3, endPoint: Vector3, resolution: number?): number
	resolution = resolution or 10
	local segments = {}
	for i = 1, resolution do
		table.insert(segments, quadbez(startPoint, controlPoint, endPoint, i/resolution))
	end
	return seglen(segments)
end

-- Return a rough estimated total length of a cubic bezier curve
local function cubicbezlen(startPoint: Vector3, controlPoint1: Vector3, controlPoint2: Vector3, endPoint: Vector3, resolution: number?): number
	resolution = resolution or 10
	local segments = {}
	for i = 1, resolution do
		table.insert(segments, cubicbez(startPoint, controlPoint1, controlPoint2, endPoint, i/resolution))
	end
	return seglen(segments)
end

-- ZoneComponent character query validation
local function CharacterQuerySearch(CharacterList: {Pair<Model, {Pair<BasePart, boolean>}>}, CharacterResolution: string): {Model}
	local ValidCharacterList = {}
	for i,v in pairs(CharacterList) do
		local valid = false
		if CharacterResolution == "FullBody" then
			valid = true
			for _,v2 in pairs(v) do
				if v2 == false then
					valid = false
					break
				end
			end
		elseif CharacterResolution == "Root" then
			for i2,v2 in pairs(v) do
				if i2.Name == "HumanoidRootPart" and v2 == true then
					valid = true
					break
				end
			end
		elseif CharacterResolution == "Head" then
			for i2,v2 in pairs(v) do
				if i2.Name == "Head" and v2 == true then
					valid = true
					break
				end
			end
		else
			for _,v2 in pairs(v) do
				if v2 == true then
					valid = true
					break
				end
			end
		end
		if valid == true then
			table.insert(ValidCharacterList, i)
		end
	end
	return ValidCharacterList
end

-- Hitbox spatial query main
local function HitReg(self: HitboxType, deltaTime: number): {BasePart}
	local HitboxMode = self:GetCurrentMode()
	local Velocity = self:GetVelocity()
	if HitboxMode == "Linear" then
		self.Position += (self.Trajectory._DirectionalVector * (Velocity * deltaTime))
	elseif HitboxMode == "Bezier" then
		local interpolationGain = (Velocity * deltaTime) / self.Trajectory._Length
		if interpolationGain > (1 - self.Trajectory._Completion) then
			interpolationGain = (1 - self.Trajectory._Completion)
		end
		self.Trajectory._Completion += interpolationGain
		self.BezierCompletion += interpolationGain

		local BezierMode = self.Trajectory:_GetBezierMode()
		if BezierMode == "Quadratic" then
			self.Position = quadbez(self.StartPoint, self.ControlPoint1, self.EndPoint, self.Trajectory._Completion)
		elseif BezierMode == "Cubic" then
			self.Position = cubicbez(self.StartPoint, self.ControlPoint1, self.ControlPoint2, self.EndPoint, self.Trajectory._Completion)
		end
	elseif HitboxMode == "Attachment" then
		self.Position = self._Attachment.WorldCFrame.Position
	end

	if self._CurrentFrame >= 5 and self._Visual ~= nil then
		self._CurrentFrame = 0
		if self.Shape == "Sphere" then
			self._Visual.Shape = Enum.PartType.Ball
			self._Visual.Size = Vector3.new(self.Radius * 2, self.Radius * 2, self.Radius * 2)
		else
			self._Visual.Shape = Enum.PartType.Block
			self._Visual.Size = self.Size
		end

		if self.CopyCFrame ~= nil then
			self._Visual.CFrame = self.CopyCFrame.CFrame
		elseif self.Position ~= nil then
			if self.Orientation ~= nil then
				self._Visual.CFrame = CFrame.new(self.Position) * CFrame.Angles(math.rad(self.Orientation.X), math.rad(self.Orientation.Y), math.rad(self.Orientation.Z))
			else
				self._Visual.Position = self.Position
			end
		end
	end

	if self.Pierce > 0 then
		local result: {BasePart} = {}
		if self.Shape == "Sphere" then
			result = workspace:GetPartBoundsInRadius(self.Position, self.Radius, self.OverlapParams) or {}
		elseif self.Shape == "Box" then
			if typeof(self.Orientation) == "Vector3" then
				result = workspace:GetPartBoundsInBox(CFrame.new(self.Position) * CFrame.Angles(math.rad(self.Orientation.X), math.rad(self.Orientation.Y), math.rad(self.Orientation.Z)), self.Size, self.OverlapParams) or {}
			elseif typeof(self.CopyCFrame) == "Instance" then
				if self.CopyCFrame:IsA("BasePart") then
					result = workspace:GetPartBoundsInBox(self.CopyCFrame.CFrame, self.Size, self.OverlapParams) or {} 
				end
			else
				result = workspace:GetPartBoundsInBox(CFrame.new(self.Position), self.Size, self.OverlapParams) or {}
			end
		elseif self._CanWarn == true then
			self._CanWarn = false
			task.delay(5, function()
				self._CanWarn = true
			end)
			warn(concatPrint("Hitbox " .. self.Serial .. " has an invalid shape."))
		end
		if #result > 0 then
			local hitHumanoids: {humanoid: BasePart} = {}
			local registeredHumanoids: {Humanoid} = {}

			for _,v in ipairs(result) do
				local hum = v.Parent:FindFirstChildOfClass("Humanoid")
				if hum ~= nil then
					if v.Parent:FindFirstChildOfClass("ForceField") == nil and v.Parent:FindFirstChild("HitboxSerial" .. self.Serial) == nil and hum:GetState() ~= Enum.HumanoidStateType.Dead then
						table.insert(hitHumanoids, {hum, v})
					end
				end
			end

			for _,v in pairs(hitHumanoids) do
				local canHit = true
				for _,v2 in ipairs(registeredHumanoids) do
					if v[1] == v2 then
						canHit = false
						break
					end
				end
				if canHit == true then
					if self.Debounce > 0 then
						local newSerial: BoolValue = Instance.new("BoolValue")
						Debris:AddItem(newSerial, self.Debounce)
						newSerial.Name = "HitboxSerial" .. self.Serial
						newSerial.Value = true
						newSerial.Parent = v[2].Parent
					end
					---@diagnostic disable-next-line: redundant-parameter
					self.Hit:Fire(v[1], v[2], { -- Humanoid, HitPart, HitboxDataBundle
						["Serial"] = self.Serial,
						["Position"] = self.Position,
						["Radius"] = self.Radius or 0,
						["Size"] = self.Size or Vector3.new(0, 0, 0)
					})
					table.insert(registeredHumanoids, v[1])
					self.Pierce -= 1
					if self.Pierce <= 0 then
						break
					end
				end
			end
		end
	end
	if ((self.LifeTime <= 0 and HitboxMode ~= "Bezier") or (HitboxMode == "Bezier" and self.Trajectory._Completion >= 1)) and self._Destroying == false then
		self:Destroy()
	end
end

-- Main runner
local function MainRunner(_, deltaTime: number): ()
	for _,self: HitboxType in pairs(ActiveHitboxes) do
		if self.Active == true then
			self._CurrentFrame += 1
			self.LifeTime -= deltaTime
			if deltaTime < 1/30 then
				HitReg(self, deltaTime)
			else
				local Factor = math.floor(deltaTime / (1/60))
				for i = 1, Factor do
					HitReg(self, deltaTime / Factor)
				end
			end
		end
	end
	for _,self: ZoneType in pairs(ActiveZones) do
		if self.Active == true then
			local Frames = 60 / self.Rate
			self._CurrentFrame += 1
			if self._CurrentFrame >= Frames then
				self._CurrentFrame = 0
				local CurrentPartList = self:GetPartsInside()
				local CurrentCharacterList = self:GetCharactersInside(CurrentPartList)
				local CurrentPlayerList = self:GetPlayersInside(CurrentPartList)

				local XLastPart, XCurrentPart = CompareTableValues(self._PartsInside, CurrentPartList)
				for _,v in ipairs(XLastPart) do
					self.PartLeft:Fire(v)
				end
				for _,v in ipairs(XCurrentPart) do
					self.PartEntered:Fire(v)
				end

				local XLastCharacter, XCurrentCharacter = CompareTableValues(self._CharactersInside, CurrentCharacterList)
				for _,v in ipairs(XLastCharacter) do
					self.CharacterLeft:Fire(v)
				end
				for _,v in ipairs(XCurrentCharacter) do
					self.CharacterEntered:Fire(v)
				end

				local XLastPlayer, XCurrentPlayer = CompareTableValues(self._PlayersInside, CurrentPlayerList)
				for _,v in ipairs(XLastPlayer) do
					self.PlayerLeft:Fire(v)
				end
				for _,v in ipairs(XCurrentPlayer) do
					self.PlayerEntered:Fire(v)
				end

				self._PartsInside = CurrentPartList
				self._CharactersInside = CurrentCharacterList
				self._PlayersInside = CurrentPlayerList
			end
		end
	end
end
local RunnerConnection = RunService.Stepped:Connect(MainRunner)
game:BindToClose(function()
	RunnerConnection:Disconnect()
	for _,v in pairs(ActiveHitboxes) do
		v:Destroy()
	end
	for _,v in pairs(ActiveZones) do
		v:Destroy()
	end
	ActiveHitboxes = {}
	ActiveZones = {}
end)

--[[
    @class Enum
    Enumeration implementation to prevent unexpected values
--]]
local enum = {}
local enumMetatable = {
	__index = function(_, i): any
		return enum[i] or error(concatPrint(i .. " is not a valid member of the Enum."), getStackLevel())
	end,
	__newindex = function(): ()
		error(concatPrint("Enums are read-only."), getStackLevel())
	end
}

enum._new = function(Name: string, Children: {string: any}): enumPair<any>
	if enum[Name] ~= nil then
		return enum[Name]
	end

	enum[Name] = Children

	return setmetatable(Children, enumMetatable)
end

enum._get = function(Name: string): enumPair<any>
	if enum[Name] then
		return setmetatable(enum[Name], enumMetatable)
	else
		local Result = DeepFind(enum, {Name = nil})
		if Result ~= nil then
			return setmetatable(Result, enumMetatable)
		end
	end
end

-- Do not call _isEnum as a method as self is readonly
enum._isEnum = function(ValueToCheck: any): boolean
	if IsPrivate(ValueToCheck) == false and DeepFind(enum, {ValueToCheck}) ~= nil then
		return true
	end
	return false
end

enum._new("StateEnum", {Active = "Active", Paused = "Paused", Dead = "Dead"})
enum._new("ConstructionMode", {None = "None", Linear = "Linear", Bezier = "Bezier"})
enum._new("BezierMode", {Quadratic = "Quad", Cubic = "Cubic"})
enum._new("Shape", {Box = "Box", Sphere = "Sphere"})
enum._new("HitboxMode", {None = "None", Attachment = "Attachment", Linear = "Linear", Bezier = "Bezier", Orientation = "Orientation", Copying = "Copy"})
enum._new("CharacterResolution", {OnePart = "OnePart", Root = "Root", Head = "Head", FullBody = "FullBody"})
enum._new("QueryType", {Bounds = "Bounds", Full = "Full"})

--[[
    @class ScriptConnection
    Child of @ConnectionRunner
--]]
local Connection = {}
Connection.__index = Connection
Connection.StateEnum = enum._get("StateEnum")

Connection.new = function(signal: ScriptSignal, func: any, once: boolean?): ScriptConnection
	local self = setmetatable({}, Connection)

	self._Connected = true
	self._Signal = signal
	self._Function = func
	self._Identifier = HttpService:GenerateGUID(false)
	self._Once = false
	if once ~= nil then
		self._Once = once
	end
	self._State = enum.StateEnum.Paused

	return self
end

function Connection:_Fire(...): ()
	if self._Connected == true then
		coroutine.wrap(self._Function)(...)
		if self._Once == true then
			self:Disconnect()
		end
	end
end

function Connection:GetIdentifier(): string
	return self._Identifier
end

function Connection:Disconnect(): ()
	self._Connected = false
	self._Function = nil
	self = {_State = enum.StateEnum.Dead}
end

--[[
    @class ConnectionRunner
    @parent ScriptConnection
    Private child of @ScriptSignal, manages child ScriptConnections
--]]
local Runner = {}
Runner.__index = Runner

Runner.new = function(): ConnectionRunner
	local self = setmetatable({}, Runner)

	self._Connections = {}
	self._State = enum.StateEnum.Active

	return self
end

function Runner:_AddConnection(Cn: ScriptConnection): ()
	Cn._State = enum.StateEnum.Active
	table.insert(self._Connections, Cn)
end

function Runner:_CleanUp(): ()
	local CullingList = {}
	for i,v in ipairs(self._Connections) do
		if v._Connected == false then
			table.insert(CullingList, i)
		end
	end
	CullTable(self._Connections, CullingList)
end

function Runner:_RemoveConnection(identifier: string): ()
	for _,v in ipairs(self._Connections) do
		if v._Identifier == identifier then
			v:Disconnect()
		end
	end
	self:_CleanUp()
end

function Runner:_GetConnections(): Pair<number, ScriptConnection>
	return self._Connections
end

function Runner:_FireOne(identifier: string, args: {any}): ()
	for _,v in ipairs(self._Connections) do
		if v._Identifier == identifier then
			v:Fire(table.unpack(args))
		end
	end
end

function Runner:_FireAll(...): ()
	for _,v in ipairs(self._Connections) do
		v:_Fire(...)
	end
end

function Runner:Destroy(): ()
	for _,v in ipairs(self._Connections) do
		v:Disconnect()
	end
	self:_CleanUp()
	self = {_State = enum}
end

--[[
    @class ScriptSignal
    @parent enum, ConnectionRunner
    ScriptSignal implementation
--]]
local Signal = {}
Signal.__index = Signal
Signal.StateEnum = enum._get("StateEnum")

Signal.new = function(): ScriptSignal
	local self = setmetatable({}, Signal)

	self._ActiveRunner = Runner.new()
	self._State = enum.StateEnum.Active

	return self
end

function Signal:GetState(): string
	return self._State
end

function Signal:FireOne(...): ()
	self._ActiveRunner:_FireOne(...)
end

function Signal:Fire(...): ()
	self._ActiveRunner:_FireAll(...)
end

function Signal:Connect(func: any, connectImmediately: boolean?): ScriptConnection
	if connectImmediately == nil then
		connectImmediately = true
	end
	local newConnection = Connection.new(self, func)

	if connectImmediately == true then
		self._ActiveRunner:_AddConnection(newConnection) 
	end

	return newConnection
end

function Signal:DisconnectOne(identifier: string): ()
	self._ActiveRunner:_RemoveConnection(identifier)
end

function Signal:DisconnectAll(): ()
	for _,v in ipairs(self._ActiveRunner:_GetConnections()) do
		v:Disconnect()
	end
	self._ActiveRunner:_CleanUp()
end

function Signal:Once(func: any): ScriptConnection
	local newConnection = self:Connect(func, false)
	newConnection._Once = true

	self._ActiveRunner:_AddConnection(newConnection)

	return newConnection
end

function Signal:Destroy(): ()
	self:DisconnectAll()
	self._ActiveRunner:Destroy()
	self = {_State = enum.StateEnum.Dead}
end

--[[
    @class Trajectory
	Child of @Hitbox
	Enables trajectory construction
--]]
local Trajectory = {}
Trajectory.__index = Trajectory

Trajectory.new = function(Fields: {Pair<string, any>}): TrajectoryType
	Fields = Fields or {}
	local self = setmetatable({}, Trajectory)

	self._State = enum.StateEnum.Active
	self.ConstructionMode = enum.ConstructionMode.None

	-- Linear Construction
	self._DirectionalVector = nil

	-- Bezier Construction
	self._Length = 0
	self._Completion = 0
	self._Points = {}

	-- Universal
	self.Velocity = Fields["Velocity"] or 10

	return self
end

function Trajectory:_GetBezierMode(): string
	if self._Points.Control2 == nil then
		return enum.BezierMode.Quadratic
	else
		return enum.BezierMode.Cubic
	end
end

function Trajectory:Construct(Mode: string, Fields: {Pair<string, any>}): boolean
	Fields = Fields or {}
	if Mode ~= enum.ConstructionMode.None and enum._isEnum(Mode) == true then
		if Mode == enum.ConstructionMode.Linear then
			self._DirectionalVector = Fields["DirectionalVector"] or error(concatPrint("Trajectory:Construct(Linear) is missing field DirectionalVector."), getStackLevel())
		elseif Mode == enum.ConstructionMode.Bezier then
			self._Points = Fields["BezierPoints"] or error(concatPrint("Trajectory:Construct(Bezier) is missing field BezierPoints."), getStackLevel())
			if self:_GetBezierMode() == enum.BezierMode.Quadratic then
				self._Length = quadbezlen(self._Points["Start"], self._Points["Control1"], self._Points["End"])
			else
				self._Length = cubicbezlen(self._Points["Start"], self._Points["Control1"], self._Points["Control2"], self._Points["End"])
			end
		end
		self.Velocity = Fields["Velocity"] or self.Velocity
		self.ConstructionMode = Mode
		return true
	end
	return false
end

function Trajectory:Deconstruct(): ()
	self.ConstructionMode = enum.ConstructionMode.None
	self._DirectionalVector = nil
	self._Length = 0
	self._Completion = 0
	self._Points = {}
end

function Trajectory:Destroy(): ()
	self = {_State = enum.StateEnum.Dead}
end

--[[
    @class Hitbox
    @parent enum, ScriptSignal, Trajectory
    Hitbox class
--]]
local Hitbox = {}
Hitbox.__index = Hitbox
Hitbox.ShapeEnum = enum._get("Shape")
Hitbox.ModeEnum = enum._get("HitboxMode")
Hitbox.StateEnum = enum._get("StateEnum")
Hitbox.ConstructionEnum = enum._get("ConstructionMode")
Hitbox.BezierEnum = enum._get("BezierMode")

Hitbox.new = function(Fields: {Pair<string, any>}): HitboxType
	Fields = Fields or {}
	HitboxSerial += 1
	local self = setmetatable({}, Hitbox)

	-- Private variables
	self._Attachment = Fields["Attachment"]
	self._CurrentFrame = 0
	self._CanWarn = true
	self._Visual = nil
	self._Destroying = false

	-- Public variables
	self.Hit = Signal.new()
	self.Trajectory = Trajectory.new()
	self.Serial = HitboxSerial
	self.Shape = Fields["Shape"] or enum.Shape.Box
	self.Position = Fields["Position"] or Vector3.new(0, 0, 0)
	self.Pierce = Fields["Pierce"] or 1
	self.Debounce = Fields["Debounce"] or 5
	self.LifeTime = Fields["LifeTime"] or 1
	self.Orientation = Fields["Orientation"]
	self.CopyCFrame = Fields["CopyCFrame"]
	self.OverlapParams = OverlapParams.new()
	self.OverlapParams.FilterType = Enum.RaycastFilterType.Exclude
	self.OverlapParams.FilterDescendantsInstances = {}
	self.OverlapParams.RespectCanCollide = false
	self.OverlapParams.MaxParts = 0
	self.Active = false
	self.State = enum.StateEnum.Paused

	self.Radius = Fields["Radius"] or 3 -- Used for Sphere shape
	self.Size = Fields["Size"] or Vector3.new(3, 3, 3) -- Used for Box shape

	ActiveHitboxes[self.Serial] = self

	return self
end

function Hitbox:Visualize(): BasePart?
	if self._Visual ~= nil then
		warn(concatPrint("Hitbox is already visualizing."))
	else
		self._Visual = Instance.new("Part")
		self._Visual.Name = "HitboxVisualization" .. tostring(self.Serial)
		self._Visual.Anchored = true
		self._Visual.CanCollide = false
		self._Visual.BrickColor = BrickColor.new("Really red")
		self._Visual.Transparency = 0.75
		self._Visual.Material = Enum.Material.SmoothPlastic
		self._Visual.Position = self.Position or Vector3.new(0, 0, 0)

		if self.Shape == enum.Shape.Sphere then
			self._Visual.Shape = Enum.PartType.Ball
			self._Visual.Size = Vector3.new(self.Radius * 2, self.Radius * 2, self.Radius * 2)
		else
			self._Visual.Shape = Enum.PartType.Block
			self._Visual.Size = self.Size
		end

		self._Visual.Parent = workspace

		return self._Visual
	end
end

function Hitbox:Unvisualize(doNotWarn: boolean?): ()
	if self._Visual == nil then
		if doNotWarn ~= true then
			warn(concatPrint("Hitbox is not visualizing."))
		end
		return false
	else
		self._Visual:Destroy()
		self._Visual = nil
		return true
	end
end

function Hitbox:Activate(): ()
	self.Active = true
	self.State = enum.StateEnum.Active
end

function Hitbox:Deactivate(): ()
	self.Active = false
	self.State = enum.StateEnum.Paused
end

function Hitbox:GetCurrentSerial(): number
	return HitboxSerial
end

function Hitbox:GetConstructionMode(): string
	return self.Trajectory.ConstructionMode
end

function Hitbox:GetCurrentMode(): string
	if self._Attachment ~= nil then
		return enum.HitboxMode.Attachment
	elseif self.Trajectory.ConstructionMode == enum.ConstructionMode.Linear then
		return enum.HitboxMode.Linear
	elseif self.Trajectory.ConstructionMode == enum.ConstructionMode.Bezier then
		return enum.HitboxMode.Bezier
	elseif self.Orientation ~= nil and self.Orientation ~= Vector3.new(0, 0, 0) then
		return enum.HitboxMode.Orientation
	elseif self.CopyCFrame ~= nil then
		return enum.HitboxMode.CopyCFrame
	else
		return enum.HitboxMode.None
	end
end

function Hitbox:GetVelocity(): number
	return self.Trajectory.Velocity
end

function Hitbox:SetVelocity(velocity: number): ()
	self.Trajectory.Velocity = velocity
end

function Hitbox:AddIgnore(object: Instance): boolean
	if typeof(object) == "Instance" then
		if object:IsA("BasePart") or object:IsA("Model") then
			local oldTable = self.OverlapParams.FilterDescendantsInstances or {}
			table.insert(oldTable, object)
			self.OverlapParams.FilterDescendantsInstances = oldTable
			return true
		end
	end
	return false
end

function Hitbox:RemoveIgnore(object: Instance): number
	if typeof(object) == "Instance" then
		if object:IsA("BasePart") or object:IsA("Model") then
			local indexes = {}
			for i,v in ipairs(self.OverlapParams.FilterDescendantsInstances) do
				if v == object then
					table.insert(indexes, i)
				end
			end
			for i,v in ipairs(indexes) do
				table.remove(self.OverlapParams.FilterDescendantsInstances, v)
				for i2,v2 in ipairs(indexes) do
					if i2 > i and v2 > v then
						indexes[i2] -= 1
					end
				end
			end
			return #indexes
		end
	end
	return 0
end

function Hitbox:IsHitboxBackstab(Part: BasePart, DataBundle: HitboxDataBundle): boolean
	if DataBundle.Radius > 100 or DataBundle.Size.X > 50 or DataBundle.Size.Y > 50 or DataBundle.Size.Z > 50 then
		warn(concatPrint("Hitbox is too large to support Hitbox:IsHitboxBackstab(). (Maximum 50 magnitude per-axis)"))
		return false
	elseif CFrame.new(DataBundle.Position):inverse() * Part.CFrame < 0 then
		return true
	end
	return false
end

function Hitbox:IsBackstab(Part: BasePart, Character: Model): boolean
	local root: BasePart = Character:FindFirstChild("HumanoidRootPart")
	if root then
		if root.CFrame:inverse() * Part.CFrame < 0 then
			return true
		end
	end
	warn(concatPrint("Provided Character for Hitbox:IsBackstab() has no HumanoidRootPart."))
	return false
end

function Hitbox:Destroy(): ()
	self._Destroying = true
	self:Deactivate()
	self.Hit:DisconnectAll()
	self.Hit:Destroy()
	self.Trajectory:Destroy()
	self:Unvisualize(true)
	ActiveHitboxes[self.Serial] = nil
	self = {State = enum.StateEnum.Dead}
end

--[[
    @class Metatable
    Child of Zone. Enables and manages metafunctions to be connected to events of Instances inside a readable table.
--]]
local Metatable = {}
Metatable.__index = function(self, index)
	if Metatable[index] ~= nil then
		return Metatable[index]
	else
		return self._Members[index]
	end
end

Metatable.new = function(Members: {any}?): MetatableType
	local self = setmetatable({}, Metatable)
	self._Members = Members or {}
	self._State = enum.StateEnum.Active
	return self
end

function Metatable:_CleanUp(): ()
	local CullingList = {}
	for i,v in ipairs(self._Members) do
		if v.Instance == nil or #v.Connections < 1 or v.Instance.Parent == nil then
			for _,v2 in pairs(v.Connections) do
				if typeof(v2) == "RBXScriptConnection" then
					v2:Disconnect()
				end
			end
			table.insert(CullingList, i)
		end
	end
	CullTable(self._Members, CullingList)
end

function Metatable:_Add(Value: Instance, Metafunctions: Pair<string, (any)>?): ()
	Metafunctions = Metafunctions or {}
	local Connections: RBXScriptConnection = {}
	for i,v in pairs(Metafunctions) do
		if typeof(Value[i]) == "RBXScriptSignal" and typeof(v) == "function" then
			Connections[i] = Value[i]:Connect(v)
		end
	end
	table.insert(self._Members, {Instance = Value, Connections = Connections})
end

function Metatable:_Remove(Value: Instance): ()
	local CullingList = {}
	for i,v in ipairs(self._Members) do
		if v.Instance == nil or v.Instance == Value or v.Instance.Parent == nil then
			for _,v2 in pairs(v.Connections) do
				if typeof(v2) == "RBXScriptConnection" then
					v2:Disconnect()
				end
			end
			table.insert(CullingList, i)
		end
	end
	CullTable(self._Members, CullingList)
end

function Metatable:_AddMetafunction(Value: Instance, Metafunctions: Pair<string, (any)>): ()
	Metafunctions = Metafunctions or {}
	for _,v in ipairs(self._Members) do
		if v.Instance == Value then
			for i,v2 in pairs(Metafunctions) do
				if Value[i] ~= nil then
					v.Connections[i] = Value[i]:Connect(v2)
				end
			end
		end
	end
	self:_CleanUp()
end

function Metatable:_RemoveMetafunction(Value: Instance, Metafunctions: {string}): ()
	Metafunctions = Metafunctions or {}
	for _,v in ipairs(self._Members) do
		if v.Instance == Value or v.Instance == nil or v.Instance.Parent == nil then
			local CullingList = {}
			for _,v2 in pairs(Metafunctions) do
				if typeof(v.Connections[v2]) == "RBXScriptConnection" then
					v.Connections[v2]:Disconnect()
					table.insert(CullingList, v2)
				end
			end
			CullTable(v.Connections, CullingList)
		end
	end
	self:_CleanUp()
end

function Metatable:_IsMember(Value: Instance): boolean
	for _,v in ipairs(self._Members) do
		if v.Instance == Value then
			return true
		end
	end
	return false
end

function Metatable:_GetMembers(): {BasePart}
	local MemberList = {}
	for _,v in ipairs(self._Members) do
		if typeof(v.Instance) == "Instance" then
			table.insert(MemberList, v.Instance)
		end
	end
	return MemberList
end

function Metatable:Destroy(): ()
	for _,v in ipairs(self._Members) do
		for _,v2 in pairs(v.Connections) do
			if typeof(v2) == "RBXScriptConnection" then
				v2:Disconnect()
			end
		end
	end
	self._Members = {}
	self = {_State = enum.StateEnum.Dead}
end

--[[
    @class ZoneComponent
    Child of Zone, "single-part" component of a Zone
--]]
local ZoneComponent = {}
ZoneComponent.__index = ZoneComponent

ZoneComponent.new = function(Fields: Pair<string, any>?): ZoneComponentType
	Fields = Fields or {}
	local self = setmetatable({}, ZoneComponent)

	-- Private variables
	self._Part = nil
	self._State = enum.StateEnum.Active

	-- Public variables
	self.Shape = Fields["Shape"] or Enum.PartType.Block
	self.CFrame = Fields["CFrame"] or CFrame.new(0, 0, 0)
	if (self.CFrame == CFrame.new(0, 0, 0) or self.CFrame == nil) and typeof(Fields["Position"]) == "Vector3" then
		self.CFrame = CFrame.new(self.Position)
	end
	if typeof(Fields["Orientation"]) == "Vector3" then
		self.CFrame *= CFrame.Angles(Fields["Orientation"])
	end
	self.Size = Fields["Size"] or Vector3.new(3, 3, 3)

	return self
end

function ZoneComponent:_NewPart(): ()
	self._Part.Shape = self.Shape
	self._Part.Size = self.Size
	self._Part.CFrame = self.CFrame
	self._Part.Transparency = 1
	self._Part.Anchored = true
	self._Part.CanCollide = false
	self._Part.CanTouch = false
	self._Part.Massless = true
	self._Part.CastShadow = false
	self._Part.Parent = ZoneFolder
end

function ZoneComponent:Query(QueryType: string, Params: OverlapParams): {BasePart}
	Params = Params or OverlapParams.new()
	if QueryType == enum.QueryType.Bounds then
		if self._Part ~= nil then
			self._Part:Destroy()
		end
		if self.Shape == Enum.PartType.Block then
			return workspace:GetPartBoundsInBox(self.CFrame, self.Size, Params)
		elseif self.Shape == Enum.PartType.Ball then
			return workspace:GetPartBoundsInRadius(self.CFrame, self.Size, Params)
		end
	elseif QueryType == enum.QueryType.Full then
		if self._Part == nil then
			self:_NewPart()
		elseif self._Part.CFrame ~= self.CFrame or self._Part.Size ~= self.Size or self._Part.Shape ~= self.Shape then
			self._Part:Destroy()
			self:_NewPart()
		end
		return workspace:GetPartsInPart(self._Part, Params)
	end
end

function ZoneComponent:GetCharacters(CharacterResolution: string, QueryType: string, Params: OverlapParams): {Model}
	local PartList = self:Query(QueryType, Params)
	local CharacterList = {}
	for _,v in ipairs(PartList) do
		if v.Parent:FindFirstChildOfClass("Humanoid") then
			if CharacterList[v.Parent] == nil then
				local CharacterParts = {}
				for _,v2 in ipairs(v.Parent:GetChildren()) do
					if v2:IsA("BasePart") then
						CharacterParts[v2] = false
					end
				end
				CharacterParts[v] = true
				CharacterList[v.Parent] = CharacterParts
			else
				CharacterList[v.Parent][v] = true
			end
		end
	end
	return CharacterQuerySearch(CharacterList, CharacterResolution)
end

function ZoneComponent:GetPlayers(CharacterResolution: string, QueryType: string, Params: OverlapParams): {Model}
	local PartList = self:Query(QueryType, Params)
	local CharacterList = {}
	for _,v in ipairs(Players:GetPlayers()) do
		if v.Character ~= nil then
			local CharacterParts = {}
			for _,v2 in ipairs(v.Character:GetChildren()) do
				if v2:IsA("BasePart") then
					CharacterParts[v2] = false
				end
			end
			CharacterList[v.Character] = CharacterParts
		end
	end
	for _,v in ipairs(PartList) do
		if CharacterList[v.Parent] ~= nil then
			CharacterList[v.Parent][v] = true
		end
	end
	return CharacterQuerySearch(CharacterList, CharacterResolution)
end

function ZoneComponent:Destroy(): ()
	if typeof(self._Part) == "Instance" then
		self._Part:Destroy()
	end
	self = {_State = enum.StateEnum.Dead}
end

--[[
    @class Zone
    @parent enum, ScriptSignal, Metatable, ZoneComponent
    Static counterpart of Hitbox with a different set of functionalities
--]]
local Zone = {}
Zone.__index = Zone
Zone.CharacterResolutionEnum = enum._get("CharacterResolution")
Zone.QueryTypeEnum = enum._get("QueryType")
enum.StateEnum = enum._get("StateEnum")

Zone.new = function(Fields: Pair<string, any>): ZoneType
	Fields = Fields or {}
	HitboxSerial += 1
	local self = setmetatable({}, Zone)

	-- Private variables
	self._CurrentFrame = 0
	self._CanWarn = true
	self._Visual = nil
	self._MemberParts = Metatable.new(Fields["Members"] or nil)
	self._MemberComponents = {}
	self._CharactersInside = {}
	self._PlayersInside = {}
	self._PartsInside = {}
	self._Destroying = false

	-- Public variables
	self.CharacterEntered = Signal.new()
	self.CharacterLeft = Signal.new()
	self.PlayerEntered = Signal.new()
	self.PlayerLeft = Signal.new()
	self.PartEntered = Signal.new()
	self.PartLeft = Signal.new()

	self.Serial = HitboxSerial
	self.CharacterResolution = Fields["CharacterResolution"] or enum.CharacterResolution.FullBody
	self.QueryType = Fields["QueryType"] or enum.QueryType.Bounds
	self.Rate = Fields["Rate"] or 10 -- How many checks per second
	self.OverlapParams = OverlapParams.new()
	self.OverlapParams.FilterType = Enum.RaycastFilterType.Exclude
	self.OverlapParams.FilterDescendantsInstances = {}
	self.OverlapParams.RespectCanCollide = false
	self.OverlapParams.MaxParts = 0
	self.Active = Fields["Active"] or false
	if self.Active == true then
		self.State = enum.StateEnum.Active
	else
		self.State = enum.StateEnum.Paused
	end

	for _,v in ipairs(self._MemberParts) do
		if typeof(v) == "Instance" and v:IsA("BasePart") then
			table.insert(self._MemberComponents, ZoneComponent.new({
				["Shape"] = v.Shape,
				["CFrame"] = v.CFrame,
				["Size"] = v.Size
			}))
		end
	end

	if typeof(Fields["Components"]) == "table" then
		for _,v in ipairs(Fields["Components"]) do
			if typeof(v) == "table" and v.Shape ~= nil and v.CFrame ~= nil and v.Size ~= nil then
				self._MemberComponents[FindHighestIndex(self._MemberComponents) + 1] = v
			end
		end
	end

	ActiveZones[self.Serial] = self

	return self
end

function Zone:Update(): ()
	for i,v in pairs(self._MemberComponents) do
		if typeof(i) == "Instance" then
			if i.Parent == nil then
				v:Destroy()
				self._MemberComponents[i] = nil
			elseif self._MemberParts:_IsMember(v) == false then
				v:Destroy()
				self._MemberComponents[i] = nil
			else
				v.CFrame = i.CFrame
				v.Size = i.Size
				v.Shape = i.Shape
			end
		end
	end
	for _,v in ipairs(self._MemberParts._Members) do
		if self._MemberComponents[v.Instance] == nil then
			self._MemberComponents[v.Instance] = ZoneComponent.new({
				["Shape"] = v.Instance.Shape,
				["CFrame"] = v.Instance.CFrame,
				["Size"] = v.Instance.Size
			})
		end
	end
	self._MemberParts:_CleanUp()
end

function Zone:Relocate(newCFrame: CFrame): ()
	-- WIP
end

function Zone:AddMember(part: BasePart, Metafunctions: Pair<string, (any)>?): ()
	if self._MemberParts:_IsMember(part) == false then
		Metafunctions["Destroying"] = function()
			task.wait()
			self._MemberParts:_CleanUp()
			task.wait()
		end
		self._MemberParts:_Add(part, Metafunctions)
	end
end

function Zone:RemoveMember(part: BasePart): ()
	if self._MemberParts:_IsMember(part) == true then
		self._MemberParts:_Remove(part)
	end
end

function Zone:AddComponent(Component: ZoneComponentType): number?
	if typeof(Component) == "table" and Component.Shape ~= nil and Component.CFrame ~= nil and Component.Size ~= nil then
		local index = FindHighestIndex(self._MemberComponents) + 1
		self._MemberComponents[index] = Component
		return index
	end
	return nil
end

function Zone:RemoveComponent(index: BasePart | number): ()
	for i,v in pairs(self._MemberComponents) do
		if i == index then
			v:Destroy()
			self._MemberComponents[i] = nil
			if typeof(index) == "Instance" then
				self:RemoveMember(index)
			end
		end
	end
end

function Zone:IsPartInside(Part: BasePart): boolean
	for _,v in ipairs(self._PartsInside) do
		if v == Part then
			return true
		end
	end
	return false
end

function Zone:IsCharacterInside(Character: Model): boolean
	for _,v in ipairs(self._CharactersInside) do
		if v == Character then
			return true
		end
	end
	return false
end

function Zone:IsPlayerInside(Character: Model): boolean
	for _,v in ipairs(self._PlayersInside) do
		if v == Character then
			return true
		end
	end
	return false
end

function Zone:GetPartsInside(): {BasePart}
	local PartList = {}
	for _,v in pairs(self._MemberComponents) do
		for _,v2 in ipairs(v:Query(self.QueryType, self.OverlapParams)) do
			table.insert(PartList, v2)
		end
	end
	return PartList
end

function Zone:GetCharactersInside(PartList: {BasePart}?): {Model}
	local CharacterList = {}
	if typeof(PartList) == "table" then
		for _,v in ipairs(PartList) do
			if v.Parent:FindFirstChildOfClass("Humanoid") then
				if CharacterList[v.Parent] == nil then
					local CharacterParts = {}
					for _,v2 in ipairs(v.Parent:GetChildren()) do
						if v2:IsA("BasePart") then
							CharacterParts[v2] = false
						end
					end
					CharacterParts[v] = true
					CharacterList[v.Parent] = CharacterParts
				else
					CharacterList[v.Parent][v] = true
				end
			end
		end
		return CharacterQuerySearch(CharacterList, self.CharacterResolution)
	else
		for _,v in pairs(self._MemberComponents) do
			for _,v2 in ipairs(v:GetCharacters(self.CharacterResolution, self.QueryType, self.OverlapParams)) do
				table.insert(CharacterList, v2)
			end
		end
		return CharacterList
	end
end

function Zone:GetPlayersInside(PartList: {BasePart}?): {Model}
	local CharacterList = {}
	if typeof(PartList) == "table" then
		for _,v in ipairs(Players:GetPlayers()) do
			if v.Character ~= nil then
				local CharacterParts = {}
				for _,v2 in ipairs(v.Character:GetChildren()) do
					if v2:IsA("BasePart") then
						CharacterParts[v2] = false
					end
				end
				CharacterList[v.Character] = CharacterParts
			end
		end
		for _,v in ipairs(PartList) do
			if CharacterList[v.Parent] ~= nil then
				CharacterList[v.Parent][v] = true
			end
		end
		return CharacterQuerySearch(CharacterList, self.CharacterResolution)
	else
		for _,v in pairs(self._MemberComponents) do
			for _,v2 in ipairs(v:GetPlayers(self.CharacterResolution, self.QueryType, self.OverlapParams)) do
				table.insert(CharacterList, v2)
			end
		end
		return CharacterList
	end
end

function Zone:Activate(): ()
	self.Active = true
	self.State = enum.StateEnum.Active
end

function Zone:Deactivate(): ()
	self.Active = false
	self.State = enum.StateEnum.Paused
end

function Zone:Destroy(): ()
	self._Destroying = true
	self:Deactivate()
	self.CharacterEntered:Destroy()
	self.CharacterLeft:Destroy()
	self.PlayerEntered:Destroy()
	self.PlayerLeft:Destroy()
	self.PartEntered:Destroy()
	self.PartLeft:Destroy()
	self._MemberParts:Destroy()
	for _,v in pairs(self._MemberComponents) do
		v:Destroy()
	end

	ActiveZones[self.Serial] = nil

	self = {State = enum.StateEnum.Dead}
end

--[[
    @main
    @class Module
    Instantiation handler
--]]
local Module = {}

Module.newHitbox = function(...): HitboxType -- Can be ran on both client and server
	return Hitbox.new(...)
end

Module.newZone = function(...): ZoneType -- Can be ran on both client and server
	return Zone.new(...)
end

Module.newEnum = function(): {enumPair<string>} -- Can be ran on both client and server
	return setmetatable(enum, enumMetatable)
end

Module.newSignal = function(): ScriptSignal -- Can be ran on both client and server
	return Signal.new()
end

Module.newMetatable = function(...): MetatableType -- Can be ran on both client and server
	return Metatable.new(...)
end

Module.newZoneComponent = function(...): ZoneComponentType -- Can be ran on both client and server
	return ZoneComponent.new(...)
end

function Module:CharacterListToPlayerList(CharacterList: {Model}): {Player}
	local PlayerList = {}
	for _,v in ipairs(CharacterList) do
		local Player = Players:GetPlayerFromCharacter(v)
		if Player ~= nil then
			table.insert(PlayerList, Player)
		end
	end
	return PlayerList
end

function Module:_PrintSerial(): ()
	print(concatPrint("The current highest serial is " .. HitboxSerial .. "."))
end

function Module:_PrintActiveHitboxes(): ()
	print(concatPrint("There are " .. #ActiveHitboxes .. " hitboxes."))
end

function Module:_PrintActiveZones(): ()
	print(concatPrint("There are " .. #ActiveZones .. " hitboxes."))
end

function Module:_GetActiveHitboxes(): {Pair<number, HitboxType>}
	return ActiveHitboxes
end

function Module:_GetActiveZones(): {Pair<number, ZoneType>}
	return ActiveZones
end

return Module
