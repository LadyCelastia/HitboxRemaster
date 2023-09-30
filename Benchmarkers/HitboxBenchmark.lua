local rep = game:GetService("ServerStorage")
local modules = rep:WaitForChild("Modules")
local hitboxremaster = require(modules:WaitForChild("HitboxRemaster"))
local tool = script.Parent
local handle = tool:WaitForChild("Handle")
local attach = handle:WaitForChild("Attachment")

local function HitboxPure()
	hitboxremaster.newHitbox()
end

local function HitboxFull()
	local hitbox = hitboxremaster.newHitbox({
		["Attachment"] = attach,
		["LifeTime"] = 1,
		["Pierce"] = 3,
	})
	hitbox.Shape = hitbox.ShapeEnum.Sphere
	hitbox:AddIgnore(tool.Parent)
	hitbox.Hit:Connect(function(hum, part, data)
		hum:TakeDamage(10)
	end)
	hitbox:Activate()
end

local function bulkBenchmark(cycles, func)
	local timeList = {tick()}
	for i = 1, cycles do
		func()
		table.insert(timeList, tick())
	end
	local avg = 0
	for i,v in ipairs(timeList) do
		if i ~= #timeList then
			avg = avg + (timeList[i + 1] - timeList[i])
			if i ~= 1 then
				avg /= 2
			end
		end
	end
	local total = timeList[#timeList] - timeList[1]
	print("Ran " .. cycles .. " times in " .. total .. " second(s) with average of " .. avg .. " second(s) per call")
end

tool.Activated:Connect(function()
	-- 1 run
	local before = tick()
	HitboxFull()
	local after = tick()
	print("Ran 1 time in " .. (after - before) .. " second(s)")
	--[[
	task.wait()
	hitboxremaster:_PrintActiveHitboxes()
	hitboxremaster:_PrintSerial()
	--]]
	
	task.wait(3)
	--[[
	local activeHitboxes = hitboxremaster:_GetActiveHitboxes()
	print(activeHitboxes[1])
	--]]
	
	-- 100 runs
	bulkBenchmark(100, HitboxFull)
	--[[
	task.wait()
	hitboxremaster:_PrintActiveHitboxes()
	hitboxremaster:_PrintSerial()
	--]]
	
	task.wait(3)
	--[[
	activeHitboxes = hitboxremaster:_GetActiveHitboxes()
	print(activeHitboxes[1])
	print(activeHitboxes[11])
	print(activeHitboxes[27])
	print(activeHitboxes[49])
	print(activeHitboxes[69])
	print(activeHitboxes[99])
	print(activeHitboxes[101])
	--[[--]]
	
	-- 1000 runs
	bulkBenchmark(1000, HitboxFull)
	--[[
	task.wait()
	hitboxremaster:_PrintActiveHitboxes()
	hitboxremaster:_PrintSerial()
	--]]
	
	task.wait(3)
	--[[
	print(activeHitboxes[1])
	print(activeHitboxes[102])
	print(activeHitboxes[420])
	print(activeHitboxes[690])
	print(activeHitboxes[999])
	print(activeHitboxes[1100])
	print(activeHitboxes[1101])
	--]]
	
	-- 10000 runs stress test
	bulkBenchmark(10000, HitboxFull)
	--[[
	task.wait()
	hitboxremaster:_PrintActiveHitboxes()
	hitboxremaster:_PrintSerial()
	--]]
end)
