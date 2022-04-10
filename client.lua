local parent = script.Parent.Parent

game.Players.PlayerAdded:Connect(function(player)
	player:SetAttribute("frozen", false)
end)

local plrCount = 0

function close()
	parent:Destroy()
end

function getUsers()
	local playerList = {}
	
	for i, v in pairs(game.Players:GetChildren()) do
		table.insert(playerList, v)
	end
	
	local amount_ofPlayers = table.getn(playerList)	
	plrCount = amount_ofPlayers
end

function updateUsers()
	parent["main-frame"]["player-count-text"].Text = plrCount .. " Players Active"
end

function heal()
	local target = parent["main-frame"]["player-entry"].Text
	workspace:WaitForChild(target):WaitForChild("Humanoid").Health = 100
	print(tostring(game.Players.LocalPlayer).." healed "..target..".")
end

function kick()
	local target = parent["main-frame"]["player-entry"].Text
	game.Players:WaitForChild(target):Kick("Kicked by admin - appeal if you think this was unnecessary.")
	print(tostring(game.Players.LocalPlayer).." kicked "..target..".")
end

function freeze()
	local target = parent["main-frame"]["player-entry"].Text
	
	if game.Players:WaitForChild(target):GetAttribute("frozen") == false then
		workspace:WaitForChild(target):WaitForChild("Head").Anchored = true
		game.Players:WaitForChild(target):SetAttribute("frozen", true)
		print(tostring(game.Players.LocalPlayer).." froze "..target..".")
	else
		workspace:WaitForChild(target):WaitForChild("Head").Anchored = false
		game.Players:WaitForChild(target):SetAttribute("frozen", false)
		print(tostring(game.Players.LocalPlayer).." unfroze "..target..".")
	end
	
end

function kill()
	local target = parent["main-frame"]["player-entry"].Text
	workspace:WaitForChild(target):WaitForChild("Humanoid").Health = 0
	print(tostring(game.Players.LocalPlayer).." killed "..target..".")
end

function predictName(input)
	local players = {}
	
	for _, player in pairs(game.Players:GetPlayers()) do
		players[player.Name] = player.Name
	end
	
	for _, name in pairs(players) do

		if parent["main-frame"]["player-entry"].Text:lower():sub(1, 4) == name:lower():sub(1, 4) then
			parent["main-frame"]["player-entry"].Text = name
		end

	end
end

game:GetService("RunService").RenderStepped:Connect(function()
	getUsers()
	updateUsers()
end)

parent["main-frame"]["action-buttons"]["kick-button"].MouseButton1Click:Connect(kick)
parent["main-frame"]["action-buttons"]["freeze-button"].MouseButton1Click:Connect(freeze)
parent["main-frame"]["action-buttons"]["kill-button"].MouseButton1Click:Connect(kill)
parent["main-frame"]["exit-button"].MouseButton1Click:Connect(close)

parent["main-frame"]["player-entry"]:GetPropertyChangedSignal("Text"):Connect(predictName)

-- comment
