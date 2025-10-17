-- Brainrot Dominator v4.0
-- Created by: узник концлагеря, hhhh, deepseek

if _G.BrainrotDominator then return end
_G.BrainrotDominator = true

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local Config = {
    AutoSteal = true,
    TeleportHome = false,
    TeleportToPlayer = false,
    ESPPlayers = false,
    ESPBrainrots = false,
    ESPSecret = false,
    StealRange = 50,
    TeleportDelay = 2
}

-- ESP Storage
local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "BrainrotESP"
ESPFolder.Parent = workspace

-- Create GUI with background
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotDominatorGUI"
ScreenGui.Parent = game.CoreGui

local Background = Instance.new("Frame")
Background.Name = "Background"
Background.Parent = ScreenGui
Background.Size = UDim2.new(1, 0, 1, 0)
Background.BackgroundColor3 = Color3.fromRGB(10, 10, 30)
Background.BackgroundTransparency = 0.1
Background.ZIndex = 0

local CreditLabel = Instance.new("TextLabel")
CreditLabel.Name = "CreditLabel"
CreditLabel.Parent = Background
CreditLabel.Size = UDim2.new(1, 0, 0, 50)
CreditLabel.Position = UDim2.new(0, 0, 0.9, 0)
CreditLabel.BackgroundTransparency = 1
CreditLabel.Text = "Created by: узник концлагеря, hhhh, deepseek"
CreditLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
CreditLabel.TextSize = 14
CreditLabel.Font = Enum.Font.GothamBold
CreditLabel.ZIndex = 1

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.2, 0)
MainFrame.Size = UDim2.new(0, 450, 0, 500)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Font = Enum.Font.GothamBold
Title.Text = "🧠 BRAINROT DOMINATOR v4.0 🧠"
Title.TextColor3 = Color3.fromRGB(255, 255, 0)
Title.TextSize = 16

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = Title
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.95, -25, 0.5, -10)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    _G.BrainrotDominator = false
end)

local TabsFolder = Instance.new("Folder")
TabsFolder.Name = "TabsFolder"
TabsFolder.Parent = MainFrame

local ButtonsFrame = Instance.new("Frame")
ButtonsFrame.Name = "ButtonsFrame"
ButtonsFrame.Parent = MainFrame
ButtonsFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 50)
ButtonsFrame.BorderSizePixel = 0
ButtonsFrame.Position = UDim2.new(0, 0, 0, 40)
ButtonsFrame.Size = UDim2.new(0, 120, 0, 460)

-- Create Tab Function
local function CreateTab(tabName, tabText)
    local TabButton = Instance.new("TextButton")
    local TabFrame = Instance.new("Frame")
    
    TabButton.Name = tabName .. "Button"
    TabButton.Parent = ButtonsFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, 0, 0, 50)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = tabText
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 12
    
    TabFrame.Name = tabName .. "Frame"
    TabFrame.Parent = TabsFolder
    TabFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    TabFrame.BorderSizePixel = 0
    TabFrame.Position = UDim2.new(0, 120, 0, 40)
    TabFrame.Size = UDim2.new(0, 330, 0, 460)
    TabFrame.Visible = false
    
    TabButton.MouseButton1Click:Connect(function()
        for _, child in pairs(TabsFolder:GetChildren()) do
            if child:IsA("Frame") then
                child.Visible = false
            end
        end
        
        TabFrame.Visible = true
        
        for _, btn in pairs(ButtonsFrame:GetChildren()) do
            if btn:IsA("TextButton") then
                btn.BackgroundColor3 = Color3.fromRGB(40, 40, 80)
            end
        end
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 120)
    end)
    
    return TabFrame
end

-- Create Toggle Function
local function CreateToggle(parent, name, default, callback)
    local ToggleFrame = Instance.new("Frame")
    local ToggleButton = Instance.new("TextButton")
    local ToggleStatus = Instance.new("TextLabel")
    
    ToggleFrame.Name = name .. "Toggle"
    ToggleFrame.Parent = parent
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 70)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(1, -20, 0, 35)
    ToggleFrame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 40)
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(0, 5, 0, 5)
    ToggleButton.Size = UDim2.new(0, 25, 0, 25)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = ""
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 12
    
    ToggleStatus.Name = "ToggleStatus"
    ToggleStatus.Parent = ToggleFrame
    ToggleStatus.BackgroundTransparency = 1
    ToggleStatus.Position = UDim2.new(0, 40, 0, 0)
    ToggleStatus.Size = UDim2.new(1, -45, 1, 0)
    ToggleStatus.Font = Enum.Font.Gotham
    ToggleStatus.Text = name .. ": " .. (default and "ON" or "OFF")
    ToggleStatus.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleStatus.TextSize = 12
    ToggleStatus.TextXAlignment = Enum.TextXAlignment.Left
    
    ToggleButton.MouseButton1Click:Connect(function()
        local newState = not default
        default = newState
        ToggleButton.BackgroundColor3 = newState and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
        ToggleStatus.Text = name .. ": " .. (newState and "ON" or "OFF")
        callback(newState)
    end)
