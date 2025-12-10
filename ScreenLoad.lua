--SWIFTZ LOADING SCREEN
local CoreGui = game:GetService("CoreGui")

--ลบ Loading เดิมถ้ามี
if CoreGui:FindFirstChild("SwiftzLoadingUI") then
	CoreGui.SwiftzLoadingUI:Destroy()
end

-- UI MAIN
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SwiftzLoadingUI"
ScreenGui.Parent = CoreGui
ScreenGui.IgnoreGuiInset = true

local MainBlack = Instance.new("Frame", ScreenGui)
MainBlack.Size = UDim2.new(1,0,1,0)
MainBlack.BackgroundColor3 = Color3.fromRGB(0,0,0)
MainBlack.BackgroundTransparency = 0

-- TITLE MAIN
local Title = Instance.new("TextLabel", MainBlack)
Title.AnchorPoint = Vector2.new(0.5, 0.5)
Title.Position = UDim2.new(0.5,0,0.38,0)
Title.Size = UDim2.new(0,600,0,80)
Title.Text = "Swiftz Hub"
Title.TextColor3 = Color3.fromRGB(255,255,255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 48
Title.BackgroundTransparency = 1


-- Background Full
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
BarFill.BorderSizePixel = 0

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

-- FOOTER TEXT CYCLING
local Footer = Instance.new("TextLabel", MainBlack)
Footer.AnchorPoint = Vector2.new(0.5, 0.5)
Footer.Position = UDim2.new(0.5,0,0.61,0)
Footer.Size = UDim2.new(0,700,0,30)
Footer.BackgroundTransparency = 1
Footer.Font = Enum.Font.Gotham
Footer.TextSize = 18
Footer.TextColor3 = Color3.fromRGB(255,255,255)
Footer.TextTransparency = 1 -- จะ Fade เข้ามาทีหลัง

local footerMessages = {
	"Swiftz Hub The best script",
	"https://discord.gg/U6Kgwwa9f",
	"Welcome to Swiftz Hub",
	"Love Swiftz Hub"
  "Swiftz Hub No.1"
  "dev is x2Sxqz_"
}

--------------------------------------------------------
-- ทำให้ข้อความเปลี่ยนแบบ Fade
--------------------------------------------------------
spawn(function()
	while wait(1.5) do
		for _,v in ipairs(footerMessages) do
			Footer.Text = v
			-- fade in
			for i=1,20 do
				Footer.TextTransparency = 1 - (i/20)
				wait(0.05)
			end
			wait(1.5)
			-- fade out
			for i=1,20 do
				Footer.TextTransparency = (i/20)
				wait(0.05)
			end
		end
	end
end)

-- PROGRESSING FUNCTION
local totalTime = 90 -- 90 seconds → 1.30 minute
local steps = 100
local interval = totalTime/steps

for i = 1,steps do
	PercentageText.Text = i.."%"
	BarFill:TweenSize(UDim2.new(i/100,0,1,0), "Out", "Sine", 0.2, true)
	wait(interval)
end

-- FADE OUT ALL UI
for t=1,20 do
	MainBlack.BackgroundTransparency = (t/20)
	Title.TextTransparency = (t/20)
	Footer.TextTransparency = (t/20)
	PercentageText.TextTransparency = (t/20)
	BarFill.BackgroundTransparency = (t/20)
	wait(0.04)
end

ScreenGui:Destroy()

-- LOAD MAIN SCRIPT
loadstring(game:HttpGet("https://raw.githubusercontent.com/Swiftz007/EvadeSwiftz/refs/heads/main/SwiftzEVbit.lua"))()
