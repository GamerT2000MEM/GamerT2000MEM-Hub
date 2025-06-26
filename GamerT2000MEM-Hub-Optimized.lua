-- GamerT2000MEM Hub (Optimized)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")


if _G.GamerT2000MEM_Loaded then return end
_G.GamerT2000MEM_Loaded = true


local oldUI = CoreGui:FindFirstChild("GamerT2000MEMHub")
if oldUI then oldUI:Destroy() end


local screenGui = Instance.new("ScreenGui")
screenGui.Name = "GamerT2000MEMHub"
screenGui.Parent = CoreGui
screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local mainFrame = Instance.new("Frame")
mainFrame.Name = "MainFrame"
mainFrame.Size = UDim2.new(0, 350, 0, 400)
mainFrame.Position = UDim2.new(0.35, 0, 0.3, 0)
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 0
mainFrame.Active = true
mainFrame.Parent = screenGui


local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 30)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
titleBar.Parent = mainFrame

local title = Instance.new("TextLabel")
title.Text = "GAMERT2000MEM HUB"
title.Size = UDim2.new(0.7, 0, 1, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(0, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 16
title.Parent = titleBar


local blocks = {
    {Name = "Normal", Color = Color3.fromRGB(200, 200, 200)},
    {Name = "Super", Color = Color3.fromRGB(0, 200, 0)},
    {Name = "Diamond", Color = Color3.fromRGB(0, 200, 200)},
    {Name = "Rainbow", Color = Color3.fromRGB(255, 0, 255)},
    {Name = "Galaxy", Color = Color3.fromRGB(0, 0, 100)}
}


local container = Instance.new("ScrollingFrame")
container.Name = "Container"
container.Size = UDim2.new(1, 0, 1, -30)
container.Position = UDim2.new(0, 0, 0, 30)
container.BackgroundTransparency = 1
container.ScrollBarThickness = 5
container.CanvasSize = UDim2.new(0, 0, 0, #blocks * 70)
container.Parent = mainFrame


local function spawnBlock(blockName)
    local remote = ReplicatedStorage:FindFirstChild("Spawn"..blockName.."Block")
    if remote then
        remote:FireServer()
        print(blockName.." block spawned!")
    else
        warn("RemoteEvent not found for", blockName)
    end
end


for i, block in ipairs(blocks) do
    local button = Instance.new("TextButton")
    button.Name = block.Name.."Btn"
    button.Text = block.Name:upper()
    button.Size = UDim2.new(0.9, 0, 0, 60)
    button.Position = UDim2.new(0.05, 0, 0, (i-1)*70)
    button.BackgroundColor3 = block.Color
    button.TextColor3 = Color3.new(0, 0, 0)
    button.Font = Enum.Font.GothamBold
    button.TextSize = 18
    button.Parent = container
    
    button.MouseButton1Click:Connect(function()
        spawnBlock(block.Name)
    end)
end


local dragging, dragStart, startPos = false

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
    end
end)

titleBar.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        mainFrame.Position = startPos + UDim2.new(0, delta.X, 0, delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

print("GamerT2000MEM Hub successfully loaded!")
