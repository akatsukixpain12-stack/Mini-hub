--// QUANTUM ONYX PROJECT v7.8 - BLOX FRUITS FULL HUB
-- Optimized for Delta Executor | Clean Professional Style | Many Features Added
-- All previous features (Aimbot, Silent Aim, FOV, Player List, Fast Attack, etc.) untouched

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Workspace = game:GetService("Workspace")
local VirtualUser = game:GetService("VirtualUser")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local camera = Workspace.CurrentCamera

-- Safe Anti-Detection for Delta
print("🔒 Quantum Onyx Anti-Detection v3.1 Loading...")
pcall(function()
    local mt = getrawmetatable(game)
    if mt then
        setreadonly(mt, false)
        local oldNamecall = mt.__namecall
        mt.__namecall = newcclosure(function(self, ...)
            local method = getnamecallmethod()
            if method == "Kick" or method == "kick" then return end
            if method == "FireServer" then
                local tn = tostring(self)
                if tn:find("Kick") or tn:find("Ban") or tn:find("Anti") then return end
            end
            return oldNamecall(self, ...)
        end)
        setreadonly(mt, true)
    end
end)

-- Destroy old GUI
if player.PlayerGui:FindFirstChild("QuantumOnyxProject") then
    player.PlayerGui.QuantumOnyxProject:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "QuantumOnyxProject"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

-- Mini-open button
local openBtn = Instance.new("TextButton")
openBtn.Name = "OpenQuantumOnyx"
openBtn.Size = UDim2.new(0, 170, 0, 42)
openBtn.Position = UDim2.new(0, 20, 0.5, 0)
openBtn.Text = "🔶 Open Quantum"
openBtn.TextColor3 = Color3.new(1, 1, 1)
openBtn.BackgroundColor3 = Color3.fromRGB(255, 120, 0)
openBtn.Visible = false
openBtn.Parent = gui
Instance.new("UICorner", openBtn).CornerRadius = UDim.new(0, 10)

-- Main Frame
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 820, 0, 560)
main.Position = UDim2.new(0.5, -410, 0.5, -280)
main.BackgroundColor3 = Color3.fromRGB(18, 18, 22)
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 12)

-- Title Bar
local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 55)
titleBar.BackgroundColor3 = Color3.fromRGB(255, 100, 0)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 12)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, -220, 1, 0)
title.Position = UDim2.new(0, 20, 0, 0)
title.Text = "Quantum Onyx Project - Blox Fruits • v7.8"
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 24
title.BackgroundTransparency = 1

local minBtn = Instance.new("TextButton", titleBar)
minBtn.Size = UDim2.new(0, 45, 0, 45)
minBtn.Position = UDim2.new(1, -110, 0, 5)
minBtn.Text = "–"
minBtn.BackgroundColor3 = Color3.fromRGB(0, 170, 0)
minBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", minBtn).CornerRadius = UDim.new(1, 0)

local closeBtn = Instance.new("TextButton", titleBar)
closeBtn.Size = UDim2.new(0, 45, 0, 45)
closeBtn.Position = UDim2.new(1, -60, 0, 5)
closeBtn.Text = "✕"
closeBtn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
closeBtn.TextColor3 = Color3.new(1, 1, 1)
Instance.new("UICorner", closeBtn).CornerRadius = UDim.new(1, 0)

-- Dragging
local dragging, dragStart, startPos = false, nil, nil
titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)
UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
end)

minBtn.MouseButton1Click:Connect(function() main.Visible = false; openBtn.Visible = true end)
openBtn.MouseButton1Click:Connect(function() main.Visible = true; openBtn.Visible = false end)
closeBtn.MouseButton1Click:Connect(function() gui:Destroy() end)

-- Tab System
local tabFrame = Instance.new("Frame", main)
tabFrame.Size = UDim2.new(0, 200, 1, -60)
tabFrame.Position = UDim2.new(0, 10, 0, 60)
tabFrame.BackgroundTransparency = 1