end

-- Create Slider Function
local function CreateSlider(parent, name, min, max, default, callback)
    local SliderFrame = Instance.new("Frame")
    local SliderLabel = Instance.new("TextLabel")
    local SliderValue = Instance.new("TextLabel")
    local SliderTrack = Instance.new("Frame")
    local SliderButton = Instance.new("TextButton")
    
    SliderFrame.Name = name .. "Slider"
    SliderFrame.Parent = parent
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 70)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Size = UDim2.new(1, -20, 0, 60)
    SliderFrame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 65)
    
    SliderLabel.Name = "SliderLabel"
    SliderLabel.Parent = SliderFrame
    SliderLabel.BackgroundTransparency = 1
    SliderLabel.Position = UDim2.new(0, 5, 0, 5)
    SliderLabel.Size = UDim2.new(0.6, -5, 0, 20)
    SliderLabel.Font = Enum.Font.Gotham
    SliderLabel.Text = name
    SliderLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderLabel.TextSize = 12
    SliderLabel.TextXAlignment = Enum.TextXAlignment.Left
    
    SliderValue.Name = "SliderValue"
    SliderValue.Parent = SliderFrame
    SliderValue.BackgroundTransparency = 1
    SliderValue.Position = UDim2.new(0.6, 5, 0, 5)
    SliderValue.Size = UDim2.new(0.4, -10, 0, 20)
    SliderValue.Font = Enum.Font.Gotham
    SliderValue.Text = tostring(default)
    SliderValue.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderValue.TextSize = 12
    SliderValue.TextXAlignment = Enum.TextXAlignment.Right
    
    SliderTrack.Name = "SliderTrack"
    SliderTrack.Parent = SliderFrame
    SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 100)
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Position = UDim2.new(0, 5, 0, 35)
    SliderTrack.Size = UDim2.new(1, -10, 0, 15)
    
    local fillSize = ((default - min) / (max - min)) * (SliderTrack.AbsoluteSize.X)
    SliderButton.Name = "SliderButton"
    SliderButton.Parent = SliderTrack
    SliderButton.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    SliderButton.BorderSizePixel = 0
    SliderButton.Size = UDim2.new(0, fillSize, 1, 0)
    SliderButton.Font = Enum.Font.Gotham
    SliderButton.Text = ""
    SliderButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    SliderButton.TextSize = 12
    
    local dragging = false
    
    local function updateSlider(input)
        local relativeX = input.Position.X - SliderTrack.AbsolutePosition.X
        local percentage = math.clamp(relativeX / SliderTrack.AbsoluteSize.X, 0, 1)
        local value = math.floor(min + (max - min) * percentage)
        
        SliderButton.Size = UDim2.new(percentage, 0, 1, 0)
        SliderValue.Text = tostring(value)
        callback(value)
    end
    
    SliderButton.MouseButton1Down:Connect(function()
        dragging = true
    end)
    
    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)
end

-- Create Button Function
local function CreateButton(parent, name, callback)
    local Button = Instance.new("TextButton")
    
    Button.Name = name .. "Button"
    Button.Parent = parent
    Button.BackgroundColor3 = Color3.fromRGB(0, 100, 200)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, -20, 0, 35)
    Button.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 40)
    Button.Font = Enum.Font.Gotham
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 12
    
    Button.MouseButton1Click:Connect(callback)
end

-- Create Tabs
local MainTab = CreateTab("Main", "🎯 Main")
local TeleportTab = CreateTab("Teleport", "📍 Teleport")
local ESPTab = CreateTab("ESP", "👁️ ESP")
local PlayerTab = CreateTab("Players", "👥 Players")

-- Main Tab
CreateToggle(MainTab, "Auto Steal Brainrot", Config.AutoSteal, function(state)
    Config.AutoSteal = state
end)

CreateSlider(MainTab, "Steal Range", 10, 100, Config.StealRange, function(value)
    Config.StealRange = value
end)

CreateSlider(MainTab, "Teleport Delay", 1, 5, Config.TeleportDelay, function(value)
    Config.TeleportDelay = value
end)

-- Teleport Tab
CreateButton(TeleportTab, "Teleport Home", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        -- Find home base (adjust coordinates as needed)
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 50, 0)
    end
end)

CreateButton(TeleportTab, "Teleport to Random Player Base", function()
    TeleportToRandomBase()
end)

CreateToggle(TeleportTab, "Auto Teleport Home", Config.TeleportHome, function(state)
    Config.TeleportHome = state
end)

CreateToggle(TeleportTab, "Auto Teleport to Players", Config.TeleportToPlayer, function(state)
    Config.TeleportToPlayer = state
end)

-- ESP Tab
CreateToggle(ESPTab, "ESP Players", Config.ESPPlayers, function(state)
    Config.ESPPlayers = state
    UpdateESP()
end)

