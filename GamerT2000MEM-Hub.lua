--[[
  GamerT2000MEM Hub v1.0
  Author: GamerT2000MEM
  GitHub: github.com/GamerT2000MEM/GamerT2000MEM
]]

local function checkUpdates()
    -- Функция для проверки обновлений
end

checkUpdates()
-- GamerT2000MEM Hub (Clean Edition)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- Удаляем старые GUI
if CoreGui:FindFirstChild("GamerT2000MEMHub") then
    CoreGui.GamerT2000MEMHub:Destroy()
end

-- Создаем GUI
local GamerT2000MEMHub = Instance.new("ScreenGui")
GamerT2000MEMHub.Name = "GamerT2000MEMHub"
GamerT2000MEMHub.Parent = CoreGui

local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Parent = GamerT2000MEMHub
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Active = true

-- Заголовок
local TitleBar = Instance.new("Frame")
TitleBar.Name = "TitleBar"
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
TitleBar.Parent = MainFrame

local Title = Instance.new("TextLabel")
Title.Text = "GAMERT2000MEM HUB"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.Parent = TitleBar

local MinimizeBtn = Instance.new("TextButton")
MinimizeBtn.Name = "MinimizeBtn"
MinimizeBtn.Text = "_"
MinimizeBtn.Size = UDim2.new(0, 40, 0, 40)
MinimizeBtn.Position = UDim2.new(0.9, 0, 0, 0)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.TextSize = 24
MinimizeBtn.Parent = TitleBar

-- Все типы блоков
local blocks = {
    {Name = "Normal", Color = Color3.fromRGB(200, 200, 200)},
    {Name = "Super", Color = Color3.fromRGB(0, 200, 0)},
    {Name = "Diamond", Color = Color3.fromRGB(0, 200, 200)},
    {Name = "Rainbow", Color = Color3.fromRGB(255, 0, 255)},
    {Name = "Galaxy", Color = Color3.fromRGB(0, 0, 100), Remotes = {"SpawnGalaxyBlock", "GalaxyBlockEvent"}}
}

-- Контейнер с прокруткой
local Container = Instance.new("ScrollingFrame")
Container.Name = "Container"
Container.Size = UDim2.new(1, 0, 1, -40)
Container.Position = UDim2.new(0, 0, 0, 40)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 8
Container.CanvasSize = UDim2.new(0, 0, 0, #blocks * 80)
Container.Parent = MainFrame

-- Улучшенная функция спавна
local function spawnBlock(blockData)
    local remotes = blockData.Remotes or {"Spawn"..blockData.Name.."Block"}
    
    for _, remoteName in ipairs(remotes) do
        local remote = ReplicatedStorage:FindFirstChild(remoteName)
        if remote then
            remote:FireServer()
            print(blockData.Name.." block spawned via "..remoteName)
            return true
        end
    end
    
    warn("RemoteEvent not found for "..blockData.Name)
    return false
end

-- Создаем кнопки
for i, block in ipairs(blocks) do
    local btn = Instance.new("TextButton")
    btn.Name = block.Name.."Btn"
    btn.Text = block.Name:upper()
    btn.Size = UDim2.new(0.9, 0, 0, 70)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1)*80)
    btn.BackgroundColor3 = block.Color
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Parent = Container
    
    btn.MouseButton1Click:Connect(function()
        spawnBlock(block)
    end)
end

-- Система перетаскивания
local dragging, dragStart, startPos

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

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

-- Сворачивание/разворачивание с анимацией
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad)
    
    if minimized then
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 350, 0, 40)}):Play()
        Container.Visible = false
        MinimizeBtn.Text = "+"
    else
        TweenService:Create(MainFrame, tweenInfo, {Size = UDim2.new(0, 350, 0, 400)}):Play()
        Container.Visible = true
        MinimizeBtn.Text = "_"
    end
end)

-- Автокоррекция позиции
RunService.Heartbeat:Connect(function()
    local viewport = workspace.CurrentCamera.ViewportSize
    local pos = MainFrame.AbsolutePosition
    local size = MainFrame.AbsoluteSize
    
    if pos.X < 0 then
        MainFrame.Position = UDim2.new(0, 5, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset)
    elseif pos.X + size.X > viewport.X then
        MainFrame.Position = UDim2.new(0, viewport.X - size.X - 5, MainFrame.Position.Y.Scale, MainFrame.Position.Y.Offset)
    end
end)

print("GamerT2000MEM Hub loaded successfully!")
