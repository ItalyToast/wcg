--Database Function

function db_set_xp(player, xp, classid)
	if(classid == nil) then classid = player:GetClassID() end

	if(isnumber(xp)) then
		player:SetPData("class_" .. classid .. "_xp", xp)
	else
		throw("not a number: xp")
	end
end

function db_get_xp(player, classid)
	if(classid == nil) then classid = player:GetClassID() end
	
	return player:GetPData("class_" .. classid .. "_xp") or 0
end

function db_set_level(player, level, classid)
	if(classid == nil) then classid = player:GetClassID() end

	if(isnumber(level)) then
		player:SetPData("class_" .. classid .. "_level", level)
	else
		throw("not a number: level")
	end
end

function db_get_level(player, classid)
	if(classid == nil) then classid = player:GetClassID() end
	
	return player:GetPData("class_" .. classid .. "_level") or 0
end

function db_set_race(player, classid)
	if(classid == nil) then classid = player:GetClassID() end

	if(isnumber(classid)) then
		player:SetPData("selected_class", classid)
	else
		throw("not a number: classid")
	end
end

function db_get_race(player)
	return player:GetPData("selected_class") or -1
end

--Networking
function net_WCG_ChangeRace(len, player)
	local classID = net.ReadInt(32)
	
	player.SetClassID(classID)
	db_set_race(classID);
end

net.Receive("WCG_ChangeRace", net_WCG_ChangeRace)
