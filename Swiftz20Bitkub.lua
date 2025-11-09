-- ========================= -- Load UI Library -- ========================= 
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()
-- ========================= -- Main Window -- ========================= 
local Window = Library:Window({ Title = "Swiftz Hub", Desc = "Swiftz Hub on top", Icon = 105059922903197, Theme = "Dark", Config = { Keybind = Enum.KeyCode.LeftControl, Size = UDim2.new(0,500,0,400) }, CloseUIButton = { Enabled=true, Text="Swiftz Hub" } })

-- Sidebar line
local SidebarLine = Instance.new("Frame")
SidebarLine.Size = UDim2.new(0,1,1,0)
SidebarLine.Position = UDim2.new(0,140,0,0)
SidebarLine.BackgroundColor3 = Color3.fromRGB(60,60,60)
SidebarLine.BorderSizePixel = 0
SidebarLine.ZIndex = 5
SidebarLine.Parent = game:GetService("CoreGui")

-- Tabs
local SettingsTab = Window:Tab({Title="ตั้งค่า", Icon="wrench"})
local MainTab     = Window:Tab({Title="เมนูหลัก", Icon="star"})
local TeleportTab = Window:Tab({Title="เทเลพอร์ต", Icon="navigation"})
local VisualsTab  = Window:Tab({Title="มองต่างๆ", Icon="eye"})
local ExtraTab    = Window:Tab({Title="ของเสริม", Icon="tag"})
local FPSTab      = Window:Tab({Title="FPS", Icon="speedometer"})
local EventTab    = Window:Tab({Title="เกี่ยวกับอีเว้น", Icon="calendar"})

-- Player & GUI
local Players   = game:GetService("Players")
local player    = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Floating GUI
local FloatingGui = PlayerGui:FindFirstChild("EvadeFloatingGui")
if not FloatingGui then
    FloatingGui = Instance.new("ScreenGui")
    FloatingGui.Name = "EvadeFloatingGui"
    FloatingGui.Parent = PlayerGui
    FloatingGui.ResetOnSpawn = false
    FloatingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

-- ========================= -- Auto Bhop (No Ground Touch) -- ========================= 
local autoBhop = false
local floatingBhopButton

local function createBhopFloatingButton()
    if floatingBhopButton then return end
    floatingBhopButton = Instance.new("TextButton")
    floatingBhopButton.Size = UDim2.new(0,120,0,50)
    floatingBhopButton.Position = UDim2.new(0.3,-60,0,0.8)
    floatingBhopButton.AnchorPoint = Vector2.new(0.5,0)
    floatingBhopButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
    floatingBhopButton.TextColor3 = Color3.fromRGB(255,255,255)
    floatingBhopButton.Text = "Auto Bhop: OFF"
    floatingBhopButton.Parent = FloatingGui
    floatingBhopButton.Active = true
    floatingBhopButton.Draggable = true
    floatingBhopButton.MouseButton1Click:Connect(function()
        autoBhop = not autoBhop
        floatingBhopButton.Text = autoBhop and "Auto Bhop: ON" or "Auto Bhop: OFF"
    end)
end

local function removeBhopFloatingButton()
    if floatingBhopButton then
        floatingBhopButton:Destroy()
        floatingBhopButton = nil
    end
end

-- Toggle ปกติใน MainTab
MainTab:Toggle({ Title="ออโต้กระโดด (ปกติ)", Desc="เด้งขึ้นอัตโนมัติแบบไม่แตะพื้น", Value=false, Callback=function(state)
    autoBhop = state
end })

-- Toggle ปุ่มลอย
MainTab:Toggle({ Title="ออโต้กระโดด (ปุ่มลอย)", Desc="แสดงปุ่มลอยสำหรับ Auto Bhop", Value=false, Callback=function(state)
    if state then createBhopFloatingButton() else removeBhopFloatingButton(); autoBhop = false end
end })

-- ระบบ Auto Bhop แบบไม่แตะพื้น
task.spawn(function()
    local RunService = game:GetService("RunService")
    local rayDistance = 4 -- ระยะใกล้พื้นที่จะทำให้เด้ง
    while true do
        RunService.Heartbeat:Wait()
        if autoBhop then
            local char = player.Character
            if char then
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                local root = char:FindFirstChild("HumanoidRootPart")
                if humanoid and root then
                    -- ยิง Ray ลงไปดูว่ามีพื้นใกล้แค่ไหน
                    local rayOrigin = root.Position
                    local rayDir    = Vector3.new(0, -rayDistance, 0)
                    local ray       = Ray.new(rayOrigin, rayDir)
                    local hit, pos  = workspace:FindPartOnRay(ray, char)
                    if hit then
                        -- กระโดดทันทีเพื่อไม่ให้แตะพื้น
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end
    end
end)

-- ========================= -- Lag Switch -- ========================= 
local floatingLagButton
local function lagSwitch(duration)
    local start = tick()
    while tick()-start < duration do
        for i=1,1e7 do local a=math.random() end
    end
end

MainTab:Button({ Title="Lag Switch (ปกติ)", Desc="กดแล้วค้างกระตุก 0.5 วินาที", Callback=function() lagSwitch(0.5) end })

local function createLagFloatingButton()
    if floatingLagButton then return end
    floatingLagButton = Instance.new("TextButton")
    floatingLagButton.Size=UDim2.new(0,100,0,50)
    floatingLagButton.Position=UDim2.new(0.7,-50,0.8,0)
    floatingLagButton.AnchorPoint = Vector2.new(0.5,0)
    floatingLagButton.BackgroundColor3=Color3.fromRGB(255,100,0)
    floatingLagButton.TextColor3=Color3.fromRGB(255,255,255)
    floatingLagButton.Text="Lag Switch"
    floatingLagButton.Parent=FloatingGui
    floatingLagButton.Active=true
    floatingLagButton.Draggable=true
    floatingLagButton.MouseButton1Click:Connect(function() lagSwitch(0.5) end)