local contentFrame = Instance.new("Frame", main)
contentFrame.Size = UDim2.new(1, -220, 1, -60)
contentFrame.Position = UDim2.new(0, 215, 0, 60)
contentFrame.BackgroundTransparency = 1

local pages = {}
local tabY = 0

local function createTab(name, icon)
    local btn = Instance.new("TextButton", tabFrame)
    btn.Size = UDim2.new(1, 0, 0, 50)
    btn.Position = UDim2.new(0, 0, 0, tabY)
    btn.Text = "  " .. icon .. "   " .. name
    btn.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.Font = Enum.Font.GothamSemibold
    btn.TextSize = 18
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)

    local page = Instance.new("ScrollingFrame", contentFrame)
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.ScrollBarThickness = 6
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 2800)
    pages[name] = page

    btn.MouseButton1Click:Connect(function()
        for _, p in pairs(pages) do p.Visible = false end
        page.Visible = true
    end)

    tabY = tabY + 55
    return page
end

local mainFarm = createTab("Main Farm", "⚔️")
local sub = createTab("Sub", "🔧")
local seaEvent = createTab("Sea Event", "🌊")
local playerTab = createTab("Player", "👤")
local dragon = createTab("Dragon Update", "🐉")
local dungeon = createTab("Dungeon", "🏰")
local mastery = createTab("Mastery", "⭐")
local fruit = createTab("Fruits + 8X Luck", "🍎")
local raid = createTab("Raid", "💥")
local esp = createTab("ESP", "👁️")
local settings = createTab("Settings", "⚙️")

pages["Main Farm"].Visible = true

-- Feature States
local featureState = {
    autoFarm = false,
    takeQuest = false,
    fastAttack = false,
    bringMobs = false,
    aimbot = false,
    silentAim = false,
    tweenSpeed = 2.8,
    farmDistance = 12,
    bringRadius = 260,
    nearestDistance = 1200,
    attackSpeed = 10,
    aimbotFOV = 180,
    silentAimFOV = 220,
    selectedPlayer = nil,
    -- All previous + many new real-hub features
    autoMastery = false,
    autoRaid = false,
    autoBoss = false,
    autoSeaEvent = false,
    autoFruit = false,
    autoHaki = false,
    autoSkill = false,
    serverHop = false,
    antiAFK = false,
    autoChest = false,
    autoFishing = false,
    fruitESP = false,
    autoStat = false,
    autoBuyStyle = false,
    teleportMirage = false,
    killAura = false,
    noClip = false,
    fpsBoost = false,
    autoRaceV4 = false,
    chestESP = false,
    autoFragments = false,
    autoDungeon = false,
    autoTrial = false,
    autoMaterial = false,
    autoGodhuman = false,
    autoDragon = false
}

-- UI Helpers
local function createToggle(parent, text, y, defaultValue, callback)
    local state = defaultValue
    local btn = Instance.new("TextButton", parent)
    btn.Size = UDim2.new(0, 360, 0, 48)
    btn.Position = UDim2.new(0, 20, 0, y)
    btn.BackgroundColor3 = state and Color3.fromRGB(0, 220, 100) or Color3.fromRGB(45, 45, 55)
    btn.Text = "  " .. text .. "   [" .. (state and "ON ✅" or "OFF") .. "]"
    btn.TextColor3 = Color3.new(1, 1, 1)
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.Font = Enum.Font.Gotham
    btn.TextSize = 17
    Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 10)

    btn.MouseButton1Click:Connect(function()
        state = not state
        btn.Text = "  " .. text .. "   [" .. (state and "ON ✅" or "OFF") .. "]"
        btn.BackgroundColor3 = state and Color3.fromRGB(0, 220, 100) or Color3.fromRGB(45, 45, 55)
        if callback then callback(state) end
    end)
end

