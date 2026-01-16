--[[

    All Credits Of BlueKeep.Luau:
        Really_Ant. (Scripter)
        LuaGeek (Scripter, UI)

    Enjoy<3
]]

type Callback = () -> ()

-- Setup --

if getgenv().BlueKeep then
    error("BlueKeep is already running!")
end

getgenv().BlueKeep = {
    Services = {},
    Functions = {},
    Commands = {},
    Loops = {}
}

-- this way we dont accidently import multiple of the same service..
function BlueKeep.Functions.Service(name: string)
    local cache = BlueKeep.Services[name]

    if cache then
        return cache
    end

    BlueKeep.Services[name] = cloneref(game:GetService(name))
    return BlueKeep.Services[name]
end

-- adds new commands to BlueKeep.luau
function BlueKeep.Functions.NewCommand(name: string?, cmdlist: string?, description: string?, splitargs: boolean?, func: Callback?)
    assert(BlueKeep.Commands[name or "print"] == nil, "Command already exists")

    if splitargs == nil then
        splitargs = true
    end

    BlueKeep.Commands[name or "print"] = {
        ["CmdList"] = cmdlist or "print (text)",
        ["Description"] = description or "No description provided",
        ["SplitArgs"] = splitargs,
        ["Function"] = func or print
    }
end

-- attempts to run command with given args
function BlueKeep.Functions.RunCommand(name: string, args: {any}): boolean?
    assert(BlueKeep.Commands[name] ~= nil, `Failed to find command {name}`)

    if BlueKeep.Commands[name].SplitArgs then
        BlueKeep.Commands[name].Function(table.unpack(args))
        return
    end

    local str = ""
    for _, v in pairs(args) do -- pairs() is inefficient cause Luau!! but some shitsploits wont work w/out it
        str = str..v
    end

    BlueKeep["Commands"][name].Function(str)

    return true
end

local plrs: Players = BlueKeep.Functions.Service("Players")
local lp = plrs.LocalPlayer

-- returns list of target(s)
function BlueKeep.Functions.GetPlayers(keyword: string): { Player } | { nil }
    keyword = keyword:lower()

    local plist = plrs:GetPlayers()
    local output = {}

    if keyword == "all" then return plist end
    if keyword == "me" then return {lp} end
    if keyword == "random" then return {plist[math.random(1, #plist)]} end
    if keyword == "others" then
        for _, plr in pairs(plist) do
            if plr == lp then continue end

            table.insert(output, plr)
        end
    end

    for _, plr in pairs(plist) do
        local name, displayName = plr.Name:lower(), plr.DisplayName:lower()
        if name:find(keyword) or displayName:find(keyword) then
            table.insert(output, plr)
        end
    end

    if #output <= 0 then
        return { nil }
    end

    return output
end

-- returns character of entered player, if no player entered it returns lp character
function BlueKeep.Functions.Character(plr: Player?): Model
    local player: Player = plr or lp
    return player.Character or player.CharacterAdded:Wait()
end

function BlueKeep.Functions.NoVel()
    local char = BlueKeep.Functions.Character()
    for _, part in pairs(char:GetDescendants()) do
        pcall(function() 
            part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end)
    end
end

-- setup files --
do
    local folders = {
        "BlueKeep",
        "BlueKeep/Plugins"
    }

    local files = {
        "BlueKeep/BlueSettings.Settings"
    }

    for _, path in pairs(folders) do
        if not isfolder(path) then
            makefolder(path)
        end
    end

    for _, path in pairs(files) do
        if not isfile(path) then
            writefile(path, ' ')
        end
    end
end

-- Commands --
BlueKeep.Functions.NewCommand("goto", "goto (plr)", "Teleports to (plr)", true, function(target)
    local targets = BlueKeep.Functions.GetPlayers(target)[1]
    local char = BlueKeep.Functions.Character()

    for _, v in pairs(targets) do
        local targetchar = BlueKeep.Functions.Character(v)

        BlueKeep.Functions.NoVel()
        char:PivotTo(targetchar:GetPivot())
    end
end)
