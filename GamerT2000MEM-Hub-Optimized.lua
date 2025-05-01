-- В начало файла GamerT2000MEM-Hub-Optimized.lua
local CURRENT_VERSION = "1.2"
if _G.GamerT2000MEM_Version and _G.GamerT2000MEM_Version >= CURRENT_VERSION then
    return -- Не грузить повторно
end
_G.GamerT2000MEM_Version = CURRENT_VERSION
-- GamerT2000MEM Hub (Optimized and Fixed Edition)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- Удаляем старые GUI
local existingGui = CoreGui:FindFirstChild("GamerT2000MEMHub")
if existingGui then existingGui:Destroy() end

-- Создаем GUI
local GamerT2000MEMHub = Instance.new("ScreenGui", CoreGui)
GamerT2000MEMHub.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", GamerT2000MEMHub)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
MainFrame.BorderSizePixel = 0
MainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
MainFrame.Size = UDim2.new(0, 350, 0, 400)
MainFrame.Active = true

-- Заголовок
local TitleBar = Instance.new("Frame", MainFrame)
TitleBar.Size = UDim2.new(1, 0, 0, 30)
TitleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)

local Title = Instance.new("TextLabel", TitleBar)
Title.Text = "GAMERT2000MEM HUB"
Title.Size = UDim2.new(0.7, 0, 1, 0)
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.fromRGB(0, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16

local MinimizeBtn = Instance.new("TextButton", TitleBar)
MinimizeBtn.Size = UDim2.new(0, 30, 0, 30)
MinimizeBtn.Position = UDim2.new(0.925, 0, 0, 0)
MinimizeBtn.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
MinimizeBtn.TextColor3 = Color3.new(1, 1, 1)
MinimizeBtn.Font = Enum.Font.GothamBold
MinimizeBtn.Text = "_"

-- Lucky Blocks
local blocks = {
    {Name = "Normal", Color = Color3.fromRGB(200, 200, 200)},
    {Name = "Super", Color = Color3.fromRGB(0, 200, 0)},
    {Name = "Diamond", Color = Color3.fromRGB(0, 200, 200)},
    {Name = "Rainbow", Color = Color3.fromRGB(255, 0, 255)},
    {Name = "Galaxy", Color = Color3.fromRGB(0, 0, 100)}
}

local Container = Instance.new("ScrollingFrame", MainFrame)
Container.Size = UDim2.new(1, 0, 1, -30)
Container.Position = UDim2.new(0, 0, 0, 30)
Container.BackgroundTransparency = 1
Container.ScrollBarThickness = 5
Container.CanvasSize = UDim2.new(0, 0, 0, #blocks * 70)

-- Функция для спавна блоков
local function spawnBlock(blockName)
    local remote = ReplicatedStorage:FindFirstChild("Spawn"..blockName.."Block")
    if remote then
        remote:FireServer()
        print(blockName.." block spawned!")
    else
        warn("RemoteEvent not found:", "Spawn"..blockName.."Block")
    end
end

-- Создаем кнопки
for i, block in ipairs(blocks) do
    local btn = Instance.new("TextButton", Container)
    btn.Size = UDim2.new(0.9, 0, 0, 60)
    btn.Position = UDim2.new(0.05, 0, 0, (i-1)*70)
    btn.BackgroundColor3 = block.Color
    btn.TextColor3 = Color3.new(0, 0, 0)
    btn.Font = Enum.Font.GothamBold
    btn.TextSize = 18
    btn.Text = block.Name:upper()
    btn.MouseButton1Click:Connect(function() spawnBlock(block.Name) end)
end

-- Сворачивание/разворачивание
local minimized = false
MinimizeBtn.MouseButton1Click:Connect(function()
    minimized = not minimized
    MainFrame.Size = UDim2.new(0, 350, 0, minimized and 30 or 400)
    Container.Visible = not minimized
    MinimizeBtn.Text = minimized and "+" or "_"
end)

-- Перетаскивание
local dragging, dragStart, startPos = false, nil, nil

TitleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
    end
end)

TitleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        MainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("GamerT2000MEM Hub loaded! All buttons should work!")