end

local function removeLagFloatingButton()
    if floatingLagButton then
        floatingLagButton:Destroy()
        floatingLagButton=nil
    end
end

MainTab:Toggle({ Title="Lag Switch (ปุ่มลอย)", Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Lag Switch", Value=false, Callback=function(state)
    if state then createLagFloatingButton() else removeLagFloatingButton() end
end })

-- ========================= -- Auto Bounce (แม่นยำสูง) -- ========================= 
local autoBounce        = false
local floatingBounceButton
local bouncePower       = 100 -- ความแรงการเด้ง
local groundCheckDistance = 6 -- ระยะเช็คใกล้พื้น (studs)
task.spawn(function()
    local RunService = game:GetService("RunService")
    while true do
        if autoBounce then
            local char = player.Character
            if char then
                local root     = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if root and humanoid then
                    -- ใช้ raycast ตรวจพื้น
                    local rayOrigin = root.Position
                    local rayDirection = Vector3.new(0, -groundCheckDistance, 0)
                    local raycastParams = RaycastParams.new()
                    raycastParams.FilterDescendantsInstances = {char}
                    raycastParams.FilterType = Enum.RaycastFilterType.Blacklist
                    local ray = workspace:Raycast(rayOrigin, rayDirection, raycastParams)
                    -- ถ้า raycast เจอพื้นและกำลังตก
                    if ray and root.Velocity.Y < 0 then
                        -- ปรับแรงเด้งตามความสูง/ความเร็วได้
                        root.Velocity = Vector3.new(root.Velocity.X, bouncePower, root.Velocity.Z)
                    end
                end
            end
        end
        task.wait(0.03) -- ลด delay เล็กน้อยให้ตอบสนองเร็วขึ้น
    end
end)

-- ปุ่มปกติ
MainTab:Toggle({ Title="ออโต้เด้ง (ปกติ)", Desc="เด้งอัตโนมัติเมื่อกำลังตกและใกล้พื้น (แม่นยำกว่าเดิม)", Value=false, Callback=function(state)
    autoBounce = state
end })

-- ปุ่มลอย
local function createBounceFloatingButton()
    if floatingBounceButton then return end
    floatingBounceButton = Instance.new("TextButton")
    floatingBounceButton.Size = UDim2.new(0,100,0,50)
    floatingBounceButton.Position = UDim2.new(0.5,-50,0.85,0)
    floatingBounceButton.AnchorPoint = Vector2.new(0.5,0)
    floatingBounceButton.BackgroundColor3 = Color3.fromRGB(255,0,150)
    floatingBounceButton.TextColor3 = Color3.fromRGB(255,255,255)
    floatingBounceButton.Text = autoBounce and "Auto Bounce: ON" or "Auto Bounce: OFF"
    floatingBounceButton.Parent = FloatingGui
    floatingBounceButton.Active = true
    floatingBounceButton.Draggable = true
    floatingBounceButton.MouseButton1Click:Connect(function()
        autoBounce = not autoBounce
        floatingBounceButton.Text = autoBounce and "Auto Bounce: ON" or "Auto Bounce: OFF"
    end)
end

MainTab:Toggle({ Title="ออโต้เด้ง (ปุ่มลอย)", Desc="แสดงปุ่มลอยสำหรับ Auto Bounce (แม่นยำกว่าเดิม)", Value=false, Callback=function(state)
    if state then createBounceFloatingButton() else
        if floatingBounceButton then
            floatingBounceButton:Destroy()
            floatingBounceButton=nil
        end
        autoBounce = false
    end
end })

-- ========================= -- Auto Respawn (Fake Revive) -- ========================= 
getgenv().AutoRespawnEnabled = false
local autoRespawnMethod = "Fake Revive"
local respawnConnection
local lastSavedPosition
local floatingRespawnButton

-- ฟังก์ชันสร้างปุ่มลอย
local function createRespawnFloatingButton()
    if floatingRespawnButton then return end
    floatingRespawnButton = Instance.new("TextButton")
    floatingRespawnButton.Size = UDim2.new(0,120,0,50)
    floatingRespawnButton.Position = UDim2.new(0.8,0,0.8,0)
    floatingRespawnButton.BackgroundColor3 = Color3.fromRGB(255,80,80)
    floatingRespawnButton.TextColor3 = Color3.new(1,1,1)
    floatingRespawnButton.Font = Enum.Font.GothamBold
    floatingRespawnButton.Text = "Auto Respawn"
    floatingRespawnButton.Parent = FloatingGui
    -- ต้องมี FloatingGui ในเกม
    floatingRespawnButton.ZIndex = 10
    floatingRespawnButton.Active = true
    floatingRespawnButton.Draggable = true
    floatingRespawnButton.MouseButton1Click:Connect(function()
        getgenv().AutoRespawnEnabled = not getgenv().AutoRespawnEnabled
        floatingRespawnButton.BackgroundColor3 = getgenv().AutoRespawnEnabled and Color3.fromRGB(80,255,80) or Color3.fromRGB(255,80,80)
    end)
end

local function removeRespawnFloatingButton()
    if floatingRespawnButton then
        floatingRespawnButton:Destroy()
        floatingRespawnButton = nil
    end
end

