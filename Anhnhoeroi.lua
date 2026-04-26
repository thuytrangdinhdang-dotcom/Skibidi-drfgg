-- [[ BANANA HUB x REDZ V3 - FIX LOADING NO MENU ]] --
repeat task.wait() until game:IsLoaded()

local CoreGui = game:GetService("CoreGui")

-- [[ 1. LOADING SCREEN CỰC NHANH ]] --
local Screen = Instance.new("ScreenGui", CoreGui)
local Main = Instance.new("Frame", Screen)
Main.Size, Main.Position = UDim2.new(0, 350, 0, 120), UDim2.new(0.5, -175, 0.5, -60)
Main.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", Main)

local BarBack = Instance.new("Frame", Main)
BarBack.Size, BarBack.Position = UDim2.new(0.8, 0, 0, 10), UDim2.new(0.1, 0, 0.65, 0)
BarBack.BackgroundColor3 = Color3.fromRGB(30, 30, 30)

local Bar = Instance.new("Frame", BarBack)
Bar.Size, Bar.BackgroundColor3 = UDim2.new(0, 0, 1, 0), Color3.fromRGB(255, 255, 0)

local Txt = Instance.new("TextLabel", Main)
Txt.Size, Txt.Text = UDim2.new(1, 0, 0, 50), "ĐANG KÍCH HOẠT REDZ V3..."
Txt.TextColor3, Txt.BackgroundTransparency = Color3.new(1, 1, 0), 1
Txt.Font = Enum.Font.GothamBold

-- Hiệu ứng load giả lập để đợi script gốc
for i = 1, 100 do
    task.wait(0.01)
    Bar.Size = UDim2.new(i/100, 0, 1, 0)
end
Screen:Destroy()

-- [[ 2. LOAD THẲNG REDZ V3 (FULL CHỨC NĂNG) ]] --
local Settings = {
    JoinTeam = "Pirates",
    Translator = true,
}

-- Gọi script RedZ gốc ngay lập tức
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/newredzv3/Scripts/refs/heads/main/main.luau"))(Settings)
    end)
end)

-- [[ 3. TAB NHẠC RIÊNG (CHO ĐẠI CA QUẨY) ]] --
local MusicGui = Instance.new("ScreenGui", CoreGui)
local MFrame = Instance.new("Frame", MusicGui)
MFrame.Size, MFrame.Position = UDim2.new(0, 220, 0, 130), UDim2.new(1, -230, 0.5, -65)
MFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MFrame.Visible = false
Instance.new("UICorner", MFrame)
Instance.new("UIStroke", MFrame).Color = Color3.new(1,1,0)

local Sound = Instance.new("Sound", game.Workspace)
local Play = Instance.new("TextButton", MFrame)
Play.Size, Play.Position = UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0.1, 0)
Play.Text = "QUẨY NHẠC SÀN"
Play.BackgroundColor3 = Color3.fromRGB(40,40,0)
Play.TextColor3 = Color3.new(1,1,1)

Play.MouseButton1Click:Connect(function()
    Sound.SoundId = "rbxassetid://1837871155"
    Sound:Play()
end)

local Stop = Instance.new("TextButton", MFrame)
Stop.Size, Stop.Position = UDim2.new(0.9, 0, 0, 40), UDim2.new(0.05, 0, 0.55, 0)
Stop.Text = "DỪNG NHẠC"
Stop.MouseButton1Click:Connect(function() Sound:Stop() end)

-- [[ 4. NÚT ANIME TOGGLE (FIX MẤT MENU) ]] --
if CoreGui:FindFirstChild("BananaToggle") then CoreGui.BananaToggle:Destroy() end
local ToggleGui = Instance.new("ScreenGui", CoreGui)
ToggleGui.Name = "BananaToggle"

local Btn = Instance.new("ImageButton", ToggleGui)
Btn.Size, Btn.Position = UDim2.new(0, 65, 0, 65), UDim2.new(0, 15, 0.4, 0)
Btn.Image = "rbxassetid://16045543360"
Btn.ZIndex = 9999
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

local drag, start, startP
Btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then drag = true start = i.Position startP = Btn.Position end end)
game:GetService("UserInputService").InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.Touch then
    local d = i.Position - start
    Btn.Position = UDim2.new(startP.X.Scale, startP.X.Offset + d.X, startP.Y.Scale, startP.Y.Offset + d.Y)
end end)
Btn.InputEnded:Connect(function() drag = false end)

Btn.MouseButton1Click:Connect(function()
    if not drag then
        -- Gửi phím RightControl để hiện Menu RedZ (Lệnh này cực nhạy)
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
        -- Hiện/Ẩn bảng nhạc
        MFrame.Visible = not MFrame.Visible
    end
end)
