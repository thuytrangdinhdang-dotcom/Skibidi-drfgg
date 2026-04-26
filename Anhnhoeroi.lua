-- [[ KAITO HUB - MARU PREMIUM - BY QQUY 10T ]] --
repeat task.wait() until game:IsLoaded()

-- [[ 1. THƯ VIỆN UI MARU PREMIUM ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/x0637/lucy/main/marulib.lua"))()

local Window = Library:CreateWindow({
    Title = "KAITO HUB",
    SubTitle = "Maru Premium Engine",
    Footer = "Kaito x Maru Soul",
    Icon = "rbxassetid://16045543360"
})

-- [[ 2. THÊM CHỮ "By QQuy 10t" MÀU XANH NHỎ ]] --
local CoreGui = game:GetService("CoreGui")
local MainUI = CoreGui:FindFirstChild("MaruLib") or CoreGui:FindFirstChild("KaitoHub")
if MainUI then
    local CreditLabel = Instance.new("TextLabel")
    CreditLabel.Parent = MainUI:FindFirstChildOfClass("Frame") -- Gắn vào khung chính của UI
    CreditLabel.Name = "QQuyCredit"
    CreditLabel.Text = "By QQuy 10t"
    CreditLabel.Size = UDim2.new(0, 100, 0, 20)
    CreditLabel.Position = UDim2.new(1, -110, 1, -25) -- Góc dưới bên phải
    CreditLabel.BackgroundTransparency = 1
    CreditLabel.TextColor3 = Color3.fromRGB(0, 255, 255) -- Màu xanh Cyan nhỏ
    CreditLabel.TextSize = 12
    CreditLabel.Font = Enum.Font.GothamBold
    CreditLabel.TextXAlignment = Enum.TextXAlignment.Right
end

-- [[ 3. LOGIC ĐÁNH SIÊU NHANH (FAST ATTACK MARU) ]] --
_G.FastAttack = true
task.spawn(function()
    local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
    while task.wait() do
        if _G.AutoFarm or _G.FastAttack then
            pcall(function()
                CombatFramework.activeController.hitboxMagnitude = 60
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", "Melee")
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
            end)
        end
    end
end)

-- [[ 4. CÁC TAB CHỨC NĂNG ]] --
local MainTab = Window:AddTab("Main", "home")
local MusicTab = Window:AddTab("Music", "music")

MainTab:AddSection("Auto Farming")
MainTab:AddToggle("Auto Farm Level", false, function(v) _G.AutoFarm = v end)
MainTab:AddToggle("Super Fast Attack", true, function(v) _G.FastAttack = v end)

-- Tab Music quẩy nhạc sàn
MusicTab:AddSection("Kaito Music")
local Sound = Instance.new("Sound", game.Workspace)
MusicTab:AddInput("ID Nhạc", function(ID) Sound.SoundId = "rbxassetid://"..ID Sound:Play() end)
MusicTab:AddButton("Nhạc Sàn Remix", function() Sound.SoundId = "rbxassetid://1837871155" Sound:Play() end)
MusicTab:AddButton("Dừng Nhạc", function() Sound:Stop() end)

-- [[ 5. NÚT TOGGLE MOBILE ]] --
if CoreGui:FindFirstChild("KaitoBtn") then CoreGui.KaitoBtn:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KaitoBtn"
local ImageButton = Instance.new("ImageButton", ScreenGui)
ImageButton.Size = UDim2.new(0, 60, 0, 60)
ImageButton.Position = UDim2.new(0, 15, 0.45, 0)
ImageButton.Image = "rbxassetid://16045543360"
Instance.new("UICorner", ImageButton).CornerRadius = UDim.new(1, 0)

ImageButton.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
end)

Library:Notification("KAITO HUB", "Đã thêm Credit: By QQuy 10t", 5)
