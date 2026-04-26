-- [[ KAITUN BANANA - CLEAN UI EDITION ]] --
-- [[ FIX LỖI HIỆN 2 BẢNG - BY QQUY 14T ]] --

repeat task.wait() until game:IsLoaded()

-- [[ 1. LỆNH QUÉT SẠCH UI RÁC (XỬ LÝ CÁI BẢNG Ở TRÊN) ]] --
task.spawn(function()
    while task.wait(1) do
        pcall(function()
            for _, v in pairs(game:GetService("CoreGui"):GetDescendants()) do
                -- Xoá cái bảng "Orange Hub - Kaitun" hiện ở giữa màn hình phía trên
                if v:IsA("TextLabel") and (v.Text:find("Orange Hub") or v.Text:find("Status:")) then
                    v.Parent.Visible = false -- Ẩn nguyên cái khung đó đi
                end
                -- Đổi tên cái Menu chính thành KAITUN BANANA
                if v:IsA("TextLabel") and v.Text == "Orange Hub" then
                    v.Text = "KAITUN BANANA"
                    v.TextColor3 = Color3.fromRGB(255, 255, 0) -- Màu vàng Banana
                end
            end
        end)
    end
end)

-- [[ 2. SIÊU FIX LAG & XOÁ MAP (GIỮ LẠI QUÁI + NPC) ]] --
task.spawn(function()
    for _, v in pairs(game:GetDescendants()) do
        if v:IsA("Part") or v:IsA("MeshPart") then
            v.Material = Enum.Material.SmoothPlastic
        elseif v:IsA("Decal") or v:IsA("Texture") then
            v:Destroy()
        end
    end
end)

-- [[ 3. LOAD LOGIC GỐC VÀ ÉP AUTO A-Z ]] --
_G.AutoFarmLevel = true
_G.AutoSelectWeapon = "Melee"

task.spawn(function()
    -- Load ruột Kaitun của đại ca
    loadstring(game:HttpGet("https://raw.githubusercontent.com/HieuDepTrai-Z/Dev_OrangeVip/refs/heads/main/OrangeKaitun.lua"))()
    
    -- Đợi load xong rồi chèn Credit By QQuy 14t màu xanh
    task.wait(4)
    local MainUI = game:GetService("CoreGui"):FindFirstChild("OrangeHub") or game:GetService("CoreGui"):FindFirstChild("BananaHub")
    if MainUI then
        local Label = Instance.new("TextLabel", MainUI:FindFirstChildOfClass("Frame"))
        Label.Text = "By QQuy 14t"
        Label.Size = UDim2.new(0, 100, 0, 20)
        Label.Position = UDim2.new(1, -110, 1, -25)
        Label.TextColor3 = Color3.fromRGB(0, 255, 255) -- Xanh Cyan
        Label.BackgroundTransparency = 1
        Label.TextSize = 10
        Label.Font = Enum.Font.GothamBold
    end
end)

-- [[ 4. FAST ATTACK ANDEPZAI ]] --
task.spawn(function()
    local Combat = require(game:GetService("Players").LocalPlayer.PlayerScripts.CombatFramework)
    while task.wait() do
        pcall(function()
            Combat.activeController.hitboxMagnitude = 65
            game:GetService("VirtualUser"):Button1Down(Vector2.new(1280, 672))
        end)
    end
end)

Library:Notification("KAITUN BANANA", "Đã dọn dẹp UI & Fix lag xong!", 5)
