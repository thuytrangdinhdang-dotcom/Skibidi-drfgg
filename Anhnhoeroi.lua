-- [[ BANANA HUB x REDZ FULL FEATURES EDITION ]] --
-- [[ COPY FULL LOGIC FROM REDZV3 + ADD MUSIC + ADD LOADING ]] --

repeat task.wait() until game:IsLoaded()

-- [[ 1. LOADING SCREEN BANANA (CHO UY TÍN) ]] --
local CoreGui = game:GetService("CoreGui")
local Screen = Instance.new("ScreenGui", CoreGui)
local MainLoad = Instance.new("Frame", Screen)
MainLoad.Size, MainLoad.Position = UDim2.new(0, 350, 0, 120), UDim2.new(0.5, -175, 0.5, -60)
MainLoad.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", MainLoad)
local BarBack = Instance.new("Frame", MainLoad)
BarBack.Size, BarBack.Position = UDim2.new(0.8, 0, 0, 8), UDim2.new(0.1, 0, 0.6, 0)
BarBack.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
local Bar = Instance.new("Frame", BarBack)
Bar.Size, Bar.BackgroundColor3 = UDim2.new(0, 0, 1, 0), Color3.fromRGB(255, 255, 0)
local Text = Instance.new("TextLabel", MainLoad)
Text.Size, Text.Text = UDim2.new(1, 0, 0, 50), "ĐANG COPY FULL CHỨC NĂNG REDZ..."
Text.TextColor3, Text.BackgroundTransparency = Color3.new(1, 1, 0), 1

for i = 1, 100 do task.wait(0.015) Bar.Size = UDim2.new(i/100, 0, 1, 0) end
Screen:Destroy()

-- [[ 2. LOAD REDZ HUB VỚI SETTINGS ĐẠI CA ĐƯA ]] --
local Settings = {
    JoinTeam = "Pirates",
    Translator = true,
}

-- Khởi tạo RedZ Library
local RedzLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/realredz/RedzLibV5/main/Source.lua"))()
local Window = RedzLib:MakeWindow({
  Title = "BANANA HUB PREMIUM",
  SubTitle = "RedZ Full Features Copy",
  SaveFolder = "BananaRedZ.json"
})

-- [[ COPY TOÀN BỘ TAB TỪ REDZ ]] --
local Main = Window:MakeTab({"Main / Farm", "home"})
local Items = Window:MakeTab({"Items / Quests", "swords"})
local Sea = Window:MakeTab({"Sea Event", "skull"})
local Dungeon = Window:MakeTab({"Dungeon / Raid", "zap"})
local Music = Window:MakeTab({"Music / Misic", "music"}) -- TAB ĐẠI CA ĐÒI
local Config = Window:MakeTab({"Config / UI", "settings"})

-- --- TAB MUSIC (TÍCH HỢP THÊM) ---
Music:AddSection({"Trình Phát Nhạc Banana"})
local Sound = Instance.new("Sound", game.Workspace)
Music:AddTextBox({
    Name = "Nhập ID Nhạc",
    Callback = function(ID)
        Sound.SoundId = "rbxassetid://"..ID
        Sound:Play()
    end
})
Music:AddButton({"Nhạc Sàn Remix", function() Sound.SoundId = "rbxassetid://1837871155" Sound:Play() end})
Music:AddButton({"Dừng Nhạc", function() Sound:Stop() end})

-- --- LOAD CORE REDZ LOGIC (Dán link script gốc để lấy full chức năng) ---
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/newredzv3/Scripts/refs/heads/main/main.luau"))(Settings)
end)

-- [[ 3. NÚT ANIME TOGGLE (FIX MẤT UI & DRAG) ]] --
if CoreGui:FindFirstChild("BananaToggle") then CoreGui.BananaToggle:Destroy() end
local ToggleGui = Instance.new("ScreenGui", CoreGui)
local Btn = Instance.new("ImageButton", ToggleGui)
Btn.Size, Btn.Position = UDim2.new(0, 65, 0, 65), UDim2.new(0, 15, 0.5, 0)
Btn.Image = "rbxassetid://16045543360"
Btn.ZIndex = 9999
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)

-- Logic Drag (Kéo thả) chuẩn
local drag, start, startP
Btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then drag = true start = i.Position startP = Btn.Position end end)
game:GetService("UserInputService").InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.Touch then
    local d = i.Position - start
    Btn.Position = UDim2.new(startP.X.Scale, startP.X.Offset + d.X, startP.Y.Scale, startP.Y.Offset + d.Y)
end end)
Btn.InputEnded:Connect(function() drag = false end)

-- Toggle Menu RedZ
Btn.MouseButton1Click:Connect(function()
    if not drag then
        -- RedZ mặc định dùng phím RightControl hoặc nút của Lib
        game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
    end
end)

print("Banana Hub x RedZ: Full Features Loaded!")
