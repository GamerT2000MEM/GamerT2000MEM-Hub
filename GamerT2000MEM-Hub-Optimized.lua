-- GamerT2000MEM Hub (Ultra-Optimized)
local v=game;local s=v:GetService
local Players,ReplicatedStorage,CoreGui,UserInputService,RunService=
s("Players"),s("ReplicatedStorage"),s("CoreGui"),s("UserInputService"),s("RunService")

-- Version check
if _G.GT2kMEM_v then return end;_G.GT2kMEM_v="1.3"

-- Single-instance cleanup
local g=CoreGui:FindFirstChild("GamerT2000MEMHub")
if g then g:Destroy() end

-- Cached functions
local iN,ud2,clr3=Instance.new,UDim2.new,Color3.fromRGB

-- Main UI
local mf=iN("Frame")
mf.Size=ud2(0,350,0,400)
mf.Position=ud2(0.35,0,0.3,0)
mf.BackgroundColor3=clr3(35,35,35)
mf.Active=true

-- Title bar
local tb=iN("Frame",mf)
tb.Size=ud2(1,0,0,30)
tb.BackgroundColor3=clr3(25,25,25)

local t=iN("TextLabel",tb)
t.Size=ud2(0.7,0,1,0)
t.Text="GAMERT2000MEM HUB"
t.TextColor3=clr3(0,255,255)
t.Font=Enum.Font.GothamBold

-- Block data (optimized array)
local b={
    {"Normal",clr3(200,200,200)},
    {"Super",clr3(0,200,0)},
    {"Diamond",clr3(0,200,200)},
    {"Rainbow",clr3(255,0,255)},
    {"Galaxy",clr3(0,0,100)}
}

-- Container
local c=iN("ScrollingFrame",mf)
c.Size=ud2(1,0,1,-30)
c.Position=ud2(0,0,0,30)
c.CanvasSize=ud2(0,0,0,#b*70)

-- Spawn function (optimized remote check)
local function sb(n)
    local r=ReplicatedStorage:FindFirstChild("Spawn"..n.."Block")
    if r then r:FireServer() end
end

-- Create buttons in one loop
for j=1,#b do
    local btn=iN("TextButton",c)
    btn.Size=ud2(0.9,0,0,60)
    btn.Position=ud2(0.05,0,0,(j-1)*70)
    btn.BackgroundColor3=b[j][2]
    btn.Text=b[j][1]:upper()
    btn.MouseButton1Click:Connect(function() sb(b[j][1]) end)
end

-- Drag system (optimized)
local d,pS,pP
tb.InputBegan:Connect(function(i)
    if i.UserInputType==Enum.UserInputType.MouseButton1 then
        d=true;pS=i.Position;pP=mf.Position
    end
end)

UserInputService.InputChanged:Connect(function(i)
    if d and i.UserInputType==Enum.UserInputType.MouseMovement then
        mf.Position=pP+ud2(0,(i.Position-pS).X,0,(i.Position-pS).Y)
    end
end)

-- Finalize
mf.Parent=iN("ScreenGui",CoreGui)
print("GT2kMEM Hub loaded in",os.clock(),"sec")
