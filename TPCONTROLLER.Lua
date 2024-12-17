local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Create GUI
local gui = Instance.new("ScreenGui")
gui.Name = "TeleportGUI"
gui.ResetOnSpawn = false
gui.Parent = player.PlayerGui

-- Create Teleport Button
local teleportButton = Instance.new("TextButton")
teleportButton.Size = UDim2.new(0, 200, 0, 50)
teleportButton.Position = UDim2.new(0.5, -100, 0.8, 0)
teleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
teleportButton.Text = "Teleport to Players"
teleportButton.TextSize = 20
teleportButton.Parent = gui

-- Add corner radius
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = teleportButton

-- Status label
local statusLabel = Instance.new("TextLabel")
statusLabel.Size = UDim2.new(0, 200, 0, 30)
statusLabel.Position = UDim2.new(0.5, -100, 0.7, 0)
statusLabel.BackgroundTransparency = 1
statusLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
statusLabel.Text = ""
statusLabel.Parent = gui

-- Variables
local isTeleporting = false

-- Teleport Function
teleportButton.MouseButton1Click:Connect(function()
    if isTeleporting then return end
    isTeleporting = true
    
    local playerList = Players:GetPlayers()
    local teleportCount = 0
    
    -- Remove local player from list
    for i, plr in ipairs(playerList) do
        if plr == player then
            table.remove(playerList, i)
            break
        end
    end
    
    -- Start teleporting
    for _, targetPlayer in ipairs(playerList) do
        if targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
            local character = player.Character
            if character and character:FindFirstChild("HumanoidRootPart") then
                statusLabel.Text = "Teleporting to " .. targetPlayer.Name
                character.HumanoidRootPart.CFrame = targetPlayer.Character.HumanoidRootPart.CFrame
                teleportCount = teleportCount + 1
                wait(4)
            end
        end
    end
    
    statusLabel.Text = "Teleported to " .. teleportCount .. " players!"
    wait(2)
    statusLabel.Text = ""
    isTeleporting = false
end)

-- Button effects
teleportButton.MouseEnter:Connect(function()
    teleportButton.BackgroundColor3 = Color3.fromRGB(30, 190, 255)
end)

teleportButton.MouseLeave:Connect(function()
    teleportButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
end)
