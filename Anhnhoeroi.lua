-- [[ BANANA HUB PREMIUM - CHẾ ĐỘ CHUYỂN UI THẦN TỐC ]] --
-- [[ SOUL: REDZ V3 + GRAVITY V2 + SKIBIDI ATK ]] --

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer

-- [[ 1. CONFIGURATION ]] --
getgenv().Config = {
    AttackSpeed = 0.5,
    Team = "Pirates",
    Translator = true,
    Language = "Vietnamese",
    RainbowUI = true
}

-- [[ 2. HÀM CHUYỂN UI (SWITCH UI SYSTEM) ]] --
local function SwitchToRedz()
    -- Xóa UI Banana hiện tại
    if game:GetService("CoreGui"):FindFirstChild("BANANA HUB PREMIUM") then
        game:GetService("CoreGui"):FindFirstChild("BANANA HUB PREMIUM"):Destroy()
    end
    -- Nạp linh hồn Redz V3
    local RedzSettings = { JoinTeam = getgenv().Team, Translator = getgenv().Translator }
    loadstring(game:HttpGet("https://raw.githubusercontent.com/newredzv3/Scripts/refs/heads/main/main.luau"))(RedzSettings)
end

-- [[ 3. HỆ THỐNG FAST ATTACK SIÊU CẤP ]] --
local function ApplyAtk(s)
    getgenv().AttackSpeed = s
    task.spawn(function()
        while task.wait(getgenv().AttackSpeed) do
            pcall(function()
                if _G.AutoFarm or _G.Kaitun then
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                end
            end)
        end
    end)
end

-- [[ 4. KHỞI CHẠY UI BANANA PREMIUM ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BANANA HUB PREMIUM", "DarkTheme")

-- TẠO CÁC TAB CHUẨN
local HomeTab = Window:NewTab("Main / Stats")
local KaitunTab = Window:NewTab("Kaitun A-Z")
local AtkTab = Window:NewTab("Attack Speed")
local SettingTab = Window:NewTab("Settings / UI")

-- TAB STATS (DỰA THEO HÌNH ĐẠI CA GỬI)
local HSection = HomeTab:NewSection("CPU: 46.40 ms | GPU: 60.66 ms")
HSection:NewSection("Ping: 57 ms | FPS: 60")
HSection:NewButton("Bật Fix Lag (Siêu Mượt)", "Remove Textures", function()
    for _,v in pairs(game:GetDescendants()) do
        if v:IsA("Part") then v.Material = Enum.Material.SmoothPlastic end
    end
end)

-- TAB ATTACK SPEED (SKIBIDI ATTACK)
local ASection = AtkTab:NewSection("Tùy Chỉnh Tốc Độ")
ASection:NewButton("Skibidi Attack (0.1s)", "Fastest", function() ApplyAtk(0.1) end)
ASection:NewButton("Super Fast (0.2s)", "Ultra", function() ApplyAtk(0.2) end)
ASection:NewButton("Normal Attack", "Default", function() ApplyAtk(0.8) end)

-- TAB SETTINGS (MỤC NÀY ĐỂ ĐẠI CA TEST CHỈNH UI)
local SSection = SettingTab:NewSection("Chỉnh Giao Diện & Ngôn Ngữ")
SSection:NewButton("CHUYỂN SANG REDZ UI", "Click để đổi giao diện ngay lập tức", function()
    SwitchToRedz()
end)
SSection:NewDropdown("Chọn Ngôn Ngữ", "Language", {"Tiếng Việt", "English"}, function(v)
    getgenv().Language = v
end)

-- TAB KAITUN A-Z
local KSection = KaitunTab:NewSection("Cày Thuê Toàn Diện")
KSection:NewToggle("Bật Kaitun A-Z", "Full Sea 1-3", function(state)
    _G.Kaitun = state
    if state then
        loadstring(game:HttpGet("https://raw.githubusercontent.com/Dev-GravityHub/BloxFruit/refs/heads/main/Main.lua"))()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/aloaloalo322/sssdas/refs/heads/main/cc"))()
    end
end)

-- [[ 5. NÚT TOGGLE ANIME & RAINBOW ENGINE ]] --
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("ImageButton", ScreenGui)
Btn.Size = UDim2.new(0, 75, 0, 75)
Btn.Position = UDim2.new(0, 20, 0.4, 0)
Btn.Image = "rbxassetid://16045543360" -- Ảnh anime tóc trắng
Btn.BackgroundTransparency = 0.3
Btn.BackgroundColor3 = Color3.new(0,0,0)
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 100)
local Stroke = Instance.new("UIStroke", Btn)
Stroke.Thickness = 3

task.spawn(function()
    while task.wait() do
        local Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        Stroke.Color = Color
        for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if v:IsA("TextLabel") and v.Name == "Title" then v.TextColor3 = Color end
        end
    end
end)

-- LOGIC KÉO THẢ NÚT
local dragging, dragStart, startPos
Btn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true dragStart = input.Position startPos = Btn.Position
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        Btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function() dragging = false end)

-- THÔNG BÁO
game.StarterGui:SetCore("SendNotification", {
    Title = "BANANA HUB PREMIUM",
    Text = "Vào mục Settings để test chuyển UI Redz nhé đại ca!",
    Icon = "rbxassetid://16045543360",
    Duration = 5
})
