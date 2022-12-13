local Player = game:GetService("Players").LocalPlayer

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

local Hook; Hook = hookmetamethod(game, "__namecall", newcclosure(function(Self, ...)
    local Arguments = {...}
    local NCM = getnamecallmethod()
    
    if Self == workspace and NCM == "FindPartOnRayWithIgnoreList" and not game:IsAncestorOf(getcallingscript()) then
        local Goal = GetGoal()
        
        return Goal, Goal.Position + Vector3.new(0, 45, 0)
    end
    
    return Hook(Self, ...)
end))
