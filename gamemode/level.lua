
function set_xp_console(player, cmd, args, argStr)
	print("setxp")
	print(argStr)
	local amount = tonumber(argStr)
	if(amount != nil) then
		set_xp(player, amount)
		print( "set xp: " .. amount)
	end
end

function get_xp_console(player, cmd, args, argStr)
	print(get_xp(player))
end


function set_xp(player, xp, classid)
	if(classid == nil) then classid = player:GetClassID() end

	if(isnumber(xp)) then
		player:SetPData("class_" .. classid .. "_xp", xp)
	else
		throw("not a number: xp")
	end
end

function get_xp(player, classid)
	if(classid == nil) then classid = player:GetClassID() end
	
	return player:GetPData("class_" .. classid .. "_xp") or 0
end

function set_level(player, level, classid)
	if(classid == nil) then classid = player:GetClassID() end

	if(isnumber(level)) then
		player:SetPData("class_" .. classid .. "_level", level)
	else
		throw("not a number: level")
	end
end

function get_level(player, classid)
	if(classid == nil) then classid = player:GetClassID() end
	
	return player:GetPData("class_" .. classid .. "_level") or 0
end