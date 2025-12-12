---------------- SWIFTZ LOADING SCREEN -----------------
local CoreGui = game:GetService("CoreGui")

--ลบ Loading เดิมถ้ามี
if CoreGui:FindFirstChild("SwiftzLoadingUI") then
	CoreGui.SwiftzLoadingUI:Destroy()
end

--------------------------------------------------------
-- UI MAIN
--------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SwiftzLoadingUI"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

local MainBlack = Instance.new("Frame", ScreenGui)
MainBlack.Size = UDim2.new(1,0,1,0)
MainBlack.BackgroundColor3 = Color3.fromRGB(0,0,0)
MainBlack.BackgroundTransparency = 0

--------------------------------------------------------
-- TITLE MAIN
--------------------------------------------------------
local Title = Instance.new("TextLabel", MainBlack)
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.Position = UDim2.new(0.5,0,0.38,0)
Title.Size = UDim2.new(0,600,0,80)
Title.Text = "Swiftz Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 48
Title.BackgroundTransparency = 1

--------------------------------------------------------
-- PROGRESS BAR
--------------------------------------------------------
local BarBack = Instance.new("Frame", MainBlack)
BarBack.BackgroundColor3 = Color3.fromRGB(45,45,45)
BarBack.Position = UDim2.new(0.5,0,0.48,0)
BarBack.AnchorPoint = Vector2.new(0.5,0.5)
BarBack.Size = UDim2.new(0,450,0,24)
BarBack.BorderSizePixel = 0
local backCorner = Instance.new("UICorner", BarBack)
backCorner.CornerRadius = UDim.new(0,12)

local BarFill = Instance.new("Frame", BarBack)
BarFill.Size = UDim2.new(0,0,1,0)
BarFill.BackgroundColor3 = Color3.fromRGB(0,230,80)
local fillCorner = Instance.new("UICorner", BarFill)
fillCorner.CornerRadius = UDim.new(0,12)

local PercentageText = Instance.new("TextLabel", MainBlack)
PercentageText.AnchorPoint = Vector2.new(0.5,0.5)
PercentageText.Position = UDim2.new(0.5,0,0.53,0)
PercentageText.Size = UDim2.new(0,200,0,30)
PercentageText.BackgroundTransparency = 1
PercentageText.TextColor3 = Color3.fromRGB(255,255,255)
PercentageText.Font = Enum.Font.Gotham
PercentageText.Text = "0%"
PercentageText.TextSize = 24

--------------------------------------------------------
-- FOOTER TEXT
--------------------------------------------------------
local Footer = Instance.new("TextLabel", MainBlack)
Footer.AnchorPoint = Vector2.new(0.5, 0.5)
Footer.Position = UDim2.new(0.5,0,0.61,0)
Footer.Size = UDim2.new(0,700,0,30)
Footer.BackgroundTransparency = 1
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 18
Footer.TextColor3 = Color3.fromRGB(255,255,255)
Footer.TextTransparency = 1

local footerMessages = {
	"Swiftz Hub The best script",
	"https://discord.gg/U6Kgwwa9f",
	"Welcome to Swiftz Hub",
	"Love Swiftz Hub"
}

spawn(function()
	while wait(1.5) do
		for _,v in ipairs(footerMessages) do
			Footer.Text = v
			for i=1,20 do Footer.TextTransparency = 1 - i/20 wait(0.05) end
			wait(1.5)
			for i=1,20 do Footer.TextTransparency = i/20 wait(0.05) end
		end
	end
end)

--------------------------------------------------------
-- PROGRESSING (90 seconds)
--------------------------------------------------------
local totalTime = 60
local steps = 100
local interval = totalTime/steps

for i = 1,steps do
	PercentageText.Text = i.."%"
	BarFill:TweenSize(UDim2.new(i/100,0,1,0), "Out", "Sine", 0.15, true)
	wait(interval)
end

--------------------------------------------------------
-- FADE OUT LOADING UI
--------------------------------------------------------
for t=1,20 do
	MainBlack.BackgroundTransparency = t/20
	Title.TextTransparency = t/20
	Footer.TextTransparency = t/20
	PercentageText.TextTransparency = t/20
	BarFill.BackgroundTransparency = t/20
	wait(0.03)
end

MainBlack.Visible = false
--------------------------------------------------------
-- POPUP SELECTOR
--------------------------------------------------------
local Popup = Instance.new("Frame", ScreenGui)
Popup.Size = UDim2.new(0,420,0,250)
Popup.Position = UDim2.new(0.5,-210,0.5,-125)
Popup.BackgroundColor3 = Color3.fromRGB(20,20,20)
Popup.BackgroundTransparency = 0
Popup.BorderSizePixel = 0
local pc = Instance.new("UICorner", Popup)
pc.CornerRadius = UDim.new(0,12)

local PopupTitle = Instance.new("TextLabel", Popup)
PopupTitle.Size = UDim2.new(1,0,0,50)
PopupTitle.BackgroundTransparency = 1
PopupTitle.Font = Enum.Font.GothamBold
PopupTitle.TextSize = 28
PopupTitle.Text = "Choose Swiftz Mode"
PopupTitle.TextColor3 = Color3.fromRGB(255,255,255)

local FullBtn = Instance.new("TextButton", Popup)
FullBtn.Size = UDim2.new(0.8,0,0,48)
FullBtn.Position = UDim2.new(0.1,0,0.32,0)
FullBtn.BackgroundColor3 = Color3.fromRGB(0,160,255)
FullBtn.Font = Enum.Font.GothamBold
FullBtn.TextSize = 20
FullBtn.TextColor3 = Color3.fromRGB(255,255,255)
FullBtn.Text = "Full Swiftz"
local f1 = Instance.new("UICorner", FullBtn) f1.CornerRadius = UDim.new(0,10)

local BasicBtn = Instance.new("TextButton", Popup)
BasicBtn.Size = UDim2.new(0.8,0,0,48)
BasicBtn.Position = UDim2.new(0.1,0,0.62,0)
BasicBtn.BackgroundColor3 = Color3.fromRGB(0,230,100)
BasicBtn.Font = Enum.Font.GothamBold
BasicBtn.TextSize = 20
BasicBtn.TextColor3 = Color3.fromRGB(255,255,255)
BasicBtn.Text = "Basic Swiftz"
local f2 = Instance.new("UICorner", BasicBtn) f2.CornerRadius = UDim.new(0,10)

--------------------------------------------------------
-- FUNCTION FOR FADING POPUP
--------------------------------------------------------
local function closePopupAndRun(callback)
	for i=1,20 do
		Popup.BackgroundTransparency = i/20
		PopupTitle.TextTransparency = i/20
		FullBtn.BackgroundTransparency = i/20
		FullBtn.TextTransparency = i/20
		BasicBtn.BackgroundTransparency = i/20
		BasicBtn.TextTransparency = i/20
		wait(0.03)
	end
	ScreenGui:Destroy()
	callback()
end

--------------------------------------------------------
-- BUTTONS
--------------------------------------------------------
FullBtn.MouseButton1Click:Connect(function()
	closePopupAndRun(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Swiftz007/EvadeSwiftz/refs/heads/main/EVSwiftz.lua"))()
	end)
end)

BasicBtn.MouseButton1Click:Connect(function()
	closePopupAndRun(function()
		loadstring(game:HttpGet("https://raw.githubusercontent.com/Swiftz007/EvadeSwiftz/refs/heads/main/SwiftzEVbit.lua"))()
	end)
end)
