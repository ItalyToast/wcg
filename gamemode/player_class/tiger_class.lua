AddCSLuaFile()

local PLAYER = {}

PLAYER.DisplayName 			= "Tiger"
PLAYER.WalkSpeed 			= 100
PLAYER.icon 				= "materials/icon16/anchor.png"

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

PLAYER.ability1 = Ability.create("Claws", "Gives you bonus ranged and melee(2xBonus) attack damage")
PLAYER.ability1.values = {1.2, 1.4, 1.6, 1.8}
PLAYER.ability1.Level = 2
PLAYER.ability1.MaxLevel = 4
PLAYER.ability1.OnDealDamage = function(self, target, hitgroup, dmginfo)

	local buff = self.values[self.Level]
	dmginfo:ScaleDamage( buff )
	if(dmginfo:GetDamageType() == DMG_CLUB) then
		dmginfo:ScaleDamage( buff )
	end
	
end

PLAYER.ability2 = Ability.create("Jump", "Gives you bonus jump height")
PLAYER.ability2.values = {1.2, 1.4, 1.6, 1.8}
PLAYER.ability2.Level = 1
PLAYER.ability2.MaxLevel = 4
PLAYER.ability2.OnSpawn = function(self, player)

	player.Player:SetJumpPower(200*self.values[self.Level])
	
end

PLAYER.ability3 = Ability.create("Evasion", "Gives you a chance to dodge bullets")
PLAYER.ability3.values = {20, 40, 60, 80}
PLAYER.ability3.Level = 1
PLAYER.ability3.MaxLevel = 4
PLAYER.ability3.OnReciveDamage = function(self, target, hitgroup, dmginfo)
	local dodge = self.values[self.Level]
	if(dodge >= math.random( 100 )) then
		dmginfo:ScaleDamage( 0 )
	end
end

PLAYER.ability4 = Ability.create("Dash", "Dash towards target")
PLAYER.ability4.values = { 300, 400, 500 }
PLAYER.ability4.Level = 1
PLAYER.ability4.MaxLevel = 4
PLAYER.ability4.Sound = "player/jumplanding4.wav"
PLAYER.ability4.OnActivate = function(self, player)

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

PLAYER.abilities = { PLAYER.ability1, PLAYER.ability2, PLAYER.ability3, PLAYER.ability4 }

function PLAYER:SetPassives(level)

	for key,value in pairs(self.abilities) do
		if(value.OnSpawn != nil) then
			value:OnSpawn(self)
		end
	end
	
end

function PLAYER:PlayerTraceAttack( dmginfo, dir, trace )
	PrintTable(dmginfo)
end

function PLAYER:ScaleDamage( target, hitgroup, dmginfo )

	for key,value in pairs(self.abilities) do
		print(value.name)
		if(value.OnDealDamage != nil) then
			print(value.name .. 2)
			value:OnDealDamage(target, hitgroup, dmginfo)
		end
	end

end

function PLAYER:Ultimate(level)
	
	PLAYER.ability4:Activate(self.Player)

end

CreateRace( "tiger_class", PLAYER, "base" )
