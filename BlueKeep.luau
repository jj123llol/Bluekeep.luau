--[[

    All Credits Of BlueKeep.Luau:
        Really_Ant. (Scripter)
        LuaGeek (Scripter, UI)

    Enjoy<3
]]

type callback = () -> ()
getgenv = getgenv -- because visual studio code errors pmo
BlueKeep = BlueKeep or nil -- visual studio code errors pmo
if BlueKeep then return error("Bluekeep.luau is already running!") end


-- Setting Up! --

getgenv().BlueKeep = {
    ["Services"] = {},
    ["Functions"]= {},
    ["Commands"] = {},
    ["Loops"] = {},
    ["Uis"] = {},
    ["KeyBinds"] = {},
    ["Variables"] = {},
}
BlueKeep["KeyBinds"]["CmdBar"] = "Minus"
BlueKeep["Variables"]["VoidHeight"] = workspace.FallenPartsDestroyHeight
-- this way we dont accidently import multiple of the same service..
BlueKeep["Functions"]["Service"] = function(Name: string)
    if BlueKeep["Services"][Name] then return BlueKeep["Services"][Name] end
    BlueKeep["Services"][Name] = cloneref(game:GetService(Name))
    return BlueKeep["Services"][Name]
end
BlueKeep["Functions"]["Camera"] = function() return game.Workspace.CurrentCamera end

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
local rs = BlueKeep["Functions"]["Service"]("RunService")
local uis = BlueKeep["Functions"]["Service"]("UserInputService")

BlueKeep["Functions"]["PlayAudio"] = function(id:string, looped:boolean)
task.spawn(function()
    local sound = Instance.new("Sound")
    sound.SoundId = `rbxassetid://{tostring(id or 1)}`
    sound.Parent = BlueKeep["Functions"]["Service"]("SoundService")
    sound.Looped = looped or false
    sound:Play()
    if not looped then
        sound.Ended:Wait()
        sound:Destroy()
        return
    end
    return sound
end)
end

BlueKeep["Uis"]["CmdList"] = function()
    local ScreenGui = Instance.new("ScreenGui")
    local hover_Text = Instance.new("TextLabel")
    local UICorner_4 = Instance.new("UICorner")
    hover_Text.Name = "hoverthing"
    hover_Text.Parent = ScreenGui
    hover_Text.ZIndex = 3
    hover_Text.BackgroundColor3 = Color3.fromRGB(0, 0, 176)
    hover_Text.BorderColor3 = Color3.fromRGB(0, 0, 0)
    hover_Text.BorderSizePixel = 0
    hover_Text.Size = UDim2.new(0, 298, 0, 66)
    hover_Text.Font = Enum.Font.SourceSans
    hover_Text.TextColor3 = Color3.fromRGB(81, 81, 81)
    hover_Text.TextScaled = true
    hover_Text.TextSize = 14.000
    hover_Text.TextWrapped = true
    hover_Text.Text = ""
    hover_Text.TextYAlignment = Enum.TextYAlignment.Top
    hover_Text.BackgroundTransparency = 1
    UICorner_4.Parent = hover_Text
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
        BlueKeep["Functions"]["PlayAudio"](139800881181209)
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
    ForCmds.AutomaticCanvasSize = Enum.AutomaticSize.Y

    local function addcmd(Text:string, Description:string, Name:string)
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

        Command.MouseEnter:Connect(function(x, y)
			local mouse = lp:GetMouse()
			hover_Text.BackgroundTransparency = 0
			hover_Text.Text = Description
			hover_Text.Position = UDim2.new((x/mouse.ViewSizeX) + .000050, 0, (y/mouse.ViewSizeY), 0)
        end)
        
        Command.MouseMoved:Connect(function()
			local mouse = lp:GetMouse()
			hover_Text.Position = UDim2.new((mouse.x/mouse.ViewSizeX) + .000050, 0, (mouse.y/mouse.ViewSizeY), 0)
        end)

        Command.MouseLeave:Connect(function(x, y)
            hover_Text.Text = ""
            hover_Text.BackgroundTransparency = 1
            hover_Text.Position = UDim2.new(x, 0, y, 0)
        end)

    end
    for name,cmd in pairs(BlueKeep["Commands"]) do
        addcmd(cmd["CmdList"], cmd["Description"], name)
    end
    UIGridLayout.Parent = ForCmds
    UIGridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIGridLayout.CellSize = UDim2.new(0, 250, 0, 80)

    local function GUIKCM_fake_script() -- CmdList.Dragify 
	    local script = Instance.new('LocalScript', CmdList)
	    local UserInputService = uis
	    local dragToggle
	    local dragInput
	    local dragSpeed
	    local dragStart
	    local dragPos
	    local startPos
	
	    function dragify(Frame)
	        dragToggle = nil
	        dragSpeed = 0.50
	        dragInput = nil
	        dragStart = nil
	        dragPos = nil
	        local function updateInput(input)
	            local Delta = input.Position - dragStart
	            local Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + Delta.X, startPos.Y.Scale, startPos.Y.Offset + Delta.Y)
	            ts:Create(Frame, TweenInfo.new(0.30), {Position = Position}):Play()
	    end
	        Frame.InputBegan:Connect(function(input)
	            if (input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch) and UserInputService:GetFocusedTextBox() == nil then
	                dragToggle = true
	                dragStart = input.Position
	                startPos = Frame.Position
	                input.Changed:Connect(function()
	                    if input.UserInputState == Enum.UserInputState.End then
	                        dragToggle = false
	                    end
	                end)
	            end
	        end)
	        Frame.InputChanged:Connect(function(input)
	            if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
	                dragInput = input
	            end
	        end)
	        uis.InputChanged:Connect(function(input)
	            if input == dragInput and dragToggle then
	                updateInput(input)
	            end
	        end)
	    end
	
	    dragify(script.Parent)
    end
    coroutine.wrap(GUIKCM_fake_script)()