local function createSlider(parent, text, y, minV, maxV, defaultV, callback)
    local current = defaultV
    local frame = Instance.new("Frame", parent)
    frame.Size = UDim2.new(0, 360, 0, 70)
    frame.Position = UDim2.new(0, 20, 0, y)
    frame.BackgroundTransparency = 1

    local label = Instance.new("TextLabel", frame)
    label.Size = UDim2.new(1, 0, 0, 25)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.new(1, 1, 1)
    label.TextSize = 16
    label.Font = Enum.Font.Gotham
    label.Text = text .. ": " .. tostring(current)

    local bar = Instance.new("Frame", frame)
    bar.Size = UDim2.new(1, 0, 0, 18)
    bar.Position = UDim2.new(0, 0, 0, 36)
    bar.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    Instance.new("UICorner", bar).CornerRadius = UDim.new(1, 0)

    local fill = Instance.new("Frame", bar)
    fill.Size = UDim2.new((current - minV) / (maxV - minV), 0, 1, 0)
    fill.BackgroundColor3 = Color3.fromRGB(255, 140, 0)
    Instance.new("UICorner", fill).CornerRadius = UDim.new(1, 0)

    local dragging = false
    bar.InputBegan:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = true end
    end)
    UserInputService.InputEnded:Connect(function(i)
        if i.UserInputType == Enum.UserInputType.MouseButton1 then dragging = false end
    end)

    UserInputService.InputChanged:Connect(function(i)
        if not dragging then return end
        local ratio = math.clamp((i.Position.X - bar.AbsolutePosition.X) / bar.AbsoluteSize.X, 0, 1)
        fill.Size = UDim2.new(ratio, 0, 1, 0)
        current = math.floor(minV + (maxV - minV) * ratio)
        label.Text = text .. ": " .. tostring(current)
        if callback then callback(current) end
    end)
end

-- Main Farm UI - Original + All Added Features (Real Hub Style)
createToggle(mainFarm, "Auto Farm", 20, false, function(v) featureState.autoFarm = v end)
createToggle(mainFarm, "Take Quest", 80, false, function(v) featureState.takeQuest = v end)
createToggle(mainFarm, "Fast Attack", 140, false, function(v) featureState.fastAttack = v end)
createToggle(mainFarm, "Bring Mobs", 200, false, function(v) featureState.bringMobs = v end)
createToggle(mainFarm, "Aimbot (Visible Camlock)", 260, false, function(v) featureState.aimbot = v end)
createToggle(mainFarm, "Silent Aim (Neon)", 320, false, function(v) featureState.silentAim = v end)

createSlider(mainFarm, "Tweening Speed", 390, 250, 350, 280, function(v) featureState.tweenSpeed = v / 100 end)
createSlider(mainFarm, "Farm Distance", 470, 4, 30, 12, function(v) featureState.farmDistance = v end)
createSlider(mainFarm, "Bring Radius", 550, 50, 500, 260, function(v) featureState.bringRadius = v end)
createSlider(mainFarm, "Nearest Distance", 630, 200, 3000, 1200, function(v) featureState.nearestDistance = v end)
createSlider(mainFarm, "Attack Speed (per sec)", 710, 1, 20, 10, function(v) featureState.attackSpeed = v end)
createSlider(mainFarm, "Aimbot FOV", 790, 50, 400, 180, function(v) featureState.aimbotFOV = v end)
createSlider(mainFarm, "Silent Aim FOV", 870, 50, 400, 220, function(v) featureState.silentAimFOV = v end)

