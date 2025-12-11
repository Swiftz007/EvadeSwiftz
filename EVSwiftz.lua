-- Load UI Library
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x2zu/OPEN-SOURCE-UI-ROBLOX/refs/heads/main/X2ZU%20UI%20ROBLOX%20OPEN%20SOURCE/DummyUi-leak-by-x2zu/fetching-main/Tools/Framework.luau"))()

-- Main Window
local Window = Library:Window({
Title = "Swiftz Hub",
Desc = "Swiftz Hub on top",
Icon = 105059922903197,
Theme = "Dark",
Config = { Keybind = Enum.KeyCode.LeftControl, Size = UDim2.new(0,500,0,400) },
CloseUIButton = { Enabled=true, Text="Swiftz Hub" }
})

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
local EventTab    = Window:Tab({Title="อีเว้น", Icon="calendar"})

-- Player & GUI
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local PlayerGui = player:WaitForChild("PlayerGui")

-- Floating GUI
local FloatingGui = PlayerGui:FindFirstChild("SwiftzFloatingGui")
if not FloatingGui then
FloatingGui = Instance.new("ScreenGui")
FloatingGui.Name = "SwiftzFloatingGui"
FloatingGui.Parent = PlayerGui
FloatingGui.ResetOnSpawn = false
FloatingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

-- Auto Bhop (No Ground Touch)
local autoBhop = false
local floatingBhopButton

-- ปุ่มลอย
local function createBhopFloatingButton()
    if floatingBhopButton then return end
    floatingBhopButton = Instance.new("TextButton")
    floatingBhopButton.Size = UDim2.new(0,120,0,50)
    floatingBhopButton.Position = UDim2.new(0.3,-60,0.8,0)
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
        floatingBhopButton=nil
    end
end

-- Toggle ปกติใน MainTab
MainTab:Toggle({
    Title="ออโต้กระโดด (ปกติ)",
    Desc="เด้งขึ้นอัตโนมัติแบบไม่แตะพื้น",
    Value=false,
    Callback=function(state)
        autoBhop = state
    end
})

-- Toggle ปุ่มลอย
MainTab:Toggle({
    Title="ออโต้กระโดด (ปุ่มลอย)",
    Desc="แสดงปุ่มลอยสำหรับ Auto Bhop",
    Value=false,
    Callback=function(state)
        if state then createBhopFloatingButton() else removeBhopFloatingButton(); autoBhop=false end
    end
})

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
                    local rayDir = Vector3.new(0, -rayDistance, 0)
                    local ray = Ray.new(rayOrigin, rayDir)
                    local hit, pos = workspace:FindPartOnRay(ray, char)

                    if hit then
                        -- กระโดดทันทีเพื่อไม่ให้แตะพื้น
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end
    end
end)

-- =========================
-- Lag Switch
-- =========================
local floatingLagButton
local function lagSwitch(duration)
local start = tick()
while tick()-start < duration do
for i=1,1e7 do local a=math.random() end
end
end

MainTab:Button({
Title="Lag Switch (ปกติ)",
Desc="กดแล้วค้างกระตุก 0.5 วินาที",
Callback=function() lagSwitch(0.5) end
})

local function createLagFloatingButton()
if floatingLagButton then return end
floatingLagButton = Instance.new("TextButton")
floatingLagButton.Size=UDim2.new(0,100,0,50)
floatingLagButton.Position=UDim2.new(0.7,-50,0.8,0)
floatingLagButton.AnchorPoint=Vector2.new(0.5,0)
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

MainTab:Toggle({
Title="Lag Switch (ปุ่มลอย)",
Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Lag Switch",
Value=false,
Callback=function(state)
if state then createLagFloatingButton() else removeLagFloatingButton() end
end
})

-- =========================
-- Auto Bounce (แม่นยำสูง)
-- =========================
local autoBounce = false
local floatingBounceButton
local bouncePower = 100 -- ความแรงการเด้ง
local groundCheckDistance = 6 -- ระยะเช็คใกล้พื้น (studs)

task.spawn(function()
    local RunService = game:GetService("RunService")
    while true do
        if autoBounce then
            local char = player.Character
            if char then
                local root = char:FindFirstChild("HumanoidRootPart")
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
MainTab:Toggle({
    Title="ออโต้เด้ง (ปกติ)",
    Desc="เด้งอัตโนมัติเมื่อกำลังตกและใกล้พื้น (แม่นยำกว่าเดิม)",
    Value=false,
    Callback=function(state) autoBounce = state end
})

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

MainTab:Toggle({
    Title="ออโต้เด้ง (ปุ่มลอย)",
    Desc="แสดงปุ่มลอยสำหรับ Auto Bounce (แม่นยำกว่าเดิม)",
    Value=false,
    Callback=function(state)
        if state then createBounceFloatingButton() else
            if floatingBounceButton then floatingBounceButton:Destroy(); floatingBounceButton=nil end
            autoBounce=false
        end
    end
})

-- Auto Respawn (Fake Revive)
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
    floatingRespawnButton.Parent = FloatingGui -- ต้องมี FloatingGui ในเกม
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
                if hrp then
                    character:SetAttribute("LastPosition", hrp.Position)
                end
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

-- =========================
-- ปุ่มปกติใน MainTab
-- =========================
MainTab:Toggle({
    Title="ออโต้รีสปอน (ปกติ)",
    Desc="Respawn อัตโนมัติจนกว่าจะปิด",
    Value=false,
    Callback=function(state)
        getgenv().AutoRespawnEnabled = state

        if respawnConnection then
            respawnConnection:Disconnect()
            respawnConnection = nil
        end

        if state then
            -- เรียก setupAutoRevive สำหรับตัวละครปัจจุบัน
            if player.Character then setupAutoRevive(player.Character) end
        end
    end
})

-- =========================
-- Dropdown: วิธีรีสปอน
-- =========================
MainTab:Dropdown({
    Title="วิธีรีสปอน",
    Options={"Random","Fake Revive"},
    CurrentOption={autoRespawnMethod},
    MultipleOptions=false,
    Callback=function(opt)
        autoRespawnMethod = opt[1]
    end
})

-- =========================
-- ปุ่มลอย
-- =========================
MainTab:Toggle({
    Title="ออโต้รีสปอน (ปุ่มลอย)",
    Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Auto Respawn",
    Value=false,
    Callback=function(state)
        if state then createRespawnFloatingButton() else
            removeRespawnFloatingButton()
            getgenv().AutoRespawnEnabled = false
        end
    end
})

-- =========================
-- Teleport Roof
-- =========================
local floatingTPButton
local function teleportRoof()
local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
if root then root.CFrame += Vector3.new(0,500,0) end
end

TeleportTab:Button({
Title="เทเลพอร์ตขึ้นหลังคา (ปกติ)",
Desc="กดเพื่อขึ้นหลังคา",
Callback=teleportRoof
})

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

TeleportTab:Toggle({
Title="เทเลพอร์ตขึ้นหลังคา (ปุ่มลอย)",
Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Teleport Roof",
Value=false,
Callback=function(state)
if state then createTPFloatingButton() else
if floatingTPButton then floatingTPButton:Destroy(); floatingTPButton=nil end
end
end
})

-- =============================
-- Anti AFK Ultimate
-- =============================

local player = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

local AFKPart
local AFKActive = false

local function createAFKPart()
	if AFKPart then return AFKPart end

	AFKPart = Instance.new("Part")
	AFKPart.Anchored = true
	AFKPart.Size = Vector3.new(40,1,40)  -- ใหญ่ ไม่ตก
	AFKPart.Position = Vector3.new(0,1300,0)
	AFKPart.Color = Color3.fromRGB(255, 255, 0)
	AFKPart.Parent = workspace

	return AFKPart
end


local function walkFor(sec, dirVector)
	local char = player.Character
	if not char then return end
	local hum = char:FindFirstChildWhichIsA("Humanoid")
	if not hum then return end
	
	local stopTime = time() + sec
	RunService:BindToRenderStep("AFKMove", Enum.RenderPriority.Character.Value, function()
		hum:Move(dirVector, true)
	end)

	repeat task.wait() until time() > stopTime
	RunService:UnbindFromRenderStep("AFKMove")
	hum:Move(Vector3.new(), true)
end


local function afkLoop()
	task.spawn(function()

		-- หมุนกล้องช้า ๆ กัน AFK
		local cam = workspace.CurrentCamera

		while AFKActive do

			local char = player.Character or player.CharacterAdded:Wait()
			local root = char:WaitForChild("HumanoidRootPart")

			-- เทเลพอร์ตขึ้นบน Part
			local p = createAFKPart()
			root.CFrame = p.CFrame + Vector3.new(0,3,0)


			-- เดินหน้า 1 วิ
			walkFor(1, Vector3.new(0,0,-1))

			-- รอ 1 วิ
			task.wait(1)

			-- เดินถอยหลัง 1 วิ
			walkFor(1, Vector3.new(0,0,1))

			-- หมุนกล้องนิดนึง
			if cam then
				cam.CFrame = cam.CFrame * CFrame.Angles(0, math.rad(1), 0)
			end

			-- บางรอบกระโดด  (กัน Idle movement)
			if math.random(1,5) == 1 then
				local hum = char:FindFirstChildWhichIsA("Humanoid")
				if hum then hum.Jump = true end
			end

			task.wait(2)
		end

	end)
end


TeleportTab:Button({
	Title="AFK Money-Level (Anti-Kick)",
	Desc="เดิน หน้า/หลัง + หมุนกล้อง + กระโดด กันเตะ",
	Callback=function()
		AFKActive = not AFKActive
		if AFKActive then
			afkLoop()
		end
	end
})

-- =========================
-- Teleport to Dead Player 1s
-- =========================
local floatingDeadTPButton
local function teleportToDead()
local char = player.Character
if not char then return end
local root = char:FindFirstChild("HumanoidRootPart")
if not root then return end
local deadPlayer=nil
for _,plr in pairs(Players:GetPlayers()) do
local h = plr.Character and plr.Character:FindFirstChildOfClass("Humanoid")
if h and h.Health==0 then
deadPlayer=plr
break
end
end
if deadPlayer and deadPlayer.Character and deadPlayer.Character:FindFirstChild("HumanoidRootPart") then
local originalCFrame=root.CFrame
root.CFrame = deadPlayer.Character.HumanoidRootPart.CFrame
task.wait(1)
root.CFrame=originalCFrame
end
end

TeleportTab:Button({
Title="ไปหาผู้เล่นที่ล้ม (ปกติ)",
Desc="วาร์ปไปผู้เล่นที่ล้ม 1 วินาที",
Callback=teleportToDead
})

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

TeleportTab:Toggle({
Title="ไปหาผู้เล่นที่ล้ม (ปุ่มลอย)",
Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Dead TP",
Value=false,
Callback=function(state)
if state then createDeadTPFloatingButton() else
if floatingDeadTPButton then floatingDeadTPButton:Destroy(); floatingDeadTPButton=nil end
end
end
})

-- =========================
-- Wall Hack (ทะลุกำแพงด้านหน้า/ด้านข้างจริง)
-- =========================
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
                    local origin = root.Position
                    local forwardDir = root.CFrame.LookVector -- ด้านหน้าตัวละคร
                    for _, part in pairs(workspace:GetDescendants()) do
                        if part:IsA("BasePart") then
                            local toPart = part.Position - origin
                            local forwardDist = forwardDir:Dot(toPart)
                            local horizontalDist = (Vector3.new(toPart.X,0,toPart.Z)).Magnitude
                            local verticalDist = toPart.Y
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
ExtraTab:Button({
    Title="Wall Hack (ปกติ)",
    Desc="ทะลุกำแพงด้านหน้า/ด้านข้างจริง",
    Callback=toggleWallHack
})

-- ปุ่มลอย
ExtraTab:Toggle({
    Title="Wall Hack (ปุ่มลอย)",
    Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Wall Hack",
    Value=false,
    Callback=function(state)
        if state then
            createWallFloatingButton()
        else
            if floatingWallButton then
                floatingWallButton:Destroy()
                floatingWallButton = nil
            end
            setWallHack(false)
        end
    end
})

-- Teleport To Player (ปกติ + ลอย)
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
TeleportTab:Button({
Title="TeleTo Player (ปกติ)",
Desc="เลือกผู้เล่นแล้วเทเลพอร์ตไปหา",
Callback=createTPPlayerMenu
})

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

TeleportTab:Toggle({
Title="TP To Player (ปุ่มลอย)",
Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ TP To Player",
Value=false,
Callback=function(state)
if state then createFloatingTPPlayerButton() else
if floatingTPPlayerButton then floatingTPPlayerButton:Destroy(); floatingTPPlayerButton=nil end
end
end
})

-- =========================
-- Moon Mode (ปุ่มปกติ + ปุ่มลอย)
-- =========================
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
local root = char:FindFirstChild("HumanoidRootPart")
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

ExtraTab:Button({
Title="Moon Mode (ปกติ)",
Desc="ตกช้าๆจากที่สูง โดยไม่แข็งตัว",
Callback=toggleMoonMode
})

ExtraTab:Toggle({
Title="Moon Mode (ปุ่มลอย)",
Desc="แสดงปุ่มลอยบนหน้าจอสำหรับ Moon Mode",
Value=false,
Callback=function(state)
if state then createMoonFloatingButton() else
if floatingMoonButton then floatingMoonButton:Destroy(); floatingMoonButton=nil end
moonModeActive=false
end
end
})

-- Extra Tab - Run External Script
ExtraTab:Button({
Title = "Run External Script",
Desc = "กดเพื่อรันสคริปต์จาก Pastebin",
Callback = function()
local success, err = pcall(function()
loadstring(game:HttpGet("https://pastebin.com/raw/GHDdPh2c"))()
end)
if not success then
warn("เกิดข้อผิดพลาดในการรันสคริปต์: "..tostring(err))
end
end
})

-- Player ESP (Visuals)
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
    label.Size = UDim2.new(1,0,1,0)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(255,255,255)
    label.TextStrokeTransparency = 0
    label.Font = Enum.Font.SourceSansBold
    label.TextScaled = true
    label.Text = targetPlayer.Name
    label.Parent = billboard

    -- Box รอบตัว
    local box = Instance.new("BoxHandleAdornment")
    box.Adornee = root
    box.Size = root.Size
    box.Color = BrickColor.new("White")
    box.AlwaysOnTop = true
    box.ZIndex = 5
    box.Parent = root

    ESPBoxes[targetPlayer] = {Billboard=billboard, Box=box}
end

local function removeESPForPlayer(targetPlayer)
    if ESPBoxes[targetPlayer] then
        if ESPBoxes[targetPlayer].Billboard then ESPBoxes[targetPlayer].Billboard:Destroy() end
        if ESPBoxes[targetPlayer].Box then ESPBoxes[targetPlayer].Box:Destroy() end
        ESPBoxes[targetPlayer] = nil
    end
end

local function togglePlayerESP(state)
    playerESPActive = state
    if state then
        for _, plr in pairs(Players:GetPlayers()) do
            createESPForPlayer(plr)
        end
    else
        for plr, _ in pairs(ESPBoxes) do
            removeESPForPlayer(plr)
        end
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

-- =========================
-- ปุ่มใน VisualsTab
-- =========================
VisualsTab:Toggle({
    Title="มองผู้เล่น",
    Desc="แสดงชื่อบนหัวและกรอบรอบลำตัว",
    Value=false,
    Callback=togglePlayerESP
})

-- =========================
-- Smooth Dash (แก้กระตุกกลางอากาศ)
-- =========================
local dashEnabled = false
local dashSpeed = 50 -- ความเร็วเริ่มต้น
local floatingDashButton
local dashVelocity = nil

-- ฟังก์ชันเปิด Dash
local function startDash()
    if dashVelocity then return end
    local char = player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    dashVelocity = Instance.new("BodyVelocity")
    dashVelocity.MaxForce = Vector3.new(400000, 0, 400000)
    dashVelocity.P = 1250
    dashVelocity.Parent = root

    -- อัปเดตทิศทางเรื่อย ๆ
    task.spawn(function()
        while dashEnabled and dashVelocity and dashVelocity.Parent do
            local cam = workspace.CurrentCamera
            if cam and root then
                local dir = cam.CFrame.LookVector
                dir = Vector3.new(dir.X, 0, dir.Z)
                if dir.Magnitude > 0 then dir = dir.Unit end
                dashVelocity.Velocity = dir * dashSpeed
            end
            task.wait(0.03)
        end
        if dashVelocity then
            dashVelocity:Destroy()
            dashVelocity = nil
        end
    end)
end

-- GUI Toggle
SettingsTab:Toggle({
    Title="Smooth Dash (ปกติ)",
    Desc="พุ่งตามมุมมองแบบลื่น ไม่กระตุก",
    Value=false,
    Callback=function(state)
        dashEnabled = state
        if state then
            startDash()
        elseif dashVelocity then
            dashVelocity:Destroy()
            dashVelocity = nil
        end
    end
})

-- TextBox ปรับความเร็ว
SettingsTab:Textbox({
    Title="Dash Speed",
    Desc="ปรับความเร็ว Dash",
    Placeholder=tostring(dashSpeed),
    Callback=function(txt)
        local num = tonumber(txt)
        if num then dashSpeed = num end
    end
})

-- ปุ่มลอย
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
        if dashEnabled then
            startDash()
        elseif dashVelocity then
            dashVelocity:Destroy()
            dashVelocity = nil
        end
    end)
