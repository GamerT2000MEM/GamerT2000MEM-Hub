local CURRENT_VERSION = "1.0"
local VERSION_CHECK_URL = "https://raw.githubusercontent.com/Zayn31214/GamerT2000MEM-Hub/main/version.txt"


local function checkForUpdates()
    local success, response = pcall(function()
        return game:HttpGet(VERSION_CHECK_URL)
    end)
    
    if success and response ~= CURRENT_VERSION then
        warn("Доступно обновление! Текущая версия: "..CURRENT_VERSION..", Новая: "..response)
    end
end

checkForUpdates()
 
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local SoundService = game:GetService("SoundService")


if CoreGui:FindFirstChild("GamerT2000MEM_RoyalHub") then
    CoreGui.GamerT2000MEM_RoyalHub:Destroy()
end


local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://131233154" -- Одинаковый звук для всех кнопок
clickSound.Volume = 0.5
clickSound.Parent = SoundService

local hoverSound = Instance.new("Sound")
hoverSound.SoundId = "rbxassetid://876996543" -- Звук наведения
hoverSound.Volume = 0.3
hoverSound.Parent = SoundService

local openSound = Instance.new("Sound")
openSound.SoundId = "rbxassetid://138080862" -- Звук открытия
openSound.Volume = 0.7
openSound.Parent = SoundService


local RoyalHub = Instance.new("ScreenGui")
RoyalHub.Name = "GamerT2000MEM_RoyalHub"
RoyalHub.ZIndexBehavior = Enum.ZIndexBehavior.Global
RoyalHub.Parent = CoreGui


local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 60) -- Начальный размер (свернутый)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -30)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 30)
MainFrame.BackgroundTransparency = 0.1
MainFrame.Parent = RoyalHub


local UIStroke = Instance.new("UIStroke")
UIStroke.Color = Color3.fromRGB(255, 215, 0)
UIStroke.Thickness = 2
UIStroke.Parent = MainFrame

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = MainFrame


local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 60)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame


local Avatar = Instance.new("ImageLabel")
Avatar.Image = "https://i.ibb.co/3XjTvSK/Gamer-T2000-MEM.jpg"
Avatar.Size = UDim2.new(0, 40, 0, 40)
Avatar.Position = UDim2.new(0, 10, 0, 10)
Avatar.BackgroundTransparency = 1
Avatar.Parent = TitleBar


local AvatarCorner = Instance.new("UICorner")
AvatarCorner.CornerRadius = UDim.new(1, 0)
AvatarCorner.Parent = Avatar


local Title = Instance.new("TextLabel")
Title.Text = "GAMERT2000MEM ROYAL HUB" -- Слитное написание
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextColor3 = Color3.fromRGB(255, 215, 0)
Title.Size = UDim2.new(0, 300, 0, 40)
Title.Position = UDim2.new(0, 60, 0, 10)
Title.BackgroundTransparency = 1
Title.Parent = TitleBar


local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(1, -50, 0, 10)
ToggleButton.BackgroundTransparency = 1
ToggleButton.Text = "▼"
ToggleButton.TextColor3 = Color3.fromRGB(255, 215, 0)
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 24
ToggleButton.Parent = TitleBar


local ScrollFrame = Instance.new("ScrollingFrame")
ScrollFrame.Size = UDim2.new(1, -20, 0, 0)
ScrollFrame.Position = UDim2.new(0, 10, 0, 70)
ScrollFrame.BackgroundTransparency = 1
ScrollFrame.ScrollBarThickness = 5
ScrollFrame.Visible = false
ScrollFrame.Parent = MainFrame


local ContactsFrame = Instance.new("Frame")
ContactsFrame.Size = UDim2.new(1, -20, 0, 60)
ContactsFrame.Position = UDim2.new(0, 10, 0, 540)
ContactsFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
ContactsFrame.BackgroundTransparency = 1 -- Начинаем прозрачным
ContactsFrame.Visible = false
ContactsFrame.Parent = MainFrame

local UICorner2 = Instance.new("UICorner")
UICorner2.CornerRadius = UDim.new(0, 8)
UICorner2.Parent = ContactsFrame

local DiscordLabel = Instance.new("TextLabel")
DiscordLabel.Text = "DISCORD: gamert2000mem"
DiscordLabel.Font = Enum.Font.GothamMedium
DiscordLabel.TextSize = 16
DiscordLabel.TextColor3 = Color3.fromRGB(88, 101, 242)
DiscordLabel.Size = UDim2.new(1, -20, 0, 25)
DiscordLabel.Position = UDim2.new(0, 10, 0, 5)
DiscordLabel.BackgroundTransparency = 1
DiscordLabel.Parent = ContactsFrame

