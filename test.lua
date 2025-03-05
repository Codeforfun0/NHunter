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

local icons = {
  bacon = "rbxassetid://88763602960873",
}

local cid = {
  f = false,
  a = false,
}  

local WindUI = loadstring(game:HttpGet("https://tree-hub.vercel.app/api/UI/WindUI"))()

local Window = WindUI:CreateWindow({
    Title = "Hao",
    Icon = icons.bacon,
    Author = "Hate",
    Folder = "Nigger",
    Size = getopsize(),
    Transparent = true,
    Theme = "Dark",
    SideBarWidth = 200,
    HasOutline = false,
})

local Tabs = {
    Main = Window:Tab({ Title = "Main", Icon = icons.bacon, Desc = "BThanhLGBT" }),
}

Window:SelectTab(1)

Tabs.Main:Button({
    Title = "Summon Owner Say Gex 69",
    Desc = "",
    Callback = function()
      game:GetService("ReplicatedStorage"):WaitForChild("SPAWNOWNER"):FireServer()
      end
})


Tabs.Main:Toggle({
    Title = "Summon Owner Say Gex 69",
    Default = false,
    Callback = function(state) 
      cid.f = state
      if cid.f then 
        while cid.f do
          game:GetService("ReplicatedStorage"):WaitForChild("SPAWNOWNER"):FireServer()
          wait(0.69)
        end  
      end
    end  
})

Tabs.Main:Toggle({
    Title = "Aura + 500000",
    Default = false,
    Callback = function(state) 
      cid.a = state
      if cid.a then 
        while cid.a do
          game:GetService("ReplicatedStorage"):WaitForChild("A8"):FireServer()
          wait(0.1)
        end  
      end
    end  
})
