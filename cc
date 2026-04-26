-- [[ KAITO HUB : BLOX FRUIT MINI UI ]]
local Players = game:GetService("Players")
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local function CreateKaitoBloxFruit()
    -- Xóa bản cũ nếu có
    if CoreGui:FindFirstChild("KaitoBloxFruit") then CoreGui.KaitoBloxFruit:Destroy() end

    local sg = Instance.new("ScreenGui", CoreGui)
    sg.Name = "KaitoBloxFruit"
    sg.ResetOnSpawn = false

    -- NÚT ẢNH BẬT TẮT (SAD BOY)
    local toggleBtn = Instance.new("ImageButton", sg)
    toggleBtn.Size = UDim2.new(0, 50, 0, 50) -- Nhỏ hơn một chút
    toggleBtn.Position = UDim2.new(0, 10, 0.5, -25)
    toggleBtn.Image = "rbxassetid://95101112877359"
    toggleBtn.BackgroundTransparency = 0.4
    toggleBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
    Instance.new("UICorner", toggleBtn).CornerRadius = UDim.new(1, 0)

    -- Kéo thả nút ảnh
    local dragging, dragStart, startPos
    toggleBtn.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true; dragStart = input.Position; startPos = toggleBtn.Position
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
            local delta = input.Position - dragStart
            toggleBtn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
        end
    end)
    UserInputService.InputEnded:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end end)

    -- FRAME CHÍNH (GỌN GÀNG)
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 400, 0, 280) -- Size nhỏ gọn hơn
    main.Position = UDim2.new(0.5, -200, 0.5, -140)
    main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    main.BorderSizePixel = 0
    main.Visible = false
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 8)
    
    -- Viền mỏng cho đẹp
    local stroke = Instance.new("UIStroke", main)
    stroke.Color = Color3.fromRGB(255, 192, 216)
    stroke.Thickness = 1.2

    -- TIÊU ĐỀ CHỮ NHỎ
    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, -20, 0, 35)
    title.Position = UDim2.new(0, 10, 0, 0)
    title.Text = "KAITO HUB : BLOX FRUIT"
    title.Font = Enum.Font.Code -- Font chữ nhỏ, thanh mảnh
    title.TextSize = 13 -- Chữ siêu nhỏ gọn
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextXAlignment = Enum.TextXAlignment.Left
    title.BackgroundTransparency = 1

    -- Bật/tắt menu
    toggleBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        if main.Visible then
            main.ClipsDescendants = true
            main.Size = UDim2.new(0, 400, 0, 0)
            TweenService:Create(main, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 400, 0, 280)}):Play()
        end
    end)

    -- Danh sách chức năng (Scrolling)
    local scroll = Instance.new("ScrollingFrame", main)
    scroll.Size = UDim2.new(1, -20, 1, -50)
    scroll.Position = UDim2.new(0, 10, 0, 40)
    scroll.BackgroundTransparency = 1
    scroll.BorderSizePixel = 0
    scroll.ScrollBarThickness = 2
    
    local layout = Instance.new("UIListLayout", scroll)
    layout.Padding = UDim.new(0, 5)

    -- Hàm thêm nút chữ nhỏ
    local function AddMiniButton(name)
        local btn = Instance.new("TextButton", scroll)
        btn.Size = UDim2.new(1, -5, 0, 30)
        btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
        btn.Text = "  " .. name
        btn.Font = Enum.Font.Code
        btn.TextSize = 12
        btn.TextColor3 = Color3.fromRGB(200, 200, 200)
        btn.TextXAlignment = Enum.TextXAlignment.Left
        Instance.new("UICorner", btn)
        
        local bStroke = Instance.new("UIStroke", btn)
        bStroke.Color = Color3.fromRGB(50, 50, 50)
        bStroke.Thickness = 0.8
    end

    -- Test thử vài nút
    AddMiniButton("Auto Farm Level")
    AddMiniButton("Auto Farm Mastery")
    AddMiniButton("Teleport Sea 1-2-3")
    AddMiniButton("Fruit Notifier")

    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Kaito Hub",
        Text = "Blox Fruit Edition Loaded!",
        Duration = 3
    })
end

CreateKaitoBloxFruit()
