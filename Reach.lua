local plr = game.Players.LocalPlayer
local rs = game:GetService("RunService")

function getNearestPart(torso)
    local dist, part = 9e9 
    for i,v in pairs(plr.Character:GetChildren()) do
        if v:IsA("Part") and torso then
            local mag = (v.Position - torso.Position).Magnitude
            if dist > mag then
                dist = mag
                part = v
            end
        end
    end
    return part
end

while task.wait() do; pcall(function()
    for i,v in pairs(game.Players:GetPlayers()) do
        if (v.Name ~= plr.Name and v.Character and plr.Character) and _G.Autogaurd then
            for z,x in pairs(v.Character:GetChildren()) do
                local nearestPart = getNearestPart(v.Character.Torso)
                
                if ((nearestPart.Position - v.Character.Torso.Position).Magnitude < 8) then
                    if (x:IsA("Tool") or x:IsA("Folder")) then
                        firetouchinterest(nearestPart, x:FindFirstChildOfClass("Part"), 0)
                        task.wait()
                        firetouchinterest(nearestPart, x:FindFirstChildOfClass("Part"), 1)
                    elseif (x:IsA("BasePart") and string.find(x.Name:lower(), "ball")) then
                        firetouchinterest(nearestPart, x, 0)
                        task.wait()
                        firetouchinterest(nearestPart, x, 1)
                    end
                end
            end
        end
    end
end); end
