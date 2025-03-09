function getopsize()
    local screenSize = workspace.CurrentCamera.ViewportSize
    if screenSize.X <= 720 then
        return UDim2.fromOffset(240, 180) 
    elseif screenSize.X <= 1080 then
        return UDim2.fromOffset(360, 280)
    else
        return UDim2.fromOffset(480, 360) 
    end
end

local config = {
    ps = {
        cds = false,
        heal = false,
        damage = false,
        health = false,
    }
}

local icon = {
    ccc = "rbxassetid://74835846528618",
}


local username = game:GetService("Players").LocalPlayer.Name
local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Universal Battlegrounds | Username: " .. username, 
    Icon = icon.ccc,
    Author = ".C4F", 
    Folder = "SynHaX_universal", 
    Size = getopsize(), 
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,    
})

Window:EditOpenButton({
    Title = "Open",
    Icon = icon.ccc, 
    CornerRadius = UDim.new(0,10),
    StrokeThickness = 3,
    Color = ColorSequence.new(
        Color3.fromHex("FF0F7B"), 
        Color3.fromHex("F89B29")
    )
})

local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = "home" }),
    Charms = Window:Tab({ Title = "Character Moveset", Icon = "code" }),
    Moves = Window:Tab({ Title = "Moves", Icon = "code" }),
}

Window:SelectTab(1)

Tabs.Main:Section({ Title = "PS+", TextXAlignment = "Center" })
Tabs.Main:Toggle({
    Title = "Cooldown",
    Desc = "Bật/Tắt Cooldown",
    Value = false,
    Callback = function(value)
        config.ps.cds = value 
        if config.ps.cds then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].NoCDS:FireServer()
        else
            game:GetService("ReplicatedStorage")["PS+ Remotes"].DisableNoCDS:FireServer()
        end
    end
})
Tabs.Main:Toggle({
    Title = "Heal",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.ps.heal = value 
        if config.ps.heal then
            while config.ps.heal do
                game:GetService("ReplicatedStorage")["PS+ Remotes"].Heal:FireServer()
                wait()
            end
        end
    end
})
Tabs.Main:Button({
    Title = "Give Ultimate",
    Desc = " ",
    Callback = function() 
        game:GetService("ReplicatedStorage")["PS+ Remotes"].GiveUlt:FireServer()
    end
})

Tabs.Main:Button({
    Title = "Admin Tool",
    Desc = "lấy các chiêu của admin",
    Callback = function()
        local bp = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
        for _, item in ipairs(bp:GetChildren()) do item:Destroy() end
        for _, tool in ipairs(game:GetService("ReplicatedStorage"):WaitForChild("exe_storage"):WaitForChild("tools"):GetChildren()) do
            tool:Clone().Parent = bp
        end
    end
})

Tabs.Main:Button({
    Title = "All Moves At Once",
    Desc = "cre: hao",
    Callback = function()
        if config.ps.heal == true then
            local groups = { game:GetService("ReplicatedStorage"), game:GetService("ReplicatedStorage").Remotes, game:GetService("ReplicatedStorage").seson }

            for _, group in ipairs(groups) do
                for _, remote in ipairs(group:GetChildren()) do
                    if remote:IsA("RemoteEvent") then
                        remote:FireServer()
                    end
                end
            end
        else
            local Notification = WindUI:Notify({
                Title = "SynHax",
                Content = "Vui lòng bật: Heal - để sử dụng tính năng.",
                Duration = 5,
            })
        end
    end
})

Tabs.Main:Dropdown({
    Title = "Spawn",
    Values = { "AttackingDummy", "BlockingDummy", "CounteringDummy", "Dummy", "LowHPDummy" },
    Value = "Dummy",
    Callback = function(option)
        if option == "AttackingDummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnAttackingDummy:FireServer()
        elseif option == "BlockingDummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnBlockingDummy:FireServer()
        elseif option == "CounteringDummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnCounteringDummy:FireServer()
        elseif option == "Dummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnDummy:FireServer()
        elseif option == "LowHPDummy" then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].SpawnLowHPDummy:FireServer()
        end
    end
})
Tabs.Main:Toggle({
    Title = "Double Damage",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.ps.damage = value 
        if config.ps.damage then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].DoubleDamage:FireServer()
        else
            game:GetService("ReplicatedStorage")["PS+ Remotes"].DisableDoubleDamage:FireServer()
        end
    end
})
Tabs.Main:Toggle({
    Title = "Double Health",
    Desc = " ",
    Value = false,
    Callback = function(value)
        config.ps.health = value 
        if config.ps.health then
            game:GetService("ReplicatedStorage")["PS+ Remotes"].DoubleHealth:FireServer()
        else
            game.Players.LocalPlayer.Character.Humanoid.Health = 0
        end
    end
})

