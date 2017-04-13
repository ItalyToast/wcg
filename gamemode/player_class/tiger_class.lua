AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName 			= "Tiger"
PLAYER.WalkSpeed 			= 100
PLAYER.icon 				= "materials/icon16/basket.png"

PLAYER.skills = {}

PLAYER.ultimate = 4
local ultimate = PLAYER.ultimate
PLAYER.ultimate_last_used = 0
PLAYER.ultimate_cd = 10

PLAYER.skills[1] = {}
PLAYER.skills[2] = {}
PLAYER.skills[3] = {}
PLAYER.skills[ultimate] = {}

PLAYER.skills[1].Name = "Claws"
PLAYER.skills[1].Desc = "Gives you bonus ranged and melee(2xBonus) attack damage"
PLAYER.skills[1].MaxLevel = 4
PLAYER.skills[1].Values = {1.2, 1.4, 1.6, 1.8}

PLAYER.skills[2].Name = "Evasion"
PLAYER.skills[2].Desc = "Gives you a chance to dodge bullets"
PLAYER.skills[2].MaxLevel = 4
PLAYER.skills[2].Values = {20, 40, 60, 80}

PLAYER.skills[3].Name = "Jump"
PLAYER.skills[3].Desc = "Gives you bonus jump height"
PLAYER.skills[3].MaxLevel = 4
PLAYER.skills[3].Values = {2, 1.4, 1.6, 1.8}

PLAYER.skills[ultimate].Name = "Dash"
PLAYER.skills[ultimate].Desc = "Dash towards target"
PLAYER.skills[ultimate].MaxLevel = 4
PLAYER.skills[ultimate].Values = {20, 30, 40, 50}

function PLAYER:SetPassives(level)

	-- Skill2
	self.Player:SetJumpPower(200*self.skills[3].Values[level])
end

function PLAYER:PlayerTraceAttack( dmginfo, dir, trace )
	PrintTable(dmginfo)
end

function PLAYER:ScaleDamage( target, hitgroup, dmginfo )

	local buff = self.skills[1].Values[1]
	dmginfo:ScaleDamage( buff )
	if(dmginfo:GetDamageType() == DMG_CLUB) then
		dmginfo:ScaleDamage( buff )
	end
	
end

function PLAYER:Ultimate(level)
	
	print("tiger")
	
	local ultimate_used = false
	local curTime = CurTime()
	
	if(curTime - self.ultimate_last_used >= self.ultimate_cd) then
	
		local ent = self.Player:GetViewEntity()
		local dir = self.Player:GetAimVector()
		--PrintTable(dir)
		
		dir:Mul(2000)
		if(dir.z < 0) then dir.z = 0 end
		dir.z = dir.z + 300
		ent:SetVelocity( dir )
		
	else
		self.Player:ChatPrint("Cooldown: "..math.floor(curTime - self.ultimate_last_used).."s/"..self.ultimate_cd..'s')
	end
	
	return ultimate_used
end

CreateRace( "tiger_class", PLAYER, "base" )
