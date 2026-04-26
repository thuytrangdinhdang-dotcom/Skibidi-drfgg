-- [[ KAITO HUB - SUPER FAST ATTACK & NO DAME BUG ]] --
-- [[ UI BANANA PREMIUM STYLE - FULL SOUL ALOALOALO322 ]] --

repeat task.wait() until game:IsLoaded()

-- [[ 1. CONFIG ATTACK (SIÊU NHANH & KHÔNG LỖI) ]] --
_G.FastAttack = true
_G.NoDamageBug = true
_G.AttackDistance = 60

-- [[ 2. LOADING SCREEN KAITO PREMIUM ]] --
local CoreGui = game:GetService("CoreGui")
local Screen = Instance.new("ScreenGui", CoreGui)
local MainLoad = Instance.new("Frame", Screen)
MainLoad.Size, MainLoad.Position = UDim2.new(0, 320, 0, 100), UDim2.new(0.5, -160, 0.5, -50)
MainLoad.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
Instance.new("UICorner", MainLoad)
local Bar = Instance.new("Frame", MainLoad)
Bar.Size, Bar.Position = UDim2.new(0, 0, 0, 5), UDim2.new(0.1, 0, 0.7, 0)
Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
local Txt = Instance.new("TextLabel", MainLoad)
Txt.Size, Txt.Text = UDim2.new(1, 0, 0, 50), "KAITO HUB: FAST ATTACK READY"
Txt.TextColor3, Txt.BackgroundTransparency = Color3.new(1, 1, 0), 1
Txt.Font = Enum.Font.GothamBold

for i = 1, 100 do task.wait(0.01) Bar.Size = UDim2.new(i/100 * 0.8, 0, 0, 5) end
Screen:Destroy()

-- [[ 3. KÍCH HOẠT LOGIC BANANA GỐC (aloaloalo322) ]] --
task.spawn(function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/aloaloalo322/sssdas/refs/heads/main/cc"))()
    
    -- Đổi tên UI Banana sang KAITO HUB
    task.wait(2)
    pcall(function()
        for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
            if v:IsA("TextLabel") and (v.Text == "Banana Hub" or v.Text:find("Banana")) then
                v.Text = "KAITO HUB"
            end
        end
    end)
end)

-- [[ 4. SCRIPT PHỤ TRỢ FIX DAME (CHẠY SONG SONG) ]] --
task.spawn(function()
    while task.wait() do
        if _G.FastAttack then
            pcall(function()
                local Combat = game:GetService("VirtualUser")
                Combat:CaptureController()
                Combat:ClickButton1(Vector2.new(851, 158)) -- Giả lập click siêu tốc
            end)
        end
    end
end)

-- [[ 5. TAB NHẠC SÀN (MISIC) ]] --
local MusicGui = Instance.new("ScreenGui", CoreGui)
local MBtn = Instance.new("ImageButton", MusicGui)
MBtn.Size, MBtn.Position = UDim2.new(0, 60, 0, 60), UDim2.new(0, 10, 0.6, 0)
MBtn.Image = "rbxassetid://16045543360"
Instance.new("UICorner", MBtn).CornerRadius = UDim.new(1, 0)

local Sound = Instance.new("Sound", game.Workspace)
MBtn.MouseButton1Click:Connect(function()
    Sound.SoundId = "rbxassetid://1837871155" -- Nhạc sàn mặc định
    if Sound.IsPlaying then Sound:Stop() else Sound:Play() end
end)
