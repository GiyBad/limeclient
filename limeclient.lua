-- LimeClient | Delta Executor
-- Author: GiyBad
-- Внимание: для Roblox, используй Delta Executor

if not game:IsLoaded() then
    game.Loaded:Wait()
end

-- Проверка на повторный запуск
if _G.LimeClientLoaded then
    warn("LimeClient уже запущен")
    return
end
_G.LimeClientLoaded = true

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local StarterGui = game:GetService("StarterGui")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")

-- ============================
-- GUI
-- ============================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LimeClientGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 300, 0, 200)
Frame.Position = UDim2.new(0.5, -150, 0.5, -100)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui
Frame.AnchorPoint = Vector2.new(0.5,0.5)
Frame.BackgroundTransparency = 0.1
Frame.ClipsDescendants = true

local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Padding = UDim.new(0,10)
UIListLayout.Parent = Frame
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder

-- Title
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1,0,0,30)
Title.BackgroundTransparency = 1
Title.Text = "LimeClient"
Title.TextColor3 = Color3.fromRGB(0,255,0)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.Parent = Frame

-- Music Section
local MusicLabel = Instance.new("TextLabel")
MusicLabel.Size = UDim2.new(1,0,0,20)
MusicLabel.BackgroundTransparency = 1
MusicLabel.Text = "Музыка (Roblox ID):"
MusicLabel.TextColor3 = Color3.fromRGB(255,255,255)
MusicLabel.Font = Enum.Font.Gotham
MusicLabel.TextSize = 18
MusicLabel.Parent = Frame

local MusicBox = Instance.new("TextBox")
MusicBox.Size = UDim2.new(1,0,0,30)
MusicBox.PlaceholderText = "Вставь ID"
MusicBox.Text = ""
MusicBox.ClearTextOnFocus = false
MusicBox.TextColor3 = Color3.fromRGB(0,0,0)
MusicBox.BackgroundColor3 = Color3.fromRGB(200,200,200)
MusicBox.Font = Enum.Font.Gotham
MusicBox.TextSize = 18
MusicBox.Parent = Frame

local PlayButton = Instance.new("TextButton")
PlayButton.Size = UDim2.new(1,0,0,30)
PlayButton.Text = "Играть 3 секунды"
PlayButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
PlayButton.TextColor3 = Color3.fromRGB(0,0,0)
PlayButton.Font = Enum.Font.Gotham
PlayButton.TextSize = 18
PlayButton.Parent = Frame

-- ============================
-- Music Function
-- ============================
local Sound = Instance.new("Sound")
Sound.Parent = workspace
Sound.Looped = false

PlayButton.MouseButton1Click:Connect(function()
    local id = MusicBox.Text
    if id ~= "" then
        pcall(function()
            Sound.SoundId = "rbxassetid://"..id
            Sound:Play()
            -- Авто-стоп через 3 секунды
            task.delay(3, function()
                Sound:Stop()
            end)
        end)
    end
end)

-- ============================
-- Smooth Drag (по желанию)
-- ============================
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
                               startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

RunService.RenderStepped:Connect(function()
    if dragging and dragInput then
        update(dragInput)
    end
end)

-- ============================
-- Конец
-- ============================
print("LimeClient успешно загружен")
