-- [[ KAITUN BANANA - FULL AUTO A-Z ]] --
-- [[ KHÔNG CẦN CHỈNH - BẬT LÀ CHẠY ]] --
-- [[ CREDIT: BY QQUY 14T ]] --

repeat task.wait() until game:IsLoaded()

-- [[ 1. BỘ AUTO-CONFIG: TỰ ĐỘNG THIẾT LẬP TỪ A-Z ]] --
_G.Config = {
    Team = "Pirates", -- Tự chọn Hải Tặc
    AutoFarm = true, -- Tự động Farm Level
    AutoStats = true, -- Tự nâng chỉ số (Melee, Defense, Sword)
    AutoSkills = true, -- Tự dùng kỹ năng khi farm
    
    -- Tự động thu thập vật phẩm quan trọng
    AutoItems = {
        Saber = true,
        Godhuman = true,
        CursedDualKatana = true,
        SoulGuitar = true,
        RaceV4 = true
    },
    
    -- Tối ưu hệ thống
    Optimization = {
        FpsBoost = true, -- Giảm lag tối đa
        WhiteScreen = false, -- Không bị trắng màn hình để dễ xem
        AutoHopCheck = true -- Tự đổi server nếu server vắng hoặc lag
    }
}

-- [[ 2. KHỞI TẠO GIAO DIỆN BANANA (MÀU VÀNG NEON) ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/aloaloalo322/sssdas/refs/heads/main/cc"))()

task.spawn(function()
    task.wait(1)
    pcall(function()
        -- Ép giao diện đổi tên thành KAITUN BANANA
        for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if v:IsA("TextLabel") and (v.Text:find("Orange") or v.Text:find("Banana")) then
                v.Text = "KAITUN BANANA (AUTO A-Z)"
                v.TextColor3 = Color3.fromRGB(255, 255, 0) -- Màu vàng Banana
            end
        end
    end)
end)

-- [[ 3. RUỘT ANDEPZAI: ĐÁNH SIÊU TỐC (LINH HỒN CỦA SCRIPT) ]] --
task.spawn(function()
    local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
    while task.wait() do
        pcall(function()
            -- Đánh nhanh và gom quái theo logic AnDepZai
            CombatFramework.activeController.hitboxMagnitude = 65
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
            
            -- Tự động đổi vũ khí Melee để farm
            if not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                game.ReplicatedStorage.RigControllerEvent:FireServer("weaponChange", "Melee")
            end
        end)
    end
end)

-- [[ 4. CREDIT "By QQuy 14t" MÀU XANH CYAN ]] --
local function AddCredit()
    pcall(function()
        task.wait(3)
        local Screen = game:GetService("CoreGui"):FindFirstChild("BananaHub") or game:GetService("CoreGui"):FindFirstChild("KaitoHub")
        if Screen then
            local Label = Instance.new("TextLabel")
            Label.Parent = Screen:FindFirstChildOfClass("Frame")
            Label.Text = "By QQuy 14t"
            Label.Size = UDim2.new(0, 100, 0, 20)
            Label.Position = UDim2.new(1, -110, 1, -25)
            Label.TextColor3 = Color3.fromRGB(0, 255, 255) -- Xanh Cyan 14t
            Label.BackgroundTransparency = 1
            Label.TextSize = 10 
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Right
        end
    end)
end
task.spawn(AddCredit)

-- [[ 5. KÍCH HOẠT LINH HỒN ORANGE KAITUN ]] --
task.spawn(function()
    -- Nạp toàn bộ logic Kaitun A-Z
    loadstring(game:HttpGet("https://raw.githubusercontent.com/HieuDepTrai-Z/Dev_OrangeVip/refs/heads/main/OrangeKaitun.lua"))()
    
    -- Tự động kích hoạt các nút bấm trong Menu sau khi load
    task.wait(5)
    _G.AutoFarmLevel = true
    _G.AutoFarmBoss = true
    _G.AutoSelectWeapon = "Melee"
end)

-- [[ 6. NÚT TOGGLE & THÔNG BÁO ]] --
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("KaitunToggle") then CoreGui.KaitunToggle:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "KaitunToggle"
local Btn = Instance.new("ImageButton", ScreenGui)
Btn.Size, Btn.Position = UDim2.new(0, 60, 0, 60), UDim2.new(0, 15, 0.45, 0)
Btn.Image = "rbxassetid://16045543360"
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)
Btn.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
end)

Library:Notification("KAITUN BANANA", "Hệ thống A-Z đã sẵn sàng! By QQuy 14t", 5)
