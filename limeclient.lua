-- Получаем доступ к сервису Lighting
local Lighting = game:GetService("Lighting")

-- Заменяем небо на новое
local sky = Instance.new("Sky")
sky.SkyboxBk = "rbxassetid://111189183635765"  -- Замените на свой ID изображения
sky.SkyboxDn = "rbxassetid://111189183635765"  -- Замените на свой ID изображения
sky.SkyboxFt = "rbxassetid://111189183635765"  -- Замените на свой ID изображения
sky.SkyboxLf = "rbxassetid://111189183635765"  -- Замените на свой ID изображения
sky.SkyboxRt = "rbxassetid://111189183635765"  -- Замените на свой ID изображения
sky.SkyboxUp = "rbxassetid://111189183635765"  -- Замените на свой ID изображения

-- Добавляем новое небо в Lighting
sky.Parent = Lighting
