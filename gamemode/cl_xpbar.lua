print("exec cl_xpbar.lua")

XPBar = { }

--[[---------------------------------------------------------
   Name: gamemode:ShowTeam()
   Desc:
-----------------------------------------------------------]]
function XPBar:Show(xp, xp_max)

	print("show xp bar")
	if ( IsValid( self.XPBarPanel ) ) then return end
	
	-- Create XPBar
	self.XPBarPanel = vgui.Create( "DPanel" )
	self.XPBarPanel:SetSize( 200, 30 )
	self.XPBarPanel:SetPos(20, 10)
	
	--ProgressBar
	local XPprog = vgui.Create( "DProgress", self.XPBarPanel )
	self.XPprog = XPprog
	XPprog:Dock(FILL)
	
	--XP Text
	local XPlbl = vgui.Create( "DLabel", self.XPBarPanel )
	self.XPlbl = XPlbl
	XPlbl:SetColor(Color(0, 0, 0))
	
	--Show panel
	XPBar:SetXP(xp, xp_max)
end

function XPBar:SetXP(xp, xp_max)
	local text = xp .. "/" .. xp_max
	local w = surface.GetTextSize(text)
	self.XPlbl:SetText(text)
	self.XPprog:SetFraction(xp / xp_max)
	self.XPlbl:SetSize(w, 30)
	self.XPlbl:Center()
end

--[[---------------------------------------------------------
   Name: gamemode:HideTeam()
   Desc:
-----------------------------------------------------------]]
function XPBar:Hide()

	if ( IsValid(self.XPBarPanel) ) then
		self.XPBarPanel:Remove()
		self.XPBarPanel = nil
	end

end

XPBar.Show(XPBar, 50, 100)
