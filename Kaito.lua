local Services = setmetatable({}, {
    __index = function(self, serviceName)
        local service = game:GetService(serviceName)
        rawset(self, serviceName, service)
        return service
    end
})


local function NotificacaoNightMystic(titulo, mensagem)
    local success = pcall(function()
        -- Lấy Services an toàn (Hỗ trợ cả bảng Services của bạn hoặc mặc định của Roblox)
        local TweenService = (Services and Services.TweenService) or game:GetService("TweenService")
        local CoreGui = (Services and Services.CoreGui) or game:GetService("CoreGui")
        local RunService = (Services and Services.RunService) or game:GetService("RunService")
        local LogoID = "rbxassetid:"
        local duration = 5//16045543360

        -- 1. HỆ THỐNG XẾP CHỒNG (Tạo 1 lần duy nhất)
        local ScreenGui = CoreGui:FindFirstChild("NM_Premium_Notify")
        if not ScreenGui then
            ScreenGui = Instance.new("ScreenGui")
            ScreenGui.Name = "NM_Premium_Notify"
            ScreenGui.ResetOnSpawn = false
            ScreenGui.DisplayOrder = 9999
            ScreenGui.Parent = CoreGui
        end

        local Holder = ScreenGui:FindFirstChild("Holder")
        if not Holder then
            Holder = Instance.new("Frame")
            Holder.Name = "Holder"
            Holder.Parent = ScreenGui
            Holder.Size = UDim2.new(0, 300, 1, -40)
            Holder.Position = UDim2.new(1, -20, 1, -20)
            Holder.AnchorPoint = Vector2.new(1, 1)
            Holder.BackgroundTransparency = 1
            
            local Layout = Instance.new("UIListLayout")
            Layout.Parent = Holder
            Layout.VerticalAlignment = Enum.VerticalAlignment.Bottom
            Layout.SortOrder = Enum.SortOrder.LayoutOrder
            Layout.Padding = UDim.new(0, 12)
        end

        -- 2. TẠO KHUNG THÔNG BÁO CAO CẤP
        local Main = Instance.new("CanvasGroup")
        Main.Name = "PremiumNoti"
        Main.Parent = Holder
        Main.Size = UDim2.new(1, 0, 0, 80)
        Main.BackgroundColor3 = Color3.fromRGB(12, 12, 12)
        Main.BorderSizePixel = 0
        Main.GroupTransparency = 1 -- Bắt đầu tàng hình
        Main.Position = UDim2.new(1.2, 0, 0, 0) -- Nằm tít bên ngoài

        -- Viền Đỏ 255 - Dày 1
        local UIStroke = Instance.new("UIStroke")
        UIStroke.Parent = Main
        UIStroke.Color = Color3.fromRGB(255, 0, 0)
        UIStroke.Thickness = 1
        UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
        
        local UICorner = Instance.new("UICorner")
        UICorner.CornerRadius = UDim.new(0, 12)
        UICorner.Parent = Main

        -- ICON (Đã làm to và bo góc trực tiếp ảnh)
        local IconBg = Instance.new("Frame")
        IconBg.Parent = Main
        IconBg.Size = UDim2.new(0, 55, 0, 55)
        IconBg.Position = UDim2.new(0, 12, 0.5, -27)
        IconBg.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
        Instance.new("UICorner", IconBg).CornerRadius = UDim.new(0, 10)

        local Logo = Instance.new("ImageLabel")
        Logo.Parent = IconBg
        Logo.Size = UDim2.new(0.85, 0, 0.85, 0) -- Kích thước to hơn chút
        Logo.Position = UDim2.new(0.5, 0, 0.5, 0)
        Logo.AnchorPoint = Vector2.new(0.5, 0.5)
        Logo.BackgroundTransparency = 1
        Logo.Image = LogoID
        Logo.ScaleType = Enum.ScaleType.Fit
        Instance.new("UICorner", Logo).CornerRadius = UDim.new(0, 8) -- Bo tròn ảnh

        -- TITLE
        local Title = Instance.new("TextLabel")
        Title.Parent = Main
        Title.BackgroundTransparency = 1
        Title.Position = UDim2.new(0, 78, 0, 12)
        Title.Size = UDim2.new(1, -120, 0, 20)
        Title.Font = Enum.Font.GothamBold
        Title.Text = titulo
        Title.TextColor3 = Color3.fromRGB(255, 255, 255)
        Title.TextSize = 14
        Title.TextXAlignment = Enum.TextXAlignment.Left
        Title.TextTruncate = Enum.TextTruncate.AtEnd

        -- MESSAGE
        local Msg = Instance.new("TextLabel")
        Msg.Parent = Main
        Msg.BackgroundTransparency = 1
        Msg.Position = UDim2.new(0, 78, 0, 32)
        Msg.Size = UDim2.new(1, -120, 0, 35)
        Msg.Font = Enum.Font.GothamMedium
        Msg.Text = mensagem
        Msg.TextColor3 = Color3.fromRGB(200, 200, 200)
        Msg.TextSize = 12
        Msg.TextXAlignment = Enum.TextXAlignment.Left
        Msg.TextYAlignment = Enum.TextYAlignment.Top
        Msg.TextWrapped = true

        -- TIMER LABEL
        local TimerLabel = Instance.new("TextLabel")
        TimerLabel.Parent = Main
        TimerLabel.BackgroundTransparency = 1
        TimerLabel.Position = UDim2.new(1, -15, 0, 12)
        TimerLabel.Size = UDim2.new(0, 40, 0, 20)
        TimerLabel.AnchorPoint = Vector2.new(1, 0)
        TimerLabel.Font = Enum.Font.GothamBold
        TimerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        TimerLabel.TextSize = 13
        TimerLabel.TextXAlignment = Enum.TextXAlignment.Right

        -- 3. HIỆU ỨNG TRƯỢT CHẬM VÀO
        local tweenIn = TweenService:Create(
            Main, 
            TweenInfo.new(0.8, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out),
            {Position = UDim2.new(0, 0, 0, 0), GroupTransparency = 0}
        )
        tweenIn:Play()

        -- 4. LOGIC ĐẾM GIÂY VÀ TRƯỢT RA
        task.spawn(function()
            local start = tick()
            local render
            render = RunService.RenderStepped:Connect(function()
                if not Main or not Main.Parent then 
                    render:Disconnect() 
                    return 
                end
                local diff = tick() - start
                local remain = math.max(0, duration - diff)
                TimerLabel.Text = string.format("%.1f", remain)
                if remain <= 0 then 
                    render:Disconnect() 
                end
            end)

            task.wait(duration)

            if Main and Main.Parent then
                local tweenOut = TweenService:Create(
                    Main,
                    TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.In),
                    {Position = UDim2.new(1.2, 0, 0, 0), GroupTransparency = 1}
                )
                tweenOut:Play()
                tweenOut.Completed:Wait()
                Main:Destroy()
            end
        end)
    end)
    
    if not success then
        warn("[Kaito hub] Erro ao exibir notificação")
    end
