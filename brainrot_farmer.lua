-- Brainrot Farmer v2.0
print("🧠 Brainrot Farmer загружен!")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Простой скрипт для начала
function AutoSteal()
    for _, obj in pairs(workspace:GetDescendants()) do
        if string.lower(obj.Name):find("brainrot") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = obj.CFrame
            break
        end
    end
end

while wait(1) do
    AutoSteal()
end
