-- Brainrot Farmer v3.0 - Complete with GUI
if _G.BrainrotFarmerLoaded then
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Brainrot Farmer",
        Text = "Script already loaded!",
        Duration = 3
    })
    return
end
_G.BrainrotFarmerLoaded = true

-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local LocalPlayer = Players.LocalPlayer

-- Configuration
local Config = {
    AutoSteal = true,
    AutoSpawn = true,
    AutoCollect = true,
    CheckDistance = 50,
    Speed = 50,
    JumpPower = 50,
    NoClip = false
}

-- Create GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BrainrotFarmerGUI"
ScreenGui.Parent = game.CoreGui
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.3, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 400, 0, 350)
MainFrame.Active = true
MainFrame.Draggable = true

local Title = Instance.new("TextLabel")
Title.Name = "Title"
Title.Parent = MainFrame
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.BorderSizePixel = 0
Title.Size = UDim2.new(1, 0, 0, 30)
Title.Font = Enum.Font.GothamBold
Title.Text = "🧠 Brainrot Farmer v3.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextSize = 14

local CloseButton = Instance.new("TextButton")
CloseButton.Name = "CloseButton"
CloseButton.Parent = Title
CloseButton.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseButton.BorderSizePixel = 0
CloseButton.Position = UDim2.new(0.95, -25, 0, 5)
CloseButton.Size = UDim2.new(0, 20, 0, 20)
CloseButton.Font = Enum.Font.GothamBold
CloseButton.Text = "X"
CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseButton.TextSize = 12

CloseButton.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    _G.BrainrotFarmerLoaded = false
end)

local TabsFolder = Instance.new("Folder")
TabsFolder.Name = "TabsFolder"
TabsFolder.Parent = MainFrame

local ButtonsFrame = Instance.new("Frame")
ButtonsFrame.Name = "ButtonsFrame"
ButtonsFrame.Parent = MainFrame
ButtonsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
ButtonsFrame.BorderSizePixel = 0
ButtonsFrame.Position = UDim2.new(0, 0, 0, 30)
ButtonsFrame.Size = UDim2.new(0, 100, 0, 320)

-- Create Tab Function
local function CreateTab(tabName, tabText)
    local TabButton = Instance.new("TextButton")
    local TabFrame = Instance.new("Frame")
    
    TabButton.Name = tabName .. "Button"
    TabButton.Parent = ButtonsFrame
    TabButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    TabButton.BorderSizePixel = 0
    TabButton.Size = UDim2.new(1, 0, 0, 40)
    TabButton.Font = Enum.Font.Gotham
    TabButton.Text = tabText
    TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabButton.TextSize = 12
    
    TabFrame.Name = tabName .. "Frame"
    TabFrame.Parent = TabsFolder
    TabFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    TabFrame.BorderSizePixel = 0
    TabFrame.Position = UDim2.new(0, 100, 0, 30)
    TabFrame.Size = UDim2.new(0, 300, 0, 320)
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
                btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
            end
        end
        TabButton.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
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
    ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    ToggleFrame.BorderSizePixel = 0
    ToggleFrame.Size = UDim2.new(1, -20, 0, 30)
    ToggleFrame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 35)
    
    ToggleButton.Name = "ToggleButton"
    ToggleButton.Parent = ToggleFrame
    ToggleButton.BackgroundColor3 = default and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 0, 0)
    ToggleButton.BorderSizePixel = 0
    ToggleButton.Position = UDim2.new(0, 5, 0, 5)
    ToggleButton.Size = UDim2.new(0, 20, 0, 20)
    ToggleButton.Font = Enum.Font.GothamBold
    ToggleButton.Text = ""
    ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ToggleButton.TextSize = 12
    
    ToggleStatus.Name = "ToggleStatus"
    ToggleStatus.Parent = ToggleFrame
    ToggleStatus.BackgroundTransparency = 1
    ToggleStatus.Position = UDim2.new(0, 35, 0, 0)
    ToggleStatus.Size = UDim2.new(1, -40, 1, 0)
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
    SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
    SliderFrame.BorderSizePixel = 0
    SliderFrame.Size = UDim2.new(1, -20, 0, 50)
    SliderFrame.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 55)
    
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
    SliderTrack.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    SliderTrack.BorderSizePixel = 0
    SliderTrack.Position = UDim2.new(0, 5, 0, 30)
    SliderTrack.Size = UDim2.new(1, -10, 0, 10)
    
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
    Button.BackgroundColor3 = Color3.fromRGB(0, 100, 255)
    Button.BorderSizePixel = 0
    Button.Size = UDim2.new(1, -20, 0, 30)
    Button.Position = UDim2.new(0, 10, 0, #parent:GetChildren() * 35)
    Button.Font = Enum.Font.Gotham
    Button.Text = name
    Button.TextColor3 = Color3.fromRGB(255, 255, 255)
    Button.TextSize = 12
    
    Button.MouseButton1Click:Connect(callback)
end

-- Create Tabs
local MainTab = CreateTab("Main", "🧠 Main")
local PlayerTab = CreateTab("Player", "👤 Player")
local TeleportTab = CreateTab("Teleport", "📍 Teleport")

-- Main Tab Toggles
CreateToggle(MainTab, "Auto Steal Brainrot", Config.AutoSteal, function(state)
    Config.AutoSteal = state
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Brainrot Farmer",
        Text = "Auto Steal: " .. (state and "ON" or "OFF"),
        Duration = 2
    })