end

-- ==========================================
-- GỌI THỬ ĐỂ TEST:
-- ==========================================
NotificacaoNightMystic("KAITO Notification 🔔", "New Update v4.0🔥")
task.wait(0.8)
NotificacaoNightMystic("KAITO Thông Báo 🔔", "Cập Nhật Mới v4.0🔥")

local HttpService = Services.HttpService
local FolderName = "Ai hỏi.json"
local FileName = "Settings.json"
local FullPath = FolderName .. "/" .. FileName

if makefolder and not isfolder(FolderName) then 
    makefolder(FolderName) 
end

_G.SaveData = _G.SaveData or {}

function SaveSettings()
    if not writefile then return false end
    local success = pcall(function()
        local json = HttpService:JSONEncode(_G.SaveData)
        writefile(FullPath, json)
    end)
    return success
end

function LoadSettings()
    if not (isfile and isfile(FullPath)) then return false end
    local success, result = pcall(function()
        local content = readfile(FullPath)
        return HttpService:JSONDecode(content)
    end)
    if success and result then 
        _G.SaveData = result
        return true
    end
    return false
end

function GetSetting(name, default)
    return _G.SaveData[name] ~= nil and _G.SaveData[name] or default
end

LoadSettings()
-- ========================================
-- PLAYER ESP (SỬ DỤNG HÀM G)
-- ========================================

local PlayerESPEnabled = false
local PlayerESPNumber = math.random(1, 1000000)

