-- Brainrot Auto Farm for https://www.roblox.com/games/109983668079237/Steal-a-Brainrot
if _G.BrainrotExecuted then return end
G.BrainrotExecuted = true

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

print("🎯 BRAINROT FARM ACTIVATED!")

-- Auto collect brainrots
function CollectBrainrots()
    for , obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "BrainRot" or string.lower(obj.Name):find("brainrot") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                task.wait(0.1)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
            end
        end
    end
end

-- Auto spawn brainrots
function SpawnBrainrots()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj.Name == "Spawn" or string.lower(obj.Name):find("spawn") then
            if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 0)
                task.wait(0.1)
                firetouchinterest(LocalPlayer.Character.HumanoidRootPart, obj, 1)
            end
        end
    end
end

-- Main farm loop
while task.wait(0.5) do
    CollectBrainrots()
    SpawnBrainrots()
end
