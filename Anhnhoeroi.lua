-- [[ KAITO HUB - DARK GREY PREMIUM EDITION ]] --
-- [[ STYLE: BLACK & GREY - NO KEY - FULL BANANA SOUL ]] --

repeat task.wait() until game:IsLoaded()

-- [[ 1. LOADING SCREEN PHONG CÁCH XÁM ĐEN ]] --
local CoreGui = game:GetService("CoreGui")
local Screen = Instance.new("ScreenGui", CoreGui)
local Main = Instance.new("Frame", Screen)
Main.Size, Main.Position = UDim2.new(0, 320, 0, 100), UDim2.new(0.5, -160, 0.5, -50)
Main.BackgroundColor3 = Color3.fromRGB(20, 20, 20) -- Xám đậm
Instance.new("UICorner", Main)
local Stroke = Instance.new("UIStroke", Main)
Stroke.Thickness, Stroke.Color = 2, Color3.fromRGB(80, 80, 80) -- Viền xám sáng

local Txt = Instance.new("TextLabel", Main)
Txt.Size, Txt.Text = UDim2.new(1, 0, 0, 50), "KAITO HUB - DARK EDITION"
Txt.TextColor3, Txt.BackgroundTransparency = Color3.fromRGB(200, 200, 200), 1
Txt.Font = Enum.Font.GothamBold

local BarBack = Instance.new("Frame", Main)
BarBack.Size, BarBack.Position = UDim2.new(0.8, 0, 0, 5), UDim2.new(0.1, 0, 0.7, 0)
BarBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
local Bar = Instance.new("Frame", BarBack)
Bar.Size, Bar.BackgroundColor3 = UDim2.new(0, 0, 1, 0), Color3.fromRGB(150, 150, 150) -- Thanh load xám trắng

for i = 1, 100 do task.wait(0.005) Bar.Size = UDim2.new(i/100, 0, 1, 0) end
Screen:Destroy()

-- [[ 2. KHỞI TẠO UI KAITO PREMIUM (XÁM ĐEN) ]] --
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local Window = Fluent:CreateWindow({
    Title = "KAITO HUB",
    SubTitle = "Dark Grey Premium",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false,
    Theme = "Darker", -- Chế độ tối nhất của Fluent
    MinimizeKey = Enum.KeyCode.RightControl
})

-- Đổi màu chủ đạo (Accent) sang Xám Trắng cho sang
Fluent.Options.AccentColor = Color3.fromRGB(180, 180, 180)

local Tabs = {
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
    Sea = Window:AddTab({ Title = "Sea Event", Icon = "skull" }),
    Music = Window:AddTab({ Title = "Music / Misic", Icon = "music" }),
    Config = Window:AddTab({ Title = "Config", Icon = "settings" })
}

-- --- TAB MUSIC (GIỮ NGUYÊN TÍNH NĂNG) ---
local Sound = Instance.new("Sound", game.Workspace)
Tabs.Music:AddTextBox("IDNhac", {
    Title = "Dán ID Nhạc",
    Callback = function(ID)
        Sound.SoundId = "rbxassetid://"..ID
        Sound:Play()
    end
})
Tabs.Music:AddButton({Title = "Nhạc Sàn Remix", Callback = function() Sound.SoundId = "rbxassetid://1837871155" Sound:Play() end})
Tabs.Music:AddButton({Title = "Dừng Nhạc", Callback = function() Sound:Stop() end})

-- --- LOAD FULL LOGIC ALOALOALO322 NGẦM ---
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/aloaloalo322/sssdas/refs/heads/main/cc"))()
    end)
end)

-- [[ 3. NÚT ANIME TOGGLE (ĐỔI SANG TÔNG XÁM) ]] --
if CoreGui:FindFirstChild("KaitoToggle") then CoreGui.KaitoToggle:Destroy() end
local KaitoGui = Instance.new("ScreenGui", CoreGui)
KaitoGui.Name = "KaitoToggle"
local Btn = Instance.new("ImageButton", KaitoGui)
Btn.Size, Btn.Position = UDim2.new(0, 65, 0, 65), UDim2.new(0, 15, 0.45, 0)
Btn.Image = "rbxassetid://16045543360"
Btn.ImageColor3 = Color3.fromRGB(200, 200, 200) -- Làm nút Anime hơi xám lại cho hợp tông
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", Btn).Color = Color3.fromRGB(100, 100, 100)

local drag, start, startP
Btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then drag = true start = i.Position startP = Btn.Position end end)
game:GetService("UserInputService").InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.Touch then
    local d = i.Position - start
    Btn.Position = UDim2.new(startP.X.Scale, startP.X.Offset + d.X, startP.Y.Scale, startP.Y.Offset + d.Y)
end end)
Btn.InputEnded:Connect(function() drag = false end)
Btn.MouseButton1Click:Connect(function() if not drag then Window:Minimize() end end)

Fluent:Notify({Title = "KAITO HUB", Content = "Đã chuyển sang giao diện Xám Đen!", Duration = 5})
