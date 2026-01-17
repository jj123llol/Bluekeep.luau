--[[

    All Credits Of BlueKeep.Luau:
        Really_Ant. (Scripter)
        LuaGeek (Scripter, UI)

    Enjoy<3
]]

type callback = () -> ()
if BlueKeep then return error("Bluekeep.luau is already running!") end


-- Setting Up! --

getgenv().BlueKeep = {
    ["Services"] = {},
    ["Functions"]= {},
    ["Commands"] = {},
    ["Loops"] = {},
    ["Uis"] = {}
}
-- this way we dont accidently import multiple of the same service..
BlueKeep["Functions"]["Service"] = function(Name: string)
    if BlueKeep["Services"][Name] then return BlueKeep["Services"][Name] end
    BlueKeep["Services"][Name] = cloneref(game:GetService(Name))
    return BlueKeep["Services"][Name]
end

-- adds new commands to BlueKeep.luau
BlueKeep["Functions"]["NewCommand"] = function(Name:string, CmdList: string, Description: string, SplitArgs: boolean, func: callback)
    BlueKeep["Commands"][Name or "print"] = {
        ["CmdList"] = CmdList or "print (Text)",
        ["Description"] = Description or "No Description provided",
        ["SplitArgs"] = SplitArgs or true,
        ["Function"] = func or print
    }
end

BlueKeep["Functions"]["RunCommand"] = function(Name: string, args: {any}) -- attempts to run command with given args
    if not BlueKeep["Commands"][Name] then return false, error(`Failed to find command {Name}!`) end
    if BlueKeep["Commands"][Name]["SplitArgs"] then
        BlueKeep["Commands"][Name]["Function"](table.unpack(args))
    else
        local str = ""
        for _,v in pairs(args) do
            str = str..v
        end
        BlueKeep["Commands"][Name]["Function"](str)
    end
    return true
end
local players: Players = BlueKeep["Functions"]["Service"]("Players")
local lp: Player = players.LocalPlayer  --ts does NOT need a comment
local ts = BlueKeep["Functions"]["Service"]("TweenService")
local core = BlueKeep["Functions"]["Service"]("CoreGui")

