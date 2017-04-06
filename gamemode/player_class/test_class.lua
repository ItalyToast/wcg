include("player_default.lua")

PLAYER.skills = {}
PLAYER.ultimate = 3

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
	PLAYER.Speed = 400*PLAYER.skills[0].Values[level]
	
	-- Skill1
	PLAYER.MaxHealth = 100+PLAYER.skills[1].Values[level]
	PLAYER.StartHealth = 100+PLAYER.skills[1].Values[level]
	
	-- Skill2
	PLAYER.MaxHealth = 200*PLAYER.skills[2].Values[level]
	PLAYER.StartHealth = 200*PLAYER.skills[2].Values[level]
end

function PLAYER:Ultimate(client, victim)
	victim.TakeDamage(PLAYER.skills[ultimate].Values[level], client, client)
end