end

SettingsTab:Toggle({
    Title="Smooth Dash (ปุ่มลอย)",
    Desc="แสดงปุ่มลอยสำหรับ Smooth Dash",
    Value=false,
    Callback=function(state)
        if state then
            createFloatingDashButton()
        else
            if floatingDashButton then
                floatingDashButton:Destroy()
                floatingDashButton = nil
            end
            dashEnabled = false
            if dashVelocity then
                dashVelocity:Destroy()
                dashVelocity = nil
            end
        end
    end
})

-- ปุ่ม มองตั๋ว (ESP Ticket)
EventTab:Toggle({
    Title = "มองตั๋ว (ESP Ticket)",
    Desc = "แสดงตำแหน่งตั๋วทั้งหมดในแมพ",
    Value = false,
    Callback = function(state)
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local ticketESPThread

        local function getDistance(pos)
            local char = LocalPlayer.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            return hrp and (pos - hrp.Position).Magnitude or nil
        end

        local function createESP(part)
            local billboard = Instance.new("BillboardGui")
            billboard.Name = "TicketESP"
            billboard.Adornee = part
            billboard.Size = UDim2.new(0, 180, 0, 25)
            billboard.StudsOffset = Vector3.new(0, 3.2, 0)
            billboard.AlwaysOnTop = true
            billboard.LightInfluence = 0
            billboard.Parent = part

            local label = Instance.new("TextLabel")
            label.Name = "Ticket"
            label.Size = UDim2.new(1, 0, 1, 0)
            label.BackgroundTransparency = 1
            label.TextStrokeTransparency = 0.25
            label.TextScaled = true
            label.Font = Enum.Font.GothamSemibold
            label.TextColor3 = Color3.fromRGB(255, 255, 150) -- สีเหลืองอ่อน
            label.Text = "Ticket"
            label.Parent = billboard

            return billboard
        end

        local function removeAllTicketESP()
            local ticketFolder = workspace:FindFirstChild("Game") 
                and workspace.Game:FindFirstChild("Effects") 
                and workspace.Game.Effects:FindFirstChild("Tickets")
            if ticketFolder then
                for _, ticketModel in ipairs(ticketFolder:GetChildren()) do
                    if ticketModel:IsA("Model") then
                        local part = ticketModel:FindFirstChildWhichIsA("BasePart")
                        if part then
                            local existing = part:FindFirstChild("TicketESP")
                            if existing then existing:Destroy() end
                        end
                    end
                end
            end
        end

        if state then
            -- เปิดระบบ ESP
            ticketESPThread = task.spawn(function()
                while state do
                    local ticketFolder = workspace:FindFirstChild("Game") 
                        and workspace.Game:FindFirstChild("Effects") 
                        and workspace.Game.Effects:FindFirstChild("Tickets")
                    if ticketFolder then
                        for _, ticketModel in ipairs(ticketFolder:GetChildren()) do
                            if ticketModel:IsA("Model") then
                                local part = ticketModel:FindFirstChildWhichIsA("BasePart")
                                if part then
                                    local billboard = part:FindFirstChild("TicketESP") or createESP(part)
                                    local label = billboard and billboard:FindFirstChild("Ticket")
                                    if label then
                                        local dist = getDistance(part.Position)
                                        if dist then
                                            label.Text = string.format("%s\n%.0f studs", ticketModel.Name, dist)
                                        else
                                            label.Text = ticketModel.Name
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
        else
            -- ปิดระบบ ESP
            removeAllTicketESP()
        end
    end
})

-- ปุ่ม มองเน็กบอท (ESP Nextbot)
VisualsTab:Button({
    Title = "มองบอท",
    Desc = "ESP Nextbot",
    Callback = function()
        local LocalPlayer = game:GetService("Players").LocalPlayer

        -- เช็คว่าเปิดอยู่หรือไม่
        if _G.NextbotESPEnabled then
            -- ปิด ESP
            _G.NextbotESPEnabled = false
            if _G.NextbotESPThread and coroutine.status(_G.NextbotESPThread) ~= "dead" then
                coroutine.close(_G.NextbotESPThread)
                _G.NextbotESPThread = nil
            end

            -- ลบ ESP ทุกอัน
            local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
            if folder then
                for _, npc in ipairs(folder:GetChildren()) do
                    local part = (npc:IsA("Model") and (npc:FindFirstChild("Root") or npc:FindFirstChild("Head") or npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart"))) or nil
                    if part then
                        local esp = part:FindFirstChild("NextbotESP")
                        if esp then esp:Destroy() end
                    end
                end
            end

            print("🛑 ESP Nextbot ปิดแล้ว")
        else
            -- เปิด ESP
            _G.NextbotESPEnabled = true

            _G.NextbotESPThread = coroutine.create(function()
                while _G.NextbotESPEnabled do
                    local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
                    if folder then
                        for _, npc in ipairs(folder:GetChildren()) do
                            if npc:GetAttribute("Team") == "Nextbot" then
                                local part = (npc:IsA("Model") and (npc:FindFirstChild("Root") or npc:FindFirstChild("Head") or npc:FindFirstChild("HumanoidRootPart") or npc:FindFirstChildWhichIsA("BasePart"))) or nil
                                if part then
                                    local billboard = part:FindFirstChild("NextbotESP")
                                    if not billboard then
                                        billboard = Instance.new("BillboardGui")
                                        billboard.Name = "NextbotESP"
                                        billboard.Adornee = part
                                        billboard.Size = UDim2.new(0, 180, 0, 25)
                                        billboard.StudsOffset = Vector3.new(0, 3.2, 0)
                                        billboard.AlwaysOnTop = true
                                        billboard.LightInfluence = 0
                                        billboard.Parent = part

                                        local label = Instance.new("TextLabel")
                                        label.Name = "Label"
                                        label.Size = UDim2.new(1, 0, 1, 0)
                                        label.BackgroundTransparency = 1
                                        label.TextStrokeTransparency = 0.25
                                        label.TextScaled = true
                                        label.Font = Enum.Font.GothamSemibold
                                        label.TextColor3 = Color3.fromRGB(255, 255, 255)
                                        label.Parent = billboard
                                    end

                                    local label = billboard:FindFirstChild("Label")
                                    if label then
                                        local hrp = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                                        local dist = hrp and (part.Position - hrp.Position).Magnitude or nil
                                        if dist then
                                            label.Text = string.format("%s\n%.0f studs", npc.Name, dist)
                                            -- กำหนดสีตามระยะทาง
                                            if dist <= 12 then
                                                label.TextColor3 = Color3.fromRGB(50, 50, 50)
                                            elseif dist <= 60 then
                                                local t = (dist - 6) / 14
                                                label.TextColor3 = Color3.fromRGB(255, 120 + (255 - 120) * t, 120)
                                            else
                                                label.TextColor3 = Color3.fromRGB(200, 150, 255)
                                            end
                                        else
                                            label.Text = npc.Name
                                            label.TextColor3 = Color3.fromRGB(255, 255, 255)
                                        end
                                    end
                                end
                            end
                        end
                    end
                    task.wait(0.5)
                end
            end)
            coroutine.resume(_G.NextbotESPThread)
            print("✅ ESP Nextbot เปิดแล้ว")
        end
    end
})

-- =========================
-- ปุ่มแสดง FPS
-- =========================
FPSTab:Button({
    Title = "แสดง FPS",
    Desc = "กดเพื่อเปิด/ปิดการแสดง FPS",
    Callback = function()
        local player = game.Players.LocalPlayer
        local playerGui = player:WaitForChild("PlayerGui")

        -- ตรวจสอบว่ามีอยู่แล้วไหม
        local existingGui = playerGui:FindFirstChild("FPSGui")
        if existingGui then
            existingGui:Destroy()
            return
        end

        -- สร้าง ScreenGui
        local fpsGui = Instance.new("ScreenGui")
        fpsGui.Name = "FPSGui"
        fpsGui.ResetOnSpawn = false
        fpsGui.Parent = playerGui

        -- กรอบแสดง FPS
        local frame = Instance.new("Frame")
        frame.Size = UDim2.new(0, 200, 0, 100)
        frame.Position = UDim2.new(1, -210, 0, 10) -- มุมบนขวา
        frame.BackgroundTransparency = 0.5
        frame.BackgroundColor3 = Color3.fromRGB(0,0,0)
        frame.Parent = fpsGui

        -- Label FPS ของเรา
        local fpsLabel = Instance.new("TextLabel")
        fpsLabel.Size = UDim2.new(1, -10, 0, 30)
        fpsLabel.Position = UDim2.new(0, 5, 0, 5)
        fpsLabel.BackgroundTransparency = 1
        fpsLabel.TextColor3 = Color3.fromRGB(255,255,255)
        fpsLabel.TextScaled = true
        fpsLabel.Font = Enum.Font.GothamSemibold
        fpsLabel.Text = "FPS: 0"
        fpsLabel.Parent = frame

        -- Label สำหรับผู้เล่นอื่น
        local othersLabel = Instance.new("TextLabel")
        othersLabel.Size = UDim2.new(1, -10, 1, -40)
        othersLabel.Position = UDim2.new(0, 5, 0, 35)
        othersLabel.BackgroundTransparency = 1
        othersLabel.TextColor3 = Color3.fromRGB(180,180,255)
        othersLabel.TextScaled = true
        othersLabel.Font = Enum.Font.GothamSemibold
        othersLabel.Text = "Players FPS:"
        othersLabel.TextWrapped = true
        othersLabel.TextYAlignment = Enum.TextYAlignment.Top
        othersLabel.Parent = frame

        -- อัปเดต FPS
        local lastTime = tick()
        local frameCount = 0
        local runService = game:GetService("RunService")

        runService.RenderStepped:Connect(function()
            frameCount += 1
            local now = tick()
            if now - lastTime >= 1 then
                fpsLabel.Text = "FPS: " .. frameCount
                frameCount = 0
                lastTime = now

                -- อัปเดต FPS ของผู้เล่นอื่น (จำลองตัวอย่าง)
                local players = game.Players:GetPlayers()
                local otherText = "Players FPS:\n"
                for _, p in pairs(players) do
                    if p ~= player then
                        otherText = otherText .. p.Name .. ": ?\n" -- จริง ๆ ต้องมีระบบเก็บ FPS ของแต่ละคน
                    end
                end
                othersLabel.Text = otherText
            end
        end)
    end
})

-- =========================
-- ปุ่ม Teleport
-- =========================
local teleportEnabled = false
local floatingTeleportButton

-- ฟังก์ชันเปิด Teleport Mode
local function startTeleport()
    local UIS = game:GetService("UserInputService")
    local player = game.Players.LocalPlayer
    local mouse = player:GetMouse()

    local function onClick()
        if teleportEnabled then
            local targetPos = mouse.Hit.Position + Vector3.new(0, 3, 0) -- ยกขึ้นเล็กน้อย
            local char = player.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    hrp.CFrame = CFrame.new(targetPos)
                end
            end
        end
    end

    -- เชื่อม Event
    local clickConnection = mouse.Button1Down:Connect(onClick)
    
    -- คืนค่าปิด
    return clickConnection
end

local teleportConnection

-- =========================
-- ปุ่มปกติในหมวด Teleport
TeleportTab:Toggle({
    Title = "คริป Teleport",
    Desc  = "กดเพื่อเปิด/ปิด Teleport Mode",
    Value = false,
    Callback = function(state)
        teleportEnabled = state
        if state then
            teleportConnection = startTeleport()
        elseif teleportConnection then
            teleportConnection:Disconnect()
            teleportConnection = nil
        end
    end
})

-- =========================
-- ปุ่มลอย
local function createFloatingTeleportButton()
    if floatingTeleportButton then return end

    floatingTeleportButton = Instance.new("TextButton")
    floatingTeleportButton.Size = UDim2.new(0, 140, 0, 50)
    floatingTeleportButton.Position = UDim2.new(0.5, -70, 0.4, 0)
    floatingTeleportButton.AnchorPoint = Vector2.new(0.5, 0)
    floatingTeleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    floatingTeleportButton.TextColor3 = Color3.fromRGB(255,255,255)
    floatingTeleportButton.Text = teleportEnabled and "Teleport: ON" or "Teleport: OFF"
    floatingTeleportButton.Parent = FloatingGui
    floatingTeleportButton.Active = true
    floatingTeleportButton.Draggable = true

    floatingTeleportButton.MouseButton1Click:Connect(function()
        teleportEnabled = not teleportEnabled
        floatingTeleportButton.Text = teleportEnabled and "Teleport: ON" or "Teleport: OFF"
        if teleportEnabled then
            teleportConnection = startTeleport()
        elseif teleportConnection then
            teleportConnection:Disconnect()
            teleportConnection = nil
        end
    end)
end

-- ปุ่ม Toggle สำหรับลอย
TeleportTab:Toggle({
    Title = "คริป Teleport (ปุ่มลอย)",
    Desc  = "แสดงปุ่มลอยสำหรับ Teleport",
    Value = false,
    Callback = function(state)
        if state then
            createFloatingTeleportButton()
        else
            if floatingTeleportButton then
                floatingTeleportButton:Destroy()
                floatingTeleportButton = nil
            end
            teleportEnabled = false
            if teleportConnection then
                teleportConnection:Disconnect()
                teleportConnection = nil
            end
        end
    end
})

-- =========================
-- ปุ่ม Reduce Graphics V.1
-- =========================
FPSTab:Button({
    Title = "ลดกราฟฟิก V.1",
    Desc  = "ทุก Part เรียบเนียน",
    Callback = function()
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            end
        end
        print("✅ ลดกราฟฟิก V.1 เรียบร้อย")
    end
})

-- =========================
-- ปุ่ม Reduce Graphics V.2
-- =========================
FPSTab:Button({
    Title = "ลดกราฟฟิก V.2",
    Desc  = "เรียบเนียน + ลบหมอกและเอฟเฟกต์",
    Callback = function()
        -- เรียบเนียนเหมือน V.1
        for _, obj in ipairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") then
                obj.Material = Enum.Material.SmoothPlastic
                obj.Reflectance = 0
            elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
                obj.Enabled = false
            elseif obj:IsA("Decal") or obj:IsA("Texture") then
                obj:Destroy()
            end
        end

        -- ลบหมอก/เอฟเฟกต์จาก Lighting
        local Lighting = game:GetService("Lighting")
        Lighting.FogEnd = 100000
        Lighting.FogStart = 0
        Lighting.GlobalShadows = false
        print("✅ ลดกราฟฟิก V.2 เรียบร้อย")
    end
})

-- =========================
-- ปุ่ม เพิ่มแสงหน้าจอ
-- =========================
FPSTab:Button({
    Title = "เพิ่มแสงหน้าจอ",
    Desc  = "หน้าจอสว่างขึ้นเล็กน้อย",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.Brightness = (Lighting.Brightness or 2) + 1 -- เพิ่มทีละ 1
        print("✅ เพิ่มแสงเรียบร้อย")
    end
})

-- =========================
-- AUTO TICKET FARM (EventTab)
-- =========================
EventTab:Toggle({
    Title = "Auto Ticket Farm",
    Desc = "เก็บตั๋วอัตโนมัติทั้งเซิร์ฟ",
    Value = false,
    Callback = function(state)
        getgenv().AutoTicketFarm = state
        if state then
            task.spawn(function()
                while getgenv().AutoTicketFarm do
                    task.wait(0.1)
                    if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                        local hrp = player.Character.HumanoidRootPart
                        local ticketsFolder = workspace:FindFirstChild("Game") 
                                             and workspace.Game:FindFirstChild("Effects") 
                                             and workspace.Game.Effects:FindFirstChild("Tickets")
                        if ticketsFolder then
                            for _, ticket in pairs(ticketsFolder:GetChildren()) do
                                if not getgenv().AutoTicketFarm then break end
                                local root = ticket:FindFirstChild("HumanoidRootPart")
                                if root then
                                    local pos = root.Position
                                    local downPos = CFrame.new(pos.X, pos.Y - 15, pos.Z)
                                    local upPos = CFrame.new(pos.X, pos.Y + 2, pos.Z)

                                    hrp.CFrame = downPos
                                    task.wait(0.15)
                                    hrp.CFrame = upPos
                                    task.wait(0.05)

                                    local success = false
                                    if game:GetService("ReplicatedStorage"):FindFirstChild("Events") 
                                       and game.ReplicatedStorage.Events:FindFirstChild("CollectTicket") then
                                        local ok, _ = pcall(function()
                                            game.ReplicatedStorage.Events.CollectTicket:FireServer(ticket)
                                        end)
                                        success = ok
                                    end

                                    local startTime = tick()
                                    repeat task.wait(0.05) until not ticket.Parent or tick() - startTime > 2
                                    if not ticket.Parent or success then
                                        hrp.CFrame = CFrame.new(pos.X, 1300, pos.Z)
                                        task.wait(0.3)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
})

-- SYSTEM: Auto Carry Logic
getgenv().autoCarryEnabled = false
getgenv().autoCarryConnection = nil

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local localPlayer = Players.LocalPlayer

-- ฟังก์ชันเริ่มอุ้มแบบจริง
local function startAutoCarry()
    if getgenv().autoCarryConnection then return end

    getgenv().autoCarryConnection = RunService.Heartbeat:Connect(function()
        if not getgenv().autoCarryEnabled then return end

        local char = localPlayer.Character
        local hrp = char and char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= localPlayer and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                local otherHRP = plr.Character.HumanoidRootPart
                local dist = (hrp.Position - otherHRP.Position).Magnitude

                if dist <= 2 then
                    pcall(function()
                        ReplicatedStorage.Events.Character.Interact:FireServer("Carry", nil, plr.Name)
                    end)
                    task.wait(0.05)
                end
            end
        end
    end)
end

-- ฟังก์ชันหยุดอุ้ม
local function stopAutoCarry()
    if getgenv().autoCarryConnection then
        getgenv().autoCarryConnection:Disconnect()
        getgenv().autoCarryConnection = nil
    end
end


-- =========================
-- ปุ่มในเมนู MainTab
-- =========================
MainTab:Toggle({
    Title="Auto Carry",
    Desc="เปิด/ปิดการอุ้มผู้เล่นอัตโนมัติ",
    Value=false,
    Callback=function(state)
        getgenv().autoCarryEnabled = state

        if state then 
            startAutoCarry()
        else
            stopAutoCarry()
        end

        -- อัปเดตปุ่มลอยถ้ามี
        if getgenv().floatingCarryButton then
            getgenv().floatingCarryButton.Text = state and "Auto Carry: ON" or "Auto Carry: OFF"
            getgenv().floatingCarryButton.BackgroundColor3 =
                state and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        end
    end
})


-- =========================
-- ปุ่มลอย Floating Button
-- =========================
local PlayerGui = localPlayer:WaitForChild("PlayerGui")

local FloatingGui = PlayerGui:FindFirstChild("EvadeFloatingGui")
if not FloatingGui then
    FloatingGui = Instance.new("ScreenGui")
    FloatingGui.Name = "EvadeFloatingGui"
    FloatingGui.ResetOnSpawn = false
    FloatingGui.Parent = PlayerGui
end


local function createCarryFloatingButton()
    if getgenv().floatingCarryButton then
        getgenv().floatingCarryButton:Destroy()
        getgenv().floatingCarryButton = nil
        return
    end

    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0,150,0,50)
    btn.Position = UDim2.new(0.25,0,0.3,0)
    btn.BackgroundColor3 = getgenv().autoCarryEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Text = getgenv().autoCarryEnabled and "Auto Carry: ON" or "Auto Carry: OFF"
    btn.Parent = FloatingGui
    btn.Active = true
    btn.Draggable = true

    Instance.new("UICorner", btn).CornerRadius = UDim.new(0,12)
    local stroke = Instance.new("UIStroke", btn)
    stroke.Thickness = 3
    stroke.Color = Color3.new(1,1,1)

    getgenv().floatingCarryButton = btn

    btn.MouseButton1Click:Connect(function()
        getgenv().autoCarryEnabled = not getgenv().autoCarryEnabled

        if getgenv().autoCarryEnabled then
            startAutoCarry()
        else
            stopAutoCarry()
        end

        btn.Text = getgenv().autoCarryEnabled and "Auto Carry: ON" or "Auto Carry: OFF"
        btn.BackgroundColor3 =
            getgenv().autoCarryEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    end)
end


MainTab:Button({
    Title="ดึงปุ่ม Auto Carry",
    Desc="สร้าง/ลบปุ่มลอยอุ้มผู้เล่น",
    Callback=createCarryFloatingButton
})

-- =========================
-- Infinite Slide (MainTab + Floating)
-- =========================
local RunService = game:GetService("RunService")
local player = game:GetService("Players").LocalPlayer

-- ตัวแปรเก็บสถานะ
local infiniteSlideEnabled = false
local slideFrictionValue = -8
local cachedTables
local plrModel
local slideConnection
local floatingSlideButton

-- ฟังก์ชันช่วย
local keys = {
    "Friction","AirStrafeAcceleration","JumpHeight","RunDeaccel",
    "JumpSpeedMultiplier","JumpCap","SprintCap","WalkSpeedMultiplier",
    "BhopEnabled","Speed","AirAcceleration","RunAccel","SprintAcceleration"
}

local function hasAll(tbl)
    if type(tbl) ~= "table" then return false end
    for _, k in ipairs(keys) do if rawget(tbl, k) == nil then return false end end
    return true
end

local function setFriction(value)
    if not cachedTables then return end
    for _, t in ipairs(cachedTables) do
        pcall(function() t.Friction = value end)
    end
end

local function updatePlayerModel()
    local GameFolder = workspace:FindFirstChild("Game")
    local PlayersFolder = GameFolder and GameFolder:FindFirstChild("Players")
    if PlayersFolder then
        plrModel = PlayersFolder:FindFirstChild(player.Name)
    else
        plrModel = nil
    end
end

local function onHeartbeat()
    if not plrModel then setFriction(5); return end
    local success, currentState = pcall(function() return plrModel:GetAttribute("State") end)
    if success and currentState then
        if currentState == "Slide" then
            pcall(function() plrModel:SetAttribute("State", "EmotingSlide") end)
        elseif currentState == "EmotingSlide" then
            setFriction(slideFrictionValue)
        else
            setFriction(5)
        end
    else
        setFriction(5)
    end
end

-- ฟังก์ชันเปิด/ปิด Infinite Slide
local function toggleInfiniteSlide()
    infiniteSlideEnabled = not infiniteSlideEnabled

    if slideConnection then slideConnection:Disconnect(); slideConnection=nil end

    if infiniteSlideEnabled then
        cachedTables = {}
        for _, obj in ipairs(getgc(true)) do
            local success, result = pcall(function() if hasAll(obj) then return obj end end)
            if success and result then table.insert(cachedTables, result) end
        end
        updatePlayerModel()
        slideConnection = RunService.Heartbeat:Connect(onHeartbeat)
        player.CharacterAdded:Connect(function() wait(0.1); updatePlayerModel() end)
    else
        cachedTables = nil
        plrModel = nil
        setFriction(5)
    end

    -- อัปเดตปุ่มลอย
    if floatingSlideButton then
        floatingSlideButton.BackgroundColor3 = infiniteSlideEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
        floatingSlideButton.Text = infiniteSlideEnabled and "Infinite Slide: ON" or "Infinite Slide: OFF"
    end
end

-- =========================
-- ปุ่มปกติใน MainTab
MainTab:Toggle({
    Title="Infinite Slide",
    Desc="เปิด/ปิด Infinite Slide",
    Value=false,
    Callback=function(state)
        toggleInfiniteSlide()
    end
})

-- =========================
-- Slider ปรับค่า Slide Friction ใน MainTab
SettingsTab:Slider({
    Title="Slide Friction",
    Desc="ปรับค่าแรงสไลด์ (ต่ำ=เร็วกว่า)",
    Min=-500,
    Max=-1,
    Value=slideFrictionValue,
    Callback=function(val)
        slideFrictionValue = val
    end
})

-- =========================
-- ปุ่มลอยใน FloatingGui
local FloatingGui = PlayerGui:FindFirstChild("EvadeFloatingGui")
if not FloatingGui then
    FloatingGui = Instance.new("ScreenGui")
    FloatingGui.Name = "EvadeFloatingGui"
    FloatingGui.Parent = PlayerGui
    FloatingGui.ResetOnSpawn = false
    FloatingGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
end

local function createSlideFloatingButton()
    if floatingSlideButton then return end
    floatingSlideButton = Instance.new("TextButton")
    floatingSlideButton.Size = UDim2.new(0,150,0,50)
    floatingSlideButton.Position = UDim2.new(0.8,0,0.3,0)
    floatingSlideButton.AnchorPoint = Vector2.new(0.5,0.5)
    floatingSlideButton.BackgroundColor3 = infiniteSlideEnabled and Color3.fromRGB(0,200,0) or Color3.fromRGB(200,0,0)
    floatingSlideButton.TextColor3 = Color3.fromRGB(255,255,255)
    floatingSlideButton.Text = infiniteSlideEnabled and "Infinite Slide: ON" or "Infinite Slide: OFF"
    floatingSlideButton.TextScaled = true
    floatingSlideButton.Parent = FloatingGui
    floatingSlideButton.Active = true
    floatingSlideButton.Draggable = true
    Instance.new("UICorner", floatingSlideButton).CornerRadius = UDim.new(0,12)
    local border = Instance.new("UIStroke", floatingSlideButton)
    border.Thickness = 3
    border.Color = Color3.fromRGB(255,255,255)

    floatingSlideButton.MouseButton1Click:Connect(toggleInfiniteSlide)
end

MainTab:Button({
    Title="ดึงปุ่ม Infinite Slide",
    Desc="สร้างปุ่มลอยสำหรับ Infinite Slide",
    Callback=createSlideFloatingButton
})

-- =========================
-- ตัวแปรหลัก
-- =========================
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local currentSettings = {
    Speed = 1500,
    JumpCap = 1,
    AirStrafeAcceleration = 187
}

-- =========================
-- ฟังก์ชันค้นหา Table ที่ตรงเงื่อนไข
-- =========================
local requiredFields = {
    Friction=true, AirStrafeAcceleration=true, JumpHeight=true, RunDeaccel=true,
    JumpSpeedMultiplier=true, JumpCap=true, SprintCap=true, WalkSpeedMultiplier=true,
    BhopEnabled=true, Speed=true, AirAcceleration=true, RunAccel=true, SprintAcceleration=true
}

local function getMatchingTables()
    local matched = {}
    for _, obj in pairs(getgc(true)) do
        if typeof(obj) == "table" then
            local ok = true
            for field in pairs(requiredFields) do
                if rawget(obj, field) == nil then ok = false break end
            end
            if ok then
                table.insert(matched, obj)
            end
        end
    end
    return matched
end

-- ฟังก์ชันอัปเดตค่า
local function applyToTables()
    for _, tbl in ipairs(getMatchingTables()) do
        pcall(function()
            tbl.Speed = currentSettings.Speed
            tbl.JumpCap = currentSettings.JumpCap
            tbl.AirStrafeAcceleration = currentSettings.AirStrafeAcceleration
        end)
    end
end

-- =========================
-- สร้าง Slider ใน SettingsTab
-- =========================

-- Speed
SettingsTab:Slider({
    Title = "Speed",
    Min = 1450,
    Max = 1000000,
    Default = currentSettings.Speed,
    Callback = function(val)
        currentSettings.Speed = val
        applyToTables()
    end
})

-- JumpCap
SettingsTab:Slider({
    Title = "Jump Cap",
    Min = 0.1,
    Max = 5000,
    Default = currentSettings.JumpCap,
    Callback = function(val)
        currentSettings.JumpCap = val
        applyToTables()
    end
})

-- Strafe Acceleration
SettingsTab:Slider({
    Title = "Strafe Acceleration",
    Min = 200,
    Max = 1000000,
    Default = currentSettings.AirStrafeAcceleration,
    Callback = function(val)
        currentSettings.AirStrafeAcceleration = val
        applyToTables()
    end
})

-- Dropdown Apply Method
getgenv().ApplyMode = "Not Optimized"
SettingsTab:Dropdown({
    Title = "Apply Method",
    Options = {"Not Optimized", "Optimized"},
    Default = {getgenv().ApplyMode},
    MultipleOptions = false,
    Callback = function(option)
        getgenv().ApplyMode = option[1]
    end
})

-- =========================
-- อัปเดตทุกครั้งที่เกิดใหม่
-- =========================
player.CharacterAdded:Connect(function()
    task.wait(1)
    applyToTables()
end)

-- =========================
-- มองผู้เล่นที่ล้ม
-- =========================
local downedESPEnabled = false
local downedBillboards = {}

local function updateDownedESP()
    -- ลบของเก่า
    for plr, billboard in pairs(downedBillboards) do
        if billboard then billboard:Destroy() end
    end
    downedBillboards = {}

    if not downedESPEnabled then return end

    for _, plr in pairs(Players:GetPlayers()) do
        if plr ~= player and plr.Character then
            local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
            local root = plr.Character:FindFirstChild("HumanoidRootPart")
            if humanoid and root and humanoid.Health <= 0 then
                local billboard = Instance.new("BillboardGui")
                billboard.Name = "DownedESP"
                billboard.Adornee = root
                billboard.Size = UDim2.new(0, 150, 0, 50)
                billboard.StudsOffset = Vector3.new(0,3,0)
                billboard.AlwaysOnTop = true
                billboard.Parent = root

                local textLabel = Instance.new("TextLabel")
                textLabel.Size = UDim2.new(1,0,1,0)
                textLabel.BackgroundTransparency = 1
                textLabel.Text = "ล้ม"
                textLabel.TextColor3 = Color3.fromRGB(255,0,0)
                textLabel.TextScaled = true
                textLabel.Font = Enum.Font.GothamBlack
                textLabel.Parent = billboard

                downedBillboards[plr] = billboard
            end
        end
    end
end

-- อัพเดตทุก 0.5 วินาที
task.spawn(function()
    while true do
        if downedESPEnabled then
            updateDownedESP()
        else
            -- ลบ billboard ทุกอันถ้าไม่ได้เปิด
            for plr, billboard in pairs(downedBillboards) do
                if billboard then billboard:Destroy() end
            end
            downedBillboards = {}
        end
        task.wait(0.5)
    end
end)

-- Toggle ใน VisualsTab
VisualsTab:Toggle({
    Title="มองผู้เล่นที่ล้ม",
    Desc="แสดงข้อความ 'ล้ม' สีแดงเหนือหัวผู้เล่นที่มีเลือด 0",
    Value=false,
    Callback=function(state)
        downedESPEnabled = state
    end
})

EventTab:Button({
    Title = "เก็บตั๋วเรียบแมพ",
    Desc = "เทเลพอร์ตเก็บตั๋วทีละตัวจนหมด",
    Callback = function()
        local Players = game:GetService("Players")
        local LocalPlayer = Players.LocalPlayer
        local character = LocalPlayer.Character
        if not character then return end
        local hrp = character:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        local ticketFolder = workspace:FindFirstChild("Game")
            and workspace.Game:FindFirstChild("Effects")
            and workspace.Game.Effects:FindFirstChild("Tickets")
        if not ticketFolder then return end

        -- เริ่มเก็บตั๋ว
        task.spawn(function()
            while true do
                local tickets = {}
                for _, ticketModel in ipairs(ticketFolder:GetChildren()) do
                    if ticketModel:IsA("Model") then
                        local part = ticketModel:FindFirstChildWhichIsA("BasePart")
                        if part then
                            table.insert(tickets, part)
                        end
                    end
                end

                if #tickets == 0 then
                    break -- ถ้าไม่มีตั๋วแล้ว หยุด
                end

                for _, part in ipairs(tickets) do
                    if hrp and part then
                        -- เทเลพอร์ตไปที่ตั๋ว
                        hrp.CFrame = CFrame.new(part.Position + Vector3.new(0,3,0))
                        task.wait(1) -- รอเวลาเก็บ
                    end
                end
            end
        end)
    end
})

-- =========================
-- Recording & Smooth Playback
-- =========================
local ExtraTab = ExtraTab -- ใช้ tab ของของเสริม
local recording = false
local playing = false
local recordedFrames = {}
local recordStartTime = 0
local displayTimeLabel

local TweenService = game:GetService("TweenService")
local PlayerGui = player:WaitForChild("PlayerGui")

-- ฟังก์ชันอัปเดตเวลาบนหน้าจอ
local function updateTimeLabel()
    if not displayTimeLabel then
        displayTimeLabel = Instance.new("TextLabel")
        displayTimeLabel.Size = UDim2.new(0,150,0,50)
        displayTimeLabel.Position = UDim2.new(0.5,-75,0,50)
        displayTimeLabel.BackgroundTransparency = 0.5
        displayTimeLabel.BackgroundColor3 = Color3.fromRGB(0,0,0)
        displayTimeLabel.TextColor3 = Color3.fromRGB(255,255,255)
        displayTimeLabel.TextScaled = true
        displayTimeLabel.Parent = PlayerGui
    end
end

-- =========================
-- ปุ่ม 1: Record
-- =========================
ExtraTab:Button({
    Title="เริ่มอัดการเคลื่อนไหว",
    Desc="กดเพื่อเริ่ม/หยุดอัดการเคลื่อนไหว",
    Callback=function()
        local char = player.Character
        if not char then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        recording = not recording
        if recording then
            recordedFrames = {}
            recordStartTime = tick()
            updateTimeLabel()
            displayTimeLabel.Text = "0.0s"
            
            -- เริ่มบันทึก
            task.spawn(function()
                while recording do
                    local time = tick() - recordStartTime
                    displayTimeLabel.Text = string.format("%.1fs", time)
                    table.insert(recordedFrames, hrp.CFrame)
                    task.wait(0.1)
                end
                if displayTimeLabel then displayTimeLabel:Destroy(); displayTimeLabel=nil end
            end)
        end
    end
})

-- =========================
-- ปุ่ม 2: Playback Smooth
-- =========================
ExtraTab:Button({
    Title="เล่นการเคลื่อนไหว (ลื่น)",
    Desc="กดเพื่อเริ่ม/หยุดเล่นการเคลื่อนไหวที่บันทึก",
    Callback=function()
        local char = player.Character
        if not char or #recordedFrames == 0 then return end
        local hrp = char:FindFirstChild("HumanoidRootPart")
        if not hrp then return end

        playing = not playing
        task.spawn(function()
            while playing do
                for i = 1, #recordedFrames-1 do
                    if not playing then break end
                    local startCFrame = recordedFrames[i]
                    local endCFrame = recordedFrames[i+1]
                    local tween = TweenService:Create(hrp, TweenInfo.new(0.1, Enum.EasingStyle.Linear), {CFrame=endCFrame})
                    tween:Play()
                    tween.Completed:Wait()
                end
            end
        end)
    end
})

-- =========================
-- ปุ่ม 3: Reset
-- =========================
ExtraTab:Button({
    Title="รีเซ็ตการเคลื่อนไหว",
    Desc="ล้างข้อมูลการอัดทั้งหมด",
    Callback=function()
        recordedFrames = {}
        recording = false
        playing = false
        if displayTimeLabel then displayTimeLabel:Destroy(); displayTimeLabel=nil end
    end
})

-- =========================
-- ระบบลบและคืนค่า Part "Barrier" กับ "MapBarrier"
-- =========================

local workspace = game:GetService("Workspace")

local hiddenParts = {}  -- เก็บ Part ที่ถูกลบไว้เพื่อเอากลับคืน
local deleteToggle = false

-- ฟังก์ชันค้นหา Part ทั้งแมพ
local function findParts()
    local found = {}
    local function scan(parent)
        for _, obj in ipairs(parent:GetChildren()) do
            if obj:IsA("BasePart") and (obj.Name == "Barrier" or obj.Name == "MapBarrier") then
                table.insert(found, obj)
            end
            scan(obj)
        end
    end
    scan(workspace)
    return found
end

-- ลบทุก Barrier + MapBarrier
local function deleteAll()
    for _, part in ipairs(findParts()) do
        if part and part.Parent then
            hiddenParts[part] = {
                Parent = part.Parent,
                CFrame = part.CFrame,
                Transparency = part.Transparency,
                CanCollide = part.CanCollide
            }
            part.Parent = nil
        end
    end
end

-- คืนค่า Barrier + MapBarrier ที่ถูกลบ
local function restoreAll()
    for part, data in pairs(hiddenParts) do
        if part then
            part.Parent = data.Parent
            part.CFrame = data.CFrame
            part.Transparency = data.Transparency
            part.CanCollide = data.CanCollide
        end
    end
    hiddenParts = {}
end

-- =========================
-- ปุ่มในหมวด ExtraTab
-- =========================
ExtraTab:Toggle({
    Title = "ลบ/คืนค่า Barrier & MapBarrier",
    Desc = "กดเพื่อสลับลบหรือคืนค่า Part ทั้งหมด",
    Value = false,
    Callback = function(state)
        deleteToggle = state
        if deleteToggle then
            deleteAll()
        else
            restoreAll()
        end
    end
})

-- =========================
-- ปุ่ม ออโต้เก็บไก่งวง
-- =========================
local autoTurkey = false
local autoTurkeyThread

EventTab:Toggle({
    Title = "ออโต้เก็บไก่งวง",
    Desc = "เทเลพอร์ตไป Nextbot ชื่อ Turkey อัตโนมัติ",
    Value = false,
    Callback = function(state)
        autoTurkey = state

        if autoTurkey then
            autoTurkeyThread = coroutine.create(function()
                local player = game.Players.LocalPlayer
                while autoTurkey do
                    local char = player.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        local hrp = char.HumanoidRootPart
                        local turkeyNPC
                        -- หา Nextbot ชื่อ Turkey
                        local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
                        if folder then
                            for _, npc in ipairs(folder:GetChildren()) do
                                if npc.Name == "Turkey" then
                                    turkeyNPC = npc
                                    break
                                end
                            end
                        end

                        if turkeyNPC and turkeyNPC.Parent then
                            local targetPart = turkeyNPC:FindFirstChild("Root") or turkeyNPC:FindFirstChild("HumanoidRootPart") or turkeyNPC:FindFirstChild("Head")
                            if targetPart then
                                hrp.CFrame = targetPart.CFrame + Vector3.new(0, 3, 0) -- ยกขึ้นเล็กน้อย
                            end
                        else
                            -- ถ้า Turkey หายไป ให้เทเลพอร์ตขึ้นสูง
                            hrp.CFrame = CFrame.new(hrp.Position.X, 1300, hrp.Position.Z)
                        end
                    end
                    task.wait(0.5)
                end
            end)
            coroutine.resume(autoTurkeyThread)
        else
            autoTurkey = false
            if autoTurkeyThread and coroutine.status(autoTurkeyThread) ~= "dead" then
                coroutine.close(autoTurkeyThread)
                autoTurkeyThread = nil
            end
        end
    end
})

-- =========================
-- ปุ่ม วาปหนีบอท
-- =========================
local warpBotActive = false
local warpBotCoroutine

ExtraTab:Toggle({
    Title = "วาปหนีบอท",
    Desc = "เมื่อเน็กบอทใกล้ จะวาปไปผู้เล่นที่สูงที่สุด",
    Value = false,
    Callback = function(state)
        warpBotActive = state

        if warpBotActive then
            -- เริ่ม coroutine ตรวจ Nextbot
            warpBotCoroutine = coroutine.create(function()
                local RunService = game:GetService("RunService")
                local LocalPlayer = game:GetService("Players").LocalPlayer
                local Players = game:GetService("Players")
                while warpBotActive do
                    task.wait(0.1)
                    local char = LocalPlayer.Character
                    if not char then continue end
                    local root = char:FindFirstChild("HumanoidRootPart")
                    if not root then continue end

                    -- ตรวจ Nextbot ใกล้ตัว
                    local folder = workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players")
                    if folder then
                        for _, npc in ipairs(folder:GetChildren()) do
                            if npc:GetAttribute("Team") == "Nextbot" then
                                local npcPart = npc:FindFirstChild("Root") or npc:FindFirstChild("HumanoidRootPart")
                                if npcPart and (npcPart.Position - root.Position).Magnitude <= 10 then
                                    -- หา Player ที่อยู่สูงที่สุด
                                    local targetPlayer = nil
                                    local maxY = -math.huge
                                    for _, plr in ipairs(Players:GetPlayers()) do
                                        if plr ~= LocalPlayer and plr.Character then
                                            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
                                            if hrp then
                                                if hrp.Position.Y > maxY then
                                                    maxY = hrp.Position.Y
                                                    targetPlayer = hrp
                                                end
                                            end
                                        end
                                    end
                                    -- วาร์ปไป Player สูงที่สุด
                                    if targetPlayer then
                                        root.CFrame = targetPlayer.CFrame + Vector3.new(0,2,0)
                                    end
                                end
                            end
                        end
                    end
                end
            end)
            coroutine.resume(warpBotCoroutine)
        else
            -- ปิดระบบ
            if warpBotCoroutine and coroutine.status(warpBotCoroutine) ~= "dead" then
                coroutine.close(warpBotCoroutine)
            end
            warpBotCoroutine = nil
        end
    end
})

-- =========================
-- ปุ่ม เปลี่ยนเป็นกลางวัน
-- =========================
ExtraTab:Button({
    Title = "เปลี่ยนเป็นกลางวัน",
    Desc = "ตั้งเวลา Map เป็น 12:00",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.ClockTime = 12 -- ตั้งเวลาเที่ยงวัน
        print("ตั้งเวลาเป็นกลางวัน 12:00 เรียบร้อย")
    end
})

-- =========================
-- ปุ่ม เปลี่ยนเป็นกลางคืน
-- =========================
ExtraTab:Button({
    Title = "เปลี่ยนเป็นกลางคืน",
    Desc = "ตั้งเวลา Map เป็น 22:00",
    Callback = function()
        local Lighting = game:GetService("Lighting")
        Lighting.ClockTime = 22 -- ตั้งเวลา 22:00
        print("ตั้งเวลาเป็นกลางคืน 22:00 เรียบร้อย")
    end
})

local AutoCarryEnabled = false
local CarryConnection

TeleportTab:Toggle({
    Title = "เก็บผู้เล่นที่ล้ม",
    Desc = "เทเลพอร์ตไปหาผู้เล่นที่ล้มและอุ้ม",
    Value = false,
    Callback = function(state)
        AutoCarryEnabled = state

        if CarryConnection then
            CarryConnection:Disconnect()
            CarryConnection = nil
        end

        if state then
            CarryConnection = game:GetService("RunService").Heartbeat:Connect(function()
                if not AutoCarryEnabled then return end
                local localChar = game.Players.LocalPlayer.Character
                local hrp = localChar and localChar:FindFirstChild("HumanoidRootPart")
                if not hrp then return end

                -- เก็บตำแหน่งเดิม
                local originalCFrame = hrp.CFrame

                -- หา player ที่ล้ม
                local fallenPlayers = {}
                for _, plr in ipairs(game.Players:GetPlayers()) do
                    if plr ~= game.Players.LocalPlayer and plr.Character then
                        local humanoid = plr.Character:FindFirstChildOfClass("Humanoid")
                        if humanoid and humanoid.Health <= 0 then
                            table.insert(fallenPlayers, plr)
                        end
                    end
                end

                -- ถ้าเจอคนล้ม
                if #fallenPlayers > 0 then
                    -- เลือกคนที่ไม่ใช่คนใกล้ที่สุด (สุ่ม)
                    local target = fallenPlayers[math.random(1, #fallenPlayers)]
                    local targetHRP = target.Character and target.Character:FindFirstChild("HumanoidRootPart")
                    if targetHRP then
                        -- เทเลพอร์ตไปยังผู้เล่นนั้น
                        hrp.CFrame = targetHRP.CFrame + Vector3.new(0,3,0)

                        -- ใช้ระบบ Auto Carry
                        pcall(function()
                            game:GetService("ReplicatedStorage"):WaitForChild("Events")
                                :WaitForChild("Character")
                                :WaitForChild("Interact")
                                :FireServer("Carry", nil, target.Name)
                        end)

                        task.wait(0.5) -- เวลารออุ้ม

                        -- เทเลพอร์ตกลับ
                        hrp.CFrame = originalCFrame
                        task.wait(0.3) -- เว้นเวลาสักนิดก่อนวนต่อ
                    end
                end
            end)
        end
    end
})

-- =========================================
-- ตัวแปรบิน
-- =========================================
local Players = game:GetService("Players")
local Camera = workspace.CurrentCamera
local player = Players.LocalPlayer

local flying = false
local flyForce, flyGyro

-- ค่าเริ่มต้นของความเร็วบิน
local FlySpeed = 1.5


-- =========================================
-- ฟังก์ชันเริ่มบิน
-- =========================================
local function StartFly()
    local char = player.Character
    if not char then return end

    local human = char:FindFirstChildOfClass("Humanoid")
    local root = char:FindFirstChild("HumanoidRootPart")
    if not human or not root then return end

    flying = true

    flyForce = Instance.new("BodyVelocity")
    flyGyro = Instance.new("BodyGyro")

    flyGyro.P = 10000
    flyGyro.MaxTorque = Vector3.new(10000, 10000, 10000)
    flyGyro.CFrame = root.CFrame

    flyForce.Velocity = Vector3.new()
    flyForce.MaxForce = Vector3.new(100000, 100000, 100000)

    flyForce.Parent = root
    flyGyro.Parent = root

    human.PlatformStand = true
    human.AutoRotate = false

    task.spawn(function()
        while flying do
            task.wait()

            local FV = Camera.CFrame:VectorToWorldSpace(Vector3.new(0, 0, -1))
            local SV = Camera.CFrame:VectorToWorldSpace(Vector3.new(-1, 0, 0))
            local move = human.MoveDirection

            local push =
                (FV * (60 * FlySpeed) * -move.Z)
                + (SV * (40 * FlySpeed) * -move.X)

            flyGyro.CFrame = CFrame.new(Vector3.new(), FV)
            flyForce.Velocity = flyForce.Velocity:Lerp(push, 0.2)
        end
    end)
end

-- =========================================
-- ฟังก์ชันหยุดบิน
-- =========================================
local function StopFly()
    flying = false

    local char = player.Character
    if not char then return end
    local human = char:FindFirstChildOfClass("Humanoid")

    if flyForce then flyForce:Destroy() end
    if flyGyro then flyGyro:Destroy() end

    if human then
        human.PlatformStand = false
        human.AutoRotate = true
    end
end


-- =========================================
-- ปุ่มบินในหมวดเมนูหลัก
-- =========================================

MainTab:Button({
    Title = "บิน (Fly)",
    Desc = "เปิด/ปิดระบบบิน",
    Callback = function()
        flying = not flying
        if flying then
            StartFly()
        else
            StopFly()
        end
    end
})

-- =========================================
-- ช่องใส่ความเร็วอยู่ใต้ปุ่มบิน
-- =========================================

MainTab:Textbox({
    Title = "ความเร็วบิน (Speed)",
    Default = tostring(FlySpeed),
    Placeholder = "1.5",
    Callback = function(txt)
        local num = tonumber(txt)
        if num then
            FlySpeed = num
        end
    end
})

-- =============================
-- ของเสริม : Korblox / Headless (เวอร์ชันแก้ตายแล้วหาย)
-- =============================

local player = game.Players.LocalPlayer

-- เก็บสถานะปุ่ม
local extraStatus = {
    Korblox = false,
    Headless = false,
}

-- ฟังก์ชันเอาไว้รันสคริปต์ทุกครั้งที่ต้องการ
local function applyBodyMod()
    getgenv().Setting = {
        ["Body"] = {
            ["Korblox"] = extraStatus.Korblox,
            ["Headless"] = extraStatus.Headless,
        },
    }

    -- โหลดสคริปต์ลิงก์ (ชุด headless/korblox)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/khen791/script-khen/refs/heads/main/KorbloxAndHeadless.txt", true))()
end

-- ฟังก์ชันรอเกิดใหม่ แล้วใช้ของเสริมให้อัตโนมัติ
player.CharacterAdded:Connect(function()
    task.wait(1) -- รอให้ตัวโหลดครบ
    applyBodyMod()
end)

-- =============================
-- ปุ่ม Korblox
-- =============================
ExtraTab:Toggle({
    Title = "ขากุด (Korblox)",
    Desc = "เปิด/ปิด ขากุด โดยใช้สคริปต์จากลิงก์",
    Value = false,
    Callback = function(state)
        extraStatus.Korblox = state
        applyBodyMod()
    end
})

-- =============================
-- ปุ่ม Headless
-- =============================
ExtraTab:Toggle({
    Title = "หัวล่องหน (Headless)",
    Desc = "เปิด/ปิด หัวล่องหน โดยใช้สคริปต์จากลิงก์",
    Value = false,
    Callback = function(state)
        extraStatus.Headless = state
        applyBodyMod()
    end
})

-- =========================
-- ลบความมืดออก / เพิ่มแสง
-- =========================
ExtraTab:Button({
    Title = "ลบมืดออก",
    Desc = "ทำให้ Map สว่าง และตัดเงาออกทั้งหมด",
    Callback = function()
        local Lighting = game:GetService("Lighting")

        -- ปรับแสงให้สว่าง
        Lighting.Ambient = Color3.new(1,1,1)
        Lighting.OutdoorAmbient = Color3.new(1,1,1)
        Lighting.Brightness = 3
        Lighting.ExposureCompensation = 1

        -- ปิด Shadow
        Lighting.GlobalShadows = false

        -- ลบเอฟเฟกต์มืดทั้งหมด เช่น ColorCorrection, DepthOfField, Bloom, SunRays
        for _, v in pairs(Lighting:GetChildren()) do
            if v:IsA("ColorCorrectionEffect")
            or v:IsA("DepthOfFieldEffect")
            or v:IsA("BloomEffect")
            or v:IsA("SunRaysEffect")
            or v:IsA("Atmosphere")
            or v:IsA("Sky") then
                v:Destroy()
            end
        end
    end
})

-- ตัวแปรสถานะรันสคริปต์
local fakeEdashRunning = false
local fakeEdashConnection

-- ปุ่มในหมวด ของเสริม
ExtraTab:Button({
    Title = "เสกท่าเวล100 ของปลอม❌(ของคนอื่น)",
    Desc = "กดเพื่อเปิด/ปิดสคริปต์ fake edash",
    Callback = function()
        if not fakeEdashRunning then
            -- ========== เริ่มรันสคริปต์ ==========
            fakeEdashRunning = true
            print("Fake Edash เริ่มทำงาน!")

            -- โหลดสคริปต์จากลิ้ง
            local source = game:HttpGet("https://raw.githubusercontent.com/G4V3S/S/refs/heads/main/fake%20edash.lua")
            fakeEdashConnection = loadstring(source)

            -- รัน
            task.spawn(function()
                pcall(fakeEdashConnection)
            end)

        else
            -- ========== ปิดสคริปต์ ==========
            fakeEdashRunning = false
            print("Fake Edash ถูกปิดแล้ว!")

            -- พยายามหยุดสคริปต์โดยรีโหลด environment
            fakeEdashConnection = nil
        end
    end
})

-- =========================
-- Bounce Button (Auto Trimp Style)
-- =========================
local RunService = game:GetService("RunService")
local Debris = game:GetService("Debris")

local bounceEnabled = false
local bounceHeight = 100
local bounceDistance = 8

local function isNearGround(hrp)
    local rayParams = RaycastParams.new()
    rayParams.FilterType = Enum.RaycastFilterType.Blacklist
    rayParams.FilterDescendantsInstances = {hrp.Parent}

    local offsets = {
        Vector3.new(0,-bounceDistance,0),
        Vector3.new(2,-bounceDistance,0),
        Vector3.new(-2,-bounceDistance,0),
        Vector3.new(0,-bounceDistance,2),
        Vector3.new(0,-bounceDistance,-2)
    }

    for _,offset in ipairs(offsets) do
        local r = workspace:Raycast(hrp.Position, offset, rayParams)
        if r and r.Instance and r.Instance.CanCollide then
            return true
        end
    end
    return false
end

-- ทำงานตลอดจนกว่าจะปิด
task.spawn(function()
    while true do
        if bounceEnabled then
            local char = player.Character
            if char then
                local hrp = char:FindFirstChild("HumanoidRootPart")
                if hrp then
                    
                    local vel = hrp.Velocity
                    if vel.Y < -35 and isNearGround(hrp) then
                        hrp.Velocity = Vector3.new(vel.X, bounceHeight, vel.Z)

                        local fx = Instance.new("ParticleEmitter")
                        fx.Texture = "rbxassetid://241594180"
                        fx.Lifetime = NumberRange.new(0.3)
                        fx.Speed = NumberRange.new(40)
                        fx.Rate = 200
                        fx.Parent = hrp
                        Debris:AddItem(fx,0.3)
                    end
                end
            end
        end
        task.wait()
    end
end)

-- ========= ปุ่มลอย =========
local floatingBounceButton
local autoBounce = false

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
        bounceEnabled = autoBounce
        floatingBounceButton.Text = autoBounce and "Auto Bounce: ON" or "Auto Bounce: OFF"
    end)
end



-- ========= ปุ่มในเมนูหลัก =========
MainTab:Toggle({
    Title = "ออโต้ทริป",
    Desc = "เด้งอัตโนมัติแบบตรวจพื้นแม่นยำ",
    Value = false,
    Callback = function(v)
        bounceEnabled = v
    end
})

-- ========= ปุ่มลอยในเมนูหลัก =========
MainTab:Toggle({
    Title="ออโต้เด้ง (ปุ่มลอย)",
    Desc="แสดงปุ่มลอยสำหรับ Auto Bounce (แม่นยำกว่าเดิม)",
    Value=false,
    Callback=function(state)
        if state then 
            createBounceFloatingButton()
        else
            if floatingBounceButton then
                floatingBounceButton:Destroy()
                floatingBounceButton=nil
            end
            autoBounce=false
            bounceEnabled=false
        end
    end
})

-- =========================
-- INFO DISPLAY (Time / FPS / Speed + หมัดอูฐ)
-- =========================
local RunService = game:GetService("RunService")

local infoGui = Instance.new("ScreenGui")
infoGui.Name = "InfoGui"
infoGui.ResetOnSpawn = false
infoGui.Parent = game.CoreGui

local info = Instance.new("TextLabel")
info.Size = UDim2.new(0,230,0,80)
info.Position = UDim2.new(0,10,0,10)
info.BackgroundTransparency = 1 -- โปร่งใสหมด
info.TextColor3 = Color3.fromRGB(255,255,255)
info.Font = Enum.Font.Code
info.TextScaled = true
info.TextXAlignment = Enum.TextXAlignment.Left
info.Parent = infoGui

local elapsed = 0

RunService.RenderStepped:Connect(function(dt)
	elapsed += dt
	local char = player.Character
	local hum = char and char:FindFirstChild("Humanoid")
	local speed = hum and hum.WalkSpeed or 0
	local fps = math.floor(1/dt)

	info.Text = string.format(
		"หมัดอูฐ\nTime: %.1f\nFPS: %d\nSpeed: %d",
		elapsed,fps,speed
	)
end)


-- =========================
-- TOGGLE ปิดข้อความตรงจอ (อยู่ในหมวด ของเสริม)
-- =========================
local infoVisible = true

ExtraTab:Toggle({
    Title = "เปิดแฟ้มอีโมท(เสกท่า)",
    Desc = "รันสคริปต์ Emote จาก Pastebin",
    Callback = function()
        local url = "https://pastebin.com/raw/DSZCMGqh" -- ใช้ raw link ของ Pastebin
        local success, err = pcall(function()
            loadstring(game:HttpGet(url))()
        end)
        if not success then
            warn("ไม่สามารถรันสคริปต์ Emote ได้: "..tostring(err))
        end
    end
})

--===========================
-- ตัวแปร / Logic เดิม
--===========================

local RS = game:GetService("ReplicatedStorage")
local itemsFolder = RS:FindFirstChild("Items")

local originalEmoteSpeeds = {}
local emotingSpeed = 1.5


-- เก็บค่าเดิมของ Emote
do
    if itemsFolder then
        local emotesFolder = itemsFolder:FindFirstChild("Emotes")
        if emotesFolder then
            for _, mod in ipairs(emotesFolder:GetChildren()) do
                if mod:IsA("ModuleScript") then
                    local ok,data = pcall(require,mod)
                    if ok and data.EmoteInfo then
                        originalEmoteSpeeds[mod.Name] = data.EmoteInfo.SpeedMult
                    end
                end
            end
        end
    end
end


function applyOriginalEmoteSpeed(spd)
    local emotesFolder = itemsFolder:FindFirstChild("Emotes")
    for _, mod in ipairs(emotesFolder:GetChildren()) do
        local ok,data = pcall(require,mod)
        if ok and data.EmoteInfo and data.EmoteInfo.SpeedMult ~= 0 then
            data.EmoteInfo.SpeedMult = spd
        end
    end
end


function resetOriginal()
    local emotesFolder = itemsFolder:FindFirstChild("Emotes")
    for _,mod in ipairs(emotesFolder:GetChildren()) do
        local sp = originalEmoteSpeeds[mod.Name]
        if sp then
            local ok,data = pcall(require,mod)
            if ok then data.EmoteInfo.SpeedMult = sp end
        end
    end
end


function applyWalkMultiplier(mult)
	for _,t in pairs(getgc(true)) do
		if typeof(t)=="table" and rawget(t,"WalkSpeedMultiplier") then
			pcall(function()
				t.WalkSpeedMultiplier = mult
			end)
		end
	end
end



--===========================
-- GUI ของมึง
--===========================

local speedValue = 1

SettingsTab:Textbox({
    Title = "ความเร็ว",
    Placeholder = "1000",
    Callback = function(text)

        local number = tonumber(text)
        if not number then
            warn("กรุณาใส่ตัวเลขเท่านั้น")
            return
        end

        speedValue = number / 1000
        
        -- ใช้ระบบเดิม 👇
        resetOriginal()
        applyOriginalEmoteSpeed(speedValue)
        applyWalkMultiplier(speedValue)

        game.StarterGui:SetCore("SendNotification",{
            Title="ตั้งค่าความเร็ว",
            Text="ความเร็วอีโมทตอนนี้: x"..speedValue,
            Duration=2
        })
    end
})


SettingsTab:Button({
    Title="รีเซ็ต",
    Callback=function()
        speedValue = 1
        resetOriginal()
        applyWalkMultiplier(1)

        game.StarterGui:SetCore("SendNotification",{
            Title="รีเซ็ต",
            Text="กลับสู่ความเร็วปกติ",
            Duration=2
        })
    end
})

-- สร้าง Tab ใหม่สำหรับ Emote Changer เสริม
Tabs.ExtraEmotes = WindUI:Tab({Title = "Emote Changer (เสริม)"})

-- Section และ Divider
Tabs.ExtraEmotes:Section({ Title = "Emote Changer", TextSize = 20 })
Tabs.ExtraEmotes:Divider()

-- เก็บค่า Emote
local currentEmotes = table.create(12, "")
local selectEmotes = table.create(12, "")
local emoteEnabled = table.create(12, false)
local currentEmoteInputs = {}
local selectEmoteInputs = {}

-- Input Current Emote
for i = 1, 12 do
    currentEmoteInputs[i] = Tabs.ExtraEmotes:Input({
        Title = "Current Emote " .. i,
        Placeholder = "Enter current emote name",
        Value = currentEmotes[i],
        Callback = function(v)
            currentEmotes[i] = v:gsub("%s+", "")
        end
    })
end

Tabs.ExtraEmotes:Divider()

-- Input Select Emote
for i = 1, 12 do
    selectEmoteInputs[i] = Tabs.ExtraEmotes:Input({
        Title = "Select Emote " .. i,
        Placeholder = "Enter select emote name",
        Value = selectEmotes[i],
        Callback = function(v)
            selectEmotes[i] = v:gsub("%s+", "")
        end
    })
end

-- Emote Possible Option
local EmoteChangerEmoteOption = Tabs.ExtraEmotes:Input({
    Title = "Emote Possible option",
    Desc = "Higher Value may break animation, recommend 1-3",
    Placeholder = "1",
    Callback = function(v)
        local num = tonumber(v) or 1
        local player = game:GetService("Players").LocalPlayer
        local currentNum = num  

        local function setupCharacter(character)
            if character == player.Character then  
                character:SetAttribute("EmoteNum", currentNum)
            end
        end

        local function monitorCharacter()
            while true do
                task.wait(1)
                local character = player.Character
                if character and character:GetAttribute("EmoteNum") ~= currentNum then
                    character:SetAttribute("EmoteNum", currentNum)
                end
            end
        end

        if player.Character then setupCharacter(player.Character) end
        player.CharacterAdded:Connect(function(character) task.wait(1) setupCharacter(character) end)
        spawn(monitorCharacter)
    end
})

-- ===============================
-- ระบบ Emote Remote + Respawn
-- ===============================
local player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Events = ReplicatedStorage:WaitForChild("Events", 10)
local CharacterFolder = Events and Events:WaitForChild("Character", 10)
local EmoteRemote = CharacterFolder and CharacterFolder:WaitForChild("Emote", 10)
local PassCharacterInfo = CharacterFolder and CharacterFolder:WaitForChild("PassCharacterInfo", 10)
local remoteSignal = PassCharacterInfo and PassCharacterInfo.OnClientEvent

local currentTag = nil
local pendingSlot = nil
local blockOriginalEmote = false

local function readTagFromFolder(f)
    if not f then return nil end
    local a = f:GetAttribute("Tag")
    if a ~= nil then return a end
    local o = f:FindFirstChild("Tag")
    if o and o:IsA("ValueBase") then return o.Value end
    return nil
end

local function onRespawn()
    currentTag = nil
    pendingSlot = nil
    task.spawn(function()  
        local startTime = tick()  
        while tick() - startTime < 10 do  
            if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") then  
                local pf = workspace.Game.Players:FindFirstChild(player.Name)  
                if pf then  
                    currentTag = readTagFromFolder(pf)  
                    if currentTag then  
                        local b = tonumber(currentTag)  
                        if b and b >= 0 and b <= 255 then break end  
                        currentTag = nil  
                    end  
                end  
            end  
            task.wait(0.5)  
        end  
    end)
end

local function fireSelect(slot)
    if not currentTag then return end
    local b = tonumber(currentTag)
    if not b or b < 0 or b > 255 then return end
    if not selectEmotes[slot] or selectEmotes[slot] == "" then return end

    local buf = buffer.create(2)
    buffer.writeu8(buf, 0, b)
    buffer.writeu8(buf, 1, 17)

    if remoteSignal then
        firesignal(remoteSignal, buf, {selectEmotes[slot]})
    end
end

-- Connect Remote Event
if PassCharacterInfo and EmoteRemote then
    PassCharacterInfo.OnClientEvent:Connect(function(...)
        if not pendingSlot then return end
        local slot = pendingSlot
        pendingSlot = nil
        task.wait(0.1)
        fireSelect(slot)
    end)

    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local m = getnamecallmethod()
        local a = {...}

        if m == "FireServer" and self == EmoteRemote and type(a[1]) == "string" then
            for i = 1, 12 do
                if emoteEnabled[i] and currentEmotes[i] ~= "" and a[1] == currentEmotes[i] then
                    pendingSlot = i
                    blockOriginalEmote = true

                    task.spawn(function()
                        task.wait(0.1)
                        blockOriginalEmote = false
                        if pendingSlot == i then
                            pendingSlot = nil
                            fireSelect(i)
                        end
                    end)

                    if blockOriginalEmote then return nil end
                end
            end
        end

        return oldNamecall(self, ...)
    end)

    if player.Character then task.spawn(onRespawn) end
    player.CharacterAdded:Connect(function() task.wait(1) onRespawn() end)

    if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") then
        workspace.Game.Players.ChildAdded:Connect(function(child)
            if child.Name == player.Name then task.wait(0.5) onRespawn() end
        end)
        workspace.Game.Players.ChildRemoved:Connect(function(child)
            if child.Name == player.Name then currentTag = nil pendingSlot = nil end
        end)
    end
end

-- ===============================
-- ปุ่ม Apply Emote
-- ===============================
local EmoteChangerEmoteApply = Tabs.ExtraEmotes:Button({
    Title="Apply Emote Mappings",
    Icon="check",
    Callback=function()
        local hasAnyEmote = false
        for i=1,12 do
            if currentEmotes[i] ~= "" or selectEmotes[i] ~= "" then hasAnyEmote = true break end
        end
        if not hasAnyEmote then
            WindUI:Notify({Title="Emote Changer", Content="Please enter your emote", Duration=3})
            return
        end

        local function normalizeEmoteName(name) return name:gsub("%s+", ""):lower() end
        local function isValidEmote(emoteName)
            if emoteName == "" then return false, "" end
            local normalizedInput = normalizeEmoteName(emoteName)
            local emotesFolder = game:GetService("ReplicatedStorage"):FindFirstChild("Items")
            if emotesFolder then
                emotesFolder = emotesFolder:FindFirstChild("Emotes")
                if emotesFolder then
                    for _, emoteModule in ipairs(emotesFolder:GetChildren()) do
                        if emoteModule:IsA("ModuleScript") then
                            local normalizedEmote = normalizeEmoteName(emoteModule.Name)
                            if normalizedEmote == normalizedInput then return true, emoteModule.Name end
                        end
                    end
                end
            end
            return false, ""
        end

        local sameEmoteSlots, missingEmoteSlots, invalidEmoteSlots, successfulSlots = {}, {}, {}, {}
        for i=1,12 do
            if currentEmotes[i] ~= "" and selectEmotes[i] ~= "" then
                local currentValid, currentActual = isValidEmote(currentEmotes[i])
                local selectValid, selectActual = isValidEmote(selectEmotes[i])
                if not currentValid and not selectValid then
                    table.insert(invalidEmoteSlots,{slot=i,currentInvalid=true,currentName=currentEmotes[i],selectInvalid=true,selectName=selectEmotes[i]})
                elseif not currentValid then
                    table.insert(invalidEmoteSlots,{slot=i,currentInvalid=true,currentName=currentEmotes[i],selectInvalid=false,selectName=selectEmotes[i]})
                elseif not selectValid then
                    table.insert(invalidEmoteSlots,{slot=i,currentInvalid=false,currentName=currentEmotes[i],selectInvalid=true,selectName=selectEmotes[i]})
                elseif currentActual:lower()==selectActual:lower() then
                    table.insert(sameEmoteSlots,i)
                else
                    table.insert(successfulSlots,{slot=i,current=currentActual,select=selectActual})
                end
            elseif currentEmotes[i] ~= "" or selectEmotes[i] ~= "" then
                table.insert(missingEmoteSlots,i)
            end
        end

        local message = ""
        if #successfulSlots>0 then
            message = message.."<font color='#00FF00'><stroke color='#000000' width='0.0001'>Successfully applied emote on:</stroke></font>\n"
            for _,data in ipairs(successfulSlots) do
                message=message.."<font color='#00FF00'><stroke color='#000000' width='0.0001'>Slot "..data.slot.." Emote: "..data.current.." -> "..data.select.."</stroke></font>\n"
            end
            message=message.."\n"
        end
        if #sameEmoteSlots>0 then
            message=message.."<font color='#ff0000'><stroke color='#FFFFFF' width='0.0001'>Failed to apply emote on (same emote):</stroke></font>\n"
            for _,slot in ipairs(sameEmoteSlots) do message=message.."<font color='#ff0000'><stroke color='#FFFFFF' width='0.0001'>Slot "..slot.."</stroke></font>\n" end
            message=message.."\n"
        end
        if #invalidEmoteSlots>0 then
            message=message.."<font color='#ff0000'><stroke color='#FFFFFF' width='0.0001'>Invalid emotes:</stroke></font>\n"
            for _,data in ipairs(invalidEmoteSlots) do
                message=message.."<font color='#ff0000'><stroke color='#FFFFFF' width='0.0001'>Slot "..data.slot.." - "
                if data.currentInvalid and data.selectInvalid then
                    message=message.."Invalid current: "..data.currentName..", Invalid select: "..data.selectName.."</stroke></font>\n"
                elseif data.currentInvalid then
                    message=message.."Invalid current: "..data.currentName..", Select: "..data.selectName.."</stroke></font>\n"
                else
                    message=message.."Current: "..data.currentName..", Invalid select: "..data.selectName.."</stroke></font>\n"
                end
            end
            message=message.."\n"
        end
        if #missingEmoteSlots>0 then
            message=message.."<font color='#ff0000'><stroke color='#FFFFFF' width='0.0001'>Missing emote slots:</stroke></font>\n"
            for _,slot in ipairs(missingEmoteSlots) do
                if currentEmotes[slot]=="" then message=message.."<font color='#ff0000'><stroke color='#FFFFFF' width='0.0001'>Slot "..slot.." - Current missing</stroke></font>\n"
                else message=message.."<font color='#ff0000'><stroke color='#FFFFFF' width='0.0001'>Slot "..slot.." - Select missing</stroke></font>\n" end
            end
        end

        for i=1,12 do
            local currentValid, _ = isValidEmote(currentEmotes[i])
            local selectValid, _ = isValidEmote(selectEmotes[i])
            emoteEnabled[i] = (currentValid and selectValid and currentEmotes[i]:lower()~=selectEmotes[i]:lower())
        end

        WindUI:Notify({Title="Emote Changer", Content=message, Duration=8})
    end
})

-- ปุ่ม Reset All Emotes
local EmoteChangerEmoteReset = Tabs.ExtraEmotes:Button({
    Title = "Reset All Emotes",
    Icon = "trash-2",
    Callback = function()
        for i = 1, 12 do
            currentEmotes[i]=""
            selectEmotes[i]=""
            emoteEnabled[i]=false
            if currentEmoteInputs[i] and currentEmoteInputs[i].Set then currentEmoteInputs[i]:Set("") end
            if selectEmoteInputs[i] and selectEmoteInputs[i].Set then selectEmoteInputs[i]:Set("") end
        end
        WindUI:Notify({Title="Emote Changer", Content="All emotes have been reset!"})
    end
})

-- =========================
-- Emote System in ExtraTab
-- =========================

-- Variables
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

local Events = ReplicatedStorage:WaitForChild("Events", 10)
local CharacterFolder = Events and Events:WaitForChild("Character", 10)
local EmoteRemote = CharacterFolder and CharacterFolder:WaitForChild("Emote", 10)
local PassCharacterInfo = CharacterFolder and CharacterFolder:WaitForChild("PassCharacterInfo", 10)
local remoteSignal = PassCharacterInfo and PassCharacterInfo.OnClientEvent

local currentEmote = ""
local selectEmote = ""
local emoteEnabled = false
local pendingSlot = nil
local blockOriginalEmote = false
local currentTag = nil

-- Function: read Tag
local function readTagFromFolder(f)
    if not f then return nil end
    local a = f:GetAttribute("Tag")
    if a ~= nil then return a end
    local o = f:FindFirstChild("Tag")
    if o and o:IsA("ValueBase") then return o.Value end
    return nil
end

-- Function: respawn / update tag
local function onRespawn()
    currentTag = nil
    pendingSlot = nil
    task.spawn(function()
        local startTime = tick()
        while tick() - startTime < 10 do
            if workspace:FindFirstChild("Game") and workspace.Game:FindFirstChild("Players") then
                local pf = workspace.Game.Players:FindFirstChild(player.Name)
                if pf then
                    currentTag = readTagFromFolder(pf)
                    if currentTag then
                        local b = tonumber(currentTag)
                        if b and b >= 0 and b <= 255 then break end
                        currentTag = nil
                    end
                end
            end
            task.wait(0.5)
        end
    end)
end

-- Function: fire emote
local function fireSelect()
    if not currentTag or selectEmote == "" then return end
    local b = tonumber(currentTag)
    if not b or b < 0 or b > 255 then return end
    local buf = buffer.create(2)
    buffer.writeu8(buf, 0, b)
    buffer.writeu8(buf, 1, 17)
    if remoteSignal then
        firesignal(remoteSignal, buf, {selectEmote})
    end
end

-- Hook emote
if PassCharacterInfo and EmoteRemote then
    PassCharacterInfo.OnClientEvent:Connect(function(...)
        if pendingSlot then
            pendingSlot = nil
            task.wait(0.1)
            fireSelect()
        end
    end)

    local oldNamecall
    oldNamecall = hookmetamethod(game, "__namecall", function(self, ...)
        local m = getnamecallmethod()
        local a = {...}
        if m == "FireServer" and self == EmoteRemote and type(a[1]) == "string" then
            if emoteEnabled and a[1] == currentEmote then
                pendingSlot = 1
                blockOriginalEmote = true
                task.spawn(function()
                    task.wait(0.1)
                    blockOriginalEmote = false
                    if pendingSlot then
                        pendingSlot = nil
                        fireSelect()
                    end
                end)
                if blockOriginalEmote then return nil end
            end
        end
        return oldNamecall(self, ...)
    end)

    if player.Character then task.spawn(onRespawn) end
    player.CharacterAdded:Connect(function() task.wait(1) onRespawn() end)
end

-- ตรวจสอบว่า ExtraTab มีอยู่
if ExtraTab then
    ExtraTab:Button({
        Title = "เปิดแฟ้มอีโมท(เสกท่า)",
        Desc = "รันสคริปต์ Emote จาก Pastebin",
        Callback = function()
            local url = "https://pastebin.com/raw/DSZCMGqh" -- ใช้ raw link ของ Pastebin
            local success, err = pcall(function()
                loadstring(game:HttpGet(url))()
            end)
            if success then
                print("รันสคริปต์ Emote สำเร็จ")
            else
                warn("ไม่สามารถรันสคริปต์ Emote ได้: "..tostring(err))
            end
        end
    })
else
    warn("ExtraTab ยังไม่ถูกสร้าง! ตรวจสอบว่ามีโค้ดสร้าง Tab ก่อนหน้านี้")
end

-- =========================
-- Notify
-- =========================
Window:Notify({
Title="Swiftz Hub",
Desc="เมนูทั้งหมดโหลดเรียบร้อยแล้ว! เปิด/ปิดเมนูได้ทั้ง Desktop และ มือถือ",
Time=4
})