end

BlueKeep["Functions"]["Notify"] = function(Title:string, Message:string, Time:number)
task.spawn(function()
    repeat task.wait() until not core:FindFirstChild("Notification!") -- dont play multiple at once
    BlueKeep["Functions"]["PlayAudio"](124951621656853)
    local ScreenGui = Instance.new("ScreenGui")
    local NotifGUI = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")
    local NotifText = Instance.new("TextLabel")
    local UICorner_2 = Instance.new("UICorner")
    local NotifBottomText = Instance.new("TextLabel")
    ScreenGui.Name = "Notification!"
    ScreenGui.Parent = core
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.ResetOnSpawn = false
    NotifGUI.Name = "NotifGUI"
    NotifGUI.AnchorPoint = Vector2.new(1, 1)
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
    NotifText.Text = Title
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
	local function Script_1()
		local script = Instance.new('Script', NotifGUI)
		local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Back, Enum.EasingDirection.Out)
		local tween = ts:Create(script.Parent, tweenInfo, {Position = UDim2.new(0.992, 0,0.983, 0)})
		tween:Play()
        tween.Completed:Wait()
		task.wait(Time)
		tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
		tween = ts:Create(script.Parent, tweenInfo, {Position = UDim2.new(1.5, 0, 0.95, 0)})
		tween:Play()
		tween.Completed:Wait()
		ScreenGui:Destroy()
	end
	coroutine.wrap(Script_1)()
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

BlueKeep["Functions"]["Character"] = function(plr: Player) -- returns character of entered player, if no player entered it returns lp character
    plr = plr or lp
    return plr.Character or plr.CharacterAdded:Wait()
end

BlueKeep["Functions"]["StopLoop"] = function(loop: string)
    if BlueKeep["Loops"][loop] then
        BlueKeep["Loops"][loop]:Disconnect()
        table.remove(BlueKeep["Loops"], BlueKeep["Loops"][loop])
    end
end

BlueKeep["Functions"]["No Vel"] = function()
    for _, part in pairs(BlueKeep["Functions"]["Character"]():GetDescendants()) do
        pcall(function() 
            part.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
            part.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
        end)
    end
