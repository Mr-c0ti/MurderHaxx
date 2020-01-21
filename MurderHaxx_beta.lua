-- MurderHaxx by TreTrauIT
-- Beta.
local randomPlayer = nil
local MurdererHunt = false
local teletotop = false
local ESPenabled = false
local isESPing = false
local isEveryoneOldName = true
local isEveryoneAlive = true
local isDown = false
local isUp = false
local binding = false
local TPbind = Enum.KeyCode.Z
local PARENT
if game:GetService("CoreGui"):FindFirstChild('RobloxGui') then
	PARENT = game:GetService("CoreGui").RobloxGui
else
	PARENT = game:GetService("CoreGui")
end
-- Murderer Notice part.
local MurderNoti = Instance.new("Frame")
MurderNoti.Name = ""
MurderNoti.Parent = PARENT
MurderNoti.Active = true
MurderNoti.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
MurderNoti.BorderSizePixel = 0
MurderNoti.Position = UDim2.new(1, -250, 1, 20)
MurderNoti.Size = UDim2.new(0, 250, 0, 100)
local MTitle_2 = Instance.new("TextLabel")
MTitle_2.Name = "Title"
MTitle_2.Parent = MurderNoti
MTitle_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
MTitle_2.BorderSizePixel = 0
MTitle_2.Size = UDim2.new(0, 250, 0, 20)
MTitle_2.Font = Enum.Font.SourceSans
MTitle_2.TextSize = 14
MTitle_2.Text = "Murderer Found"
MTitle_2.TextColor3 = Color3.new(1, 1, 1)
local MText_2 = Instance.new("TextLabel")
MText_2.Name = "Text"
MText_2.Parent = MurderNoti
MText_2.BackgroundTransparency = 1
MText_2.BorderSizePixel = 0
MText_2.Position = UDim2.new(0, 5, 0, 25)
MText_2.Size = UDim2.new(0, 240, 0, 75)
MText_2.Font = Enum.Font.SourceSans
MText_2.TextSize = 16
MText_2.Text = "The murderer is: "
MText_2.TextColor3 = Color3.new(1, 1, 1)
MText_2.TextWrapped = true
function MurdererFind()
	spawn(function()
		MurderNoti:TweenPosition(UDim2.new(1, MurderNoti.Position.X.Offset, 1, -0), "InOut", "Quart", 0.5, true, nil)
		wait(0.5)
		MurderNoti:TweenPosition(UDim2.new(1, MurderNoti.Position.X.Offset, 1, -100), "InOut", "Quart", 0.5, true, nil)
		while MurdererHunt and wait(0.01) do
			--print('Finding murderer')
        	for i, v in pairs(game:GetService("Players"):GetPlayers()) do
				--print("Checking player: "..tostring(v))
            	if (v.Status.Role.Value == "Murderer") then
					--print("Murderer found. Name: "..tostring(v))
                	local MurdererFakeName = v.Status.FakeName.Value
					--print("Fake name: "..tostring(MurdererFakeName))
					MText_2.Text = "The murderer is: "..MurdererFakeName..string.char(10).."The murderer's real name: "..v.Name
            	end
        	end
		end
	end)
end

-- ESP Player
function round(num, numDecimalPlaces)
    local mult = 10^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
  end
