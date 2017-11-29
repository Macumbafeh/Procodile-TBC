local Procodile = LibStub("AceAddon-3.0"):GetAddon("Procodile")
local L = LibStub("AceLocale-3.0"):GetLocale("Procodile", false)
--ProcodileFu = Procodile:NewModule("FuBar", "LibFuBarPlugin-Mod-3.0")

local MinimapPosition = 225

Procodile.Minimap = CreateFrame('Button', 'ProcodileMinimapButton', Minimap)
local MinimapButton = Procodile.Minimap

function MinimapButton:Load()
	self:SetFrameStrata('MEDIUM')
	self:SetWidth(31); self:SetHeight(31)
	self:SetFrameLevel(8)
	self:RegisterForClicks('anyUp')
	self:RegisterForDrag('LeftButton')
	self:SetHighlightTexture('Interface\\Minimap\\UI-Minimap-ZoomButton-Highlight')

	local overlay = self:CreateTexture(nil, 'OVERLAY')
	overlay:SetWidth(53); overlay:SetHeight(53)
	overlay:SetTexture('Interface\\Minimap\\MiniMap-TrackingBorder')
	overlay:SetPoint('TOPLEFT')

	local icon = self:CreateTexture(nil, 'BACKGROUND')
	local iconTexture = self:GetProcIcon()
	icon:SetWidth(20); icon:SetHeight(20)
	icon:SetTexture(iconTexture)
	icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	icon:SetPoint('TOPLEFT', 7, -5)
	self.icon = icon

	self:SetScript('OnEnter', self.OnEnter)
	self:SetScript('OnLeave', self.OnLeave)
	self:SetScript('OnClick', self.OnClick)
	self:SetScript('OnDragStart', self.OnDragStart)
	self:SetScript('OnDragStop', self.OnDragStop)
	self:SetScript('OnMouseDown', self.OnMouseDown)
	self:SetScript('OnMouseUp', self.OnMouseUp)
	
end

function MinimapButton:GetProcIcon()
	local tracked = Procodile:GetTrackedSpells()
	for internalname,proc in pairs(tracked) do
		return proc.icon
	end
	return "Interface\\Icons\\INV_Misc_QuestionMark"
end

function MinimapButton:UpdateIcon()
	local iconTexture = self:GetProcIcon()
	self.icon:SetTexture(iconTexture)
end

function MinimapButton:OnClick(button)
	if button == "LeftButton" and IsShiftKeyDown() then
		Procodile:Toggle()
	elseif button == "LeftButton" and IsControlKeyDown() then
		Procodile:Reset()
	elseif button == "RightButton" then
		Procodile:OpenOptions()
	end
end

function MinimapButton:OnMouseDown()
	self.icon:SetTexCoord(0, 1, 0, 1)
end

function MinimapButton:OnMouseUp()
	self.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
end

function MinimapButton:OnEnter()
	if not self.dragging then
		GameTooltip:SetOwner(self, 'ANCHOR_BOTTOMLEFT')
		
		if Procodile:IsEnabled() then
			self:SetText("|cff22ff22"..L["Procodile"])
		else
			self:SetText("|cffff2222"..L["Procodile"])
		end
		
		GameTooltip:AddLine(L["Procodile"])
		GameTooltip:AddLine(" ")
    
		local tracked = Procodile:GetTrackedSpells()
    
		for internalname,proc in pairs(tracked) do
			-- PPM
			local ppm = 0
			if proc.count > 0 then
				ppm = proc.count / (proc.totaltime / 60)
			end
			
			-- Uptime
			local uptime = 0
			if proc.seconds > 0 and proc.totaltime > 0 then
				uptime = proc.seconds / proc.totaltime * 100
			end
					
			GameTooltip:AddLine(proc.name, 0.3, 0.3, 0.8)
			GameTooltip:AddTexture(proc.icon)
			if proc.count > 0 then
				GameTooltip:AddDoubleLine(L["Procs"], proc.count, nil, nil, nil, 1,1,1)
			else
				GameTooltip:AddDoubleLine(L["Procs"], "none", nil, nil, nil, 1,1,1)
			end
				
			if ppm > 0 then
				GameTooltip:AddDoubleLine(L["PPM"], string.format("%.2f", ppm), nil, nil, nil, 1,1,1)
			else
				GameTooltip:AddDoubleLine(L["PPM"],"unknown", nil, nil, nil, 1,1,1)
			end
			
			if uptime > 0 then
				GameTooltip:AddDoubleLine(L["Uptime"], string.format("%.2f", uptime).."%", nil, nil, nil, 1,1,1)
			else
				GameTooltip:AddDoubleLine(L["Uptime"], "unknown", nil, nil, nil, 1,1,1)
			end
			
			if proc.cooldown > 0 then
				GameTooltip:AddDoubleLine(L["Cooldown"], proc.cooldown.."s", nil, nil, nil, 1,1,1)
			else
				GameTooltip:AddDoubleLine(L["Cooldown"], "unknown", nil, nil, nil, 1,1,1)
			end
			GameTooltip:AddLine(" ")
		end

		GameTooltip:AddLine(L["Hint: Ctrl-Click to reset."], 0, 1, 0)
		GameTooltip:AddLine(L["Shift-click to toggle tracking."], 0, 1, 0)
		GameTooltip:AddLine(L["Right-click to configure"], 0, 1, 0)
		
		GameTooltip:Show()
	end
