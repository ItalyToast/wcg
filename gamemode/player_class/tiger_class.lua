AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName 			= "Tiger"
PLAYER.WalkSpeed 			= 100
PLAYER.icon 				= "materials/icon16/anchor.png"

ability1 = Ability.create("Claws", "Gives you bonus ranged and melee(2xBonus) attack damage")
ability1.values = {1.2, 1.4, 1.6, 1.8}
ability1.MaxLevel = 4
ability1.OnDealDamage = function(self, target, hitgroup, dmginfo)

	local buff = self.values[self.Level]
	dmginfo:ScaleDamage( buff )
	if(dmginfo:GetDamageType() == DMG_CLUB) then
		dmginfo:ScaleDamage( buff )
	end
	
end

ability2 = Ability.create("Jump", "Gives you bonus jump height")
ability2.values = {1.2, 1.4, 1.6, 1.8}
ability2.MaxLevel = 4
ability2.OnSpawn = function(self, player)

	player.Player:SetJumpPower(200*self.values[self.Level])
	
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

ultimate = Ability.create("Dash", "Dash towards target")
ultimate.values = { 300, 400, 500 }
ultimate.MaxLevel = 4
ultimate.Sound = "player/jumplanding4.wav"
ultimate.OnActivate = function(self, player)

	if(!player:IsOnGround())then
		return true
	end

	local ent = player:GetViewEntity()
	local dir = player:GetAimVector()
	
	local pos = ent:GetPos()
	pos.z = pos.z + 1
	ent:SetPos(pos)
	
	dir:Mul(self.values[self.Level])
	if(dir.z < 0) then dir.z = 0 end
	dir.z = dir.z + 200
	ent:SetVelocity( dir )
	
end

PLAYER.abilities = { ability1, ability2, ability3, ultimate }



function PLAYER:Ultimate(level)
	
	PLAYER.ability4:Activate(self.Player)

end

CreateRace( "tiger_class", PLAYER, "base" )
