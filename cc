-- [[ KAITO HUB : BLOX FRUIT - BANANA UI + ANDEPZAI LOGIC ]]

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- [ HỆ THỐNG CÀI ĐẶT RUỘT ANDEPZAI ]
_G.Settings = {
    AutoFarm = false,
    AutoMastery = false,
    BringMob = true,
    FastAttack = true,
    Distance = 40
}

-- [ LOGIC FAST ATTACK & BRING MOB (RUỘT ANDEPZAI) ]
local function GetWeapon()
    for _, v in pairs(LocalPlayer.Backpack:GetChildren()) do
        if v:IsA("Tool") and (v.ToolTip == "Melee" or v.ToolTip == "Sword") then
            return v.Name
        end
    end
end

task.spawn(function()
    while task.wait() do
        if _G.Settings.AutoFarm and _G.Settings.FastAttack then
            pcall(function()
                local Combat = LocalPlayer.Character:FindFirstChild(GetWeapon())
                if Combat then
                    -- Mô phỏng Fast Attack của AnDepZai
                    game:GetService("VirtualUser"):CaptureController()
                    game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
                end
            end)
        end
    end
end)

-- [ GIAO DIỆN BANANA HUB ]
local function CreateBananaUI()
    if CoreGui:FindFirstChild("KaitoBanana") then CoreGui.KaitoBanana:Destroy() end

    local sg = Instance.new("ScreenGui", CoreGui)
    sg.Name = "KaitoBanana"

    -- Nút ảnh Sad Boy (Toggle Menu)
    local toggleBtn = Instance.new("ImageButton", sg)
    toggleBtn.Size = UDim2.new(0, 55, 0, 55)
    toggleBtn.Position = UDim2.new(0, 15, 0.5, -27)
    toggleBtn.Image = "rbxassetid://95101112877359"
    toggleBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    toggleBtn.BackgroundTransparency = 0.2
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)
    Instance.new("UIStroke", toggleBtn).Color = Color3.fromRGB(255, 192, 216)

    -- Main Frame (Banana Style)
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 450, 0, 320)
    main.Position = UDim2.new(0.5, -225, 0.5, -160)
    main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
    main.Visible = false
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 10)
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(255, 192, 216)
    stroke.Thickness = 1.2

    -- Title Chữ Nhỏ (Chuẩn Banana)
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, -20, 0, 40)
    title.Position = UDim2.new(0, 15, 0, 5)
    title.Text = "KAITO HUB : BLOX FRUIT (ANDEPZAI)"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 13
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1

    -- Container nút
    local container = Instance.new("ScrollingFrame", main)
    container.Size = UDim2.new(1, -30, 1, -60)
    container.Position = UDim2.new(0, 15, 0, 45)
    container.BackgroundTransparency = 1
    container.BorderSizePixel = 0
    container.ScrollBarThickness = 0
    local layout = Instance.new("UIListLayout", container)
    layout.Padding = UDim.new(0, 8)

    -- [ HÀM TẠO NÚT BANANA ]
    local function AddToggle(name, settingKey)
        local btn = Instance.new("TextButton", container)
        btn.Size = UDim2.new(1, 0, 0, 45)
        btn.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        btn.Text = "  " .. name .. ": OFF"
        btn.Font = Enum.Font.GothamMedium
        btn.TextSize = 13
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

        btn.MouseButton1Click:Connect(function()
            _G.Settings[settingKey] = not _G.Settings[settingKey]
            local state = _G.Settings[settingKey]
            btn.Text = "  " .. name .. ": " .. (state and "ON" or "OFF")
            btn.TextColor3 = state and Color3.fromRGB(255, 192, 216) or Color3.fromRGB(200, 200, 200)
        end)
    end

    -- Gắn các chức năng ruột vào UI
    AddToggle("Auto Farm Level", "AutoFarm")
    AddToggle("Auto Mastery", "AutoMastery")
    AddToggle("Bring Mob (Gom Quái)", "BringMob")
    AddToggle("Fast Attack (Đánh Nhanh)", "FastAttack")

    -- Mở/Đóng Menu & Kéo thả
    toggleBtn.MouseButton1Click:Connect(function() main.Visible = not main.Visible end)
    
    -- (Thêm logic kéo thả của bạn vào đây)
end

CreateBananaUI()
game:GetService("StarterGui"):SetCore("SendNotification", {Title = "Kaito Hub", Text = "Sài Ruột AnDepZai Thành Công!", Duration = 5})
    