function ESP(plr)
	spawn(function()
		for i,v in pairs(PARENT:GetChildren()) do
			if v.Name == plr.Name..'_ESP' then
				v:Destroy()
			end
		end
		wait()
		if plr.Character and plr.Name ~= game:GetService("Players").LocalPlayer.Name and not PARENT:FindFirstChild(plr.Name..'_ESP') then
			local ESPholder = Instance.new("Folder", PARENT)
			ESPholder.Name = plr.Name..'_ESP'
			for b,n in pairs (plr.Character:GetChildren()) do
				if (n:IsA("BasePart")) then
					local a = Instance.new("BoxHandleAdornment", ESPholder)
					a.Name = plr.Name
					a.Adornee = n
					a.AlwaysOnTop = true
					a.ZIndex = 0
					a.Size = n.Size
					a.Transparency = 0.7
				end
			end
            if plr.Character and plr.Character:FindFirstChild('Head') then
				local BillboardGui = Instance.new("BillboardGui", ESPholder)
				local TextLabel = Instance.new("TextLabel")
				BillboardGui.Adornee = plr.Character.Head
				BillboardGui.Name = plr.Status.FakeName.Value..string.char(10).."Real name: "..plr.name
				BillboardGui.Size = UDim2.new(0, 100, 0, 150)
				BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
				BillboardGui.AlwaysOnTop = true
				TextLabel.Parent = BillboardGui
				TextLabel.BackgroundTransparency = 1
				TextLabel.Position = UDim2.new(0, 0, 0, -50)
				TextLabel.Size = UDim2.new(0, 100, 0, 100)
				TextLabel.Font = Enum.Font.SourceSansSemibold
				TextLabel.TextSize = 20
				TextLabel.TextColor3 = Color3.new(1, 1, 1)
				TextLabel.TextStrokeTransparency = 0
				TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
				plr.CharacterAdded:Connect(function()
					if ESPenabled then
						espLoopFunc:Disconnect()
						ESPholder:Destroy()
						repeat wait(1) until plr.Character:FindFirstChild('HumanoidRootPart') and plr.Character:FindFirstChild('Humanoid')
						ESP(plr)
					end
				end)
				local function espLoop()
					if PARENT:FindFirstChild(plr.Name..'_ESP') then
						if plr.Character and plr.Character:FindFirstChild('HumanoidRootPart') and plr.Character:FindFirstChild('Humanoid') then
							local pos = math.floor((game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position - plr.Character.HumanoidRootPart.Position).magnitude)
							TextLabel.Text = plr.Status.FakeName.Value..string.char(10)..'Real Name: '..plr.Name..string.char(10)..'Studs: '..pos
						end
					else
						espLoopFunc:Disconnect()
					end
				end
				espLoopFunc = game:GetService("RunService").RenderStepped:Connect(espLoop)
			end
		end
	end)
end
function everyoneOldName()
local oldName = {}
for i, v in pairs(game:GetService("Players"):GetPlayers()) do
table.insert(oldName,i,v.Status.FakeName.Value)
end
local function getCurrentName()
local currName = {}
for i, v in pairs(game:GetService("Players"):GetPlayers()) do
table.insert(currName,i,v.Status.FakeName.Value)
end
return currName
end
while oldName == getCurrentName() do 
isEveryoneOldName = true
wait()
end
isEveryoneOldName = false
end

function EveryoneAlive()
local defaultAlive = 0
for i, v in pairs(game:GetService("Players"):GetPlayers()) do
if (v.Status.Alive.Value) then
defaultAlive = defaultAlive + 1
end
end
local function getCurrentAlive()
local currAlv = 0
for i, v in pairs(game:GetService("Players"):GetPlayers()) do
if (v.Status.Alive.Value) then
currAlv = currAlv + 1
end
end
return currAlv
end
while defaultAlive == getCurrentAlive() do
	isEveryoneAlive = true
wait()
end
isEveryoneAlive = false
end
function refreshESP()
everyoneOldName()
EveryoneAlive()
while isEveryoneAlive and isEveryoneOldName do
wait()
end
if (isESPing) then
			ESPenabled = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local espplr = v
				for i,c in pairs(PARENT:GetChildren()) do
					if c.Name == espplr.Name..'_ESP' then
						c:Destroy()
					end
				end
			end
			wait()
			ESPenabled = true
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				if v.ClassName == "Player" and v.Name ~= game:GetService("Players").LocalPlayer.Name and v.Status.Alive.Value then
					ESP(v)
				end
			end
			refreshESP()	
end
end

function preventBugTp()
while (game:GetService("Players").LocalPlayer.PlayerGui.Stuff.ScoreBoard.Visible == false) and isUp do
wait()
end
teletotop = false
if (not isDown) then
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Y-299,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Z))
wait(0.01)
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Anchored = false
isUp = false
end
end
-- Notify function
local notifyCount = 0
local Notification = Instance.new("Frame")
local Title_2 = Instance.new("TextLabel")
local Text_2 = Instance.new("TextLabel")
function randomString()
	math.randomseed(os.time())
	local length = math.random(10,20)
	local array = {}
	for i = 1, length do
		math.randomseed(os.time())
		array[i] = string.char(math.random(32, 126))
	end
	return table.concat(array)
