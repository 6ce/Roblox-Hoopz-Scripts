local reset = false

pcall(function()
    if _G.stepped ~= nil or _G.input ~= nil or _G.charAdded ~= nil then
        reset = true
        _G.stepped:Disconnect()
        _G.input:Disconnect()
        _G.charAdded:Disconnect()
        _G.charAdded = nil
        _G.stepped = nil
        _G.input = nil
        print("RESET")
    end
    if not reset then
        print("LOADED")
    end
end)

local plr = game.Players.LocalPlayer
local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")

local shootingEvent = game:GetService("ReplicatedStorage").shootingEvent

if workspace:FindFirstChild("PracticeArea") then
    workspace.PracticeArea.Parent = workspace.Courts
end

local jumping = false

for i,v in pairs(getconnections(game:GetService("UserInputService").TouchTapInWorld)) do
    for z,x in pairs(getupvalues(v.Function)) do
        if type(x) == "table" and rawget(x, 1) then
            _G.method = x
        elseif z == 10 then
            _G.key = x
        end
    end
end

for i,v in pairs(getconnections(plr.Character.HumanoidRootPart:GetPropertyChangedSignal("Size"))) do
    v:Disable()
end

if _G.hook ~= nil then
    _G.hook = ""; _G.hook = hookmetamethod(game, "__index", newcclosure(function(self, idx)
        if tostring(self) == "HumanoidRootPart" and idx == "Size" then
            return Vector3.new(2, 2, 1)
        end
        return hook(self, idx)
    end))
end

shootingEvent.OnClientEvent:Connect(function(newKey)
    _G.key = newKey
end)

function setup()
    local dist, goal = 9e9, nil
    for i,v in pairs(workspace.Courts:GetDescendants()) do
        if v.Name == "Swish" and v:IsA("Sound") and plr.Character and plr.Character:FindFirstChild("Torso") then
            local mag = (plr.Character.Torso.Position - v.Parent.Position).Magnitude
            if dist > mag then
                dist = mag; goal = v.Parent
            end
        end
    end
    return dist, goal
end

function power()
    return plr.Power
end

function changePower(goal)
    power().Value = goal
end

function table(a, b)
    local args = {
		X1 = a.X, 
		Y1 = a.Y, 
		Z1 = a.Z, 
		X2 = b.X, 
		Y2 = b.Y, 
		Z2 = b.Z
	};
	
	return {args[_G.method[1]], args[_G.method[2]], args[_G.method[3]], args[_G.method[4]], args[_G.method[5]], args[_G.method[6]]}
end

function arc()
    local dist, goal = setup()

    dist = math.floor(dist)
  
    if dist == 12 or dist == 13 then
        return 20
    elseif dist == 14 or dist == 15 then
        return 25
    elseif dist == 16 or dist == 17 then
        return 15
    elseif dist == 18 then
        return 25
    elseif dist == 19 then
        return 20
    elseif dist == 20 or dist == 21 then
        return 20
    elseif dist == 22 or dist == 23 then
        return 25
    elseif dist == 24 or dist == 25 then
        return 20
    elseif dist == 26 then
        return 15
    elseif dist == 27 or dist == 28 then
        return 25
    elseif dist == 29 or dist == 30 then
        return 20
    elseif dist == 31 then
        return 15
    elseif dist == 32 or dist == 33 then
        return 30
    elseif dist == 34 or dist == 35 then
        return 25
    elseif dist == 36 or dist == 37 or dist == 38 then
        return 35
    elseif dist == 39 or dist == 40 then
        return 30
    elseif dist == 41 then
        return 25
    elseif dist == 42 or dist == 43 then
        return 40
    elseif dist == 44 then
        return 35
    elseif dist == 45 then
        return 30
    elseif dist == 46 or dist == 47 or dist == 48 then
        return 45
    elseif dist == 49 then
        return 40
    elseif dist == 50 then
        return 35
    elseif dist == 51 then
        return 50
    elseif dist == 52 then
        return 55
    elseif dist == 53 or dist == 54 then
        return 50
    elseif dist == 55 or dist == 56 then
        return 45
    elseif dist == 57 or dist == 58 then
        return 55
    elseif dist == 59 or dist == 60 then
        return 50
    elseif dist == 61 or dist == 62 or dist == 63 then
        return 65
    elseif dist == 64 then
        return 55
    elseif dist == 65 then
        return 60
    elseif dist == 66 or dist == 67 then
        return 50
    elseif dist == 68 or dist == 69 then
        return 75
    elseif dist == 70 or dist == 71 or dist == 72 then
        return 70
    elseif dist == 73 then
        return 60
    elseif dist == 74 then
        return 50
    elseif jumping then
        if dist == 9 or dist == 10 then
            return 25
        elseif dist == 11 or dist == 12 then
            return 20
        end
    end
