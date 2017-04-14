
Ability = {}
Ability.__index = Ability

Ability.name				= ""
Ability.desc				= ""
Ability.cooldown 			= 10
Ability.last_used			= 0
Ability.ActivateOnSpawn 	= false
Ability.Level				= 0
Ability.MaxLevel			= 0
Ability.Sound				= "buttons/button5.wav"
Ability.FailSound			= "buttons/button11.wav"

--Eventhandlers
Ability.OnActivate 			= function(self, player) print("using ability " .. self.name) end
Ability.OnDealDamage		= nil
Ability.OnReciveDamage		= nil
Ability.OnSpawn				= nil

function Ability.create(name, desc)
   local skill = {}
   setmetatable(skill,Ability)
   
   skill.name = name
   skill.desc = desc
   
   return skill
end

function Ability:OnActivate(player)
	print("using ability " .. self.name) 
end

function Ability:Activate(player)
    print("tiger2")
	
	local ent = player:GetViewEntity()
	if(self.Level < 1) then
		print("Ability: " .. self.name .. " not leveled up yet")
		sound.Play( self.FailSound, ent:GetPos(), 75, 100, 1 )
		return true
	end
	
	local ultimate_used = false
	local curTime = CurTime()
	
	if(curTime - self.last_used >= self.cooldown) then
		local cancelled = self:OnActivate(player)
		if(cancelled) then
			sound.Play( self.FailSound, ent:GetPos(), 75, 100, 1 )
		else
			sound.Play( self.Sound, ent:GetPos(), 75, 100, 1 )
			self.last_used = curTime
			ultimate_used = true
		end
	else
		player:ChatPrint("Cooldown: "..math.floor(curTime - self.last_used).."s/"..self.cooldown..'s')
		sound.Play( self.FailSound, ent:GetPos(), 75, 100, 1 )
	end
	
	return ultimate_used
end
