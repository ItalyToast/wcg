print("exec cl_pickrace.lua")

RacePicker = {}

--[[---------------------------------------------------------
   Name: gamemode:ShowTeam()
   Desc:
-----------------------------------------------------------]]
function RacePicker:ShowRace(player)

	print("pick race")
	if ( IsValid( self.RaceSelectFrame ) ) then return end
	
	-- Simple team selection box
	self.RaceSelectFrame = vgui.Create( "DFrame" )
	self.RaceSelectFrame:SetTitle( "Pick Race" )
	
	local Undead = { name = "Undead", icon = "materials/icon16/arrow_in.png" }
	local Human = { name = "Human", icon = "materials/icon16/basket.png" }
	local Orc = { name = "Human", icon = "materials/icon16/bell.png" }
	
	local AllRaces = { Undead, Human, Orc}
	
	local y = 30
	for i, race in pairs(AllRaces) do
	
		if ( ID != TEAM_CONNECTING && ID != TEAM_UNASSIGNED ) then
		
			--Creat Icon
			local RaceIcon = vgui.Create( "DImage", self.RaceSelectFrame )
			RaceIcon:SetPos( 10, y )
			RaceIcon:SetSize( 50, 50 )
			RaceIcon:SetImage( race["icon"] )
			
			--if ( IsValid( LocalPlayer() ) && LocalPlayer():Race() == ID ) then
			--	Race:SetDisabled( true )
			--end
		
			--Create Button
			local Race = vgui.Create( "DButton", self.RaceSelectFrame )
            function Race.DoClick()
				self.HideRace(self)
				RunConsoleCommand( "say", "You are now: " .. race["name"] )
				-- Change race
				net.Start( "WCG_ChangeRace" )
				net.WriteString( "player_default" )
				net.SendToServer()
			end
			Race:SetPos( 60, y )
			Race:SetSize( 330, 50 )
			Race:SetText( "Race: " .. race["name"] )
			
			--if ( IsValid( LocalPlayer() ) && LocalPlayer():Race() == ID ) then
			--	Race:SetDisabled( true )
			--end
			
			y = y + 70
		
		end
	end

	self.RaceSelectFrame:SetSize( 400, y )
	self.RaceSelectFrame:Center()
	self.RaceSelectFrame:MakePopup()
	self.RaceSelectFrame:SetKeyboardInputEnabled( false )

end

--[[---------------------------------------------------------
   Name: gamemode:HideTeam()
   Desc:
-----------------------------------------------------------]]
function RacePicker.HideRace(self)

	if ( IsValid(self.RaceSelectFrame) ) then
		self.RaceSelectFrame:Remove()
		self.RaceSelectFrame = nil
	end

end