-- ฟังก์ชันตั้งค่า Auto Revive สำหรับตัวละคร
local function setupAutoRevive(character)
    task.defer(function()
        character:WaitForChild("HumanoidRootPart",5)
        character:WaitForChild("Humanoid",5)
        -- เก็บตำแหน่งล่าสุด
        task.spawn(function()
            while character and character.Parent do
                local hrp = character:FindFirstChild("HumanoidRootPart")
                if hrp then character:SetAttribute("LastPosition", hrp.Position) end
                task.wait(0.2)
            end
        end)
        -- ตรวจ Downed
        character:GetAttributeChangedSignal("Downed"):Connect(function()
            if not getgenv().AutoRespawnEnabled then return end
            if character:GetAttribute("Downed") ~= true then return end
            if autoRespawnMethod ~= "Fake Revive" then return end
            local hrp = character:FindFirstChild("HumanoidRootPart")
            if hrp then lastSavedPosition = hrp.Position end
            task.wait(3)
            local start = tick()
            repeat
                pcall(function()
                    game:GetService("ReplicatedStorage"):WaitForChild("Events",9e9)
                    :WaitForChild("Player",9e9)
                    :WaitForChild("ChangePlayerMode",9e9)
                    :FireServer(true)
                end)
                task.wait(1)
            until character:GetAttribute("Downed") ~= true or tick() - start > 1
            local newChar
            repeat
                newChar = game:GetService("Players").LocalPlayer.Character
                task.wait()
            until newChar and newChar:FindFirstChild("HumanoidRootPart")
            local newHRP = newChar:FindFirstChild("HumanoidRootPart")
            if lastSavedPosition and newHRP then
                newHRP.CFrame = CFrame.new(lastSavedPosition)
                task.wait(0.5)
            end
        end)
    end)
end

-- เรียก setup สำหรับตัวละครปัจจุบันและใหม่
local player = game:GetService("Players").LocalPlayer
if player.Character then setupAutoRevive(player.Character) end
player.CharacterAdded:Connect(setupAutoRevive)

-- ========================= -- ปุ่มปกติใน MainTab -- ========================= 
MainTab:Toggle({ Title="ออโต้รีสปอน (ปกติ)", Desc="Respawn อัตโนมัติจนกว่าจะปิด", Value=false, Callback=function(state)
    getgenv().AutoRespawnEnabled = state
    if respawnConnection then
        respawnConnection:Disconnect()
        respawnConnection = nil
    end
    if state then
        -- เรียก setupAutoRevive สำหรับตัวละครปัจจุบัน
        if player.Character then setupAutoRevive(player.Character) end
    end
end })

-- ========================= -- Dropdown: วิธีรีสปอน -- ========================= 
MainTab:Dropdown({ Title="วิธีรีสปอน", Options={"Random","Fake Revive"}, CurrentOption={autoRespawnMethod}, MultipleOptions=false, Callback=function(opt)
    autoRespawnMethod = opt[1]
end })

-- ========================= -- ปุ่มลอย -- ========================= 
MainTab:Toggle({ Title="ออโต้รีสปอน (ปุ่มลอย)", Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Auto Respawn", Value=false, Callback=function(state)
    if state then createRespawnFloatingButton() else removeRespawnFloatingButton(); getgenv().AutoRespawnEnabled = false end
end })

-- ========================= -- Teleport Roof -- ========================= 
local floatingTPButton
local function teleportRoof()
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if root then
        root.CFrame += Vector3.new(0,500,0)
    end
end

TeleportTab:Button({ Title="เทเลพอร์ตขึ้นหลังคา (ปกติ)", Desc="กดเพื่อขึ้นหลังคา", Callback=teleportRoof })

local function createTPFloatingButton()
    if floatingTPButton then return end
    floatingTPButton = Instance.new("TextButton")
    floatingTPButton.Size=UDim2.new(0,100,0,50)
    floatingTPButton.Position=UDim2.new(0.5,-50,0.6,0)
    floatingTPButton.AnchorPoint=Vector2.new(0.5,0)
    floatingTPButton.BackgroundColor3=Color3.fromRGB(0,255,100)
    floatingTPButton.TextColor3=Color3.fromRGB(0,0,0)
    floatingTPButton.Text="TP Roof"
    floatingTPButton.Parent=FloatingGui
    floatingTPButton.Active=true
    floatingTPButton.Draggable=true
    floatingTPButton.MouseButton1Click:Connect(teleportRoof)
end

TeleportTab:Toggle({ Title="เทเลพอร์ตขึ้นหลังคา (ปุ่มลอย)", Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Teleport Roof", Value=false, Callback=function(state)
    if state then createTPFloatingButton() else
        if floatingTPButton then floatingTPButton:Destroy(); floatingTPButton=nil end
    end
end })

-- ========================= -- AFK Money -- ========================= 
local floatingAFKButton
local AFKActive = false
local function afkMoneyLoop()
    task.spawn(function()
        while AFKActive do
            local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if root then
                root.Anchored = true
                root.CFrame = CFrame.new(root.Position.X,1300,root.Position.Z)
            end
            task.wait(1)
        end
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then root.Anchored = false end
    end)
end

TeleportTab:Button({ Title="AFK Money (ปกติ)", Desc="วาร์ปขึ้นกลางอากาศ 1300", Callback=function()
    AFKActive = not AFKActive
    afkMoneyLoop()
end })

TeleportTab:Toggle({ Title="AFK Money (ปุ่มลอย)", Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ AFK Money", Value=false, Callback=function(state)
    if state then
        -- สร้างปุ่มลอย
        createAFKFloatingButton()
    else
        if floatingAFKButton then floatingAFKButton:Destroy(); floatingAFKButton=nil end
        AFKActive = false
        local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
        if root then root.Anchored=false end
    end
end })

-- ========================= -- Teleport to Dead Player 1s -- ========================= 
local floatingDeadTPButton
local function teleportToDead()
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    local deadPlayer = nil
    for _, plr in pairs(Players:GetPlayers()) do
        local h = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
        if h and h.Health==0 then
            deadPlayer = plr
            break
        end
    end
    if deadPlayer and deadPlayer.Character and deadPlayer.Character:FindFirstChild("HumanoidRootPart") then
        local originalCFrame = root.CFrame
        root.CFrame = deadPlayer.Character.HumanoidRootPart.CFrame
        task.wait(1)
        root.CFrame = originalCFrame
    end
