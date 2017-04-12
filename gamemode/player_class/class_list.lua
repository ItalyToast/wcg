AllRaces = {}

function CreateRace(name, table, base)
	player_manager.RegisterClass(name, table, base)
	
	local race = { name = name, icon = table.icon or "materials/icon16/arrow_in.png" }
	
	AllRaces[name] = race
end