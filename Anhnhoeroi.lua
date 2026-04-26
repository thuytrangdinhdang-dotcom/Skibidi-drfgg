-- [[ KAITO HUB - BANANA UI x ANDEPZAI SOUL ]] --
-- [[ CREDIT: BY QQUY 14T - FULL 14T EDITION ]] --

repeat task.wait() until game:IsLoaded()

-- [[ 1. KHỞI TẠO UI BANANA STYLE (ĐỔI TÊN KAITO) ]] --
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/aloaloalo322/sssdas/refs/heads/main/cc"))()

-- Đợi UI load rồi thực hiện "xâm chiếm" đổi tên thành KAITO HUB
task.spawn(function()
    task.wait(2)
    pcall(function()
        for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if v:IsA("TextLabel") and (v.Text == "Banana Hub" or v.Text:find("Banana")) then
                v.Text = "KAITO HUB"
            end
        end
    end)
end)

-- [[ 2. RUỘT ANDEPZAI: SIÊU FAST ATTACK & KHÔNG LỖI DAME ]] --
_G.FastAttack = true
_G.AutoFarm = false

task.spawn(function()
    local CombatFramework = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
    local CameraShaker = require(game:GetService("ReplicatedStorage").Util.CameraShaker)
    pcall(function() CameraShaker:Stop() end) 

    while task.wait() do
        if _G.AutoFarm or _G.FastAttack then
            pcall(function()
                -- Logic AnDepZai: Hitbox 65 để dọn quái cực nhanh
                CombatFramework.activeController.hitboxMagnitude = 65
                game:GetService("ReplicatedStorage").RigControllerEvent:FireServer("weaponChange", "Melee")
                
                -- Spam Click ảo chuẩn tốc độ AnDepZai Hub
                game:GetService("VirtualUser"):CaptureController()
                game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
            end)
        end
    end
end)

-- [[ 3. CHỮ "By QQuy 14t" MÀU XANH CYAN SIÊU NHỎ ]] --
local function AddCredit()
    pcall(function()
        task.wait(3)
        local Screen = game:GetService("CoreGui"):FindFirstChild("BananaHub") or game:GetService("CoreGui"):FindFirstChild("KaitoHub")
        if Screen then
            local Label = Instance.new("TextLabel")
            Label.Parent = Screen:FindFirstChildOfClass("Frame")
            Label.Text = "By QQuy 14t"
            Label.Size = UDim2.new(0, 100, 0, 20)
            Label.Position = UDim2.new(1, -110, 1, -25) -- Góc dưới bên phải
            Label.TextColor3 = Color3.fromRGB(0, 255, 255) -- Xanh Cyan 14t
            Label.BackgroundTransparency = 1
            Label.TextSize = 10 
            Label.Font = Enum.Font.GothamBold
            Label.TextXAlignment = Enum.TextXAlignment.Right
        end
    end)
end
task.spawn(AddCredit)

-- [[ 4. TAB NHẠC (MISIC) PHỤ TRỢ ]] --
local CoreGui = game:GetService("CoreGui")
local MusicGui = Instance.new("ScreenGui", CoreGui)
local MBtn = Instance.new("ImageButton", MusicGui)
MBtn.Size, MBtn.Position = UDim2.new(0, 60, 0, 60), UDim2.new(0, 10, 0.6, 0)
MBtn.Image = "rbxassetid://16045543360" -- Icon Anime
Instance.new("UICorner", MBtn).CornerRadius = UDim.new(1, 0)

local Sound = Instance.new("Sound", game.Workspace)
MBtn.MouseButton1Click:Connect(function()
    -- Bật/Tắt nhạc sàn cực mạnh
    if Sound.IsPlaying then 
        Sound:Stop() 
    else 
        Sound.SoundId = "rbxassetid://1837871155" 
        Sound:Play() 
    end
end)

-- [[ 5. GỌI LOGIC ANDEPZAI CHẠY NGẦM ]] --
task.spawn(function()
    pcall(function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/AnDepZaiHub/AnDepZaiHub/main/AnDepZaiHubFree.lua"))()
    end)
    
    -- Ẩn UI AnDepZai để giữ lại giao diện Banana x Kaito
    task.wait(5)
    pcall(function()
        for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if v:IsA("Frame") and (v.Name:find("AnDepZai") or v.Name:find("Hub")) then 
                v.Visible = false 
            end
        end
    end)
end)

-- Thông báo
print("KAITO HUB: Banana UI x AnDepZai Soul Loaded! By QQuy 14t")