local function UpdatePlayerESP()
    for _, player in pairs(game:GetService("Players"):GetPlayers()) do
        pcall(function()
            -- Bỏ qua bản thân
            if player == game.Players.LocalPlayer then return end

            -- Kiểm tra nhân vật còn sống bằng G.Alive
            if not G.Alive(player.Character) then return end

            local head = player.Character:FindFirstChild("Head")
            if not head then return end

            if PlayerESPEnabled then
                -- Tạo BillboardGui nếu chưa có
                if not head:FindFirstChild("PlayerESP" .. PlayerESPNumber) then
                    local billboard = Instance.new("BillboardGui")
                    billboard.Name = "PlayerESP" .. PlayerESPNumber
                    billboard.Parent = head
                    billboard.Adornee = head
                    billboard.ExtentsOffset = Vector3.new(0, 1, 0)
                    billboard.Size = UDim2.new(1, 200, 1, 45)
                    billboard.AlwaysOnTop = true

                    local textLabel = Instance.new("TextLabel", billboard)
                    textLabel.BackgroundTransparency = 1
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.Font = Enum.Font.Code
                    textLabel.TextSize = 14
                    textLabel.TextWrapped = true
                    textLabel.TextYAlignment = Enum.TextYAlignment.Top
                    textLabel.TextStrokeTransparency = 0.5

                    -- Màu sắc theo team
                    if player.Team == game.Players.LocalPlayer.Team then
                        textLabel.TextColor3 = Color3.new(0, 0, 255)      -- Cùng team → xanh
                    else
                        textLabel.TextColor3 = Color3.new(255, 0, 0)      -- Khác team → đỏ
                    end
                end

                -- Cập nhật nội dung
                local label = head["PlayerESP" .. PlayerESPNumber].TextLabel
                local hpPercent = math.floor((player.Character.Humanoid.Health * 100) / player.Character.Humanoid.MaxHealth)
                local distance = math.floor((game.Players.LocalPlayer.Character.Head.Position - head.Position).Magnitude / 3)
                local level = player.Data.Level.Value

                label.Text = string.format("%s | Lv.%d\n%d%% | %dM", player.Name, level, hpPercent, distance)

            else
                -- Xóa ESP nếu tồn tại
                local esp = head:FindFirstChild("PlayerESP" .. PlayerESPNumber)
                if esp then esp:Destroy() end
            end
        end)
    end
end

-- Vòng lặp cập nhật
task.spawn(function()
    while task.wait(0.1) do
        if PlayerESPEnabled then
            pcall(UpdatePlayerESP)
        else
            -- Dọn dẹp khi tắt (đề phòng)
            for _, player in pairs(game.Players:GetPlayers()) do
                pcall(function()
                    if player.Character and player.Character:FindFirstChild("Head") then
                        local esp = player.Character.Head:FindFirstChild("PlayerESP" .. PlayerESPNumber)
                        if esp then esp:Destroy() end
                    end
                end)
            end
        end
    end
end)

-- Toggle trong giao diện

-- ========================================
-- AUTO KEN (Observation Haki)
-- ========================================

-- LOGIC AUTO CHEST BYPASS (khai báo trước)
-- ========================================
task.spawn(function()
    while task.wait() do
        if _G.ChestBypass then  -- dùng biến _G.ChestBypass
            local Players = game:GetService("Players")
            local LocalPlayer = Players.LocalPlayer
            local CollectionService = game:GetService("CollectionService")

            local character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
            local startTick = tick()

            while _G.ChestBypass and (tick() - startTick) < 4 do
                character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
                local charPos = character:GetPivot().Position
                local chests = CollectionService:GetTagged("_ChestTagged")

                local closest, dist = nil, math.huge
                for i = 1, #chests do
                    local chest = chests[i]
                    if not chest:GetAttribute("IsDisabled") then
                        local d = (chest:GetPivot().Position - charPos).Magnitude
                        if d < dist then
                            dist = d
                            closest = chest
                        end
                    end
                end

                if closest then
                    character:PivotTo(CFrame.new(closest:GetPivot().Position))
                    task.wait(0.2)
                else
                    break
                end
            end

            if _G.ChestBypass and LocalPlayer.Character then
                LocalPlayer.Character:Breakjoints()
                LocalPlayer.CharacterAdded:Wait()
            end
        end
    end
end)
local Players = Services.Players
local CollectionService = Services.CollectionService
local ReplicatedStorage = Services.ReplicatedStorage

local player = Players.LocalPlayer
local commE = ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("CommE")

_G.AutoKen = true

