AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName 			= "Test Class"
PLAYER.WalkSpeed 			= 100
PLAYER.icon 				= "materials/icon16/basket.png"

PLAYER.skills = {}

PLAYER.ultimate = 4
local ultimate = PLAYER.ultimate
PLAYER.ultimate_cd = 10
PLAYER.ultimate_cd_time = 10

PLAYER.skills[1] = {}
PLAYER.skills[2] = {}
PLAYER.skills[3] = {}
PLAYER.skills[ultimate] = {}

PLAYER.skills[1].Name = "Speed"
PLAYER.skills[1].Desc = "Gives you bonus speed"
PLAYER.skills[1].MaxLevel = 4
PLAYER.skills[1].Values = {2, 1.4, 1.6, 1.8}

PLAYER.skills[2].Name = "Health"
PLAYER.skills[2].Desc = "Gives you bonus health"
PLAYER.skills[2].MaxLevel = 4
PLAYER.skills[2].Values = {20, 40, 60, 100}

PLAYER.skills[3].Name = "Jump"
PLAYER.skills[3].Desc = "Gives you bonus jump height"
PLAYER.skills[3].MaxLevel = 4
PLAYER.skills[3].Values = {2, 1.4, 1.6, 1.8}

PLAYER.skills[ultimate].Name = "Thunder Shock"
PLAYER.skills[ultimate].Desc = "Shocks an enemy for damage"
PLAYER.skills[ultimate].MaxLevel = 4
PLAYER.skills[ultimate].Values = {200, 30, 40, 50}

function PLAYER:SetPassives(level)
	-- Skill0
	self.Player:SetWalkSpeed(400*self.skills[1].Values[level])
	
	-- Skill1
	self.Player:SetHealth(100+self.skills[2].Values[level])
	
	-- Skill2
	self.Player:SetJumpPower(200*self.skills[3].Values[level])
end

function PLAYER:Ultimate(level)
	
	local ultimate_used = false
	
	if(self.ultimate_cd <= 0) then
	
		local target = self.Player:GetEyeTrace()
		
		if(target.HitWorld == false) then
			
			local victim = target.Entity
			
			-- Send deal damage to server
			net.Start("WCG_DamageEntity")
			net.WriteInt(victim:EntIndex(), 8)
			net.WriteInt(self.skills[self.ultimate].Values[level], 16)
			net.SendToServer()
			
			ultimate_used = true
			self.ultimate_cd = self.ultimate_cd_time
		end
	else
		player:ChatPrint("Ultimate CD: "..tostring(player.ultimate_cd))
	end
	
	return ultimate_used
end

CreateRace( "test_class", PLAYER, "base" )
