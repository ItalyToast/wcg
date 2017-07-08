AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName 			= "Starter"
PLAYER.icon 				= "icons/starter.png"

ability1 = Ability.create("Speed", "Gives you bonus speed")
ability1.values = {440, 470, 505, 520}
ability1.MaxLevel = 4
ability1.OnSpawn = function(self, player)

	player.Player:SetWalkSpeed(self.values[self.Level])
	
end

ability2 = Ability.create("Health", "Gives you bonus health")
ability2.values = {20, 40, 60, 100}
ability2.MaxLevel = 4
ability2.OnSpawn = function(self, player)

	player.Player:SetHealth(100+(self.values[self.Level]))
	
end

ability3 = Ability.create("Jump", "Gives you bonus jump height")
ability3.values = {240, 280, 320, 360}
ability3.MaxLevel = 4
ability3.OnSpawn = function(self, player)

	player.Player:SetJumpPower(self.values[self.Level])
	
end

ultimate = Ability.create("Thunder Shock", "Shocks an enemy for damage")
ultimate.MaxLevel = 4
ultimate.values = {200, 300, 400, 500}
ultimate.Sound = "weapons/party_horn_01.wav"
ultimate.OnActivate = function(self, player)

	local target = player:GetEyeTrace()
		
	if(target.HitWorld == true) then
		return true --we cancel the cast if we dont find a target
	end
	
	local victim = target.Entity
	
	local forcevector = player:GetAimVector()
	forcevector:Mul(20000)
	forcevector.z = 100000
	
	local dmginfo = DamageInfo()
	dmginfo:SetDamage(self.values[self.Level])
	dmginfo:SetInflictor(player)
	dmginfo:SetAttacker(player)
	dmginfo:SetDamageForce(forcevector)
	dmginfo:SetDamagePosition( player:GetPos() )
	dmginfo:SetDamageType(DMG_BLAST)
	dmginfo:SetReportedPosition( player:GetPos() )
	victim:TakeDamageInfo(dmginfo)

	local effectdata = EffectData()
	effectdata:SetOrigin( victim:GetPos() )
	effectdata:SetScale( 1 )
	effectdata:SetMagnitude( 25 )
	util.Effect("Explosion", effectdata)
	
end

PLAYER.abilities = { ability1, ability2, ability3, ultimate }

CreateRace( "starter", PLAYER, "base" )
