-- Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Lighting = game:GetService("Lighting")
local player = Players.LocalPlayer

-- 🌐 ตัวแปรภาษา
local currentLanguage = "EN"
local buttonTexts = {
    ["Auto Jump"] = {EN="Auto Jump", TH="กระโดดอัตโนมัติ"},
    ["Lag Switch"] = {EN="Lag Switch", TH="สวิตช์แลค"},
    ["FPS"] = {EN="FPS", TH="ลดกราฟิก"},
    ["Teleport Roof"] = {EN="Teleport Roof", TH="วาร์ปขึ้นหลังคา"},
    ["AFK Money"] = {EN="AFK Money", TH="ฟาร์มเงินอัตโนมัติ"},
    ["Teleport Downed 1s"] = {EN="Teleport Downed 1s", TH="วาร์ปหาผู้เล่นที่ล้ม 1s"},
    ["Teleport Stationary"] = {EN="Teleport Stationary", TH="วาร์ปหาผู้เล่นนิ่ง"},
    ["Moon Mode"] = {EN="Moon Mode", TH="โหมดดวงจันทร์"},
    ["Song"] = {EN="Song", TH="เพลง"}
}

-- GUI เลือกภาษา
local langGui = Instance.new("ScreenGui")
langGui.Name = "LanguageSelectGui"
langGui.ResetOnSpawn = false
langGui.Parent = player:WaitForChild("PlayerGui")

local bg = Instance.new("Frame")
bg.Size = UDim2.new(1,0,1,0)
bg.BackgroundColor3 = Color3.fromRGB(0,0,0)
bg.BackgroundTransparency = 0.3
bg.Parent = langGui

local text = Instance.new("TextLabel")
text.Size = UDim2.new(0,400,0,80)
text.Position = UDim2.new(0.5,-200,0.3,0)
text.BackgroundTransparency = 1
text.Text = "Select Your Language"
text.TextColor3 = Color3.fromRGB(255,255,255)
text.Font = Enum.Font.SourceSansBold
text.TextScaled = true
text.Parent = bg

local thaiBtn = Instance.new("TextButton")
thaiBtn.Size = UDim2.new(0,120,0,60)
thaiBtn.Position = UDim2.new(0.5,-130,0.5,0)
thaiBtn.Text = "ไทย"
thaiBtn.BackgroundColor3 = Color3.fromRGB(255,50,50)
thaiBtn.TextColor3 = Color3.new(1,1,1)
thaiBtn.Font = Enum.Font.SourceSansBold
thaiBtn.TextScaled = true
thaiBtn.Parent = bg

local engBtn = Instance.new("TextButton")
engBtn.Size = UDim2.new(0,120,0,60)
engBtn.Position = UDim2.new(0.5,10,0.5,0)
engBtn.Text = "English"
engBtn.BackgroundColor3 = Color3.fromRGB(50,50,255)
engBtn.TextColor3 = Color3.new(1,1,1)
engBtn.Font = Enum.Font.SourceSansBold
engBtn.TextScaled = true
engBtn.Parent = bg

-- GUI หลัก
local gui = Instance.new("ScreenGui")
gui.Name = "UltimateEvadeGui"
gui.ResetOnSpawn = false
gui.Enabled = false
gui.Parent = player:WaitForChild("PlayerGui")

-- ปุ่ม K (ImageButton)
local kBtn = Instance.new("ImageButton")
kBtn.Size = UDim2.new(0,60,0,60)
kBtn.Position = UDim2.new(0,50,0,50)
kBtn.BackgroundColor3 = Color3.fromRGB(0,0,0)
kBtn.Image = "rbxassetid://15565178021"
kBtn.Active = true
kBtn.Draggable = true
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0.5,0)
corner.Parent = kBtn
kBtn.Parent = gui

-- แฟ้ม GUI (ImageLabel)
local frame = Instance.new("ImageLabel")
frame.Size = UDim2.new(0,320,0,600)
frame.Position = UDim2.new(0,150,0,100)
frame.BackgroundColor3 = Color3.fromRGB(25,25,25)
frame.Image = "rbxassetid://15565178021"
frame.BackgroundTransparency = 0
frame.Active = true
frame.Visible = false
frame.Parent = gui