CreateToggle(ESPTab, "ESP Brainrots", Config.ESPBrainrots, function(state)
    Config.ESPBrainrots = state
    UpdateESP()
end)

CreateToggle(ESPTab, "ESP Secret Brainrots", Config.ESPSecret, function(state)
    Config.ESPSecret = state
    UpdateESP()
end)

-- Player List Tab
local PlayerScroll = Instance.new("ScrollingFrame")
PlayerScroll.Name = "PlayerScroll"
PlayerScroll.Parent = PlayerTab
PlayerScroll.Size = UDim2.new(1, -20, 1, -10)
PlayerScroll.Position = UDim2.new(0, 10, 0, 10)
PlayerScroll.BackgroundColor3 = Color3.fromRGB(30, 30, 60)
PlayerScroll.BorderSizePixel = 0
PlayerScroll.ScrollBarThickness = 8

-- ESP Functions
function CreateESP(object, color, name)
    local Highlight = Instance.new("Highlight")
    Highlight.Name = "ESP_" .. name
    Highlight.Parent = ESPFolder
    Highlight.Adornee = object
    Highlight.FillColor = color
    Highlight.OutlineColor = color
    Highlight.FillTransparency = 0.5
    Highlight.OutlineTransparency = 0
    return Highlight
end

function UpdateESP()
    -- Clear existing ESP
    for _, esp in pairs(ESPFolder:GetChildren()) do
        esp:Destroy()
    end
    
    -- ESP for Players
    if Config.ESPPlayers then
        for _, player in pairs(Players:GetPlayers()) do
            if player ~= LocalPlayer and player.Character then
                CreateESP(player.Character, Color3.fromRGB(255, 0, 0), "Player_" .. player.Name)
            end
        end
    end
    
    -- ESP for Brainrots
    if Config.ESPBrainrots then
        for _, obj in pairs(workspace:GetDescendants()) do
            if string.lower(obj.Name):find("brainrot") then
                CreateESP(obj, Color3.fromRGB(0, 255, 0), "Brainrot_" .. obj.Name)
            end
        end
    end
    
    -- ESP for Secret Brainrots
    if Config.ESPSecret then
        for _, obj in pairs(workspace:GetDescendants()) do
            if string.lower(obj.Name):find("secret") or string.lower(obj.Name):find("mythic") then
                CreateESP(obj, Color3.fromRGB(255, 255, 0), "Secret_" .. obj.Name)
            end
        end
    end
end

-- Player Base Detection
function GetPlayerBases()
    local bases = {}
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            -- Look for player bases (adjust detection logic as needed)
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:FindFirstChild("Owner") and obj.Owner.Value == player then
                    table.insert(bases, {Player = player, Base = obj})
                end
            end
        end
    end
    return bases
end

function TeleportToRandomBase()
    local bases = GetPlayerBases()
    if #bases > 0 then
        local randomBase = bases[math.random(1, #bases)]
        if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            LocalPlayer.Character.HumanoidRootPart.CFrame = randomBase.Base.CFrame + Vector3.new(0, 5, 0)
        end
    end
end

-- Auto Steal Function
function AutoStealBrainrots()
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

-- Update Player List
function UpdatePlayerList()
    for _, child in pairs(PlayerScroll:GetChildren()) do
        if child:IsA("TextButton") then
            child:Destroy()
        end
    end
    
    local yPos = 0
    for _, player in pairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            local PlayerButton = Instance.new("TextButton")
            PlayerButton.Size = UDim2.new(1, -10, 0, 30)
            PlayerButton.Position = UDim2.new(0, 5, 0, yPos)
            PlayerButton.BackgroundColor3 = Color3.fromRGB(50, 50, 100)
            PlayerButton.Text = player.Name
            PlayerButton.TextColor3 = Color3.fromRGB(255, 255, 255)
            PlayerButton.Parent = PlayerScroll
            PlayerButton.MouseButton1Click:Connect(function()
                if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                    LocalPlayer.Character.HumanoidRootPart.CFrame = player.Character.HumanoidRootPart.CFrame
                end
            end)
            yPos = yPos + 35
        end
    end
    PlayerScroll.CanvasSize = UDim2.new(0, 0, 0, yPos)
end

-- Show first tab
ButtonsFrame:FindFirstChild("MainButton"):MouseButton1Click()

-- Main loops
task.spawn(function()
    while task.wait(1) do
        AutoStealBrainrots()
        UpdateESP()
        UpdatePlayerList()
    end
end)

-- Auto teleport loops
task.spawn(function()
    while task.wait(Config.TeleportDelay) do
        if Config.TeleportHome then
            -- Auto teleport home logic
        end
        if Config.TeleportToPlayer then
            TeleportToRandomBase()
        end
    end
end)

print("🎮 BRAINROT DOMINATOR v4.0 LOADED!")
print("✅ Created by: узник концлагеря, hhhh, deepseek")
print("🚀 Ready for domination!")