local function HasKen()
    local char = player.Character
    return char and CollectionService:HasTag(char, "Ken")
end

task.spawn(function()
    while _G.AutoKen do
        task.wait(0.2)
        if not HasKen() then
            pcall(function()
                commE:FireServer("Ken", true)
            end)
        end
    end
end)

-- ========================================
-- AUTO TEAM & LIGHTING
-- ========================================
local desiredTeam = "Marines"

if not player.Team or player.Team.Name ~= desiredTeam then
    pcall(function()
        ReplicatedStorage.Remotes.CommF_:InvokeServer("SetTeam", desiredTeam)
    end)
end

local Lighting = Services.Lighting

-- Full bright (optimized lighting)
Lighting.Ambient = Color3.new(0.695, 0.695, 0.695)
Lighting.ColorShift_Bottom = Color3.new(0.695, 0.695, 0.695)
Lighting.ColorShift_Top = Color3.new(0.695, 0.695, 0.695)
Lighting.Brightness = 2
Lighting.FogEnd = 1e10

-- ========================================
-- GLOBAL VARIABLES (Cached & Organized)
-- ========================================
do
    ply = Services.Players
    plr = ply.LocalPlayer
    Root = plr.Character.HumanoidRootPart
    replicated = Services.ReplicatedStorage
    Lv = plr.Data.Level.Value
    TeleportService = Services.TeleportService
    TW = Services.TweenService
    Lighting = Services.Lighting
    Enemies = workspace.Enemies
    vim1 = Services.VirtualInputManager
    vim2 = Services.VirtualUser
    TeamSelf = plr.Team
    RunSer = Services.RunService
    Stats = Services.Stats
    Energy = plr.Character.Energy.Value
    
    -- Tables
    Boss = {}
    BringConnections = {}
    MaterialList = {}
    NPCList = {}
    
    -- Flags
    shouldTween = false
    SoulGuitar = false
    KenTest = true
    debug = false
    Brazier1 = false
    Brazier2 = false
    Brazier3 = false
    Sec = 0.1
    ClickState = 0
    Num_self = 25
end

-- Wait for game to load
repeat
    local loading = plr.PlayerGui:FindFirstChild("Main")
    loading = loading and loading:FindFirstChild("Loading")
    task.wait()
until game:IsLoaded() and not (loading and loading.Visible)

-- World Detection (Optimized)
local placeId = game.PlaceId
if placeId == 2753915549 or placeId == 85211729168715 then
    World1 = true
elseif placeId == 4442272183 or placeId == 79091703265657 then
    World2 = true
elseif placeId == 7449423635 or placeId == 100117331123089 then
    World3 = true
else
    plr:Kick("❌ Error Blox Fruits - World not recognized")
end

Sea = World1 or World2 or World3

Marines = function()
    replicated.Remotes.CommF_:InvokeServer("SetTeam", "Marines")
end

Pirates = function()
    replicated.Remotes.CommF_:InvokeServer("SetTeam", "Pirates")
end
if World1 then
	Boss = {
			"The Gorilla King",
			"Bobby",
			"The Saw",
			"Yeti",
			"Mob Leader",
			"Vice Admiral",
			"Saber Expert",
			"Warden",
			"Chief Warden",
			"Swan",
			"Magma Admiral",
			"Fishman Lord",
			"Wysper",
			"Thunder God",
			"Cyborg",
			"Ice Admiral",
			"Greybeard",
		};
elseif World2 then
	Boss = {
			"Diamond",
			"Jeremy",
			"Fajita",
			"Don Swan",
			"Smoke Admiral",
			"Awakened Ice Admiral",
			"Tide Keeper",
			"Darkbeard",
			"Cursed Captain",
			"Order",
		};
elseif World3 then
	Boss = {
			"Stone",
			"Hydra Leader",
			"Kilo Admiral",
			"Captain Elephant",
			"Beautiful Pirate",
			"Cake Queen",
			"Longma",
			"Soul Reaper",
		};
end;
if World1 then
	MaterialList = {
			"Leather + Scrap Metal",
			"Angel Wings",
			"Magma Ore",
			"Fish Tail",
		};
elseif World2 then
	MaterialList = {
			"Leather + Scrap Metal",
			"Radioactive Material",
			"Ectoplasm",
			"Mystic Droplet",
			"Magma Ore",
			"Vampire Fang",
		};
