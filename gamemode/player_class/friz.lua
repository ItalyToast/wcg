AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName 			= "Friz"
PLAYER.icon 				= "icons/friz.png"

ability1 = Ability.create("Frozen Touch", "Gives you a chance to freeze victim or attacker for 0.4 sec")
ability1.values = {0.05, 0.09, 0.13, 0.15}
ability1.MaxLevel = 4
ability1.OnDealDamage = function(self, target, hitgroup, dmginfo)

	local chance = self.values[self.Level]
	
	if( chance > math.Rand() ) then
		target:Freeze(true)
		print("Frozen target")
	end
	
end
ability1.OnReciveDamage = function(self, target, hitgroup, dmginfo)

	local chance = self.values[self.Level]
	
	if( chance > math.Rand() ) then
		target:Freeze(true)
		print("Frozen target")
	end

end

ability2 = Ability.create("Agile", "Gives you bonus jump speed")
ability2.values = {240, 280, 320, 360}
ability2.MaxLevel = 4
ability2.OnJump = function(self, player)
	if(!player:IsOnGround())then
		return true
	end

	local ent = player:GetViewEntity()
	local dir = player:GetAimVector()
	
	local pos = ent:GetPos()
	pos.z = pos.z + 1
	ent:SetPos(pos)
	
	local jumppower = self.values[self.Level]
	dir:Mul(jumppower)
	if(dir.z < 0) then dir.z = 0 end
	dir.z = dir.z + 200
	ent:SetVelocity( dir )
	
end

ability3 = Ability.create("Evasion", "Gives you a chance to dodge bullets")
ability3.values = {20, 40, 60, 80}
ability3.MaxLevel = 4
ability3.OnReciveDamage = function(self, target, hitgroup, dmginfo)
	local dodge = self.values[self.Level]
	if(dodge >= math.random( 100 )) then
		dmginfo:ScaleDamage( 0 )
	end
end

ultimate = Ability.create("Frozt", "Create a zone where everything except you is frozen")
ultimate.values = { 1, 1.4, 1.7 }
ultimate.MaxLevel = 3
ultimate.Sound = "player/jumplanding4.wav" -- Fix
ultimate.OnActivate = function(self, player) -- Fix

	if(!player:IsOnGround())then
		return true
	end

	local ent = player:GetViewEntity()
	local dir = player:GetAimVector()
	
	local pos = ent:GetPos()
	pos.z = pos.z + 1
	ent:SetPos(pos)
	
	local jumppower = self.values[self.Level]
	dir:Mul(jumppower)
	if(dir.z < 0) then dir.z = 0 end
	dir.z = dir.z + 200
	ent:SetVelocity( dir )
	
end

PLAYER.abilities = { ability1, ability2, ability3, ultimate }

CreateRace( "friz", PLAYER, "base" )
