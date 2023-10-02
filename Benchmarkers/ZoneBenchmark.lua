task.wait(3)
local ss = game:GetService("ServerStorage")
local modules = ss:WaitForChild("Modules")
local hitboxremaster = require(modules:WaitForChild("HitboxRemaster"))

local partList = {}
for _,v in ipairs(script.Parent:GetChildren()) do
	if v:IsA("BasePart") then
		table.insert(partList, v)
	end
end

local function ZonePure()
	hitboxremaster.newZone()
end

local function ZoneFull()
	local zone = hitboxremaster.newZone({
		["CharacterResolution"] = "OnePart",
		["QueryType"] = "Full"
	})
	zone:AddMemberBulk(partList)

	zone.PartEntered:Connect(function(part)
		print("Part entered! " .. part.Name)
	end)

	zone.PartLeft:Connect(function(part)
		print("Part left! " .. part.Name)
	end)

	zone.CharacterEntered:Connect(function(char)
		print("Character entered! " .. char.Name)
	end)

	zone.CharacterLeft:Connect(function(char)
		print("Character left! " .. char.Name)
	end)

	zone.PlayerEntered:Connect(function(char)
		print("Player entered! " .. char.Name)
	end)

	zone.PlayerLeft:Connect(function(char)
		print("Player left! " .. char.Name)
	end)

	zone:Activate()
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

local before = tick()
ZoneFull()
local after = tick()
print("Ran 1 time in " .. (after - before) .. " second(s)")

task.wait(3)

bulkBenchmark(100, ZoneFull)

task.wait(3)

bulkBenchmark(1000, ZoneFull)

task.wait(3)

bulkBenchmark(10000, ZoneFull)