elseif World3 then
	MaterialList = {
			"Scrap Metal",
			"Demonic Wisp",
			"Conjured Cocoa",
			"Dragon Scale",
			"Gunpowder",
			"Fish Tail",
			"Mini Tusk",
		};
end;
local e = {
		"Flame",
		"Ice",
		"Quake",
		"Light",
		"Dark",
		"String",
		"Rumble",
		"Magma",
		"Human: Buddha",
		"Sand",
		"Bird: Phoenix",
		"Dough",
	};
local K = {
		"Snow Lurker",
		"Arctic Warrior",
		"Hidden Key",
		"Awakened Ice Admiral",
	};
local n = {
		Mob = "Mythological Pirate",
		Mob2 = "Cursed Skeleton",
		"Hell\'s Messenger",
		Mob3 = "Cursed Skeleton",
		"Heaven\'s Guardian",
	};
local d = {
		"Part",
		"SpawnLocation",
		"Terrain",
		"WedgePart",
		"MeshPart",
	};
local z = { "Swan Pirate", "Jeremy" };
local H = { "Forest Pirate", "Captain Elephant" };
local F = { "Fajita", "Jeremy", "Diamond" };
local Q = {
		"Beast Hunter",
		"Lantern",
		"Guardian",
		"Grand Brigade",
		"Dinghy",
		"Sloop",
		"The Sentinel",
	};
local X = { "Cookie Crafter", "Head Baker", "Baking Staff", "Cake Guard" };
local P = { "Reborn Skeleton", "Posessed Mummy", "Demonic Soul", "Living Zombie" };
local w = {
		["Pirate Millionaire"] = CFrame.new(-712.82727050781, 98.577049255371, 5711.9541015625),
		["Pistol Billionaire"] = CFrame.new(-723.43316650391, 147.42906188965, 5931.9931640625),
		["Dragon Crew Warrior"] = CFrame.new(7021.5043945312, 55.762702941895, -730.12908935547),
		["Dragon Crew Archer"] = CFrame.new(6625, 378, 244),
		["Female Islander"] = CFrame.new(4692.7939453125, 797.97668457031, 858.84802246094),
		["Venomous Assailant"] = CFrame.new(4902, 670, 39),
		["Marine Commodore"] = CFrame.new(2401, 123, -7589),
		["Marine Rear Admiral"] = CFrame.new(3588, 229, -7085),
		["Fishman Raider"] = CFrame.new(-10941, 332, -8760),
		["Fishman Captain"] = CFrame.new(-11035, 332, -9087),
		["Forest Pirate"] = CFrame.new(-13446, 413, -7760),
		["Mythological Pirate"] = CFrame.new(-13510, 584, -6987),
		["Jungle Pirate"] = CFrame.new(-11778, 426, -10592),
		["Musketeer Pirate"] = CFrame.new(-13282, 496, -9565),
		["Reborn Skeleton"] = CFrame.new(-8764, 142, 5963),
		["Living Zombie"] = CFrame.new(-10227, 421, 6161),
		["Demonic Soul"] = CFrame.new(-9579, 6, 6194),
		["Posessed Mummy"] = CFrame.new(-9579, 6, 6194),
		["Peanut Scout"] = CFrame.new(-1993, 187, -10103),
		["Peanut President"] = CFrame.new(-2215, 159, -10474),
		["Ice Cream Chef"] = CFrame.new(-877, 118, -11032),
		["Ice Cream Commander"] = CFrame.new(-877, 118, -11032),
		["Cookie Crafter"] = CFrame.new(-2021, 38, -12028),
		["Cake Guard"] = CFrame.new(-2024, 38, -12026),
		["Baking Staff"] = CFrame.new(-1932, 38, -12848),
		["Head Baker"] = CFrame.new(-1932, 38, -12848),
		["Cocoa Warrior"] = CFrame.new(95, 73, -12309),
		["Chocolate Bar Battler"] = CFrame.new(647, 42, -12401),
		["Sweet Thief"] = CFrame.new(116, 36, -12478),
		["Candy Rebel"] = CFrame.new(47, 61, -12889),
		Ghost = CFrame.new(5251, 5, 1111),
	};
EquipWeapon = function(I)
		if not I then
			return;
		end;
		if plr.Backpack:FindFirstChild(I) then
			plr.Character.Humanoid:EquipTool(plr.Back
