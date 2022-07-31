local plr = game.Players.LocalPlayer

local uis = game:GetService("UserInputService")
local rs = game:GetService("RunService")
local sw = game.ReplicatedStorage:FindFirstChild("ScreenWatch")

local ground

local part = workspace:FindPartOnRay(Ray.new(plr.Character.Torso.Position, Vector3.new(0, -100, 5)))
if part then
    ground = part
end

local tracking = false
local player

function updateNearestPlayerWithBall()
    local dist = 9e9
    for i,v in pairs(game.Players:GetPlayers()) do
        if v.Name ~= plr.Name and v.Character and v.Character:FindFirstChild("Basketball") and not plr.Character:FindFirstChild("Basketball") and (plr.Character.Torso.Position - v.Character.Torso.Position).Magnitude < 50 then
            local mag = (plr.Character.Torso.Position - v.Character.Torso.Position).Magnitude
            if dist > mag then
                dist = mag
                player = v
            end
        end
    end
end

function stepped()
    updateNearestPlayerWithBall()

    if _G.Autogaurd and tracking and player and plr.Character and plr.Character:FindFirstChild("Humanoid") and not plr.Character:FindFirstChild("Basketball") and player.Character and player.Character:FindFirstChild("Basketball") then
        plr.Character.Humanoid:MoveTo(player.Character.Basketball:FindFirstChildOfClass("Part").Position + player.Character.Torso.CFrame.LookVector + ((player.Character.Humanoid.MoveDirection * 2) + (plr.Character.Torso.Velocity.Unit * 3)))
        
        if (player.Character.Torso.Position.Y - ground.Position.Y) > 2.5 then
            plr.Character.Humanoid.Jump = true
        end
    elseif tracking and player ~= nil and player.Character and plr.Character and plr.Character:FindFirstChild("Basketball") or not player.Character:FindFirstChild("Basketball") then
        tracking = false
        return
    end
end

function keyPressed(key, gpe)
    if not gpe and key.KeyCode == Enum.KeyCode.Y and _G.Autogaurd then
        updateNearestPlayerWithBall()
        if not tracking then
            tracking = true
        else
            tracking = false
        end
    end
end

local hook; hook = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local args = {...}
    if sw and player ~= nil and getnamecallmethod() == "IsKeyDown" and table.find(controls, args[1]) then
        local key = table.find(controls, args[1])
        return sw[player.Name][key.Name].Value
    end
    return hook(self, ...)
end))

uis.InputBegan:Connect(keyPressed)
rs.Stepped:Connect(stepped)