end
Notification.Name = randomString()
Notification.Parent = PARENT
Notification.Active = true
Notification.BackgroundColor3 = Color3.fromRGB(36, 36, 37)
Notification.BorderSizePixel = 0
Notification.Position = UDim2.new(1, -500, 1, 20)
Notification.Size = UDim2.new(0, 250, 0, 100)

Title_2.Name = "Title"
Title_2.Parent = Notification
Title_2.BackgroundColor3 = Color3.fromRGB(46, 46, 47)
Title_2.BorderSizePixel = 0
Title_2.Size = UDim2.new(0, 250, 0, 20)
Title_2.Font = Enum.Font.SourceSans
Title_2.TextSize = 14
Title_2.Text = "Notification Title"
Title_2.TextColor3 = Color3.new(1, 1, 1)

Text_2.Name = "Text"
Text_2.Parent = Notification
Text_2.BackgroundTransparency = 1
Text_2.BorderSizePixel = 0
Text_2.Position = UDim2.new(0, 5, 0, 25)
Text_2.Size = UDim2.new(0, 240, 0, 75)
Text_2.Font = Enum.Font.SourceSans
Text_2.TextSize = 16
Text_2.Text = "Notification Text"
Text_2.TextColor3 = Color3.new(1, 1, 1)
Text_2.TextWrapped = true
function isNumber(str)
	return tonumber(str) ~= nil
end
function notify(text,text2,length)
	spawn(function()
		local LnotifyCount = notifyCount+1
		notifyCount = notifyCount+1
		Notification:TweenPosition(UDim2.new(1, Notification.Position.X.Offset, 1, -0), "InOut", "Quart", 0.5, true, nil)
		wait(0.6)
		local closepressed = false
		if text2 then
			Notification.Title.Text = text
			Notification.Text.Text = text2
		else
			Notification.Title.Text = 'Notification'
			Notification.Text.Text = text
		end
		Notification:TweenPosition(UDim2.new(1, Notification.Position.X.Offset, 1, -100), "InOut", "Quart", 0.5, true, nil)
		if length and isNumber(length) then
			wait(length)
		else
			wait(10)
		end
		if LnotifyCount == notifyCount then
			if closepressed == false then
				Notification:TweenPosition(UDim2.new(1, Notification.Position.X.Offset, 1, -0), "InOut", "Quart", 0.5, true, nil)
			end
			notifyCount = 0
		end
	end)
