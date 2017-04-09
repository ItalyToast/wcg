-- Version of DProgressBar I can mess around with

local PANEL = {}

AccessorFunc( PANEL, "m_iMin",  "Min" )
AccessorFunc( PANEL, "m_iMax",  "Max" )
AccessorFunc( PANEL, "m_iValue",    "Value" )
AccessorFunc( PANEL, "m_BGColor",     "BGColor" )
AccessorFunc( PANEL, "m_FGColor",     "FGColor" )
AccessorFunc( PANEL, "m_textFormat",     "TextFormat" )

function PANEL:Init()
   self.Label = vgui.Create( "DLabel", self )
   self.Label:SetFont( "DefaultSmall" )
   self.Label:SetColor( Color( 0, 0, 0 ) )
   self.Label:SetZPos(self:GetZPos() + 1)
   self:SetPaintBackground(true)
   
   --SetFormat must be set first otherwise we get a nil-ref error
   self.m_textFormat = function(min, max, val) return Format( "%i / %i", val, max ) end 
   self:SetMin( 0 )
   self:SetMax( 1000 )
   self:SetValue( 253 )
   self:SetFGColor( Color( 255, 255, 0, 255 ) )
   self:SetBGColor( Color( 128, 255, 128, 255 ) )
end

function PANEL:SetMin( i )
   self.m_iMin = i
   self:UpdateText()
end

function PANEL:SetMax( i )
   self.m_iMax = i
   self:UpdateText()
end

function PANEL:SetValue( i )
   self.m_iValue = i
   self:UpdateText()
end

function PANEL:SetTextFormat( format)
   self.m_textFormat = format
   self:UpdateText()
end

function PANEL:UpdateText()
   if ( !self.m_iMax ) then return end
   if ( !self.m_iMin ) then return end
   if ( !self.m_iValue ) then return end

    -- Center Text
    local text = self.m_textFormat(self.m_iMin, self.m_iMax, self.m_iValue) or ""
	surface.SetFont("DefaultSmall")
	local w = surface.GetTextSize(text)
	self.Label:SetText(text)
	self.Label:SetWidth(w)
	self.Label:Center()
end

function PANEL:PerformLayout()
	print("layout")
   self.Label:Center()
end

function PANEL:Paint()

   local fraction = 0;
   
   if ( self.m_iMax-self.m_iMin != 0 ) then
      fraction = ( self.m_iValue - self.m_iMin ) / (self.m_iMax-self.m_iMin)
   end
   
   local w = self:GetWide()
   local h = self:GetTall()

   draw.RoundedBox(4, 0, 0, w, h, Color(0, 0, 0, 255))
   
   surface.SetDrawColor( self:GetBGColor() )
   surface.DrawRect( 2, 2, w - 4, h - 4 )
   surface.SetDrawColor( self:GetFGColor() )
   surface.DrawRect( 2, 2, w * fraction - 4, h - 4 )

end

vgui.Register( "WCGProgressBar", PANEL, "DPanel" )
