print("exec cl_xpbar.lua")

XPBar = { }

--[[---------------------------------------------------------
   Name: gamemode:ShowTeam()
   Desc:
-----------------------------------------------------------]]
function XPBar:Show(xp, xp_max)

	print("show xp bar")
	if ( IsValid( self.XPBarPanel ) ) then return end
	
	--ProgressBar
	local XPprog = vgui.Create( "WCGProgressBar", self.XPBarPanel )
	self.XPprog = XPprog
	XPprog:SetSize( 200, 30 )
	XPprog:SetPos(20, 10)
	XPprog:SetFGColor(Color(200, 0, 200))
	XPprog:SetBGColor(Color(255, 230, 230))
	
	--Show panel
	XPBar:SetXP(xp, xp_max)
end

function XPBar:SetXP(xp, xp_max)
	
	self.XPprog:SetMax(xp_max)
	self.XPprog:SetValue(xp)
	
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