end

BlueKeep["Functions"]["SetCollison"] = function(val:boolean)
   local char = BlueKeep["Functions"]["Character"]()
   for _,v in pairs(char:GetDescendants()) do
        pcall(function()
            v.CanCollide = val
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
    local targets = BlueKeep["Functions"]["GetPlayer"](target)
    for _,v in pairs(targets) do
        BlueKeep["Functions"]["No Vel"]()
        BlueKeep["Functions"]["Character"]():PivotTo(BlueKeep["Functions"]["Character"](v):GetPivot())
    end
end)

BlueKeep["Functions"]["NewCommand"]("cmds", "cmds", "Open cmd list", true, function()
    BlueKeep["Uis"]["CmdList"]()
end)

BlueKeep["Functions"]["NewCommand"]("re", "re", "respawn at current pos", true, function()
    local char = BlueKeep["Functions"]["Character"]()
    local ogpos = char:GetPivot()
    if replicatesignal then
        BlueKeep["Functions"]["Notify"]("Respawning", `Respawning in {players.RespawnTime}`, players.RespawnTime)
        replicatesignal(lp.ConnectDiedSignalBackend)
        task.wait(players.RespawnTime - 0.1)
        ogpos = char:GetPivot()
        replicatesignal(lp.Kill)
        lp.CharacterAdded:Wait():WaitForChild("Humanoid")
        BlueKeep["Functions"]["Character"]():PivotTo(ogpos)
        return
    end
	workspace.FallenPartsDestroyHeight = 0/0
	char:PivotTo(CFrame.new(5235, BlueKeep["Variables"]["VoidHeight"] - 100, 5235))
	task.wait(.1)
	workspace.FallenPartsDestroyHeight = BlueKeep["Variables"]["VoidHeight"]
    char:BreakJoints()
    lp.CharacterAdded:Wait():WaitForChild("Humanoid")
    BlueKeep["Functions"]["Character"]():PivotTo(ogpos)
end)

BlueKeep["Functions"]["NewCommand"]("sit", "sit", "sits down", true, function()
    BlueKeep["Functions"]["Character"]():WaitForChild("Humanoid").Sit = true
end)

BlueKeep["Functions"]["NewCommand"]("loopgoto", "loopgoto (plr)", "loop tp to target", true, function(target)
    BlueKeep["Functions"]["StopLoop"]("Loopgoto")
    target = BlueKeep["Functions"]["GetPlayer"](target)[1]
    BlueKeep["Loops"]["Loopgoto"] = rs.Heartbeat:Connect(function()
        BlueKeep["Functions"]["No Vel"]()
        BlueKeep["Functions"]["Character"]():PivotTo(BlueKeep["Functions"]["Character"](target):GetPivot())
    end)
end)

BlueKeep["Functions"]["NewCommand"]("unloopgoto", "unloopgoto", "disables loopgoto", true, function()
    BlueKeep["Functions"]["StopLoop"]("Loopgoto")
end)

BlueKeep["Functions"]["NewCommand"]("noclip", "noclip", "walk through walls", true, function()
    BlueKeep["Functions"]["StopLoop"]("Noclip")
    BlueKeep["Loops"]["Noclip"] = rs.Heartbeat:Connect(function()
        BlueKeep["Functions"]["SetCollison"](false)
    end)
end)

BlueKeep["Functions"]["NewCommand"]("clip", "clip", "disables noclip", true, function()
    BlueKeep["Functions"]["StopLoop"]("Noclip")
    BlueKeep["Functions"]["SetCollison"](true)
end)