-- Real Hub Features
createToggle(mainFarm, "Auto Mastery", 940, false, function(v) featureState.autoMastery = v end)
createToggle(mainFarm, "Auto Raid", 1000, false, function(v) featureState.autoRaid = v end)
createToggle(mainFarm, "Auto Boss", 1060, false, function(v) featureState.autoBoss = v end)
createToggle(mainFarm, "Auto Sea Event", 1120, false, function(v) featureState.autoSeaEvent = v end)
createToggle(mainFarm, "Auto Fruit / Sniper", 1180, false, function(v) featureState.autoFruit = v end)
createToggle(mainFarm, "Auto Haki", 1240, false, function(v) featureState.autoHaki = v end)
createToggle(mainFarm, "Auto Skill", 1300, false, function(v) featureState.autoSkill = v end)
createToggle(mainFarm, "Server Hop", 1360, false, function(v) featureState.serverHop = v end)
createToggle(mainFarm, "Anti-AFK", 1420, false, function(v) featureState.antiAFK = v end)
createToggle(mainFarm, "Auto Chest Farm", 1480, false, function(v) featureState.autoChest = v end)
createToggle(mainFarm, "Auto Fishing", 1540, false, function(v) featureState.autoFishing = v end)
createToggle(mainFarm, "Fruit ESP", 1600, false, function(v) featureState.fruitESP = v end)
createToggle(mainFarm, "Auto Stat Points", 1660, false, function(v) featureState.autoStat = v end)
createToggle(mainFarm, "Auto Buy Style/Sword", 1720, false, function(v) featureState.autoBuyStyle = v end)
createToggle(mainFarm, "Teleport Mirage/Full Moon", 1780, false, function(v) featureState.teleportMirage = v end)
createToggle(mainFarm, "Kill Aura", 1840, false, function(v) featureState.killAura = v end)
createToggle(mainFarm, "No Clip / Walk on Water", 1900, false, function(v) featureState.noClip = v end)
createToggle(mainFarm, "FPS Boost", 1960, false, function(v) featureState.fpsBoost = v end)
createToggle(mainFarm, "Auto Race V4", 2020, false, function(v) featureState.autoRaceV4 = v end)
createToggle(mainFarm, "Chest ESP", 2080, false, function(v) featureState.chestESP = v end)
createToggle(mainFarm, "Auto Fragments / Beli", 2140, false, function(v) featureState.autoFragments = v end)
createToggle(mainFarm, "Auto Dungeon", 2200, false, function(v) featureState.autoDungeon = v end)
createToggle(mainFarm, "Auto Trial", 2260, false, function(v) featureState.autoTrial = v end)
createToggle(mainFarm, "Auto Material Farm", 2320, false, function(v) featureState.autoMaterial = v end)
createToggle(mainFarm, "Auto Godhuman", 2380, false, function(v) featureState.autoGodhuman = v end)
createToggle(mainFarm, "Auto Dragon / T-Rex", 2440, false, function(v) featureState.autoDragon = v end)

-- Player List Selector (Square UI)
local playerListFrame = Instance.new("Frame", mainFarm)
playerListFrame.Size = UDim2.new(0, 360, 0, 180)
playerListFrame.Position = UDim2.new(0, 20, 0, 2500)
playerListFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 35)

local playerListLabel = Instance.new("TextLabel", playerListFrame)
playerListLabel.Size = UDim2.new(1, 0, 0, 30)
playerListLabel.Text = "🎯 Target Player (Priority)"
playerListLabel.TextColor3 = Color3.new(1,1,1)
playerListLabel.BackgroundTransparency = 1
playerListLabel.Font = Enum.Font.GothamBold
playerListLabel.TextSize = 18

local playerDropdown = Instance.new("TextButton", playerListFrame)
playerDropdown.Size = UDim2.new(1, -20, 0, 40)
playerDropdown.Position = UDim2.new(0, 10, 0, 40)
playerDropdown.Text = "None (Closest Target)"
playerDropdown.BackgroundColor3 = Color3.fromRGB(45,45,55)
playerDropdown.TextColor3 = Color3.new(1,1,1)

local isListOpen = false
local dropdownList = Instance.new("ScrollingFrame", playerListFrame)
dropdownList.Size = UDim2.new(1, -20, 0, 100)
dropdownList.Position = UDim2.new(0, 10, 0, 90)
dropdownList.BackgroundColor3 = Color3.fromRGB(25,25,30)
dropdownList.Visible = false
dropdownList.ScrollBarThickness = 6

playerDropdown.MouseButton1Click:Connect(function()
    isListOpen = not isListOpen
    dropdownList.Visible = isListOpen
end)