local YouTubeLabel = Instance.new("TextLabel")
YouTubeLabel.Text = "YOUTUBE: youtube.com/@GamerT2000MEM"
YouTubeLabel.Font = Enum.Font.GothamMedium
YouTubeLabel.TextSize = 16
YouTubeLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
YouTubeLabel.Size = UDim2.new(1, -20, 0, 25)
YouTubeLabel.Position = UDim2.new(0, 10, 0, 30)
YouTubeLabel.BackgroundTransparency = 1
YouTubeLabel.Parent = ContactsFrame


local isExpanded = false


local function toggleMenu()
    clickSound:Play()
    isExpanded = not isExpanded
    
    if isExpanded then
        openSound:Play()
        ScrollFrame.Visible = true
        ContactsFrame.Visible = true
        
        
        local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 500, 0, 620)
        })
        
        local scrollTween = TweenService:Create(ScrollFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, -20, 0, 460)
        })
        
        
        local contactsTween = TweenService:Create(ContactsFrame, TweenInfo.new(0.4, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 0.2
        })
        
        mainTween:Play()
        scrollTween:Play()
        
        wait(0.2) -- Задержка перед анимацией контактов
        contactsTween:Play()
        
        ToggleButton.Text = "▲"
    else
        -- Анимации закрытия
        local contactsTween = TweenService:Create(ContactsFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad), {
            BackgroundTransparency = 1
        })
        
        local scrollTween = TweenService:Create(ScrollFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quad), {
            Size = UDim2.new(1, -20, 0, 0)
        })
        
        local mainTween = TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Quad), {
            Size = UDim2.new(0, 500, 0, 60)
        })
        
        contactsTween:Play()
        scrollTween:Play()
        mainTween:Play()
        
        wait(0.3)
        ScrollFrame.Visible = false
        ContactsFrame.Visible = false
        ToggleButton.Text = "▼"
    end
end

ToggleButton.MouseButton1Click:Connect(toggleMenu)


local dragging = false
local dragInput, dragStart, startPos

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)


local blocks = {
    {Name = "Normal", Color = Color3.fromRGB(200, 200, 200), Icon = "⭐"},
    {Name = "Super", Color = Color3.fromRGB(0, 200, 0), Icon = "✨"},
    {Name = "Diamond", Color = Color3.fromRGB(0, 200, 200), Icon = "💎"},
    {Name = "Rainbow", Color = Color3.fromRGB(255, 0, 255), Icon = "🌈"},
    {Name = "Galaxy", Color = Color3.fromRGB(0, 0, 100), Icon = "🌌"}
}


for i, block in ipairs(blocks) do
    local Button = Instance.new("TextButton")
    Button.Size = UDim2.new(1, -20, 0, 80)
    Button.Position = UDim2.new(0, 10, 0, (i-1)*90)
    Button.BackgroundColor3 = block.Color
    Button.Text = block.Icon.." "..block.Name:upper()
    Button.Font = Enum.Font.GothamBold
    Button.TextSize = 18
    Button.TextColor3 = Color3.new(0, 0, 0)
    Button.Parent = ScrollFrame
    
    
    Button.MouseEnter:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {Size = UDim2.new(1, -10, 0, 85)}):Play()
        hoverSound:Play()
    end)
    
    Button.MouseLeave:Connect(function()
        TweenService:Create(Button, TweenInfo.new(0.2), {Size = UDim2.new(1, -20, 0, 80)}):Play()
    end)
    
    
    Button.MouseButton1Click:Connect(function()
        clickSound:Play()
        local remote = ReplicatedStorage:FindFirstChild("Spawn"..block.Name.."Block")
        if remote then
            remote:FireServer()
            
            
            TweenService:Create(Button, TweenInfo.new(0.1), {BackgroundTransparency = 0.5}):Play()
            wait(0.1)
            TweenService:Create(Button, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
        end
    end)
end

ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, #blocks * 90)


local particles = Instance.new("ParticleEmitter")
particles.Texture = "rbxassetid://6031075931"
particles.LightEmission = 1
particles.Size = NumberSequence.new(0.5)
particles.Speed = NumberRange.new(5)
particles.Lifetime = NumberRange.new(1)
particles.Rate = 50
particles.Rotation = NumberRange.new(0, 360)
particles.Enabled = false
particles.Parent = MainFrame


ToggleButton.MouseButton1Click:Connect(function()
    if isExpanded then
        particles.Enabled = true
        wait(1.5)
        particles.Enabled = false
    end
end)

print("ROYAL HUB ULTIMATE READY! All fixes applied!")