BlueKeep["Functions"]["NewCommand"](
	"freecam",
	"freecam (speed)",
	"Toggle freecam (camera noclip)",
	true,
	function(speed)

		local cam = BlueKeep["Functions"]["Camera"]()
		speed = speed or 1.4
		local sensitivity = 0.0025

		if BlueKeep["Variables"]["FreecamEnabled"] then
			
			BlueKeep["Variables"]["FreecamEnabled"] = false
			cam.CameraType = Enum.CameraType.Custom
			uis.MouseBehavior = Enum.MouseBehavior.Default
			BlueKeep["Functions"]["Notify"]("Freecam", "Disabled", 2)
            BlueKeep["Functions"]["Character"]().HumanoidRootPart.Anchored = false
			return
		end

	
		BlueKeep["Variables"]["FreecamEnabled"] = true
        BlueKeep["Functions"]["Character"]().HumanoidRootPart.Anchored = true
		cam.CameraType = Enum.CameraType.Scriptable
		uis.MouseBehavior = Enum.MouseBehavior.LockCenter

		local cf = cam.CFrame
		local rx, ry = 0, 0

		local moveConn, lookConn

		moveConn = rs.RenderStepped:Connect(function()
			if not BlueKeep["Variables"]["FreecamEnabled"] then
				moveConn:Disconnect()
				if lookConn then lookConn:Disconnect() end
				return
			end

			local dir = Vector3.zero

			if uis:IsKeyDown(Enum.KeyCode.W) then dir += Vector3.new(0,0,-1) end
			if uis:IsKeyDown(Enum.KeyCode.S) then dir += Vector3.new(0,0,1) end
			if uis:IsKeyDown(Enum.KeyCode.A) then dir += Vector3.new(-1,0,0) end
			if uis:IsKeyDown(Enum.KeyCode.D) then dir += Vector3.new(1,0,0) end
			if uis:IsKeyDown(Enum.KeyCode.Space) then dir += Vector3.new(0,1,0) end
			if uis:IsKeyDown(Enum.KeyCode.LeftControl) then dir += Vector3.new(0,-1,0) end

			if dir.Magnitude > 0 then
				dir = dir.Unit
			end

			cf = cf * CFrame.new(dir * speed)
			cam.CFrame = cf
		end)

		lookConn = uis.InputChanged:Connect(function(input, gpe)
			if gpe or not BlueKeep["Variables"]["FreecamEnabled"] then return end

			if input.UserInputType == Enum.UserInputType.MouseMovement then
				rx -= input.Delta.Y * sensitivity
				ry -= input.Delta.X * sensitivity

				rx = math.clamp(rx, -math.rad(85), math.rad(85))

				cf = CFrame.new(cf.Position) * CFrame.Angles(rx, ry, 0)
				cam.CFrame = cf
			end
		end)

		BlueKeep["Functions"]["Notify"]("Freecam", "Enabled", 2)
	end
)

BlueKeep["Functions"]["NewCommand"]("view", "view (plr)", "Views player", true, function(target)
    BlueKeep["Functions"]["StopLoop"]("Viewing")
    target = BlueKeep["Functions"]["GetPlayer"](target)[1]
	local char = BlueKeep["Functions"]["Character"](target)

	if char and char:FindFirstChild("Humanoid") then
		BlueKeep["Functions"]["Notify"]("Viewing", target.Name, 10)
		BlueKeep["Functions"]["Camera"]().CameraSubject = target.Character:WaitForChild("Humanoid")
		BlueKeep["Loops"]["viewing"] = target.CharacterAdded:Connect(function()
			local hum = target.Character:WaitForChild("Humanoid")
			BlueKeep["Functions"]["Camera"]().CameraSubject = hum
		end)
	else
		BlueKeep["Functions"]["Notify"]("View", "Failed To Find Character Or Humanoid", 5)
	end
end)

BlueKeep["Functions"]["NewCommand"]("unview", "unview", "Unviews player", true, function()
    BlueKeep["Functions"]["StopLoop"]("Viewing")
    BlueKeep["Functions"]["Camera"]().CameraSubject = BlueKeep["Functions"]["Character"]():WaitForChild("Humanoid")
end)

BlueKeep["Functions"]["NewCommand"]("novoid", "novoid", "removes the void", true, function()
    workspace.FallenPartsDestroyHeight = 0/0
end)

