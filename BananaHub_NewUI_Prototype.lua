-- Banana Hub - New UI prototype
-- Standalone Roblox LocalScript UI
-- This prototype recreates the menu structure only.

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local old = playerGui:FindFirstChild("BananaHubNewUI")
if old then old:Destroy() end

local gui = Instance.new("ScreenGui")
gui.Name = "BananaHubNewUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local main = Instance.new("Frame")
main.Size = UDim2.fromOffset(720, 450)
main.Position = UDim2.new(0.5, -360, 0.5, -225)
main.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
main.BorderSizePixel = 0
main.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = main

local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(55, 55, 65)
stroke.Thickness = 1
stroke.Parent = main

local top = Instance.new("Frame")
top.Size = UDim2.new(1, 0, 0, 52)
top.BackgroundColor3 = Color3.fromRGB(27, 27, 33)
top.BorderSizePixel = 0
top.Parent = main

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, -30, 1, 0)
title.Position = UDim2.fromOffset(15, 0)
title.BackgroundTransparency = 1
title.Text = "Banana Hub"
title.TextColor3 = Color3.fromRGB(245, 245, 245)
title.TextSize = 20
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = top

local subtitle = Instance.new("TextLabel")
subtitle.Size = UDim2.fromOffset(180, 20)
subtitle.Position = UDim2.new(1, -195, 0, 16)
subtitle.BackgroundTransparency = 1
subtitle.Text = "New UI Prototype"
subtitle.TextColor3 = Color3.fromRGB(150, 150, 160)
subtitle.TextSize = 12
subtitle.Font = Enum.Font.Gotham
subtitle.TextXAlignment = Enum.TextXAlignment.Right
subtitle.Parent = top

local sidebar = Instance.new("Frame")
sidebar.Size = UDim2.new(0, 155, 1, -52)
sidebar.Position = UDim2.fromOffset(0, 52)
sidebar.BackgroundColor3 = Color3.fromRGB(24, 24, 29)
sidebar.BorderSizePixel = 0
sidebar.Parent = main

local sideLayout = Instance.new("UIListLayout")
sideLayout.Padding = UDim.new(0, 4)
sideLayout.SortOrder = Enum.SortOrder.LayoutOrder
sideLayout.Parent = sidebar

local sidePad = Instance.new("UIPadding")
sidePad.PaddingTop = UDim.new(0, 10)
sidePad.PaddingLeft = UDim.new(0, 8)
sidePad.PaddingRight = UDim.new(0, 8)
sidePad.Parent = sidebar

local content = Instance.new("Frame")
content.Size = UDim2.new(1, -155, 1, -52)
content.Position = UDim2.fromOffset(155, 52)
content.BackgroundColor3 = Color3.fromRGB(20, 20, 24)
content.BorderSizePixel = 0
content.Parent = main

local pages = {}
local tabs = {
    "Home", "Main", "Sea", "ITM", "Setting", "Status", "Stats",
    "Player", "Teleport", "Visual", "Fruit", "Raid", "Race", "Shop", "Misc"
}

local function makeLabel(parent, textValue, size, position, textSize, color)
    local label = Instance.new("TextLabel")
    label.Size = size
    label.Position = position
    label.BackgroundTransparency = 1
    label.Text = textValue
    label.TextColor3 = color or Color3.fromRGB(235, 235, 240)
    label.TextSize = textSize or 16
    label.Font = Enum.Font.Gotham
    label.TextXAlignment = Enum.TextXAlignment.Left
    label.Parent = parent
    return label
end

local function makePage(name)
    local page = Instance.new("ScrollingFrame")
    page.Name = name .. "Page"
    page.Size = UDim2.new(1, -20, 1, -20)
    page.Position = UDim2.fromOffset(10, 10)
    page.BackgroundTransparency = 1
    page.BorderSizePixel = 0
    page.ScrollBarThickness = 4
    page.Visible = false
    page.CanvasSize = UDim2.new(0, 0, 0, 0)
    page.Parent = content

    local layout = Instance.new("UIListLayout")
    layout.Padding = UDim.new(0, 8)
    layout.SortOrder = Enum.SortOrder.LayoutOrder
    layout.Parent = page

    layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
        page.CanvasSize = UDim2.fromOffset(0, layout.AbsoluteContentSize.Y + 15)
    end)

    pages[name] = page
    return page
end