local function refreshPlayerList()
    for _, child in pairs(dropdownList:GetChildren()) do
        if child:IsA("TextButton") then child:Destroy() end
    end
    local y = 0
    local noneBtn = Instance.new("TextButton", dropdownList)
    noneBtn.Size = UDim2.new(1,0,0,30)
    noneBtn.Position = UDim2.new(0,0,0,y)
    noneBtn.Text = "None (Closest Target)"
    noneBtn.BackgroundTransparency = 1
    noneBtn.TextColor3 = Color3.new(1,1,1)
    noneBtn.MouseButton1Click:Connect(function()
        featureState.selectedPlayer = nil
        playerDropdown.Text = "None (Closest Target)"
        dropdownList.Visible = false
    end)
    y = y + 35

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr \~= player then
            local btn = Instance.new("TextButton", dropdownList)
            btn.Size = UDim2.new(1,0,0,30)
            btn.Position = UDim2.new(0,0,0,y)
            btn.Text = plr.Name
            btn.BackgroundTransparency = 1
            btn.TextColor3 = Color3.new(1,1,1)
            btn.MouseButton1Click:Connect(function()
                featureState.selectedPlayer = plr
                playerDropdown.Text = plr.Name
                dropdownList.Visible = false
            end)
            y = y + 35
        end
    end
    dropdownList.CanvasSize = UDim2.new(0,0,0,y)
end

Players.PlayerAdded:Connect(refreshPlayerList)
Players.PlayerRemoving:Connect(refreshPlayerList)
refreshPlayerList()

-- FOV Circle (thick & bright like videos)
local fovCircle = Drawing.new("Circle")
fovCircle.Thickness = 3.5
fovCircle.Color = Color3.fromRGB(0, 255, 120)
fovCircle.Transparency = 0.4
fovCircle.Filled = false
fovCircle.NumSides = 100

RunService.RenderStepped:Connect(function()
    fovCircle.Position = Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)
    fovCircle.Radius = featureState.aimbotFOV
    fovCircle.Visible = featureState.aimbot or featureState.silentAim
end)

-- Get Closest Target
local function getClosestTarget(fov)
    local root = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if not root then return nil end

    if featureState.selectedPlayer and featureState.selectedPlayer.Character then
        local hrp = featureState.selectedPlayer.Character:FindFirstChild("HumanoidRootPart")
        if hrp then
            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(camera.ViewportSize.X/2, camera.ViewportSize.Y/2)).Magnitude
                if dist < (fov or featureState.aimbotFOV) then return hrp end
            end
        end
    end

    local closest, minDist = nil, fov or featureState.aimbotFOV
    local screenCenter = Vector2.new(camera.ViewportSize.X / 2, camera.ViewportSize.Y / 2)

    for _, enemy in ipairs(Workspace.Enemies:GetChildren()) do
        local hrp = enemy:FindFirstChild("HumanoidRootPart")
        local hum = enemy:FindFirstChildOfClass("Humanoid")
        if hrp and hum and hum.Health > 0 then
            local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
            if onScreen then
                local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                if dist < minDist then
                    minDist = dist
                    closest = hrp
                end
            end
        end
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr \~= player and plr.Character then
            local hrp = plr.Character:FindFirstChild("HumanoidRootPart")
            if hrp then
                local screenPos, onScreen = camera:WorldToViewportPoint(hrp.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - screenCenter).Magnitude
                    if dist < minDist then
                        minDist = dist
                        closest = hrp
                    end
                end
            end
        end
    end
    return closest
end

-- Visible Camlock
RunService.RenderStepped:Connect(function()
    if not featureState.aimbot then return end
    local target = getClosestTarget()
    if target then
        camera.CFrame = CFrame.lookAt(camera.CFrame.Position, target.Position + Vector3.new(0, 2, 0))
    end
end)

-- Fast Attack
local lastAttack = 0
RunService.Heartbeat:Connect(function()
    if not featureState.fastAttack then return end
    local char = player.Character
    if not char then return end
    local tool = char:FindFirstChildOfClass("Tool")
    if tool and tick() - lastAttack >= (1 / featureState.attackSpeed) then
        VirtualU