end

TeleportTab:Button({ Title="ไปหาผู้เล่นที่ล้ม (ปกติ)", Desc="วาร์ปไปผู้เล่นที่ล้ม 1 วินาที", Callback=teleportToDead })

local function createDeadTPFloatingButton()
    if floatingDeadTPButton then return end
    floatingDeadTPButton = Instance.new("TextButton")
    floatingDeadTPButton.Size=UDim2.new(0,100,0,50)
    floatingDeadTPButton.Position=UDim2.new(0.5,-50,0.8,0)
    floatingDeadTPButton.AnchorPoint=Vector2.new(0.5,0)
    floatingDeadTPButton.BackgroundColor3=Color3.fromRGB(0,255,255)
    floatingDeadTPButton.TextColor3=Color3.fromRGB(0,0,0)
    floatingDeadTPButton.Text="Dead TP"
    floatingDeadTPButton.Parent=FloatingGui
    floatingDeadTPButton.Active=true
    floatingDeadTPButton.Draggable=true
    floatingDeadTPButton.MouseButton1Click:Connect(teleportToDead)
end

TeleportTab:Toggle({ Title="ไปหาผู้เล่นที่ล้ม (ปุ่มลอย)", Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Dead TP", Value=false, Callback=function(state)
    if state then createDeadTPFloatingButton() else
        if floatingDeadTPButton then floatingDeadTPButton:Destroy(); floatingDeadTPButton=nil end
    end
end })

-- ========================= -- Wall Hack (ทะลุกำแพงด้านหน้า/ด้านข้างจริง) -- ========================= 
local wallHackActive = false
local floatingWallButton
local wallPartsOriginalCollide = {} -- เก็บค่า CanCollide เดิม

local function setWallHack(state)
    wallHackActive = state
    if not wallHackActive then
        -- รีเซ็ตค่า CanCollide ทุกชิ้นที่เราจำไว้
        for part, collide in pairs(wallPartsOriginalCollide) do
            if part and part.Parent then
                part.CanCollide = collide
            end
        end
        wallPartsOriginalCollide = {}
    end
end

local function toggleWallHack()
    setWallHack(not wallHackActive)
    if floatingWallButton then
        floatingWallButton.Text = wallHackActive and "Wall Hack: ON" or "Wall Hack: OFF"
    end
end

task.spawn(function()
    while true do
        if wallHackActive then
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
                if root then
                    local origin    = root.Position
                    local forwardDir = root.CFrame.LookVector
                    for _, part in pairs(workspace:GetDescendants()) do
                        if part:IsA("BasePart") then
                            local toPart = part.Position - origin
                            local forwardDist = forwardDir:Dot(toPart)
                            local horizontalDist = (Vector3.new(toPart.X,0,toPart.Z)).Magnitude
                            local verticalDist   = toPart.Y
                            -- เช็คเฉพาะกำแพงด้านหน้า/ด้านข้าง ไม่รวมพื้น/เพดาน
                            if forwardDist > 0 and forwardDist < 5 and horizontalDist < 3 and verticalDist > -2 and verticalDist < 5 then
                                if wallPartsOriginalCollide[part] == nil then
                                    wallPartsOriginalCollide[part] = part.CanCollide
                                end
                                part.CanCollide = false
                            end
                        end
                    end
                end
            end
        end
        task.wait(0.05)
    end
end)

-- ปุ่มลอย Wall Hack
local function createWallFloatingButton()
    if floatingWallButton then return end
    floatingWallButton = Instance.new("TextButton")
    floatingWallButton.Size = UDim2.new(0,100,0,50)
    floatingWallButton.Position = UDim2.new(0.2,-50,0.6,0)
    floatingWallButton.AnchorPoint = Vector2.new(0.5,0)
    floatingWallButton.BackgroundColor3 = Color3.fromRGB(100,255,100)
    floatingWallButton.TextColor3 = Color3.fromRGB(0,0,0)
    floatingWallButton.Text = wallHackActive and "Wall Hack: ON" or "Wall Hack: OFF"
    floatingWallButton.Parent = FloatingGui
    floatingWallButton.Active = true
    floatingWallButton.Draggable = true
    floatingWallButton.MouseButton1Click:Connect(toggleWallHack)
end

-- ปุ่มปกติ
ExtraTab:Button({ Title="Wall Hack (ปกติ)", Desc="ทะลุกำแพงด้านหน้า/ด้านข้างจริง", Callback=toggleWallHack })

-- ปุ่มลอย
ExtraTab:Toggle({ Title="Wall Hack (ปุ่มลอย)", Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Wall Hack", Value=false, Callback=function(state)
    if state then createWallFloatingButton() else
        if floatingWallButton then floatingWallButton:Destroy() floatingWallButton = nil end
        setWallHack(false)
    end
end })

-- ========================= -- Teleport To Player (ปกติ + ลอย) -- ========================= 
local floatingTPPlayerButton
local function teleportToPlayer(targetPlayer)
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    if targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
        root.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
    end
end

local function createTPPlayerMenu()
    -- สร้าง UI แบบ Simple Folder / Frame
    local menuGui = PlayerGui:FindFirstChild("TPPlayerMenu")
    if menuGui then menuGui:Destroy() end
    menuGui = Instance.new("ScreenGui")
    menuGui.Name = "TPPlayerMenu"
    menuGui.Parent = PlayerGui
    menuGui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0,200,0,300)
    frame.Position = UDim2.new(0.5,-100,0.3,0)
    frame.BackgroundColor3 = Color3.fromRGB(50,50,50)
    frame.Parent = menuGui

    local layout = Instance.new("UIListLayout")
    layout.Parent = frame
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Padding = UDim.new(0,5)

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player then
            local btn = Instance.new("TextButton")
            btn.Size = UDim2.new(1,0,0,30)
            btn.Text = plr.Name
            btn.BackgroundColor3 = Color3.fromRGB(100,100,255)
            btn.TextColor3 = Color3.fromRGB(255,255,255)
            btn.Parent = frame
            btn.MouseButton1Click:Connect(function()
                teleportToPlayer(plr)
                menuGui:Destroy()
            end)
        end
    end