end)

CreateToggle(MainTab, "Auto Spawn Brainrot", Config.AutoSpawn, function(state)
    Config.AutoSpawn = state
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Brainrot Farmer",
        Text = "Auto Spawn: " .. (state and "ON" or "OFF"),
        Duration = 2
    })
end)

CreateToggle(MainTab, "Auto Collect", Config.AutoCollect, function(state)
    Config.AutoCollect = state
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Brainrot Farmer",
        Text = "Auto Collect: " .. (state and "ON" or "OFF"),
        Duration = 2
    })
end)

CreateSlider(MainTab, "Search Distance", 10, 100, Config.CheckDistance, function(value)
    Config.CheckDistance = value
end)

-- Player Tab
CreateToggle(PlayerTab, "NoClip", Config.NoClip, function(state)
    Config.NoClip = state
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Brainrot Farmer",
        Text = "NoClip: " .. (state and "ON" or "OFF"),
        Duration = 2
    })
end)

CreateSlider(PlayerTab, "Walk Speed", 16, 100, Config.Speed, function(value)
    Config.Speed = value
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.WalkSpeed = value
    end
end)

CreateSlider(PlayerTab, "Jump Power", 50, 100, Config.JumpPower, function(value)
    Config.JumpPower = value
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid") then
        LocalPlayer.Character.Humanoid.JumpPower = value
    end
end)

-- Teleport Tab
CreateButton(TeleportTab, "TP to Brainrot", function()
    local brainrots = FindBrainrots()
    if #brainrots > 0 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = brainrots[1].CFrame + Vector3.new(0, 3, 0)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Brainrot Farmer",
            Text = "Teleported to Brainrot!",
            Duration = 2
        })
    end
end)

CreateButton(TeleportTab, "TP to Spawner", function()
    local spawners = FindSpawners()
    if #spawners > 0 and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = spawners[1].CFrame + Vector3.new(0, 3, 0)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Brainrot Farmer",
            Text = "Teleported to Spawner!",
            Duration = 2
        })
    end
end)

CreateButton(TeleportTab, "TP to Start", function()
    if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
        LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(0, 10, 0)
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Brainrot Farmer",
            Text = "Teleported to Start!",
            Duration = 2
        })
    end
end)

-- Show first tab by default
ButtonsFrame:FindFirstChild("MainButton"):MouseButton1Click()

-- Game Functions
function FindBrainrots()
    local brainrots = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if string.lower(obj.Name):find("brainrot") then
            if obj:IsA("Part") or obj:IsA("MeshPart") then
                table.insert(brainrots, obj)
            end
        end
    end
    return brainrots
