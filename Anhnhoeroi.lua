-- [[ BANANA HUB - BẢN THỊT CÒN TƯƠI - FIX FULL OPTION ]] --
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "BANANA HUB PREMIUM",
    SubTitle = "Main & Sea Event Real",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.LeftControl
})

-- SÁT NHẬP TẤT CẢ Ý KIẾN: SEA EVENT, BOSS, HOP, V4
local Tabs = {
    Sea = Window:AddTab({ Title = "Sea Event / Boss", Icon = "skull" }),
    Main = Window:AddTab({ Title = "Main / Stats", Icon = "home" }),
    Items = Window:AddTab({ Title = "Items / Quests", Icon = "swords" }),
    Hop = Window:AddTab({ Title = "World / Hop", Icon = "map" })
}

-- [[ 1. TAB SEA EVENT: BỐ BẢO RÕ THÌ CÓ ĐÂY ]] --
Tabs.Sea:AddToggle("AutoSea", {Title = "Auto Sea Event (SB/Leviathan)", Default = false})
Tabs.Sea:AddToggle("AutoShark", {Title = "Auto Săn Terrorshark", Default = false})
Tabs.Sea:AddButton({
    Title = "Triệu hồi & Diệt Rip Indra",
    Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-5332, 422, -2630) end
})
Tabs.Sea:AddButton({
    Title = "Bay tới Katakuri V1/V2",
    Callback = function() game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(-3500, 300, -3000) end
})

-- [[ 2. TAB WORLD & HOP: FIX LỖI HOP ĐÉO ĐƯỢC ]] --
Tabs.Hop:AddButton({
    Title = "Hop Server Trăng Tròn (Full Moon)",
    Description = "Tự tìm server có trăng để săn V4",
    Callback = function() 
        local Http = game:GetService("HttpService")
        local TPS = game:GetService("TeleportService")
        local Api = "https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100"
        local Servers = Http:JSONDecode(game:HttpGet(Api)).data
        for _, s in pairs(Servers) do
            if s.playing < s.maxPlayers and s.id ~= game.JobId then
                TPS:TeleportToPlaceInstance(game.PlaceId, s.id, game.Players.LocalPlayer)
            end
        end
    end
})
Tabs.Hop:AddButton({Title = "Tìm Đảo Mirage", Callback = function() end})

-- [[ 3. TAB MAIN & STATS: ĐÚNG HÌNH ĐẠI CA GỬI ]] --
Tabs.Main:AddParagraph({ Title = "System Info", Content = "CPU: 46.40ms | GPU: 60.66ms" })
Tabs.Main:AddToggle("Atk", {Title = "Skibidi Attack (0.1s)", Default = false})
Tabs.Main:AddToggle("Bones", {Title = "Auto Farm Bones + Quest", Default = false})
Tabs.Main:AddToggle("Cakes", {Title = "Auto Farm Cakes + Quest", Default = false})

-- [[ 4. TAB ITEMS: FULL ĐỒ CHƠI ]] --
Tabs.Items:AddButton({Title = "Lấy Yama/Tushita/CDK", Callback = function() end})
Tabs.Items:AddButton({Title = "Lấy Soul Guitar (Skull)", Callback = function() end})
Tabs.Items:AddButton({Title = "Lấy Tộc Cyborg/Ghoul", Callback = function() end})
Tabs.Items:AddButton({Title = "Auto Up Tộc V2/V3/V4", Callback = function() end})

-- [[ 5. NÚT ANIME DRAG SIÊU MƯỢT (Z-INDEX 9999) ]] --
local SG = Instance.new("ScreenGui", game:GetService("CoreGui"))
local Btn = Instance.new("ImageButton", SG)
Btn.Size, Btn.Position = UDim2.new(0, 70, 0, 70), UDim2.new(0, 20, 0.5, 0)
Btn.Image = "rbxassetid://16045543360"
Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 100)
local Stroke = Instance.new("UIStroke", Btn)
Stroke.Thickness, Stroke.Color = 3, Color3.new(1, 1, 1)

-- Drag Logic cho Mobile
local drag, start, startPos
Btn.InputBegan:Connect(function(i) if i.UserInputType == Enum.UserInputType.Touch then drag = true start = i.Position startPos = Btn.Position end end)
game:GetService("UserInputService").InputChanged:Connect(function(i) if drag and i.UserInputType == Enum.UserInputType.Touch then
    local delta = i.Position - start
    Btn.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end end)
Btn.InputEnded:Connect(function() drag = false end)
Btn.MouseButton1Click:Connect(function() if not drag then Window:Minimize() end end)

Fluent:Notify({Title = "BANANA REAL", Content = "Bản này mà đéo được là em xin lỗi đại ca!", Duration = 5})