Tabs.Charms:Button({
    Title = "Law Character Moveset",
    Desc = "Law - Surgeon of Death",
    Callback = function() 
        game:GetService("ReplicatedStorage").Law.MovesetR:FireServer()
    end
})

Tabs.Charms:Button({
    Title = "Okarun Character Moveset",
    Desc = "No Balls B(",
    Callback = function() 
        game:GetService("ReplicatedStorage").Okarun.OkarunChoose:FireServer()
    end
})

Tabs.Charms:Button({
    Title = "Gogeta SSJB Character Moveset",
    Desc = "Gogeta - The Angle Born In Hell",
    Callback = function() 
        game:GetService("ReplicatedStorage").Remotes.HairBlue:FireServer()
    end
})

Tabs.Charms:Button({
    Title = "Pucci MIH Character Moveset",
    Desc = "Pucci - The Grand Priest",
    Callback = function() 
        game:GetService("ReplicatedStorage")["Atain Heavean"]:FireServer()
    end
})

Tabs.Charms:Button({
    Title = "Pucci WS Character Moveset",
    Desc = "Pucci - The Grand Priest",
    Callback = function() 
        game:GetService("ReplicatedStorage").GivePucci:FireServer()
    end
})

-- Char
local tnames = {}
local toolMap = {} 

for _, charFolder in ipairs(game:GetService("ReplicatedStorage"):WaitForChild("Characters"):GetChildren()) do
    if charFolder:IsA("Folder") then 
        for _, tool in ipairs(charFolder:GetChildren()) do
            if tool:IsA("Tool") then
                local displayName = charFolder.Name .. " - " .. tool.Name
                table.insert(tnames, displayName)
                toolMap[displayName] = tool 
            end
        end
    end
end

Tabs.Moves:Dropdown({
    Title = "Move - Char",
    Values = tnames,
    Value = tnames[1] or "",  
    Callback = function(option)
        local sctool = toolMap[option] 
        
        if sctool then
            local clonedTool = sctool:Clone()
            clonedTool.Parent = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
        end
    end
})

-- Ult
local ultNames = {}
local ultMap = {}

local ultFolder = game:GetService("ReplicatedStorage"):WaitForChild("Ultimates")

for _, charFolder in ipairs(ultFolder:GetChildren()) do
    if charFolder:IsA("Folder") then
        local charName = charFolder.Name
        for _, child in ipairs(charFolder:GetChildren()) do
            if child:IsA("Folder") then
                for _, tool in ipairs(child:GetChildren()) do
                    if tool:IsA("Tool") then
                        local displayName = charName .. " - " .. tool.Name
                        table.insert(ultNames, displayName)
                        ultMap[displayName] = tool
                    end
                end
            elseif child:IsA("Tool") then
                local displayName = charName .. " - " .. child.Name
                table.insert(ultNames, displayName)
                ultMap[displayName] = child
            end
        end
    end
end

Tabs.Moves:Dropdown({
    Title = "Move - Ult",
    Values = ultNames,
    Value = ultNames[1] or "",
    Callback = function(option)
        local selectedUlt = ultMap[option]
        if selectedUlt then
            local clonedUlt = selectedUlt:Clone()
            clonedUlt.Parent = game:GetService("Players").LocalPlayer:WaitForChild("Backpack")
        end
    end
})

Tabs.Moves:Button({
    Title = "Rs bp",
    Desc = "làm mới túi đồ",
    Callback = function()
        for _, item in ipairs(game:GetService("Players").LocalPlayer:WaitForChild("Backpack"):GetChildren()) do item:Destroy() end
    end
})