local function addSection(page, textValue)
    local holder = Instance.new("Frame")
    holder.Size = UDim2.new(1, -4, 0, 38)
    holder.BackgroundColor3 = Color3.fromRGB(28, 28, 34)
    holder.BorderSizePixel = 0
    holder.Parent = page

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = holder

    makeLabel(holder, textValue, UDim2.new(1, -20, 1, 0), UDim2.fromOffset(10, 0), 14, Color3.fromRGB(180, 180, 195)).Font = Enum.Font.GothamBold
end

local function addButton(page, textValue)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(31, 31, 38)
    b.Text = textValue
    b.TextColor3 = Color3.fromRGB(235, 235, 240)
    b.TextSize = 14
    b.Font = Enum.Font.Gotham
    b.AutoButtonColor = false
    b.Parent = page

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = b

    b.MouseEnter:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.12), {
            BackgroundColor3 = Color3.fromRGB(43, 43, 52)
        }):Play()
    end)
    b.MouseLeave:Connect(function()
        TweenService:Create(b, TweenInfo.new(0.12), {
            BackgroundColor3 = Color3.fromRGB(31, 31, 38)
        }):Play()
    end)
end

local function addToggle(page, textValue)
    local b = Instance.new("TextButton")
    b.Size = UDim2.new(1, -4, 0, 40)
    b.BackgroundColor3 = Color3.fromRGB(31, 31, 38)
    b.Text = "OFF   " .. textValue
    b.TextColor3 = Color3.fromRGB(235, 235, 240)
    b.TextSize = 14
    b.Font = Enum.Font.Gotham
    b.AutoButtonColor = false
    b.Parent = page

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 7)
    c.Parent = b

    local enabled = false
    b.Activated:Connect(function()
        enabled = not enabled
        b.Text = (enabled and "ON    " or "OFF   ") .. textValue
        b.BackgroundColor3 = enabled
            and Color3.fromRGB(45, 80, 55)
            or Color3.fromRGB(31, 31, 38)
    end)
end

for _, name in ipairs(tabs) do
    local page = makePage(name)
    addSection(page, name)

    if name == "Home" then
        makeLabel(page, "Banana Hub - New UI", UDim2.new(1, -4, 0, 45), UDim2.fromOffset(0, 0), 22, Color3.fromRGB(245, 245, 245)).Font = Enum.Font.GothamBold
        makeLabel(page, "UI is loading correctly. Features can be connected later.", UDim2.new(1, -4, 0, 35), UDim2.fromOffset(0, 0), 14, Color3.fromRGB(160, 160, 170))
    elseif name == "Main" then
        addToggle(page, "Auto Farm")
        addToggle(page, "Mob Aura")
        addToggle(page, "Boss")
        addButton(page, "Select Weapon")
    elseif name == "Sea" then
        addToggle(page, "Sea Events")
        addToggle(page, "Sea ESP")
        addButton(page, "Boat Settings")
    elseif name == "ITM" then
        addToggle(page, "Item Features")
        addButton(page, "Item List")
    else
        addToggle(page, name .. " Feature 1")
        addToggle(page, name .. " Feature 2")
        addButton(page, "Open " .. name .. " Settings")
    end
end

local activeTab

local function selectTab(name)
    for tabName, page in pairs(pages) do
        page.Visible = (tabName == name)
    end

    for _, child in ipairs(sidebar:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundColor3 = child.Name == name
                and Color3.fromRGB(55, 55, 68)
                or Color3.fromRGB(24, 24, 29)
        end
    end

    activeTab = name
end

for _, name in ipairs(tabs) do
    local b = Instance.new("TextButton")
    b.Name = name
    b.Size = UDim2.new(1, 0, 0, 31)
    b.BackgroundColor3 = Color3.fromRGB(24, 24, 29)
    b.Text = name
    b.TextColor3 = Color3.fromRGB(210, 210, 220)
    b.TextSize = 13
    b.Font = Enum.Font.Gotham
    b.AutoButtonColor = false
    b.Parent = sidebar

    local c = Instance.new("UICorner")
    c.CornerRadius = UDim.new(0, 6)
    c.Parent = b

    b.Activated:Connect(function()
        selectTab(name)
    end)
end

selectTab("Home")

-- Dragging
local dragging = false
local dragStart
local startPos

top.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = main.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if not dragging then return end
    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then
        return
    end

    local delta = input.Position - dragStart
    main.Position = UDim2.new(
        startPos.X.Scale,
        startPos.X.Offset + delta.X,
        startPos.Y.Scale,
        startPos.Y.Offset + delta.Y
    )
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
    end
end)
