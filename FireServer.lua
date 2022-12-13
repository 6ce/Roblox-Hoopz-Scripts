local Player = game:GetService("Players").LocalPlayer
local RepStorage = game:GetService("ReplicatedStorage")

local Shooting = RepStorage:WaitForChild("shootingEvent")

local Cursor = Player.PlayerGui:WaitForChild("PowerUI"):WaitForChild("CursorButton")
local Clicked = getconnections(Cursor.MouseButton1Click)[1].Function

if workspace:FindFirstChild("PracticeArea") then
    workspace.PracticeArea.Parent = workspace.Courts
end

local Order do
    for _, Upvalue in next, getupvalues(Clicked) do
        if type(Upvalue) == "table" and table.find(Upvalue, "X1") then
            Order = Upvalue
        end
    end
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

local Randomize = function(RootPosition, Direction)
    local Arguments = {
        X1 = RootPosition.X,
        Y1 = RootPosition.Y,
        Z1 = RootPosition.Z,
        X2 = Direction.X,
        Y2 = Direction.Y,
        Z2 = Direction.Z
    }
    
    return {
        Arguments[Order[1]],
        Arguments[Order[2]],
        Arguments[Order[3]],
        Arguments[Order[4]],
        Arguments[Order[5]],
        Arguments[Order[6]]
    }
end

local FireServer do
    FireServer = hookfunction(Instance.new("RemoteEvent").FireServer, function(Self, ...)
        local Arguments = {...}
        
        if Self == Shooting and not checkcaller() then
            local RootPosition = Player.Character.HumanoidRootPart.Position
            local GoalPosition = GetGoal().Position
            local Direction = ((GoalPosition + Vector3.new(0, 50, 0)) - RootPosition).Unit
            
            Arguments[3] = Randomize(RootPosition, Direction)
        end
        
        return FireServer(Self, table.unpack(Arguments))
    end)
end
