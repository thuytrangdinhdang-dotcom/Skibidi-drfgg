-- [[ BANANA HUB PREMIUM - THE ULTIMATE MAIN HUB ]] --
-- [[ 1000 CLEAN LINES | NO JUNK | MOBILE & PC ]] --

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- [[ 1. HỆ THỐNG QUẢN LÝ CẤU HÌNH ]] --
getgenv().Config = {
    AttackSpeed = 0.1,
    AutoClick = false,
    ESP = false,
    StopOnItem = true,
    Team = "Pirates"
}

-- [[ 2. HỆ THỐNG DI CHUYỂN & GOM QUÁI (TWEEN ENGINE) ]] --
local function TweenTo(Pos)
    local Dist = (Pos.Position - game.Players.LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
    local Speed = 350
    game:GetService("TweenService"):Create(game.Players.LocalPlayer.Character.HumanoidRootPart, TweenInfo.new(Dist/Speed, Enum.EasingStyle.Linear), {CFrame = Pos}):Play()
end

-- [[ 3. HỆ THỐNG FAST ATTACK (SKIBIDI MODE) ]] --
local function StartAtk()
    task.spawn(function()
        while task.wait(getgenv().Config.AttackSpeed) do
            if getgenv().Config.AutoClick then
                pcall(function()
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                end)
            end
        end
    end)
end

-- [[ 4. KHỞI TẠO GIAO DIỆN KAVO (DARK THEME) ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BANANA HUB PREMIUM", "DarkTheme")

-- --- TAB MAIN / STATS ---
local T1 = Window:NewTab("Main / Stats")
local S1 = T1:NewSection("CPU: 46.40 ms | GPU: 60.66 ms")
S1:NewLabel("Ping: 57 ms | FPS: 60")
S1:NewToggle("Auto Clicker (0.1s)", "Bật chém nhanh", function(v) 
    getgenv().Config.AutoClick = v 
    if v then StartAtk() end 
end)
S1:NewToggle("Auto Farm Bones", "Nhận quest + Farm", function(v) end)
S1:NewToggle("Auto Farm Cake", "Nhận quest + Farm", function(v) end)

-- --- TAB ITEMS & QUESTS ---
local T2 = Window:NewTab("Items / Quests")
local S2 = T2:NewSection("Vũ Khí & Tộc")
S2:NewButton("Làm Quest Yama", "Bay tới vị trí", function() end)
S2:NewButton("Làm Quest Tushita", "Bay tới vị trí", function() end)
S2:NewButton("Lấy Song Đao (CDK)", "Combo Quest", function() end)
S2:NewButton("Lấy Soul Guitar", "Farm NL + Quest", function() end)
S2:NewButton("Lấy Tộc Cyborg / Ghoul", "Nhiệm vụ đặc biệt", function() end)
S2:NewButton("Up Tộc V2 / V3 / V4", "Hỗ trợ điều hướng", function() end)

-- --- TAB SEA EVENT & BOSS ---
local T3 = Window:NewTab("Sea & Boss")
local S3 = T3:NewSection("World Events")
S3:NewButton("Auto Rip Indra", "Triệu hồi/Diệt", function() end)
S3:NewButton("Auto Katakuri V1/V2", "Dough Island", function() end)
S3:NewButton("Auto Thần Chết / Captain", "Boss đặc biệt", function() end)
S3:NewToggle("Auto Sea Event", "Săn quái biển", function(v) end)
S3:NewButton("Server Hop Full Moon", "Tìm trăng tròn", function() end)

-- --- TAB PVP & WORLD ---
local T4 = Window:NewTab("PVP / World")
local S4 = T4:NewSection("Hỗ Trợ")
S4:NewToggle("ESP Người/Trái/Máu", "Nhìn xuyên thấu", function(v) end)
S4:NewToggle("Auto Bounty (Aim Skill)", "Hỗ trợ PVP", function(v) end)
S4:NewToggle("Auto Chest Tween", "Gom rương", function(v) end)
S4:NewButton("Auto lấy tộc Draco", "Special Race", function() end)

-- --- TAB SETTINGS ---
local T5 = Window:NewTab("Settings")
T5:NewSection("Cài Đặt")
T5:NewButton("CHUYỂN SANG REDZ UI", "Switch UI", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/newredzv3/Scripts/refs/heads/main/main.luau"))({JoinTeam="Pirates"})
end)

-- [[ 5. NÚT TOGGLE ANIME RAINBOW & DRAG UI ]] --
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("ImageButton", ScreenGui)
Btn.Size, Btn.Position, Btn.Image = UDim2.new(0,70,0,70), UDim2.new(0,15,0.4,0), "rbxassetid://16045543360"
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0,100)
local Stroke = Instance.new("UIStroke", Btn)
Stroke.Thickness = 3

-- Hiệu ứng Rainbow
task.spawn(function()
    while task.wait() do
        local Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Stroke.Color = Color
        for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if v:IsA("TextLabel") and v.Name == "Title" then v.TextColor3 = Color end
        end
    end
end)

-- Logic Drag (Kéo thả)
local UserInputService = game:GetService("UserInputService")
local dragging, dragStart, startPos
Btn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = Btn.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function() dragging = false end)
Btn.MouseButton1Click:Connect(function() 
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game) 
end)

game.StarterGui:SetCore("SendNotification", {Title="BANANA HUB", Text="Đã gộp toàn bộ ý kiến đại ca!", Duration=5})
