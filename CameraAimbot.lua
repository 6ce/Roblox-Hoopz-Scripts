-- // X to shoot

local Player = game:GetService("Players").LocalPlayer
local Camera = workspace.CurrentCamera

local Controls = require(Player.PlayerScripts.ControlScript.MasterControl)
local Button = Player.PlayerGui.PowerUI.CursorButton

if workspace:FindFirstChild("PracticeArea") then
    workspace.PracticeArea.Parent = workspace.Courts
end

local GetGoal = function()
    local Distance, Goal = 9e9;
    
    for _, Obj in next, workspace.Courts:GetDescendants() do
        if Obj.Name == "Swish" and Obj.Parent:FindFirstChildOfClass("TouchTransmitter") then
            local Magnitude = (Player.Character.Torso.Position - Obj.Parent.Position).Magnitude
        
            if Distance > Magnitude then
                Distance = Magnitude
                Goal = Obj.Parent
            end
        end
    end
    
    return Goal
end

game:GetService("UserInputService").InputBegan:Connect(function(Key, GPE)
    if not GPE and Key.KeyCode == Enum.KeyCode.X then
        local Goal = GetGoal()
        local OldCFrame = Camera.CFrame
        
        Player.DevEnableMouseLock = false
        Camera.CFrame = CFrame.new(Player.Character.Head.Position, Goal.Position)
        Camera.CFrame = OldCFrame
        Player.DevEnableMouseLock = true
    end
end)
