--Database Function

function db_set_xp(player, xp, class)
	if(class == nil) then class = player_manager.GetPlayerClass(player) end

	if(isnumber(xp)) then
		player:SetPData("class_" .. class .. "_xp", xp)
	else
		print("db_set_xp: 'xp' is not a number")
	end
end

function db_get_xp(player, class)
	if(class == nil) then class = player_manager.GetPlayerClass(player) end
	
	return player:GetPData("class_" .. class .. "_xp") or 0
end

function db_set_level(player, level, class)
	if(class == nil) then class = player_manager.GetPlayerClass(player) end

	if(isnumber(level)) then
		player:SetPData("class_" .. class .. "_level", level)
	else
		print("db_set_level: 'level' is not a number")
	end
end

function db_get_level(player, class)
	if(class == nil) then class = player_manager.GetPlayerClass(player) end
	
	return player:GetPData("class_" .. class .. "_level") or 0
end

function db_set_race(player, class)
	if(class == nil) then class = player_manager.GetPlayerClass(player) end

	if(isstring(class)) then
		player:SetPData("selected_class", class)
	else
		print("db_set_race: 'class' is not a class")
	end
end

function db_get_race(player)
	return player:GetPData("selected_class") or nil
end

--Networking
function net_WCG_ChangeRace(len, player)
	if(IsValid(player) and player:IsPlayer()) then
		local class = net.ReadInt(32)
		player.SetClass(class)
		db_set_race(class)
		player:ChatPrint("You will be '"..class.Name.."' next time you spawn.")
	end

end

net.Receive("WCG_ChangeRace", net_WCG_ChangeRace)
