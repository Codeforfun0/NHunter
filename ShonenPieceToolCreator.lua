local function CreateTool(toolName, toolType)
    local tool = Instance.new("Tool")
    tool.Name = toolName
    tool.RequiresHandle = false

    local event = game:GetService("ReplicatedStorage").Events[toolType][toolName]
    local UIS = game:GetService("UserInputService")

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "SmallControlGui_" .. toolName
    screenGui.ResetOnSpawn = false
    screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

    local frame = Instance.new("Frame")
    frame.Name = "SmallControlFrame"
    frame.Size = UDim2.new(0, 40, 0, 115)
    frame.Position = UDim2.new(1, -50, 0.5, -57)
    frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
    frame.BackgroundTransparency = 0.5
    frame.Parent = screenGui

    local uiCorner = Instance.new("UICorner")
    uiCorner.CornerRadius = UDim.new(0, 10)
    uiCorner.Parent = frame

    local listLayout = Instance.new("UIListLayout")
    listLayout.Padding = UDim.new(0, 5)
    listLayout.FillDirection = Enum.FillDirection.Vertical
    listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
    listLayout.Parent = frame

    local keys = {"Z", "X", "C", "V"}
    for _, key in ipairs(keys) do
        local button = Instance.new("TextButton")
        button.Name = "Button_" .. key
        button.Text = key
        button.Size = UDim2.new(0, 25, 0, 25)
        button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
        button.TextColor3 = Color3.new(1, 1, 1)
        button.Font = Enum.Font.SourceSansBold
        button.TextSize = 12
        button.Parent = frame
        local btnCorner = Instance.new("UICorner")
        btnCorner.CornerRadius = UDim.new(1, 0)
        btnCorner.Parent = button
        button.MouseButton1Click:Connect(function()
            event:FireServer(key)
        end)
    end

    local dragging, dragInput, dragStart, startPos
    local function update(input)
        local delta = input.Position - dragStart
        frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            dragStart = input.Position
            startPos = frame.Position
            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    frame.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            update(input)
        end
    end)

    tool.Equipped:Connect(function()
        screenGui.Enabled = true
    end)

    tool.Unequipped:Connect(function()
        screenGui.Enabled = false
    end)

    tool.Parent = game.Players.LocalPlayer.Backpack
end

CreateTool("Los Lobos", "Gun")
CreateTool("Quake", "Powers")
CreateTool("Dark Blade", "Sword")