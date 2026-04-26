-- [[ KAITO HUB V4 - FULL REMASTERED ]]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local StarterGui = game:GetService("StarterGui")
local TweenService = game:GetService("TweenService")

local LocalPlayer = Players.LocalPlayer
local PlantRemote = ReplicatedStorage.RemoteEvents:WaitForChild("PlantSeed")
local PurchaseShopItemRemote = ReplicatedStorage.RemoteEvents:FindFirstChild("PurchaseShopItem")
local GetShopDataRemote = ReplicatedStorage.RemoteEvents:FindFirstChild("GetShopData")
local ClaimQuestRemote = ReplicatedStorage.RemoteEvents:FindFirstChild("ClaimQuest")
local RequestQuestsRemote = ReplicatedStorage.RemoteEvents:FindFirstChild("RequestQuests")
local UpdateQuestsRemote = ReplicatedStorage.RemoteEvents:FindFirstChild("UpdateQuests")
local SellItemsRemote = ReplicatedStorage.RemoteEvents:FindFirstChild("SellItems")

-- [ SETTINGS ĐẦY ĐỦ ]
local Settings = {
    Enabled = false,
    AutoHarvestTeleport = false,
    IgnoreFavorited = true,
    AutoPlantAtCharacter = false,
    AutoEquipPlantSeeds = false,
    SavedPlantPosition = nil,
    SelectedSeed = nil,
    TeleportToShopOnBuy = true,
    CheckSeedStockBeforeBuy = true,
    AutoBuyLoop = false,
    AutoBuyDelay = 1.0,
    SeedShopNpcPosition = Vector3.new(177, 204, 672),
    AutoSellLoop = false,
    AutoSellDelay = 1.0,
    AutoSellOnlyWhenInventoryFull = false,
    InventoryFullSellCooldown = 1.0,
    SellMode = "Sell All",
    TeleportToSellNpcOnSell = true,
    SellNpcPosition = Vector3.new(150, 204, 674),
    AutoClaimQuests = false,
    AutoClaimQuestDelay = 1.0,
    Range = 50,
    HarvestBatchSize = 10,
    Delay = 0.1,
}

local lastPlantTime, lastAutoSellTime, lastInventoryFullSellTime = 0, 0, 0
local lastAutoClaimQuestTime = 0
local warnedMissingQuestRemotes, warnedMissingSellRemotes = false, false

-- [ HÀM HỖ TRỢ ]
local function Notify(text, duration)
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "Kaito Hub V4",
            Text = text,
            Duration = duration or 3
        })
    end)
end

local function trySell(mode, teleport)
    if SellItemsRemote then
        if teleport and Settings.SellNpcPosition and LocalPlayer.Character then
            LocalPlayer.Character:MoveTo(Settings.SellNpcPosition)
        end
        SellItemsRemote:InvokeServer(mode)
    end
end

local function autoClaimQuests()
    if ClaimQuestRemote then ClaimQuestRemote:FireServer() end
end

local function shouldSellFromInventoryFullNotification()
    -- Logic kiểm tra túi đầy (Bạn có thể tùy chỉnh thêm)
    return true 
end

-- [ GIAO DIỆN KAITO HUB V4 ]
local function CreateKaitoUI()
    local sg = Instance.new("ScreenGui", CoreGui)
    sg.Name = "KaitoHubV4"
    sg.ResetOnSpawn = false

    -- NÚT ẢNH BẬT TẮT (SAD BOY)
    local toggleBtn = Instance.new("ImageButton", sg)
    toggleBtn.Size = UDim2.new(0, 65, 0, 65)
    toggleBtn.Position = UDim2.new(0, 15, 0.5, -32)
    toggleBtn.Image = "rbxassetid://95101112877359" -- Ảnh Sad Boy từ file của bạn
    toggleBtn.BackgroundTransparency = 0.3
    toggleBtn.BackgroundColor3 = Color3.fromRGB(255, 192, 216)
    toggleBtn.BorderSizePixel = 0
    local corner = Instance.new("UICorner", toggleBtn)
    corner.CornerRadius = UDim.new(1, 0)
    
    -- Kéo thả nút ảnh
    local dragging, dragInput, dragStart, startPos
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

    -- FRAME CHÍNH (PINK STYLE)
    local main = Instance.new("Frame", sg)
    main.Size = UDim2.new(0, 550, 0, 380)
    main.Position = UDim2.new(0.5, -275, 0.5, -190)
    main.BackgroundColor3 = Color3.fromRGB(255, 224, 235)
    main.Visible = false
    Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

    -- Mở/Đóng menu
    toggleBtn.MouseButton1Click:Connect(function()
        main.Visible = not main.Visible
        if main.Visible then
            main:TweenSize(UDim2.new(0, 550, 0, 380), "Out", "Back", 0.3, true)
        end
    end)

    local title = Instance.new("TextLabel", main)
    title.Size = UDim2.new(1, 0, 0, 50)
    title.Text = "KAITO HUB V4"
    title.Font = Enum.Font.GothamBold
    title.TextSize = 24
    title.TextColor3 = Color3.fromRGB(120, 60, 90)
    title.BackgroundTransparency = 1

    return main
end

-- [ VÒNG LẶP CHÍNH - GỘP LOGIC CỦA BẠN ]
task.spawn(function()
    while task.wait(Settings.Delay) do
        local now = tick()
        local ok, err = pcall(function()
            if not Settings.Enabled then return end

            -- LOGIC AUTO SELL
            if Settings.AutoSellLoop then
                if not SellItemsRemote then
                    if not warnedMissingSellRemotes then 
                        warnedMissingSellRemotes = true; Notify("SellItems remote not found.", 3) 
                    end
                elseif now - lastAutoSellTime >= Settings.AutoSellDelay then
                    lastAutoSellTime = now
                    if Settings.AutoSellOnlyWhenInventoryFull then
                        if now - lastInventoryFullSellTime >= Settings.InventoryFullSellCooldown and shouldSellFromInventoryFullNotification() then
                            lastInventoryFullSellTime = now
                            trySell(Settings.SellMode, Settings.TeleportToSellNpcOnSell)
                        end
                    else
                        trySell(Settings.SellMode, Settings.TeleportToSellNpcOnSell)
                    end
                end
            end

            -- LOGIC AUTO QUEST
            if Settings.AutoClaimQuests then
                if not (ClaimQuestRemote and RequestQuestsRemote and UpdateQuestsRemote) then
                    if not warnedMissingQuestRemotes then 
                        warnedMissingQuestRemotes = true; Notify("Quest remotes not found.", 3) 
                    end
                else
                    if now - lastAutoClaimQuestTime >= Settings.AutoClaimQuestDelay then
                        lastAutoClaimQuestTime = now
                        autoClaimQuests()
                    end
                end
            end
        end)
        if not ok then warn("[Kaito Hub V4] Main loop error:", err) end
    end
end)

CreateKaitoUI()
Notify("Kaito Hub V4 đã tải xong! Nhấn vào ảnh để mở.", 5)
