print("exec cl_pickteam.lua")

RacePicker = {}

--[[---------------------------------------------------------
   Name: gamemode:ShowTeam()
   Desc:
-----------------------------------------------------------]]
function RacePicker:ShowRace()

	print("pick race")
	if ( IsValid( self.RaceSelectFrame ) ) then return end
	
	-- Simple team selection box
	self.RaceSelectFrame = vgui.Create( "DFrame" )
	self.RaceSelectFrame:SetTitle( "Pick Race" )
	
	local AllRaces = { "Undead", "Human", "Orc"}
	
	local AllTeams = team.GetAllTeams()
	local y = 30
	for raceName in pairs ( AllRaces ) do
	
		if ( ID != TEAM_CONNECTING && ID != TEAM_UNASSIGNED ) then
		
			--Creat Icon
			local RaceIcon = vgui.Create( "DPanel", self.RaceSelectFrame )
			RaceIcon:SetPos( 10, y )
			RaceIcon:SetSize( 50, 50 )
			RaceIcon:SetText( "Race: " .. raceName )
			
			--if ( IsValid( LocalPlayer() ) && LocalPlayer():Race() == ID ) then
			--	Race:SetDisabled( true )
			--end
		
			--Create Button
			local Race = vgui.Create( "DButton", self.RaceSelectFrame )
			function Race.DoClick() self.HideRace(self) RunConsoleCommand( "say", "You are now: " .. raceName ) end
			Race:SetPos( 60, y )
			Race:SetSize( 330, 50 )
			Race:SetText( "Race: " .. raceName )
			
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
