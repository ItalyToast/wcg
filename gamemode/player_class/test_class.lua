AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName = "Test Class"
PLAYER.WalkSpeed = 100

PLAYER.skills = {}
local ultimate = 3

PLAYER.skills[0] = {}
PLAYER.skills[1] = {}
PLAYER.skills[2] = {}
PLAYER.skills[ultimate] = {}

PLAYER.skills[0].Name = "Speed"
PLAYER.skills[0].Desc = "Gives you bonus speed"
PLAYER.skills[0].MaxLevel = 4
PLAYER.skills[0].Values = {2, 1.4, 1.6, 1.8}

PLAYER.skills[1].Name = "Health"
PLAYER.skills[1].Desc = "Gives you bonus health"
PLAYER.skills[1].MaxLevel = 4
PLAYER.skills[1].Values = {20, 40, 60, 100}

PLAYER.skills[2].Name = "Jump"
PLAYER.skills[2].Desc = "Gives you bonus jump height"
PLAYER.skills[2].MaxLevel = 4
PLAYER.skills[2].Values = {2, 1.4, 1.6, 1.8}

PLAYER.skills[ultimate].Name = "Thunder Shock"
PLAYER.skills[ultimate].Desc = "Shocks an enemy for damage"
PLAYER.skills[ultimate].MaxLevel = 4
PLAYER.skills[ultimate].Values = {200, 30, 40, 50}

function PLAYER:SetPassives(level)
	-- Skill0
	self.Player:SetWalkSpeed(400*baseclass.Get("test_class").skills[0].Values[level])
	
	-- Skill1
	self.Player:SetHealth(100+baseclass.Get("test_class").skills[1].Values[level])
	
	-- Skill2
	self.Player:SetJumpPower(200*baseclass.Get("test_class").skills[2].Values[level])
end

function PLAYER:Ultimate(level)
	
	local target = self.Player:GetEyeTrace()
	
	local ultimate_used = false
	
	if(target.HitWorld == false) then
		
		local victim = target.Entity

		-- Debug
		print(victim)
		
		victim:TakeDamage(baseclass.Get("test_class").skills[ultimate].Values[level], self.Player, self.Player)
		ultimate_used = true
	end
	
	return ultimate_used
end

player_manager.RegisterClass( "test_class", PLAYER, "base" )