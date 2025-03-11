local tool = Instance.new("Tool")
tool.Name = "AI1"
tool.RequiresHandle = false
tool.CanBeDropped = false

local al1 = {
	g = game:GetService("ReplicatedStorage").Events.Gun["Los Lobos"],
	m = {
		bl = game:GetService("ReplicatedStorage").Events.Melee["Black Leg"],
		cb = game:GetService("ReplicatedStorage").Events.Melee.Combat,
		cp = game:GetService("ReplicatedStorage").Events.Melee["Curse Punch"],
	},
	p = {
		inf = game:GetService("ReplicatedStorage").Events.Powers.Infinity,
		inv = game:GetService("ReplicatedStorage").Events.Powers.Invisible,
		koc = game:GetService("ReplicatedStorage").Events.Powers["King Of Curses"],
		mui = game:GetService("ReplicatedStorage").Events.Powers.MUI,
		q = game:GetService("ReplicatedStorage").Events.Powers.Quake,
		r = game:GetService("ReplicatedStorage").Events.Powers.Rubber,
		s = game:GetService("ReplicatedStorage").Events.Powers.Saiyan,
		sp = game:GetService("ReplicatedStorage").Events.Powers["Saiyan Prince"]
	},
	s = {
		db = game:GetService("ReplicatedStorage").Events.Sword["Dark Blade"],
		k = game:GetService("ReplicatedStorage").Events.Sword.Katana,
		ls = game:GetService("ReplicatedStorage").Events.Sword["Love Sword"]
	}
}

local function fireAllEvents(tbl, arg)
	for key, value in pairs(tbl) do
		if typeof(value) == "Instance" and value:IsA("RemoteEvent") then
			value:FireServer(arg)
		elseif typeof(value) == "table" then
			fireAllEvents(value, arg)
		end
	end
end

local UIS = game:GetService("UserInputService")
local keyMap = {
	[Enum.KeyCode.Z] = "Z",
	[Enum.KeyCode.X] = "X",
	[Enum.KeyCode.V] = "V",
	[Enum.KeyCode.C] = "C"
}

tool.Equipped:Connect(function()
	local mobileGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("MobileControlGui")
	if mobileGui then mobileGui.Enabled = true end

	local inputConnection = UIS.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
		local arg = keyMap[input.KeyCode]
		if arg then fireAllEvents(al1, arg) end
	end)
	tool.Unequipped:Connect(function()
		inputConnection:Disconnect()
		local mobileGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("MobileControlGui")
		if mobileGui then mobileGui.Enabled = false end
	end)
end)

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "MobileControlGui"
screenGui.ResetOnSpawn = false
screenGui.Enabled = false
screenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Name = "ControlFrame"
frame.Size = UDim2.new(0, 80, 0, 120)
frame.Position = UDim2.new(1, -90, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
frame.BackgroundTransparency = 0.5
frame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 20)
uiCorner.Parent = frame

local listLayout = Instance.new("UIListLayout")
listLayout.Padding = UDim.new(0, 5)
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Center
listLayout.Parent = frame

local keys = {"Z", "X", "V", "C"}
for i, key in ipairs(keys) do
	local button = Instance.new("TextButton")
	button.Name = "Button_"..key
	button.Text = key
	button.Size = UDim2.new(1, -10, 0, 25)
	button.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.Font = Enum.Font.SourceSansBold
	button.TextSize = 18
	button.Parent = frame

	local btnCorner = Instance.new("UICorner")
	btnCorner.CornerRadius = UDim.new(0, 10)
	btnCorner.Parent = button

	button.MouseButton1Click:Connect(function()
		fireAllEvents(al1, key)
	end)
end

local player = game.Players.LocalPlayer
tool.AncestryChanged:Connect(function(_, parent)
	if parent ~= player.Backpack and (not player.Character or parent ~= player.Character) then
		wait(0.1)
		tool.Parent = player.Backpack
	end
end)

tool.Parent = game.Players.LocalPlayer.Backpack
