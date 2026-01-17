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
