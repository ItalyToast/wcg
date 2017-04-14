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

PLAYER.ability1 = Ability.create("Dash", "Dash towards target")
PLAYER.ability1.values = { 300, 400, 500 }
PLAYER.ability1.Level = 1
PLAYER.ability1.MaxLevel = 4
PLAYER.ability1.Sound = "player/jumplanding4.wav"
PLAYER.ability1.OnActivate = function(self, player)

	if(!player:IsOnGround())then
		return true
	end

	local ent = player:GetViewEntity()
	local dir = player:GetAimVector()
	--PrintTable(dir)
	
	local pos = ent:GetPos()
	pos.z = pos.z + 1
	ent:SetPos(pos)
	
	dir:Mul(self.values[self.Level])
	if(dir.z < 0) then dir.z = 0 end
	dir.z = dir.z + 200
	ent:SetVelocity( dir )
	
end

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
	
	PLAYER.ability1:Activate(self.Player)

end

CreateRace( "tiger_class", PLAYER, "base" )
