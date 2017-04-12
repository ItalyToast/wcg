-----------------------------------------------------------
function cmd_set_xp(player, cmd, args, argStr)
	local amount = tonumber(argStr)
	if(amount != nil) then
		player.xp = amount
		db_set_xp(player, amount)
		player:SendRaceInfo()
		print( "set xp: " .. amount)
	else
		print("Bad argument: " + argStr)
	end
end


-----------------------------------------------------------
function cmd_get_xp(player, cmd, args, argStr)
	print(db_get_xp(player))
end

-----------------------------------------------------------
function cmd_gain_xp(player, cmd, args, argStr)
	local amount = tonumber(argStr)
	if(amount != nil) then
		player_manager.RunClass( player, "GainXP", amount)
	else
		print("Bad argument: " + argStr)
	end
end

-----------------------------------------------------------
function cmd_spawn_prison_guard(player, cmd, args, argStr)
	local npc = ents.Create( "npc_combine_s" )
	if ( !IsValid( npc ) ) then return end // Check whether we successfully made an entity, if not - bail
	npc:SetPos( player:GetShootPos() )
	npc:Spawn()
end

-----------------------------------------------------------
function cmd_changerace(player, cmd, args, argStr)
	if ( IsValid( player ) and player:IsPlayer() ) then
		player_manager.SetPlayerClass(player, args[1])
		print("New Race " .. argStr)
		
		db_set_race(player)
	end
end