end

function stepped()
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        local pwr = power()
        local dist, goal = setup()
        local root = plr.Character.HumanoidRootPart
    
        dist = math.floor(dist)

        if root and plr.Character:FindFirstChild("Basketball") and _G.HoopzAimbot then
            root.Size = Vector3.new(2.1, 2, 1.1)
            root.BrickColor = BrickColor.new("Lime green")
            root.Material = Enum.Material.Neon
        
            if dist >= 13 and dist <= 16 then
                changePower(30)
                root.Transparency = 0
            elseif dist >= 17 and dist <= 21 then
                changePower(35)
                root.Transparency = 0
            elseif dist >= 22 and dist <= 26 then
                changePower(40)
                root.Transparency = 0 
            elseif dist >= 27 and dist <= 31 then
                changePower(45)
                root.Transparency = 0
            elseif dist >= 32 and dist <= 36 then
                changePower(50)
                root.Transparency = 0
            elseif dist >= 37 and dist <= 41 then
                changePower(55)
                root.Transparency = 0
            elseif dist >= 42 and dist <= 46 then
                changePower(60)
                root.Transparency = 0
            elseif dist >= 47 and dist <= 51 then
                changePower(65)
                root.Transparency = 0
            elseif dist >= 52 and dist <= 56 then
                changePower(70)
                root.Transparency = 0
            elseif dist >= 57 and dist <= 61 then
                changePower(75)
                root.Transparency = 0
            elseif dist >= 62 and dist <= 67 then
                changePower(80)
                root.Transparency = 0
            elseif dist >= 68 and dist <= 74 then
                changePower(85)
                root.Transparency = 0
            elseif jumping and dist == 9 or dist == 10 or dist == 11 or dist == 12 then
                changePower(25)
                root.Transparency = 0
            else
                root.Transparency = 1
            end
        elseif root and not plr.Character:FindFirstChild("Basketball") and _G.HoopzAimbot then
            root.Transparency = 1
        elseif not _G.HoopzAimbot then
            root.Transparency = 1
        end
    end
end

function shoot()
    local dist, goal = setup()
    local pwr = power()
    local arc = arc()
    
    if arc ~= nil and plr.Character and plr.Character:FindFirstChild("Humanoid") then
        local args = table(plr.Character.Torso.Position, (goal.Position + Vector3.new(0, arc, 0) - plr.Character.HumanoidRootPart.Position + plr.Character.Humanoid.MoveDirection).Unit)
    
        shootingEvent:FireServer(
            plr.Character.Basketball,
            pwr.Value,
            args,
            _G.key
        )
    end
end

function jumped()
    if plr.Character and plr.Character:FindFirstChild("Basketball") and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character.HumanoidRootPart.Transparency == 0 and _G.HoopzAimbot then
        jumping = true
        task.wait(0.325)
        shoot()
        task.wait(0.1)
        jumping = false
    end
end

_G.input = plr.Character.Humanoid.Jumping:Connect(jumped)
_G.stepped = rs.Stepped:Connect(stepped)

_G.charAdded = plr.CharacterAdded:Connect(function(ch)
    ch:WaitForChild("Humanoid").Jumping:Connect(jumped)
    for i,v in pairs(getconnections(ch:WaitForChild("HumanoidRootPart"):GetPropertyChangedSignal("Size"))) do
        v:Disable()
    end
end)
