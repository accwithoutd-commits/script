-- Auto Farm for Steal a Brainrot
if _G.BrainrotFarm then return end
G.BrainrotFarm = true

print("🤖 BRAINROT FARM STARTED!")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Просто и понятно
while wait(1) do
    -- Крадем brainrot
    for , obj in pairs(workspace:GetDescendants()) do
        if string.lower(obj.Name):find("brainrot") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                wait(0.1)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
            end
        end
    end

    -- Спавним новые brainrot
    for _, obj in pairs(workspace:GetDescendants()) do
        if string.lower(obj.Name):find("spawn") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                wait(0.1)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
            end
        end
    end
end
