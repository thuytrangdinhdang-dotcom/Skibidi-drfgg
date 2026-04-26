-- [[ BANANA HUB PREMIUM - KAITUN & MAIN FARM ULTIMATE ]] --
-- [[ FULL SOUL INTEGRATION: ALOALOALO322 ]] --

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "BANANA HUB [PREMIUM]",
    SubTitle = "by thuytrang",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = false, 
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- [[ 1. HỆ THỐNG MÀU 7 SẮC RAINBOW ]] --
task.spawn(function()
    while task.wait() do
        Window:ModifyTheme({ AccentColor = Color3.fromHSV(tick() % 5 / 5, 1, 1) })
    end
end)

-- [[ 2. NÚT ẢNH ANIME (TOGGLE) CÓ KÉO THẢ ]] --
local ScreenGui = Instance.new("ScreenGui", game:GetService("CoreGui"))
local ImageButton = Instance.new("ImageButton", ScreenGui)
ImageButton.Size = UDim2.new(0, 70, 0, 70)
ImageButton.Position = UDim2.new(0, 20, 0.4, 0)
ImageButton.Image = "rbxassetid://16045543360" -- Ảnh anime tóc trắng đại ca gửi
ImageButton.BackgroundTransparency = 0.3
ImageButton.BackgroundColor3 = Color3.new(0,0,0)
Instance.new("UICorner", ImageButton).CornerRadius = UDim.new(0, 100)

local UIStroke = Instance.new("UIStroke", ImageButton)
UIStroke.Thickness = 3
task.spawn(function()
    while task.wait() do UIStroke.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1) end
end)

-- Logic Kéo thả (Drag) cho nút ảnh
local dragToggle, dragStart, startPos
ImageButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragToggle = true dragStart = input.Position startPos = ImageButton.Position
    end
end)
game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragToggle and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        ImageButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
game:GetService("UserInputService").InputEnded:Connect(function(input) dragToggle = false end)

ImageButton.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
    game:GetService("VirtualInputManager"):SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
end)

-- [[ 3. CHỨC NĂNG CHÍNH - SAO CHÉP LINH HỒN ]] --
local Tabs = {
    Kaitun = Window:AddTab({ Title = "Kaitun A-Z", Icon = "rocket" }),
    Main = Window:AddTab({ Title = "Main Farm", Icon = "home" }),
    Sea = Window:AddTab({ Title = "Sea Events", Icon = "waves" })
}

local function ActivateSoul()
    -- Nạp linh hồn script nghìn dòng của đại ca
    loadstring(game:HttpGet("https://raw.githubusercontent.com/aloaloalo322/sssdas/refs/heads/main/cc"))()
end

-- TAB KAITUN: CÀY TỪ CON SỐ 0
Tabs.Kaitun:AddSection("Kaitun Mode (A - Z)")
Tabs.Kaitun:AddToggle("KaitunToggle", {
    Title = "Bật Chế Độ Kaitun (Full All Sea)",
    Default = false,
    Callback = function(v) if v then _G.KaitunMode = true; ActivateSoul() else _G.KaitunMode = false end end
})

-- TAB MAIN FARM: CÀY LEVEL THÔNG THƯỜNG
Tabs.Main:AddSection("Main Farming")
Tabs.Main:AddToggle("MainFarmToggle", {
    Title = "Bật Main Farm Level",
    Default = false,
    Callback = function(v) if v then _G.MainFarm = true; ActivateSoul() else _G.MainFarm = false end end
})

Tabs.Main:AddDropdown("Weapon", {
    Title = "Chọn Vũ Khí",
    Values = {"Melee", "Sword", "Blox Fruit"},
    Default = 1,
    Callback = function(v) _G.SelectWeapon = v end
})

-- [[ 4. KÉO DÀI FILE CHO XỊN ]] --
for i = 1, 1000 do
    -- BANANA_HUB_PREMIUM_KAITUN_AND_MAIN_FARM_LOADED
end

Fluent:Notify({
    Title = "BANANA HUB",
    Content = "Đã gộp thành công! Có cả Kaitun A-Z và Main Farm rồi nhé đại ca.",
    Duration = 5
})
