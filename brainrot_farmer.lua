-- Brainrot Dominator v5.0 - With Cool Background
if _G.BrainrotDominator then return end
_G.BrainrotDominator = true

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local Config = {
    AutoSteal = true,
    AutoSpawn = true,
    ESPPlayers = false,
    ESPBrainrots = false,
    StealRange = 50,
    TeleportDelay = 2
}

-- Simple ESP Function
function CreateESP(object, color, name)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ESP_" .. name
    Highlight.Parent = object
    Highlight.FillColor = color
    Highlight.OutlineColor = color
    Highlight.FillTransparency = 0.5
    Highlight.OutlineTransparency = 0
    return Highlight
end

function UpdateESP()
    -- Clear old ESP
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:FindFirstChildWhichIsA("Highlight") then
            obj:FindFirstChildWhichIsA("Highlight"):Destroy()
        end
    end
    
    -- ESP Players
    if Config.ESPPlayers then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                CreateESP(player.Character, Color3.fromRGB(255, 0, 0), "Player")
            end
        end
    end
    
    -- ESP Brainrots
    if Config.ESPBrainrots then
        for _, obj in pairs(workspace:GetDescendants()) do
            if string.lower(obj.Name):find("brainrot") then
                CreateESP(obj, Color3.fromRGB(0, 255, 0), "Brainrot")
            end
        end
    end
end

-- Auto Functions
function AutoSteal()
    if not Config.AutoSteal then return end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if string.lower(obj.Name):find("brainrot") then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local distance = (obj.Position - char.HumanoidRootPart.Position).Magnitude
                if distance < Config.StealRange then
                    firetouchinterest(char.HumanoidRootPart, obj, 0)
                    task.wait(0.1)
                    firetouchinterest(char.HumanoidRootPart, obj, 1)
                end
            end
        end
    end
end

function AutoSpawn()
    if not Config.AutoSpawn then return end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if string.lower(obj.Name):find("spawn") then
            local char = LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                local distance = (obj.Position - char.HumanoidRootPart.Position).Magnitude
                if distance < Config.StealRange then
                    firetouchinterest(char.HumanoidRootPart, obj, 0)
                    task.wait(0.1)
                    firetouchinterest(char.HumanoidRootPart, obj, 1)
                end
            end
        end
    end
end

-- Create UI with Background Image
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

-- Background Image
local Background = Instance.new("ImageLabel")
Background.Name = "Background"
Background.Parent = ScreenGui
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Background.Image = "rbxassetid://13796596449" -- Cool background image
Background.ImageTransparency = 0.7
Background.ScaleType = Enum.ScaleType.Crop
Background.ZIndex = 0

-- Credit Text
local CreditLabel = Instance.new("TextLabel")
CreditLabel.Name = "CreditLabel"
CreditLabel.Parent = Background
CreditLabel.Size = UDim2.new(1, 0, 0, 30)
CreditLabel.Position = UDim2.new(0, 0, 0.97, 0)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "Created by: узник концлагеря, hhhh, deepseek"
CreditLabel.TextColor3 = Color3.fromRGB(255, 255, 0)
CreditLabel.TextSize = 14
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.ZIndex = 1

local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 350, 0, 450)
MainFrame.Position = UDim2.new(0.5, -175, 0.5, -225)
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BackgroundTransparency = 0.1
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Parent = ScreenGui

-- Add border to main frame
local FrameBorder = Instance.new("UIStroke")
FrameBorder.Parent = MainFrame
FrameBorder.Color = Color3.fromRGB(0, 150, 255)
FrameBorder.Thickness = 2

local Title = Instance.new("TextLabel")
Title.Text = "🧠 BRAINROT DOMINATOR v5.0 🧠"
Title.Size = UDim2.new(1, 0, 0, 50)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BackgroundTransparency = 0.2
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = MainFrame

-- Add border to title
local TitleBorder = Instance.new("UIStroke")
TitleBorder.Parent = Title
TitleBorder.Color = Color3.fromRGB(255, 215, 0)
TitleBorder.Thickness = 1

-- Auto Farm Toggle
local FarmToggle = Instance.new("TextButton")
FarmToggle.Text = "✅ Auto Farm: ON"
FarmToggle.Size = UDim2.new(1, -20, 0, 40)
FarmToggle.Position = UDim2.new(0, 10, 0, 60)
FarmToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
FarmToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
FarmToggle.Font = Enum.Font.Gotham
FarmToggle.TextSize = 14
FarmToggle.Parent = MainFrame

