

local NPC = {
Name = "杨永信 市民", 
Class = "npc_citizen",
Weapons = { "weapon_smg1", "weapon_ar2" },
Model = "models/yyx2fdsa.mdl",
Category =  "临沂市网戒中心" ,
KeyValues = { citizentype = 4 },
}

list.Set( "NPC", "npc_yyx1", NPC )
--市民NPC

list.Set( "PlayerOptionsModel", "杨永信", "models/pmyyx2fdsa.mdl" )
player_manager.AddValidModel( "杨永信", "models/pmyyx2fdsa.mdl" )
--玩家模型

local NPC = {
Name = "杨永信 联合军", 
Class = "npc_combine_s",
Weapons = { "weapon_smg1", "weapon_ar2" },
Model = "models/yyx2fdsa2.mdl",
Category =  "临沂市网戒中心" ,
KeyValues = { SquadName = "overwatch", Numgrenades = 5 }
}

list.Set( "NPC", "npc_yyx2", NPC )
--联合军NPC

local NPC = {
Name = "杨永信 弗地冈",
Class = "npc_vortigaunt",
	Category = "临沂市网戒中心" ,
	Model = "models/yyx52.mdl"
}

list.Set( "NPC", "npc_yyx3", NPC )
--弗地冈NPC