end

function FindSpawners()
    local spawners = {}
    local spawnerNames = {"spawn", "button", "create", "generate"}
    for _, obj in pairs(workspace:GetDescendants()) do
        local lowerName = string.lower(obj.Name)
        for _, spawnName in pairs(spawnerNames) do
            if lowerName:find(spawnName) then
                if obj:IsA("Part") or obj:IsA("ClickDetector") then
                    table.insert(spawners, obj)
                end
            end
        end
    end
    return spawners
end

function FindCollectibles()
    local collectibles = {}
    local collectibleNames = {"coin", "money", "reward", "collect"}
    for _, obj in pairs(workspace:GetDescendants()) do
        local lowerName = string.lower(obj.Name)
        for _, collectName in pairs(collectibleNames) do
            if lowerName:find(collectName) then
                if obj:IsA("Part") then
                    table.insert(collectibles, obj)
                end
            end
        end
    end
    return collectibles
end

-- Auto Functions
function AutoSteal()
    if not Config.AutoSteal then return end
    
    local brainrots = FindBrainrots()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = character.HumanoidRootPart
    
    for _, brainrot in pairs(brainrots) do
        local distance = (brainrot.Position - hrp.Position).Magnitude
        
        if distance < Config.CheckDistance then
            hrp.CFrame = CFrame.new(brainrot.Position + Vector3.new(0, 3, 0))
            
            if brainrot:IsA("Part") then
                firetouchinterest(hrp, brainrot, 0)
                task.wait(0.1)
                firetouchinterest(hrp, brainrot, 1)
            end
            
            break
        end
    end
end

function AutoSpawn()
    if not Config.AutoSpawn then return end
    
    local spawners = FindSpawners()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = character.HumanoidRootPart
    
    for _, spawner in pairs(spawners) do
        local distance = (spawner.Position - hrp.Position).Magnitude
        
        if distance < Config.CheckDistance then
            if spawner:IsA("Part") then
                firetouchinterest(hrp, spawner, 0)
                task.wait(0.1)
                firetouchinterest(hrp, spawner, 1)
            elseif spawner:IsA("ClickDetector") then
                fireclickdetector(spawner)
            end
            
            break
        end
    end
end

function AutoCollect()
    if not Config.AutoCollect then return end
    
    local collectibles = FindCollectibles()
    local character = LocalPlayer.Character
    if not character or not character:FindFirstChild("HumanoidRootPart") then return end
    
    local hrp = character.HumanoidRootPart
    
    for _, collectible in pairs(collectibles) do
        local distance = (collectible.Position - hrp.Position).Magnitude
        
        if distance < Config.CheckDistance then
            hrp.CFrame = CFrame.new(collectible.Position + Vector3.new(0, 2, 0))
            
            firetouchinterest(hrp, collectible, 0)
            task.wait(0.1)
            firetouchinterest(hrp, collectible, 1)
            
            break
        end
    end
end

-- NoClip Function
task.spawn(function()
    while task.wait(0.1) do
        if Config.NoClip and LocalPlayer.Character then
            for _, part in pairs(LocalPlayer.Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
        end
    end
end)

-- Main Loop
task.spawn(function()
    while task.wait(1) do
        if Config.AutoSteal then
            AutoSteal()
        end
        
        if Config.AutoSpawn then
            AutoSpawn()
        end
        
        if Config.AutoCollect then
            AutoCollect()
        end
    end
end)

-- Notify user
game:GetService("StarterGui"):SetCore("SendNotification", {
    Title = "Brainrot Farmer v3.0",
    Text = "Successfully loaded! Open GUI to configure.",
    Duration = 5
})

print("🎮 Brainrot Farmer v3.0 loaded!")
print("✅ GUI: ENABLED")
print("✅ Auto Steal: ON")
print("✅ Auto Spawn: ON") 
print("✅ Auto Collect: ON")