FarmToggle.MouseButton1Click:Connect(function()
    Config.AutoSteal = not Config.AutoSteal
    FarmToggle.Text = (Config.AutoSteal and "✅" or "❌") .. " Auto Farm: " .. (Config.AutoSteal and "ON" or "OFF")
    FarmToggle.BackgroundColor3 = Config.AutoSteal and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

-- Auto Spawn Toggle
local SpawnToggle = Instance.new("TextButton")
SpawnToggle.Text = "✅ Auto Spawn: ON"
SpawnToggle.Size = UDim2.new(1, -20, 0, 40)
SpawnToggle.Position = UDim2.new(0, 10, 0, 110)
SpawnToggle.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
SpawnToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
SpawnToggle.Font = Enum.Font.Gotham
SpawnToggle.TextSize = 14
SpawnToggle.Parent = MainFrame

SpawnToggle.MouseButton1Click:Connect(function()
    Config.AutoSpawn = not Config.AutoSpawn
    SpawnToggle.Text = (Config.AutoSpawn and "✅" or "❌") .. " Auto Spawn: " .. (Config.AutoSpawn and "ON" or "OFF")
    SpawnToggle.BackgroundColor3 = Config.AutoSpawn and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
end)

-- ESP Players Toggle
local ESPPlayersToggle = Instance.new("TextButton")
ESPPlayersToggle.Text = "👁️ ESP Players: OFF"
ESPPlayersToggle.Size = UDim2.new(1, -20, 0, 40)
ESPPlayersToggle.Position = UDim2.new(0, 10, 0, 160)
ESPPlayersToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ESPPlayersToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPPlayersToggle.Font = Enum.Font.Gotham
ESPPlayersToggle.TextSize = 14
ESPPlayersToggle.Parent = MainFrame

ESPPlayersToggle.MouseButton1Click:Connect(function()
    Config.ESPPlayers = not Config.ESPPlayers
    ESPPlayersToggle.Text = "👁️ ESP Players: " .. (Config.ESPPlayers and "ON" or "OFF")
    ESPPlayersToggle.BackgroundColor3 = Config.ESPPlayers and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    UpdateESP()
end)

-- ESP Brainrots Toggle
local ESPBrainrotsToggle = Instance.new("TextButton")
ESPBrainrotsToggle.Text = "🧠 ESP Brainrots: OFF"
ESPBrainrotsToggle.Size = UDim2.new(1, -20, 0, 40)
ESPBrainrotsToggle.Position = UDim2.new(0, 10, 0, 210)
ESPBrainrotsToggle.BackgroundColor3 = Color3.fromRGB(150, 0, 0)
ESPBrainrotsToggle.TextColor3 = Color3.fromRGB(255, 255, 255)
ESPBrainrotsToggle.Font = Enum.Font.Gotham
ESPBrainrotsToggle.TextSize = 14
ESPBrainrotsToggle.Parent = MainFrame

ESPBrainrotsToggle.MouseButton1Click:Connect(function()
    Config.ESPBrainrots = not Config.ESPBrainrots
    ESPBrainrotsToggle.Text = "🧠 ESP Brainrots: " .. (Config.ESPBrainrots and "ON" or "OFF")
    ESPBrainrotsToggle.BackgroundColor3 = Config.ESPBrainrots and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(150, 0, 0)
    UpdateESP()
end)

-- Range Slider
local RangeLabel = Instance.new("TextLabel")
RangeLabel.Text = "🎯 Steal Range: " .. Config.StealRange
RangeLabel.Size = UDim2.new(1, -20, 0, 30)
RangeLabel.Position = UDim2.new(0, 10, 0, 260)
RangeLabel.BackgroundTransparency = 1
RangeLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
RangeLabel.Font = Enum.Font.Gotham
RangeLabel.TextSize = 14
RangeLabel.Parent = MainFrame

local RangeSlider = Instance.new("TextButton")
RangeSlider.Text = "📏 Adjust Range"
RangeSlider.Size = UDim2.new(1, -20, 0, 40)
RangeSlider.Position = UDim2.new(0, 10, 0, 290)
RangeSlider.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
RangeSlider.TextColor3 = Color3.fromRGB(255, 255, 255)
RangeSlider.Font = Enum.Font.Gotham
RangeSlider.TextSize = 14
RangeSlider.Parent = MainFrame

RangeSlider.MouseButton1Click:Connect(function()
    Config.StealRange = Config.StealRange + 10
    if Config.StealRange > 100 then
        Config.StealRange = 10
    end
    RangeLabel.Text = "🎯 Steal Range: " .. Config.StealRange
end)

-- Teleport Buttons
local TeleportHome = Instance.new("TextButton")
TeleportHome.Text = "🏠 Teleport Home"
TeleportHome.Size = UDim2.new(1, -20, 0, 40)
TeleportHome.Position = UDim2.new(0, 10, 0, 340)
TeleportHome.BackgroundColor3 = Color3.fromRGB(255, 150, 0)
TeleportHome.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportHome.Font = Enum.Font.Gotham
TeleportHome.TextSize = 14
TeleportHome.Parent = MainFrame

TeleportHome.MouseButton1Click:Connect(function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
    end
end)

local TeleportPlayer = Instance.new("TextButton")
TeleportPlayer.Text = "🎯 TP to Player Base"
TeleportPlayer.Size = UDim2.new(1, -20, 0, 40)
TeleportPlayer.Position = UDim2.new(0, 10, 0, 390)
TeleportPlayer.BackgroundColor3 = Color3.fromRGB(200, 0, 150)
TeleportPlayer.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportPlayer.Font = Enum.Font.Gotham
TeleportPlayer.TextSize = 14
TeleportPlayer.Parent = MainFrame

TeleportPlayer.MouseButton1Click:Connect(function()
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character then
            LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
            break
        end
    end
end)

-- Close Button
local CloseButton = Instance.new("TextButton")
CloseButton.Text = "❌ Close"
CloseButton.Size = UDim2.new(1, -20, 0, 40)
CloseButton.Position = UDim2.new(0, 10, 0, 440)
CloseButton.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.Font = Enum.Font.Gotham
CloseButton.TextSize = 14
CloseButton.Parent = MainFrame

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    _G.BrainrotDominator = false
end)

-- Main Loop
task.spawn(function()
    while task.wait(1) do
        AutoSteal()
        AutoSpawn()
        UpdateESP()
    end
end)

print("🎮 Brainrot Dominator v5.0 Loaded!")
print("✅ With Cool Background Image")
print("🚀 Ready to Dominate!")
