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
	
	-- X Loop
	local x = 25
	local y = 25
	for i, race in pairs(AllRaces) do
	
		-- Make sure it is a playing player && removes class "base" from the list
		if ( ID != TEAM_CONNECTING && ID != TEAM_UNASSIGNED && race.name != "base") then
			
			-- No space down
			if (x > 600) then
				x = x + 70
				y = 25
			end
			
			--Create Icon
			local RaceIcon = vgui.Create( "DImageButton", self.RaceSelectFrame )
			RaceIcon:SetPos( 10, y )
			RaceIcon:SetSize( 50, 50 )
			RaceIcon:SetImage( race["icon"] )
			function RaceIcon.DoClick() RacePicker.ChangeRaceTo(race) self.HideRace(self) end
			
			--if ( IsValid( LocalPlayer() ) && LocalPlayer():Race() == ID ) then
			--	Race:SetDisabled( true )
			--end
		
			--Create name text
			local RaceName = vgui.Create( "DLabel", self.RaceSelectFrame )
			RaceName:SetText( race.name )
			RaceName:SetPos( 50, y )
			--RaceName:SetSize( 330, 50 )
			
			--if ( IsValid( LocalPlayer() ) && LocalPlayer():Race() == ID ) then
			--	Race:SetDisabled( true )
			--end
			
			-- Move down
			y = y + 65		
		
		end
	end

	self.RaceSelectFrame:SetSize( 625, 625 )
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

function RacePicker.ChangeRaceTo(race)

	RunConsoleCommand("wcg_changerace", race.name)

end