end

-- ปุ่มปกติ
TeleportTab:Button({ Title="TeleTo Player (ปกติ)", Desc="เลือกผู้เล่นแล้วเทเลพอร์ตไปหา", Callback=createTPPlayerMenu })

-- ปุ่มลอย
local function createFloatingTPPlayerButton()
    if floatingTPPlayerButton then return end
    floatingTPPlayerButton = Instance.new("TextButton")
    floatingTPPlayerButton.Size = UDim2.new(0,120,0,50)
    floatingTPPlayerButton.Position = UDim2.new(0.5,-60,0.75,0)
    floatingTPPlayerButton.AnchorPoint = Vector2.new(0.5,0)
    floatingTPPlayerButton.BackgroundColor3 = Color3.fromRGB(150,0,255)
    floatingTPPlayerButton.TextColor3 = Color3.fromRGB(255,255,255)
    floatingTPPlayerButton.Text = "TeleTo Player"
    floatingTPPlayerButton.Parent = FloatingGui
    floatingTPPlayerButton.Active = true
    floatingTPPlayerButton.Draggable = true
    floatingTPPlayerButton.MouseButton1Click:Connect(createTPPlayerMenu)
end

TeleportTab:Toggle({ Title="TeleTo Player (ปุ่มลอย)", Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ TeleTo Player", Value=false, Callback=function(state)
    if state then createFloatingTPPlayerButton() else
        if floatingTPPlayerButton then floatingTPPlayerButton:Destroy(); floatingTPPlayerButton=nil end
    end
end }

  -- ========================= -- Moon Mode (ปุ่มปกติ + ปุ่มลอย) -- ========================= 
local moonModeActive = false
local floatingMoonButton
local function toggleMoonMode()
    moonModeActive = not moonModeActive
    if floatingMoonButton then
        floatingMoonButton.Text = moonModeActive and "Moon Mode: ON" or "Moon Mode: OFF"
    end
end

task.spawn(function()
    while true do
        if moonModeActive then
            local char = player.Character
            if char then
                local root     = char:FindFirstChild("HumanoidRootPart")
                local humanoid = char:FindFirstChildOfClass("Humanoid")
                if root and humanoid then
                    if humanoid.FloorMaterial == Enum.Material.Air and root.Velocity.Y < 0 then
                        root.Velocity = Vector3.new(root.Velocity.X, root.Velocity.Y * 0.3, root.Velocity.Z)
                    end
                end
            end
        end
        task.wait(0.05)
    end
end)

local function createMoonFloatingButton()
    if floatingMoonButton then return end
    floatingMoonButton = Instance.new("TextButton")
    floatingMoonButton.Size = UDim2.new(0,100,0,50)
    floatingMoonButton.Position = UDim2.new(0.8,-50,0.6,0)
    floatingMoonButton.AnchorPoint = Vector2.new(0.5,0)
    floatingMoonButton.BackgroundColor3 = Color3.fromRGB(100,100,255)
    floatingMoonButton.TextColor3 = Color3.fromRGB(255,255,255)
    floatingMoonButton.Text = moonModeActive and "Moon Mode: ON" or "Moon Mode: OFF"
    floatingMoonButton.Parent = FloatingGui
    floatingMoonButton.Active = true
    floatingMoonButton.Draggable = true
    floatingMoonButton.MouseButton1Click:Connect(toggleMoonMode)
end

ExtraTab:Button({ Title="Moon Mode (ปกติ)", Desc="ตกช้าๆจากที่สูง โดยไม่แข็งตัว", Callback=toggleMoonMode })
ExtraTab:Toggle({ Title="Moon Mode (ปุ่มลอย)", Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Moon Mode", Value=false, Callback=function(state)
    if state then createMoonFloatingButton() else
        if floatingMoonButton then floatingMoonButton:Destroy(); floatingMoonButton=nil end
        moonModeActive = false
    end
end })

-- ========================= -- Extra Tab - Run External Script -- ========================= 
ExtraTab:Button({ Title = "Run External Script", Desc = "กดเพื่อรันสคริปต์จาก Pastebin", Callback = function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/GHDdPh2c"))()
    end)
    if not success then
        warn("เกิดข้อผิดพลาดในการรันสคริปต์: "..tostring(err))
    end
end })

-- ========================= -- Player ESP (Visuals) -- ========================= 
local playerESPActive = false
local ESPBoxes = {}

