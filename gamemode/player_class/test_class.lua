AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName 			= "Test Class"
PLAYER.WalkSpeed 			= 100
PLAYER.icon 				= "materials/icon16/basket.png"

ability1 = Ability.create("Speed", "Gives you bonus speed")
ability1.values = {240, 280, 320, 360}
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
		
	victim:TakeDamage(self.values[self.Level], player, player)
	
end

PLAYER.abilities = { ability1, ability2, ability3, ultimate }

CreateRace( "test_class", PLAYER, "base" )
