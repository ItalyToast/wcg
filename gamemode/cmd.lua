function set_xp_console(player, cmd, args, argStr)
	local amount = tonumber(argStr)
	if(amount != nil) then
		db_set_xp(player, amount)
		print( "set xp: " .. amount)
	else
		print("Bad argument: " + argStr)
	end
end

function get_xp_console(player, cmd, args, argStr)
	print(db_get_xp(player))
end

function spawn_prison_guard(player, cmd, args, argStr)
	local npc = ents.Create( "npc_combine_s" )
	if ( !IsValid( npc ) ) then return end // Check whether we successfully made an entity, if not - bail
	npc:SetPos( player:GetPos() )
	npc:Spawn()
end