end

function MinimapButton:OnLeave()
	GameTooltip:Hide()
end

function MinimapButton:OnDragStart()
	self.dragging = true
	self:LockHighlight()
	self.icon:SetTexCoord(0, 1, 0, 1)
	self:SetScript('OnUpdate', self.OnUpdate)
	GameTooltip:Hide()
end

function MinimapButton:OnDragStop()
	self.dragging = nil
	self:SetScript('OnUpdate', nil)
	self.icon:SetTexCoord(0.05, 0.95, 0.05, 0.95)
	self:UnlockHighlight()
end

function MinimapButton:OnUpdate()
	local mx, my = Minimap:GetCenter()
	local px, py = GetCursorPosition()
	local scale = Minimap:GetEffectiveScale()

	px, py = px / scale, py / scale

	local angle = math.deg(math.atan2(py - my, px - mx)) % 360
	
	Procodile:SetMinimapButtonPosition(angle)
	self:UpdatePosition()
end

--magic fubar code for updating the minimap button's position
--I suck at trig, so I'm not going to bother figuring it out
function MinimapButton:UpdatePosition()
	local angle = math.rad(Procodile:GetMinimapButtonPosition() or random(0, 360))
	local cos = math.cos(angle)
	local sin = math.sin(angle)
	local minimapShape = GetMinimapShape and GetMinimapShape() or 'ROUND'

	local round = false
	if minimapShape == 'ROUND' then
		round = true
	elseif minimapShape == 'SQUARE' then
		round = false
	elseif minimapShape == 'CORNER-TOPRIGHT' then
		round = not(cos < 0 or sin < 0)
	elseif minimapShape == 'CORNER-TOPLEFT' then
		round = not(cos > 0 or sin < 0)
	elseif minimapShape == 'CORNER-BOTTOMRIGHT' then
		round = not(cos < 0 or sin > 0)
	elseif minimapShape == 'CORNER-BOTTOMLEFT' then
		round = not(cos > 0 or sin > 0)
	elseif minimapShape == 'SIDE-LEFT' then
		round = cos <= 0
	elseif minimapShape == 'SIDE-RIGHT' then
		round = cos >= 0
	elseif minimapShape == 'SIDE-TOP' then
		round = sin <= 0
	elseif minimapShape == 'SIDE-BOTTOM' then
		round = sin >= 0
	elseif minimapShape == 'TRICORNER-TOPRIGHT' then
		round = not(cos < 0 and sin > 0)
	elseif minimapShape == 'TRICORNER-TOPLEFT' then
		round = not(cos > 0 and sin > 0)
	elseif minimapShape == 'TRICORNER-BOTTOMRIGHT' then
		round = not(cos < 0 and sin < 0)
	elseif minimapShape == 'TRICORNER-BOTTOMLEFT' then
		round = not(cos > 0 and sin < 0)
	end

	local x, y
	if round then
		x = cos*80
		y = sin*80
	else
		x = math.max(-82, math.min(110*cos, 84))
		y = math.max(-86, math.min(110*sin, 82))
	end

	self:SetPoint('CENTER', x, y)
end