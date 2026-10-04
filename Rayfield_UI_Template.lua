-- Rayfield UI template
-- UI shell only: no gameplay automation or combat/weapon logic.

local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
    Name = "Banana Cat Hub - UI Test",
    LoadingTitle = "Banana Cat Hub",
    LoadingSubtitle = "Rayfield UI",
    Theme = "Default",
    ToggleUIKeybind = "End",
    DisableRayfieldPrompts = true,
})

local Home = Window:CreateTab("Home")
local Main = Window:CreateTab("Main")
local Sea = Window:CreateTab("Sea")
local ITM = Window:CreateTab("Items")
local Setting = Window:CreateTab("Settings")
local Status = Window:CreateTab("Status")
local Stats = Window:CreateTab("Stats")
local Player = Window:CreateTab("Player")
local Teleport = Window:CreateTab("Teleport")
local Visual = Window:CreateTab("Visual")
local Fruit = Window:CreateTab("Fruit")
local Raid = Window:CreateTab("Raid")
local Race = Window:CreateTab("Race")
local Shop = Window:CreateTab("Shop")
local Misc = Window:CreateTab("Misc")

Home:CreateParagraph({
    Title = "UI Test",
    Content = "Rayfield loaded successfully. This template only tests the interface."
})

Home:CreateButton({
    Name = "Test Notification",
    Callback = function()
        Rayfield:Notify({
            Title = "Banana Cat Hub",
            Content = "Rayfield UI is working.",
            Duration = 3,
        })
    end,
})

Main:CreateSection("Example Controls")

Main:CreateToggle({
    Name = "Example Toggle",
    CurrentValue = false,
    Callback = function(value)
        print("Example Toggle:", value)
    end,
})

Main:CreateDropdown({
    Name = "Example Dropdown",
    Options = {"Option 1", "Option 2", "Option 3"},
    CurrentOption = {"Option 1"},
    MultipleOptions = false,
    Callback = function(value)
        print("Example Dropdown:", value)
    end,
})

Main:CreateSlider({
    Name = "Example Slider",
    Range = {0, 100},
    Increment = 1,
    Suffix = "%",
    CurrentValue = 50,
    Callback = function(value)
        print("Example Slider:", value)
    end,
})

Status:CreateInput({
    Name = "Example Input",
    CurrentValue = "",
    PlaceholderText = "Type something...",
    RemoveTextAfterFocusLost = false,
    Callback = function(value)
        print("Example Input:", value)
    end,
})

Status:CreateLabel("If you can see this, the new UI loaded correctly.")