end
-- Capture key
function onKeyPress(inputObject, gameProcessedEvent)
	if not binding then
		if inputObject.KeyCode == TPbind then
        pcall(function()
            if (randomPlayer.Character:WaitForChild('Humanoid').Health ~= 0) and (randomPlayer ~= game:GetService("Players").LocalPlayer) and (randomPlayer ~= nil) then
                if randomPlayer.Character ~= nil then
                    if game:GetService("Players").LocalPlayer.Character:FindFirstChild("Humanoid") then
                        game:GetService("Players").LocalPlayer.Character:FindFirstChildOfClass('Humanoid').Jump = true
                    end
                    --print('Teleporting To '..tostring(randomPlayer))
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = randomPlayer.Character.HumanoidRootPart.CFrame + Vector3.new(1,0,1)
                end
            else
                print('Changing Target')
                local oldTarget = randomPlayer
        		while (randomPlayer == oldTarget or randomPlayer == game:GetService("Players").LocalPlayer or (not randomPlayer.Status.Alive.Value)) and wait() do
            		math.randomseed(os.time())
            		randomPlayer = game:GetService("Players"):GetPlayers()[math.random(1,#game:GetService("Players"):GetPlayers())]
        		end
                print("New target: "..tostring(randomPlayer))
				notify("New target set","New target:"..randomPlayer.Name,1)
            end
        end)
    elseif inputObject.KeyCode == Enum.KeyCode.R then
        print('Changing Target')
        local oldTarget = randomPlayer
        math.randomseed(os.time())
        randomPlayer = game:GetService("Players"):GetPlayers()[math.random(1,#game:GetService("Players"):GetPlayers())]
        while (randomPlayer == oldTarget or randomPlayer == game:GetService("Players").LocalPlayer or (not randomPlayer.Status.Alive.Value)) and wait() do
            math.randomseed(os.time())
            randomPlayer = game:GetService("Players"):GetPlayers()[math.random(1,#game:GetService("Players"):GetPlayers())]
        end
        print("New target: "..tostring(randomPlayer))
		notify("New target set","New target:"..randomPlayer.Name,1)
    elseif inputObject.KeyCode == Enum.KeyCode.F then
		MurdererHunt = not MurdererHunt
		if MurdererHunt then
			notify("Module enabled","Murderer Finder Enabled",0.5)
			MurdererFind()
		else
			MurderNoti:TweenPosition(UDim2.new(1, MurderNoti.Position.X.Offset, 1, -0), "InOut", "Quart", 0.5, true, nil)
			notify("Module disabled","Murderer Finder Disabled",0.5)
		end
	elseif inputObject.KeyCode == Enum.KeyCode.T then
		teletotop = not teletotop
		if teletotop then
			notify("Module enabled","Bystander God [Experimental] enabled",0.5)
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Y+300,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Z))
			wait(0.01)
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Anchored = true
			isDown = false
			isUp = true
			preventBugTp()
		else
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(Vector3.new(game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.X,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Y-299,game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position.Z))
			wait(0.01)
			game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Anchored = false
			isDown = true
			isUp = false
			notify("Module disabled","Bystander God [Experimental] disabled",0.5)
		end
    elseif inputObject.KeyCode == Enum.KeyCode.G then
		isESPing = not isESPing
		if isESPing then
			notify("Module enabled","ESP [IY FE] enabled",0.5)
			ESPenabled = true
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				if v.ClassName == "Player" and v.Name ~= game:GetService("Players").LocalPlayer.Name and v.Status.Alive.Value then
					ESP(v)
				end
			end
			refreshESP()
		else
			ESPenabled = false
			for i,v in pairs(game:GetService("Players"):GetChildren()) do
				local espplr = v
				for i,c in pairs(PARENT:GetChildren()) do
					if c.Name == espplr.Name..'_ESP' then
						c:Destroy()
					end
				end
			end
			notify("Module disabled","ESP [IY FE] disabled",0.5)
		end
	end
	end
end
game:GetService("UserInputService").InputBegan:connect(onKeyPress)
game:GetService('RunService').Stepped:connect(function()
	if teletotop then
		game:GetService("Players").LocalPlayer.Character.Humanoid:ChangeState(11)
	end
end)
local banned = {
    Return = true;
    Space = true;
    Tab = true;
    Unknown = true;
}               
local allowed = {
    MouseButton1 = true;
    MouseButton2 = true;
}  
game:GetService("Players").LocalPlayer.Chatted:Connect(function(msg)
	if string.sub(msg, 1, 10):lower() == ("/e bind tp") then
			binding = true
print('Begin binding...')
notify("Binding [TP]","Press a key to bind to teleport...")
local a, b = game:GetService('UserInputService').InputBegan:wait(1);
local name = tostring(a.KeyCode.Name);
local typeName = tostring(a.UserInputType.Name);
if (a.UserInputType ~= Enum.UserInputType.Keyboard and (not allowed[a.UserInputType.Name])) or (a.KeyCode and (not banned[a.KeyCode.Name])) then
	local name = (a.UserInputType ~= Enum.UserInputType.Keyboard and a.UserInputType.Name or a.KeyCode.Name);
	TPbind = (a).KeyCode;
    notify("Keybind Updated [TP]","New key bind for teleport is: "..name,1);         
else
    if (TPbind) then
        local name = TPbind.Name
    	notify("Keybind Updated [TP]","New key bind for teleport is: "..name,1);  
    end
end
wait(0.1)  
binding = false;
	end
end)