BlueKeep["Uis"]["CmdBarUi"] = function()
    local ScreenGui = Instance.new("ScreenGui")
    local CmdList = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local TitleHolder = Instance.new("Frame")
    local UICorner_2 = Instance.new("UICorner")
    local ExitBTN = Instance.new("TextButton")
    local BKL = Instance.new("TextLabel")
    local stars = Instance.new("Frame")
    local ImageLabel = Instance.new("ImageLabel")
    local ForCmds = Instance.new("ScrollingFrame")
    local UIGridLayout = Instance.new("UIGridLayout")
    ScreenGui.Parent = core
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    CmdList.Name = "CmdList"
    CmdList.Parent = ScreenGui
    CmdList.BackgroundColor3 = Color3.fromRGB(0, 0, 121)
    CmdList.BorderColor3 = Color3.fromRGB(0, 0, 0)
    CmdList.BorderSizePixel = 0
    CmdList.Position = UDim2.new(0.318528801, 0, 0.277594715, 0)
    CmdList.Size = UDim2.new(0, 300, 0, 500)
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = CmdList
    TitleHolder.Name = "TitleHolder"
    TitleHolder.Parent = CmdList
    TitleHolder.BackgroundColor3 = Color3.fromRGB(0, 0, 176)
    TitleHolder.BorderColor3 = Color3.fromRGB(0, 0, 127)
    TitleHolder.BorderSizePixel = 0
    TitleHolder.Size = UDim2.new(0, 300, 0, 50)
    UICorner_2.CornerRadius = UDim.new(0, 10)
    UICorner_2.Parent = TitleHolder
    ExitBTN.Name = "ExitBTN"
    ExitBTN.Parent = TitleHolder
    ExitBTN.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ExitBTN.BackgroundTransparency = 1.000
    ExitBTN.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ExitBTN.BorderSizePixel = 0
    ExitBTN.Position = UDim2.new(0.829999983, 0, 0, 0)
    ExitBTN.Size = UDim2.new(0, 51, 0, 50)
    ExitBTN.Font = Enum.Font.SourceSans
    ExitBTN.Text = "X"
    ExitBTN.TextColor3 = Color3.fromRGB(255, 0, 0)
    ExitBTN.TextScaled = true
    ExitBTN.TextSize = 14.000
    ExitBTN.TextWrapped = true
    ExitBTN.MouseButton1Click:Connect(function()
        ScreenGui:Destroy()
    end)
    BKL.Name = "BKL"
    BKL.Parent = TitleHolder
    BKL.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    BKL.BackgroundTransparency = 1.000
    BKL.BorderColor3 = Color3.fromRGB(0, 0, 0)
    BKL.BorderSizePixel = 0
    BKL.Size = UDim2.new(0, 199, 0, 50)
    BKL.Font = Enum.Font.Highway
    BKL.Text = "BlueKeep"
    BKL.TextColor3 = Color3.fromRGB(184, 184, 184)
    BKL.TextScaled = true
    BKL.TextSize = 14.000
    BKL.TextWrapped = true
    stars.Name = "stars"
    stars.Parent = CmdList
    stars.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    stars.BackgroundTransparency = 1.000
    stars.BorderColor3 = Color3.fromRGB(0, 0, 0)
    stars.BorderSizePixel = 0
    stars.Position = UDim2.new(0, 0, 0.100000001, 0)
    stars.Size = UDim2.new(0, 300, 0, 450)
    ImageLabel.Parent = stars
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1.000
    ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ImageLabel.BorderSizePixel = 0
    ImageLabel.Size = UDim2.new(0, 300, 0, 450)
    ImageLabel.Image = "rbxassetid://7209784983"
    ForCmds.Name = "ForCmds"
    ForCmds.Parent = CmdList
    ForCmds.Active = true
    ForCmds.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ForCmds.BackgroundTransparency = 1.000
    ForCmds.BorderColor3 = Color3.fromRGB(0, 0, 0)
    ForCmds.BorderSizePixel = 0
    ForCmds.Position = UDim2.new(0, 0, 0.121999756, 0)
    ForCmds.Size = UDim2.new(0, 292, 0, 439)

    local function addcmd(Text:string, Description:string)
        local Command = Instance.new("TextLabel")
        local UICorner_3 = Instance.new("UICorner")
        Command.Name = Text
        Command.Parent = ForCmds
        Command.BackgroundColor3 = Color3.fromRGB(0, 54, 162)
        Command.BorderColor3 = Color3.fromRGB(0, 0, 0)
        Command.BorderSizePixel = 0
        Command.Position = UDim2.new(0.373333335, 0, 0.0354200974, 0)
        Command.Size = UDim2.new(0, 200, 0, 50)
        Command.Font = Enum.Font.Michroma
        Command.Text = Text
        Command.TextColor3 = Color3.fromRGB(255, 255, 255)
        Command.TextSize = 37.000
        Command.TextWrapped = true
        UICorner_3.Parent = Command
    end
    for _,cmd in pairs(BlueKeep["Commands"]) do
        addcmd(cmd["CmdList"], cmd["Description"])
    end
    UIGridLayout.Parent = ForCmds
    UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIGridLayout.CellSize = UDim2.new(0, 250, 0, 80)
end