-- ScrollFrame
local scroll = Instance.new("ScrollingFrame")
scroll.Size = UDim2.new(1,-10,1,-10)
scroll.Position = UDim2.new(0,5,0,5)
scroll.BackgroundTransparency = 1
scroll.ScrollBarThickness = 8
scroll.AutomaticCanvasSize = Enum.AutomaticSize.Y
scroll.Parent = frame

local layout = Instance.new("UIListLayout")
layout.SortOrder = Enum.SortOrder.LayoutOrder
layout.Padding = UDim.new(0,10)
layout.Parent = scroll

local padding = Instance.new("UIPadding")
padding.PaddingTop = UDim.new(0,10)
padding.PaddingLeft = UDim.new(0,10)
padding.PaddingRight = UDim.new(0,10)
padding.PaddingBottom = UDim.new(0,10)
padding.Parent = scroll

-- Title
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0,30)
title.BackgroundColor3 = Color3.fromRGB(40,40,40)
title.TextColor3 = Color3.fromRGB(255,255,255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 20
title.Text = "Swiftz Hub"
title.LayoutOrder = 0
title.Parent = scroll

-- เปิด/ปิดแฟ้ม
kBtn.MouseButton1Click:Connect(function()
    frame.Visible = not frame.Visible
end)

-- ปุ่มคลิกเสียง
local clickSoundId = "rbxassetid://6042053626"

-- ฟังก์ชันเพิ่มปุ่ม
local pulledButtons = {}
local buttons = {}

local function addBtn(name, callback)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(1,0,0,30)
    btn.BackgroundColor3 = Color3.fromRGB(60,60,60)
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 18
    btn.Text = buttonTexts[name][currentLanguage]
    btn.LayoutOrder = #scroll:GetChildren() + 1
    btn.Parent = scroll
    table.insert(buttons,{name=name, button=btn})

    -- ปุ่มดึง
    local pullBtn = Instance.new("TextButton")
    pullBtn.Size = UDim2.new(0,20,0,20)
    pullBtn.Position = UDim2.new(1,-25,0,5)
    pullBtn.Text = "+"
    pullBtn.Font = Enum.Font.SourceSansBold
    pullBtn.TextSize = 15
    pullBtn.TextColor3 = Color3.fromRGB(255,255,255)
    pullBtn.BackgroundColor3 = Color3.fromRGB(0,100,200)
    pullBtn.Parent = btn

    local originalPos = btn.Position
    pullBtn.MouseButton1Click:Connect(function()
        if btn.Parent == scroll then
            btn.Parent = gui
            btn.Size = UDim2.new(0,150,0,30)
            btn.Position = UDim2.new(0,300,0,100)
            btn.Draggable = true
            pulledButtons[btn] = originalPos
        else
            btn.Parent = scroll
            btn.Position = pulledButtons[btn] or originalPos
            btn.Size = UDim2.new(1,0,0,30)
            btn.Draggable = false
            pulledButtons[btn] = nil
        end
    end)

    btn.MouseButton1Click:Connect(function()
        local sound = Instance.new("Sound", workspace)
        sound.SoundId = clickSoundId
        sound:Play()
        game.Debris:AddItem(sound,3)
        if callback then callback() end
    end)
end

-- -------------------------
-- ฟังก์ชันปุ่มหลัก
-- -------------------------
local autoJump=false
RunService.Heartbeat:Connect(function()
    if autoJump and player.Character and player.Character:FindFirstChild("Humanoid") then
        local hum = player.Character.Humanoid
        local root = player.Character:FindFirstChild("HumanoidRootPart")
        if hum and workspace:FindPartOnRay(Ray.new(root.Position, Vector3.new(0,-4,0)), player.Character) then
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)
local function toggleAutoJump() autoJump = not autoJump end

local function lagSwitch()
    local start = tick()
    while tick()-start<2 do for i=1,1e7 do local a=math.random() end end
end

local clayMode=false
local function toggleFPS()
    clayMode = not clayMode
    if clayMode then
        Lighting.GlobalShadows=false
        Lighting.Brightness=1
        for _,o in pairs(workspace:GetDescendants()) do
            if o:IsA("BasePart") then o.Material=Enum.Material.SmoothPlastic end
        end
    else
        Lighting.GlobalShadows=true
        Lighting.Brightness=2
        for _,o in pairs(workspace:GetDescendants()) do
            if o:IsA("BasePart") then o.Material=Enum.Material.Plastic end
        end
    end
end

local function teleportRoof()
    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        player.Character.HumanoidRootPart.CFrame += Vector3.new(0,500,0)
    end
end

local afkActive=false
local afkPart
local afkLoop
local function toggleAFK()
    afkActive = not afkActive
    if afkActive then
        afkPart=Instance.new("Part")
        afkPart.Size=Vector3.new(10,10,10)
        afkPart.Position=Vector3.new(0,5000,0)
        afkPart.Anchored=true
        afkPart.Parent=workspace
        afkLoop=RunService.Heartbeat:Connect(function()
            if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                player.Character.HumanoidRootPart.CFrame=afkPart.CFrame+Vector3.new(0,5,0)
            end
        end)
    else
        if afkLoop then afkLoop:Disconnect() end
        if afkPart then afkPart:Destroy() end
    end
end

local function teleportDownedTemp()
    local char=player.Character or player.CharacterAdded:Wait()
    local root=char:WaitForChild("HumanoidRootPart")
    local originalCFrame=root.CFrame
    local closestDist=math.huge
    local targetRoot=nil
    for _,p in pairs(Players:GetPlayers()) do
        if p~=player and p.Character and p.Character:FindFirstChild("Humanoid") and p.Character:FindFirstChild("HumanoidRootPart") then
            local hum = p.Character.Humanoid
            local r = p.Character.HumanoidRootPart
            if hum.Health <= 0 then
                local dist=(r.Position-root.Position).Magnitude
                if dist<closestDist then closestDist=dist targetRoot=r end
            end
        end
    end
    if targetRoot then
        root.CFrame=targetRoot.CFrame+Vector3.new(0,-2,0)
        wait(1)
        root.CFrame=originalCFrame
    end
end

local function teleportStationary()
    local char=player.Character or player.CharacterAdded:Wait()
    local root=char:WaitForChild("HumanoidRootPart")
    local closestDist=math.huge
    local targetRoot=nil
    for _,p in pairs(Players:GetPlayers()) do
        if p~=player and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
            local r=p.Character.HumanoidRootPart
            if r.Velocity.Magnitude<=0.1 then
                local dist=(r.Position-root.Position).Magnitude
                if dist<closestDist then closestDist=dist targetRoot=r end
            end
        end
    end
    if targetRoot then root.CFrame=targetRoot.CFrame+Vector3.new(0,5,0) end
end

-- Moon Mode
local moonMode=false
local function toggleMoonMode()
    moonMode = not moonMode
    if moonMode then
        player.Character.Humanoid.JumpPower = 60
        player.Character.Humanoid.UseJumpPower = true
    else
        player.Character.Humanoid.JumpPower = 50
        player.Character.Humanoid.UseJumpPower = true
    end
end
RunService.Heartbeat:Connect(function()
    if moonMode and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local root = player.Character.HumanoidRootPart
        root.Velocity = Vector3.new(root.Velocity.X, root.Velocity.Y * 0.4, root.Velocity.Z)
    end
end)

-- -------------------------
-- เพิ่มปุ่มทั้งหมด
-- -------------------------
addBtn("Auto Jump", toggleAutoJump)
addBtn("Lag Switch", lagSwitch)
addBtn("FPS", toggleFPS)
addBtn("Teleport Roof", teleportRoof)
addBtn("AFK Money", toggleAFK)
addBtn("Teleport Downed 1s", teleportDownedTemp)
addBtn("Teleport Stationary", teleportStationary)
addBtn("Moon Mode", toggleMoonMode)

-- -------------------------
-- อัปเดตภาษา
-- -------------------------
local function updateLanguage()
    for _,v in ipairs(buttons) do
        if buttonTexts[v.name] then
            v.button.Text = buttonTexts[v.name][currentLanguage]
        end
    end
end

thaiBtn.MouseButton1Click:Connect(function()
    currentLanguage = "TH"
    langGui.Enabled = false
    gui.Enabled = true
    updateLanguage()
end)

engBtn.MouseButton1Click:Connect(function()
    currentLanguage = "EN"
    langGui.Enabled = false
    gui.Enabled = true
    updateLanguage()
end)