BlueKeep["Functions"]["NewCommand"]("unnovoid", "unnovoid", "brings void back", true, function()
    workspace.FallenPartsDestroyHeight = BlueKeep["Variables"]["VoidHeight"]
end)

BlueKeep["Functions"]["NewCommand"]("voidcf", "voidcf", "voids people loopgoto'ing or banging you.", true, function()
    local orgpos = BlueKeep["Functions"]["Character"]():GetPivot()
    workspace.FallenPartsDestroyHeight = 0/0
    BlueKeep["Functions"]["Character"]():PivotTo(CFrame.new(0, BlueKeep["Variables"]["VoidHeight"], 0))
    task.wait(2)
    BlueKeep["Functions"]["Character"]():PivotTo(orgpos)
    workspace.FallenPartsDestroyHeight = BlueKeep["Variables"]["VoidHeight"]
end)

-- Command bar --
local ScreenGui = Instance.new("ScreenGui")
local CmdBar = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local stars2 = Instance.new("Frame")
local ImageLabel = Instance.new("ImageLabel")
local TextBox = Instance.new("TextBox")

ScreenGui.Parent = core
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "CmdBar"


CmdBar.AnchorPoint = Vector2.new(.5, .5)
CmdBar.Name = "CmdBar"
CmdBar.Parent = ScreenGui
CmdBar.BackgroundColor3 = Color3.fromRGB(0, 0, 121)
CmdBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
CmdBar.BorderSizePixel = 0
CmdBar.Position = UDim2.new(0.5, 0, 0.8, 0)
CmdBar.Size = UDim2.new(0, 349, 0, 100)

UICorner.Parent = CmdBar

stars2.Name = "stars2"
stars2.Parent = CmdBar
stars2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
stars2.BackgroundTransparency = 1.000
stars2.BorderColor3 = Color3.fromRGB(0, 0, 0)
stars2.BorderSizePixel = 0
stars2.Position = UDim2.new(0, 0, 0.100000001, 0)
stars2.Size = UDim2.new(0, 300, 0, 450)

ImageLabel.Parent = stars2
ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ImageLabel.BackgroundTransparency = 1.000
ImageLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
ImageLabel.BorderSizePixel = 0
ImageLabel.Position = UDim2.new(0, 0, -0.0222222228, 0)
ImageLabel.Size = UDim2.new(0, 349, 0, 100)
ImageLabel.Image = "rbxassetid://7209784983"
ImageLabel.ScaleType = Enum.ScaleType.Crop

TextBox.Parent = CmdBar
TextBox.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
TextBox.BackgroundTransparency = 1.000
TextBox.BorderColor3 = Color3.fromRGB(0, 0, 0)
TextBox.BorderSizePixel = 0
TextBox.Position = UDim2.new(0.0315186232, 0, 6.10351549e-07, 0)
TextBox.Size = UDim2.new(0, 326, 0, 90)
TextBox.Font = Enum.Font.FredokaOne
TextBox.PlaceholderText = "Commands Here"
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(0, 0, 0)
TextBox.TextScaled = true
TextBox.TextSize = 14.000
TextBox.TextWrapped = true

BlueKeep['Loops']['cmdbar_Toggle'] = uis.InputBegan:Connect(function(input, chting)
	if input.KeyCode.Name == BlueKeep["KeyBinds"]["CmdBar"] and not chting then
        task.wait()
		TextBox:CaptureFocus()
	end
end)

TextBox.FocusLost:Connect(function(ep)
    if not ep then return end
	local args = TextBox.Text:split(" ")
	local cmd = args[1]

	TextBox.Text = ""
	table.remove(args,1)

    BlueKeep["Functions"]["RunCommand"](cmd, args)
end)
-- Done Setting Up! --

local function getlen(t:{any}) -- #table does not work on bad executors..
    local h = 0
    for _, v in pairs(t) do
        h+=1
    end
    return h 
end

BlueKeep["Functions"]["Notify"]("BlueKeep", `Loaded<3\n {getlen(BlueKeep["Commands"])} commands loaded.`, 10)