BlueKeep["Functions"]["Notify"] = function(Title:string, Message:string)
task.spawn(function()
    local ScreenGui = Instance.new("ScreenGui")
    local NotifGUI = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local NotifText = Instance.new("TextLabel")
    local UICorner_2 = Instance.new("UICorner")
    local NotifBottomText = Instance.new("TextLabel")
    ScreenGui.Parent = core
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    NotifGUI.Name = "NotifGUI"
    NotifGUI.Parent = ScreenGui
    NotifGUI.BackgroundColor3 = Color3.fromRGB(0, 0, 121)
    NotifGUI.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NotifGUI.BorderSizePixel = 0
    NotifGUI.Position = UDim2.new(0.835877836, 0, 0.806425035, 0)
    NotifGUI.Size = UDim2.new(0, 298, 0, 198)
    UICorner.Parent = NotifGUI
    NotifText.Name = "NotifText"
    NotifText.Parent = NotifGUI
    NotifText.BackgroundColor3 = Color3.fromRGB(0, 0, 176)
    NotifText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NotifText.BorderSizePixel = 0
    NotifText.Size = UDim2.new(0, 298, 0, 66)
    NotifText.Font = Enum.Font.SourceSans
    NotifText.TextColor3 = Color3.fromRGB(81, 81, 81)
    NotifText.TextScaled = true
    NotifText.TextSize = 14.000
    NotifText.TextWrapped = true
    NotifText.Text = title
    NotifText.TextYAlignment = Enum.TextYAlignment.Top
    UICorner_2.Parent = NotifText
    NotifBottomText.Name = "NotifBottomText"
    NotifBottomText.Parent = NotifGUI
    NotifBottomText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    NotifBottomText.BackgroundTransparency = 1.000
    NotifBottomText.BorderColor3 = Color3.fromRGB(0, 0, 0)
    NotifBottomText.BorderSizePixel = 0
    NotifBottomText.Position = UDim2.new(0, 0, 0.333333343, 0)
    NotifBottomText.Size = UDim2.new(0, 298, 0, 122)
    NotifBottomText.Font = Enum.Font.SourceSans
    NotifBottomText.TextColor3 = Color3.fromRGB(115, 115, 115)
    NotifBottomText.TextScaled = true
    NotifBottomText.TextSize = 14.000
    NotifBottomText.TextWrapped = true
    NotifBottomText.Text = Message
end)
end

BlueKeep["Functions"]["GetPlayer"] = function(partName: string) -- returns list of target(s)
    partName = partName:lower()
    local plrs = players:GetPlayers()
    local returntable = {}
    if partName == "all" then return plrs end
    if partName == "me" then return {lp} end
    if partName == "random" then return {plrs[math.random(1, #plrs)]} end
    if partName == "others" then
        for _,v in pairs(plrs) do
            if v == lp then continue end
            table.insert(returntable, v)
        end
    end
    for _,v in pairs(plrs) do
        if v:find(partName) then
            return {v}
        end
    end
    return {nil}
end

BlueKeep["Functions"]["Character"] = function(plr) -- returns character of entered player, if no player entered it returns lp character
    plr = plr or lp
    return plr.Character or plr.CharacterAdded:Wait()
end

BlueKeep["Functions"]["No Vel"] = function()
    for _, part in pairs(BlueKeep["Functions"]["Character"]():GetDescendants()) do
        pcall(function() 
            part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end)
    end
end

-- set up files --
local checkfor = {
    "BlueKeep",
    "BlueKeep/Plugins",
    "BlueKeep/BlueSettings.Settings" -- are we even gonna use settings?
}
for _, path in pairs(checkfor) do
    if not isfile(path) then
        makefolder(path)
    end
end

for _, file in pairs(listfiles("BlueKeep/Plugins")) do
    pcall(function()
        loadfile(file)()
    end)
end

-- Commands --
BlueKeep["Functions"]["NewCommand"]("Goto", "Goto (Plr)", "Teleports to (Plr)", true, function(target)
    local targets = BlueKeep["Functions"]["GetPlayer"](target)[1]
    for _,v in pairs(targets) do
        BlueKeep["Functions"]["No Vel"]()
        BlueKeep["Functions"]["Character"]():PivotTo(BlueKeep["Functions"]["Character"](v):GetPivot())
    end
end)

BlueKeep["Functions"]["NewCommand"]("cmds", "cmds", "Open cmd list", true, function()
    BlueKeep["Uis"]["CmdBarUi"]
end)
