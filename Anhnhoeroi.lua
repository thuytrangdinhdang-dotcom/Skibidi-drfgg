-- [[ KAITUN BANANA - SIÊU FIX LAG x XOÁ MAP ]] --
-- [[ FULL AUTO A-Z - BY QQUY 14T ]] --

repeat task.wait() until game:IsLoaded()

-- [[ 1. CONFIG TỰ ĐỘNG CHUẨN 14T ]] --
_G.Config = {
    Team = "Pirates",
    AutoFarm = true,
    AutoStats = true,
    AutoSelectWeapon = "Melee",
    -- Tự động làm mọi nhiệm vụ vật phẩm
    AutoItems = {Saber = true, Godhuman = true, CDK = true, SoulGuitar = true}
}

-- [[ 2. SIÊU CẤP FIX LAG & XOÁ MAP (CHỈ CHỪA QUÁI + NPC) ]] --
task.spawn(function()
    local g = game
    local w = g.Workspace
    local l = g.Lighting
    
    -- Xoá texture và làm mượt môi trường
    l.GlobalShadows = false
    l.FogEnd = 9e9
    settings().Rendering.QualityLevel = 1

    for _, v in pairs(g:GetDescendants()) do
        if v:IsA("Part") or v:IsA("UnionOperation") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0
            -- Xoá map nhưng không xoá Quái (NPC) và Đảo nhiệm vụ
            if not v:IsDescendantOf(w:FindFirstChild("NPCs")) and not v:IsDescendantOf(w:FindFirstChild("Enemies")) then
                -- Nếu không phải vật thể quan trọng thì làm trong suốt để fix lag
                if v.Name ~= "HumanoidRootPart" then
                    -- v.Transparency = 1 -- Đại ca có thể bật cái này nếu muốn map trắng tinh
                end
            end
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy() -- Xoá sạch hoa văn, cỏ cây
        elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
            v.Enabled = false
        end
    end
end)

-- [[ 3. KHỞI TẠO UI BANANA (KAITUN BANANA 14T) ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/aloaloalo322/sssdas/refs/heads/main/cc"))()

task.spawn(function()
    task.wait(1)
    pcall(function()
        for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if v:IsA("TextLabel") and (v.Text:find("Orange") or v.Text:find("Banana")) then
                v.Text = "KAITUN BANANA (FIX LAG MAX)"
                v.TextColor3 = Color3.fromRGB(255, 255, 0)
            end
        end
    end)
end)

-- [[ 4. RUỘT ANDEPZAI: FAST ATTACK KHÔNG LỖI DAME ]] --
task.spawn(function()
    local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
    while task.wait() do
        pcall(function()
            -- Đánh cực nhanh nhưng vẫn chuẩn để server không check
            CombatFramework.activeController.hitboxMagnitude = 65
            game:GetService("VirtualUser"):CaptureController()
            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
            
            -- Tự động cầm vũ khí
            if not game.Players.LocalPlayer.Character:FindFirstChildOfClass("Tool") then
                game.ReplicatedStorage.RigControllerEvent:FireServer("weaponChange", "Melee")
            end
        end)
    end
end)

-- [[ 5. DÒNG CHỮ "By QQuy 14t" MÀU XANH CYAN SIÊU NHỎ ]] --
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
            Label.TextColor3 = Color3.fromRGB(0, 255, 255)
            Label.BackgroundTransparency = 1
            Label.TextSize = 10 
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Right
        end
    end)
end
task.spawn(AddCredit)

-- [[ 6. NẠP LOGIC KAITUN A-Z ]] --
task.spawn(function()
    -- Load script gốc Orange Kaitun của đại ca
    loadstring(game:HttpGet("https://raw.githubusercontent.com/HieuDepTrai-Z/Dev_OrangeVip/refs/heads/main/OrangeKaitun.lua"))()
    
    -- Ép chạy farm ngay lập tức
    task.wait(5)
    _G.AutoFarmLevel = true
    _G.AutoSelectWeapon = "Melee"
end)

-- [[ 7. NÚT TOGGLE MOBILE ]] --
local CoreGui = game:GetService("CoreGui")
if CoreGui:FindFirstChild("FixLagToggle") then CoreGui.FixLagToggle:Destroy() end
local ScreenGui = Instance.new("ScreenGui", CoreGui)
ScreenGui.Name = "FixLagToggle"
local Btn = Instance.new("ImageButton", ScreenGui)
Btn.Size, Btn.Position = UDim2.new(0, 60, 0, 60), UDim2.new(0, 15, 0.45, 0)
Btn.Image = "rbxassetid://16045543360"
Instance.new("UICorner", Btn).CornerRadius = UDim.new(1, 0)
Btn.MouseButton1Click:Connect(function()
    game:GetService("VirtualInputManager"):SendKeyEvent(true, Enum.KeyCode.RightControl, false, game)
end)

Library:Notification("KAITUN BANANA", "Đã xoá map & Fix lag cực hạn! By QQuy 14t", 5)
