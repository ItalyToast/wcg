--Database Function

function db_set_xp(player, xp, class)
	if(class == nil) then class = player_manager.GetPlayerClass(player) end

	if(isnumber(xp)) then
		player:SetPData("class_" .. class .. "_xp", xp)
	else
		throw("not a number: xp")
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
		throw("not a number: level")
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
		throw("not a number: class")
	end
end

function db_get_race(player)
	return player:GetPData("selected_class") or nil
end

--Networking
function net_WCG_ChangeRace(len, player)
	local class = net.ReadInt(32)
	
	player.Setclass(class)
	db_set_race(class);
end

net.Receive("WCG_ChangeRace", net_WCG_ChangeRace)