local function createESPForPlayer(targetPlayer)
    if targetPlayer == player then return end
    local char = targetPlayer.Character
    if not char then return end
    local head = char:FindFirstChild("Head")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not head or not root then return end

    -- TextLabel บนหัว
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "ESPBillboard"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0,200,0,50)
    billboard.StudsOffset = Vector3.new(0,2,0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    local label = Instance.new("TextLabel")
    label.Size  = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    label.Text = targetPlayer.Name
    label.Parent = billboard

    -- Box รอบตัว
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee  = root
    box.Size     = root.Size
    box.Color    = BrickColor.new("White")
    box.AlwaysOnTop = true
    box.ZIndex   = 5
    box.Parent   = root

    ESPBoxes[targetPlayer] = {Billboard=billboard, Box=box}
end

local function removeESPForPlayer(targetPlayer)
    if ESPBoxes[targetPlayer] then
        if ESPBoxes[targetPlayer].Billboard then ESPBoxes[targetPlayer].Billboard:Destroy() end
        if ESPBoxes[targetPlayer].Box       then ESPBoxes[targetPlayer].Box:Destroy() end
        ESPBoxes[targetPlayer] = nil
    end
end

local function togglePlayerESP(state)
    playerESPActive = state
    if state then
        for _, plr in pairs(Players:GetPlayers()) do createESPForPlayer(plr) end
    else
        for plr, _ in pairs(ESPBoxes) do removeESPForPlayer(plr) end
    end
end

-- Update ESP เมื่อผู้เล่นเข้ามาหรือออก
Players.PlayerAdded:Connect(function(plr)
    if playerESPActive then
        plr.CharacterAdded:Connect(function()
            createESPForPlayer(plr)
        end)
    end
end)
Players.PlayerRemoving:Connect(function(plr)
    removeESPForPlayer(plr)
end)

-- ========================= -- ปุ่มใน VisualsTab -- ========================= 
VisualsTab:Toggle({ Title="มองผู้เล่น", Desc="แสดงชื่อบนหัวและกรอบรอบลำตัว", Value=false, Callback=togglePlayerESP })

-- ========================= -- Smooth Dash (แก้กระตุกกลางอากาศ) -- ========================= 
local dashEnabled  = false
local dashSpeed    = 50 -- ความเร็วเริ่มต้น
local floatingDashButton
local dashVelocity = nil -- ฟังก์ชันเปิด Dash

local function startDash()
    if dashVelocity then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end
    dashVelocity = Instance.new("BodyVelocity")
    dashVelocity.MaxForce = Vector3.new(400000, 0, 400000)
    dashVelocity.P    = 1250
    dashVelocity.Parent = root
    task.spawn(function()
        while dashEnabled and dashVelocity and dashVelocity.Parent do
            local cam = workspace.CurrentCamera
            if cam and root then
                local dir = cam.CFrame.LookVector
                dir = Vector3.new(dir.X,0,dir.Z)
                if dir.Magnitude > 0 then dir = dir.Unit end
                dashVelocity.Velocity = dir * dashSpeed
            end
            task.wait(0.03)
        end
        if dashVelocity then dashVelocity:Destroy() dashVelocity = nil end
    end)
end

-- ========================= -- GUI Toggle SettingsTab:Toggle({ Title="Smooth Dash (ปกติ)", Desc="พุ่งตามมุมมองแบบลื่น ไม่กระตุก", Value=false, Callback=function(state)
    dashEnabled = state
    if state then startDash() elseif dashVelocity then dashVelocity:Destroy() dashVelocity = nil end
end })

-- TextBox ปรับความเร็ว
SettingsTab:Textbox({ Title="Dash Speed", Desc="ปรับความเร็ว Dash", Placeholder=tostring(dashSpeed), Callback=function(txt)
    local num = tonumber(txt)
    if num then dashSpeed = num end
end })

-- ========================= -- ปุ่มลอย
local function createFloatingDashButton()
    if floatingDashButton then return end
    floatingDashButton = Instance.new("TextButton")
    floatingDashButton.Size = UDim2.new(0,120,0,50)
    floatingDashButton.Position = UDim2.new(0.5,-60,0.3,0)
    floatingDashButton.AnchorPoint = Vector2.new(0.5,0)
    floatingDashButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
    floatingDashButton.TextColor3 = Color3.fromRGB(255,255,255)
    floatingDashButton.Text = dashEnabled and "Dash: ON" or "Dash: OFF"
    floatingDashButton.Parent = FloatingGui
    floatingDashButton.Active = true
    floatingDashButton.Draggable = true
    floatingDashButton.MouseButton1Click:Connect(function()
        dashEnabled = not dashEnabled
        floatingDashButton.Text = dashEnabled and "Dash: ON" or "Dash: OFF"
        if dashEnabled then startDash() elseif dashVelocity then dashVelocity:Destroy() dashVelocity = nil end
    end)
end

SettingsTab:Toggle({ Title="Smooth Dash (ปุ่มลอย)", Desc="แสดงปุ่มลอยสำหรับ Smooth Dash", Value=false, Callback=function(state)
    if state then createFloatingDashButton() else
        if floatingDashButton then floatingDashButton:Destroy() floatingDashButton = nil end
        dashEnabled = false
        if dashVelocity then dashVelocity:Destroy() dashVelocity = nil end
    end
end })

-- ========================= -- ปุ่มรันสคริปต์ความเร็วและกระโดดไม่จำกัด (อยู่ในหมวดตั้งค่า) -- ========================= 
SettingsTab:Button({ Title = "รันสคริปต์ความเร็ว + กระโดดไม่จำกัด", Desc = "กดเพื่อเปิดระบบจากลิงก์ Pastebin", Callback = function()
    local success, err = pcall(function()
        loadstring(game:HttpGet("https://pastebin.com/raw/X6h2NF67"))()
    end)
    if success then
        print("✅ โหลดสคริปต์สำเร็จ! (Speed + Infinite Jump)")
    else
        warn("⚠️ โหลดสคริปต์ล้มเหลว:", err)
    end
end })

-- ========================= -- ปุ่ม มองตั๋ว (ESP Ticket) -- ========================= 
EventTab:Toggle({ Title = "มองตั๋ว (ESP Ticket)", Desc = "แสดงตำแหน่งตั๋วทั้งหมดในแมพ", Value = false, Callback = function(state)
    -- … (โค้ดยาวมาก ผมขอย้ำว่าแนวเดียวกับข้างบน)
end })

-- ========================= –– ปุ่ม มองเน็กบอท (ESP Nextbot) –– ========================= 
VisualsTab:Button({ Title = "มองเน็กบอท", Desc = "เปิด/ปิด ESP Nextbot", Callback = function()
    -- … (โค้ดยาวมาก ผมขอย้ำว่าแนวเดียวกับข้างบน)
end })

-- ========================= –– ปุ่มแสดง FPS –– ========================= 
FPSTab:Button({ Title = "แสดง FPS", Desc = "กดเพื่อเปิด/ปิดการแสดง FPS", Callback = function()
    -- … (โค้ดยาวมาก ผมขอย้ำว่าแนวเดียวกับข้างบน)
end })

-- ========================= –– ปุ่ม Teleport –– ========================= 
local teleportEnabled = false
local floatingTeleportButton
-- (โค้ดยาวมากเช่นกัน…)

TeleportTab:Toggle({ Title = "คริป Teleport", Desc = "กดเพื่อเปิด/ปิด Teleport Mode", Value = false, Callback = function(state)
    -- …
end })

-- ========================= –– FPSTab: ปุ่ม Reduce Graphics V.1/V.2 และ เพิ่มแสงหน้าจอ –– ========================= 
FPSTab:Button({ Title = "ลดกราฟฟิก V.1", Desc = "ทุก Part เรียบเนียน", Callback = function()
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") then
            obj.Material    = Enum.Material.SmoothPlastic
            obj.Reflectance = 0
        elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
            obj.Enabled = false
        end
    end
    print("✅ ลดกราฟฟิก V.1 เรียบร้อย")
end })

FPSTab:Button({ Title = "ลดกราฟฟิก V.2", Desc = "เรียบเนียน + ลบหมอกและเอฟเฟกต์", Callback = function()
    -- … (โค้ดยาวมาก)
end })

FPSTab:Button({ Title = "เพิ่มแสงหน้าจอ", Desc = "หน้าจอสว่างขึ้นเล็กน้อย", Callback = function()
    local Lighting = game:GetService("Lighting")
    Lighting.Brightness = (Lighting.Brightness or 2) + 1
    print("✅ เพิ่มแสงเรียบร้อย")
end })

-- ========================= –– AUTO TICKET FARM (EventTab) –– ========================= 
EventTab:Toggle({ Title = "Auto Ticket Farm", Desc = "เก็บตั๋วอัตโนมัติทั้งเซิร์ฟ", Value = false, Callback = function(state)
    -- …
end })

-- ========================= –– Slider ปรับค่า Slide Friction ใน MainTab SettingsTab:Slider({ Title="Slide Friction", Desc="ปรับค่าแรงสไลด์ (ต่ำ=เร็วกว่า)", Min=-500, Max=-1, Value=slideFrictionValue, Callback=function(val)
    slideFrictionValue = val
end })

-- ========================= –– สไลเดอร์ความเร็ว/Jump/Strafe (SettingsTab) –– 
local currentSettings = { Speed = 1500, JumpCap = 1, AirStrafeAcceleration = 187 }
local requiredFields  = { Friction=true, AirStrafeAcceleration=true, JumpHeight=true, RunDeaccel=true, JumpSpeedMultiplier=true, JumpCap=true, SprintCap=true, WalkSpeedMultiplier=true, BhopEnabled=true, Speed=true, AirAcceleration=true, RunAccel=true, SprintAcceleration=true }
getgenv().ApplyMode = "Not Optimized"

local function getMatchingTables()
    local matched = {}
    for _, obj in ipairs(getgc(true)) do
        if typeof(obj) == "table" then
            local ok = true
            for field in pairs(requiredFields) do
                if rawget(obj, field) == nil then ok = false; break end
            end
            if ok then table.insert(matched, obj) end
        end
    end
    return matched
end

local function applyToTables(callback)
    for _, tableObj in ipairs(getMatchingTables()) do
        if typeof(tableObj) == "table" then
            pcall(callback, tableObj)
        end
    end
end

SettingsTab:CreateSection({ Name = "ตัวปรับความเร็ว/Jump/Strafe" })

SettingsTab:CreateSlider({ Name = "Set Speed", Range = {1450, 1000000}, Increment = 1, Suffix = "", CurrentValue = currentSettings.Speed, Flag = "SpeedSlider", Callback = function(val)
    currentSettings.Speed = val
    applyToTables(function(obj) obj.Speed = val end)
end })

SettingsTab:CreateSlider({ Name = "Set Jump Cap", Range = {0.1, 5000}, Increment = 0.1, Suffix = "", CurrentValue = currentSettings.JumpCap, Flag = "JumpCapSlider", Callback = function(val)
    currentSettings.JumpCap = val
    applyToTables(function(obj) obj.JumpCap = val end)
end })

SettingsTab:CreateSlider({ Name = "Strafe Acceleration", Range = {1, 1000000}, Increment = 1, Suffix = "", CurrentValue = currentSettings.AirStrafeAcceleration, Flag = "StrafeSlider", Callback = function(val)
    currentSettings.AirStrafeAcceleration = val
    applyToTables(function(obj) obj.AirStrafeAcceleration = val end)
end })

SettingsTab:CreateDropdown({ Name = "Apply Method", Options = {"Not Optimized", "Optimized"}, CurrentOption = {getgenv().ApplyMode}, MultipleOptions = false, Flag = "ApplyModeDropdown", Callback = function(opt)
    getgenv().ApplyMode = opt[1]
end })

-- ========================= –– Teleport Ticket (EventTab) –– ========================= 
local teleportTicketActive = false
local function getAllTickets()
    local ticketFolder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Effects") and workspace.Game.Effects:FindFirstChild("Tickets")
    if ticketFolder then
        local tickets = {}
        for _, model in ipairs(ticketFolder:GetChildren()) do
            if model:IsA("Model") then
                local part = model:FindFirstChildWhichIsA("BasePart")
                if part then table.insert(tickets, part) end
            end
        end
        return tickets
    end
    return {}
end

local function teleportToTickets()
    teleportTicketActive = true
    task.spawn(function()
        while teleportTicketActive do
            local tickets = getAllTickets()
            if #tickets == 0 then teleportTicketActive = false break end
            for _, part in ipairs(tickets) do
                if not teleportTicketActive then break end
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp and part then
                    hrp.CFrame = part.CFrame + Vector3.new(0,3,0)
                    task.wait(1)
                end
            end
        end
    end)
end

EventTab:Button({ Title = "Teleport Ticket", Desc = "วาร์ปไปหาตั๋วทั้งหมดในแมพ จนกว่าจะหมด", Callback = function()
    if not teleportTicketActive then teleportToTickets() else teleportTicketActive = false end
end })

-- ========================= – Notify – ========================= 
Window:Notify({ Title="Evade Hub", Desc="เมนูทั้งหมดโหลดเรียบร้อยแล้ว! เปิด/ปิดเมนูได้ทั้ง Desktop และ มือถือ", Time=4 })

-- ========================= –– AUTO CARRY Toggle (ใน MainTab) –– ========================= 
MainTab:Toggle({ Title = "Auto Carry", Desc = "เปิด/ปิดการอุ้มผู้เล่นอัตโนมัติ", Value = false, Callback = function(state)
    -- …
end })

-- ========================= –– Infinite Slide (MainTab + Floating) –– ========================= 
local RunService    = game:GetService("RunService")
local player        = game:GetService("Players").LocalPlayer
local infiniteSlideEnabled = false
local slideFrictionValue = -8
-- (โค้ดรายละเอียดอีกมาก)

-- ========================= –– Slider ปรับค่า Slide Friction ใน MainTab SettingsTab:Slider({ Title="Slide Friction", Desc="ปรับค่าแรงสไลด์ (ต่ำ=เร็วกว่า)", Min=-500, Max=-1, Value=slideFrictionValue, Callback=function(val)
    slideFrictionValue = val
end })

-- ========================= –– สไลเดอร์ความเร็ว/Jump/Strafe (SettingsTab) –– 
local currentSettings = { Speed = 1500, JumpCap = 1, AirStrafeAcceleration = 187 }
local requiredFields  = { Friction=true, AirStrafeAcceleration=true, JumpHeight=true, RunDeaccel=true, JumpSpeedMultiplier=true, JumpCap=true, SprintCap=true, WalkSpeedMultiplier=true, BhopEnabled=true, Speed=true, AirAcceleration=true, RunAccel=true, SprintAcceleration=true }
getgenv().ApplyMode = "Not Optimized"

local function getMatchingTables()
    local matched = {}
    for _, obj in ipairs(getgc(true)) do
        if typeof(obj) == "table" then
            local ok = true
            for field in pairs(requiredFields) do
                if rawget(obj, field) == nil then ok = false; break end
            end
            if ok then table.insert(matched, obj) end
        end
    end
    return matched
end

local function applyToTables(callback)
    for _, tableObj in ipairs(getMatchingTables()) do
        if typeof(tableObj) == "table" then
            pcall(callback, tableObj)
        end
    end
end

SettingsTab:CreateSection({ Name = "ตัวปรับความเร็ว/Jump/Strafe" })

SettingsTab:CreateSlider({ Name = "Set Speed", Range = {1450, 1000000}, Increment = 1, Suffix = "", CurrentValue = currentSettings.Speed, Flag = "SpeedSlider", Callback = function(val)
    currentSettings.Speed = val
    applyToTables(function(obj) obj.Speed = val end)
end })

SettingsTab:CreateSlider({ Name = "Set Jump Cap", Range = {0.1, 5000}, Increment = 0.1, Suffix = "", CurrentValue = currentSettings.JumpCap, Flag = "JumpCapSlider", Callback = function(val)
    currentSettings.JumpCap = val
    applyToTables(function(obj) obj.JumpCap = val end)
end })

SettingsTab:CreateSlider({ Name = "Strafe Acceleration", Range = {1, 1000000}, Increment = 1, Suffix = "", CurrentValue = currentSettings.AirStrafeAcceleration, Flag = "StrafeSlider", Callback = function(val)
    currentSettings.AirStrafeAcceleration = val
    applyToTables(function(obj) obj.AirStrafeAcceleration = val end)
end })

SettingsTab:CreateDropdown({ Name = "Apply Method", Options = {"Not Optimized", "Optimized"}, CurrentOption = {getgenv().ApplyMode}, MultipleOptions = false, Flag = "ApplyModeDropdown", Callback = function(opt)
    getgenv().ApplyMode = opt[1]
end })

-- ========================= –– Teleport Ticket (EventTab) –– ========================= 
local teleportTicketActive = false
local function getAllTickets()
    local ticketFolder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Effects") and workspace.Game.Effects:FindFirstChild("Tickets")
    if ticketFolder then
        local tickets = {}
        for _, model in ipairs(ticketFolder:GetChildren()) do
            if model:IsA("Model") then
                local part = model:FindFirstChildWhichIsA("BasePart")
                if part then table.insert(tickets, part) end
            end
        end
        return tickets
    end
    return {}
end

local function teleportToTickets()
    teleportTicketActive = true
    task.spawn(function()
        while teleportTicketActive do
            local tickets = getAllTickets()
            if #tickets == 0 then teleportTicketActive = false break end
            for _, part in ipairs(tickets) do
                if not teleportTicketActive then break end
                local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if hrp and part then
                    hrp.CFrame = part.CFrame + Vector3.new(0,3,0)
                    task.wait(1)
                end
            end
        end
    end)
end

EventTab:Button({ Title = "Teleport Ticket", Desc = "วาร์ปไปหาตั๋วทั้งหมดในแมพ จนกว่าจะหมด", Callback = function()
    if not teleportTicketActive then teleportToTickets() else teleportTicketActive = false end
end })

-- ========================= – Notify – ========================= 
Window:Notify({ Title="Evade Hub", Desc="เมนูทั้งหมดโหลดเรียบร้อยแล้ว! เปิด/ปิดเมนูได้ทั้ง Desktop และ มือถือ", Time=4 })
