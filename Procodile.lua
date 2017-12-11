Procodile = LibStub("AceAddon-3.0"):NewAddon("Procodile", "AceConsole-3.0", "AceEvent-3.0", "AceTimer-3.0", "LibBars-1.0", "LibSink-2.0")
local L = LibStub("AceLocale-3.0"):GetLocale("Procodile", false)
local bars = LibStub("LibBars-1.0")
local media = LibStub("LibSharedMedia-3.0")

BINDING_HEADER_Procodile = "Procodile"
BINDING_NAME_TOGGLE_PROCODILE = "Toggle" --L["TOGGLE_PROCODILE"]


local items = {
-- [spellid]  	= itemid,			-- Item name

-- WEAPONS AND OFFHANDS
	[40408]		= 32375,			-- Bulwark of Azzinoth
	[21165]		= {['type'] = 'sharedproc', 28439,28438,28437},	-- Dragonstrike, Dragonmaw, Drakefist Hammer
	[34513]		= {['type'] = 'sharedproc', 28430,28429,28428},	-- Lionheart Executioner, Lionheart Champion, Lionheart Blade
	[36041]		= 29962,			-- Heartrazor
	--[unkno]		= 29348,            -- Bladefist
	[16916]		= 23541,			-- Khorium Champion
	[38282]		= 31318,			-- Singing Crystal Axe
	[38307]		= 31331,			-- The Night Blade
	[38293]		= 31323,			-- Don Santos' Famous Hunting Rifle
	[38317]		= 31336,			-- Blade of Wizardry
	
-- RELICS
	[43747]		= 33503,			-- Libram of Divine Judgement
	[43749]		= 33507,			-- Stonebreaker's Tote
	[43738]		= 33509,			-- Idol of Terror
	[43740]		= 33510,			-- Idol of the Unseen Moon

-- ARMOR PIECES
	[34585]		= 28578,			-- Masquerade Gown
	[34597]		= 28602,			-- Robe of the Elder Scribes
		
-- RINGS
	[35081]		= 29301, 			-- Band of the Eternal Champion
	[35087]		= 29307,			-- Band of the Eternal Restorer
	[35078]		= 29297,			-- Band of the Eternal Defender
	[35084]		= 29305, 			-- Band of the Eternal Sage
	
-- NECKLACES
--	[unkno]		= 34677,			-- Shattered Sun Pendant of Restoration (Scryers - Proc is 'Arcane Surge' healingeffect instead of a buff)	
	[45478]		= {	['type'] = 'conditional', 
					['itemid'] = 34677, 	-- Shattered Sun Pendant of Restoration
					['info'] = 'Aldor', 	-- Aldor exalted
					['condition'] = function() return Procodile:IsAldorExalted() end, },
--	[unkno]		= 34678,			-- Shattered Sun Pendant of Acumen (Scryers - Proc is 'Arcane Bolt' damageffect instead of a buff)
	[45479]		= {	['type'] = 'conditional', 
					['itemid'] = 34678, 	-- Shattered Sun Pendant of Acumen
					['info'] = 'Aldor', 	-- Aldor exalted
					['condition'] = function() return Procodile:IsAldorExalted() end, },
--	[unkno]		= 34679,			-- Shattered Sun Pendant of Might  (Scryers - Proc is 'Arcane Strike' damageffect instead of a buff)
	[45480]		= {	['type'] = 'conditional', 
					['itemid'] = 34679, 	-- Shattered Sun Pendant of Might
					['info'] = 'Aldor', 	-- Aldor exalted
					['condition'] = function() return Procodile:IsAldorExalted() end, },
	[45432]		= {	['type'] = 'conditional', 
					['itemid'] = 34680, 	-- Shattered Sun Pendant of Reslove
					['info'] = 'Aldor', 	-- Aldor exalted
					['condition'] = function() return Procodile:IsAldorExalted() end, },
	[45431]		= {	['type'] = 'conditional', 
					['itemid'] = 34680, 	-- Shattered Sun Pendant of Reslove
					['info'] = 'Scryers', 	-- Scryers exalted
					['condition'] = function() return Procodile:IsScryersExalted() end, },
	
-- TRINKETS	
	-- Itemlevel 160 - 130
	[45040]		= 34427,			-- Blackened Naaru Sliver
	[37656]		= 32496,			-- Memento of Tyrande
	[40477]		= 32505,			-- Madness of the Betrayer
	[40487]		= 32487,			-- Ashtongue Talisman of Swiftness
	[40483]		= 32488,			-- Ashtongue Talisman of Insight
	[40480]		= 32493,			-- Ashtongue Talisman of Shadows

	-- Itemlevel 130 - 100
	[37340]		= {	['type'] = 'conditional', 
					['itemid'] = 30664, 	-- Living Root of the Wildheart
					['info'] = 'Bear form', -- Ursine Blessing (+4k armor))
					['condition'] = function() return Procodile:IsDruidInBearForm() end, },
	[37341]		= {	['type'] = 'conditional', 
					['itemid'] = 30664, 	-- Living Root of the Wildheart
					['info'] = 'Cat form', 	-- Feline Blessing (+64 str))
					['condition'] = function() return Procodile:IsDruidInCatForm() end, },
	[37342]		= {	['type'] = 'conditional', 
					['itemid'] = 30664, 	-- Living Root of the Wildheart
					['info'] = 'Tree form', -- Sylvan Blessing (+324 healing)
					['condition'] = function() return Procodile:IsDruidInTreeForm() end, },
	[37343]		= {	['type'] = 'conditional', 
					['itemid'] = 30664, 	-- Living Root of the Wildheart
					['info'] = 'Moonkin form', 	-- Lunar Blessing  (+140 sp))
					['condition'] = function() return Procodile:IsDruidInMoonkinForm() end, },  			
	[37344]		= {	['type'] = 'conditional', 
					['itemid'] = 30664, 	-- Living Root of the Wildheart
					['info'] = "No form", 	-- Cenarion Blessing (+175 sp)
					['condition'] = function() return Procodile:IsDruidOutOfForm() end, },  
	[38348]		= 30626,			-- Sextant of Unstable Currents
	[37198]		= 30447,			-- Tome of Fiery Redemption
	[42084]		= 30627,			-- Tsunami Talisman
	[37174]		= 30450,			-- Warp-Spring Coil
	[34775]		= 28830,			-- Dragonspine Trophy
	[37706]		= 28823,			-- Eye of Gruul
	[34747]		= 28789,			-- Eye of Magtheridon
	
	-- Itemlevel 120 - 100
	[45058]		= 34473,			-- Commendation of Kael'thas
	[45053]		= 34472,			-- Shard of Contempt
	[34321]		= 28418,			-- Shiffar's Nexus-Horn
	[38346]		= 28370,			-- Bangle of Endless Blessings
	[33370] 	= {['type'] = 'sharedproc', 27683, 28190},	-- Quagmirran's Eye, Scarab of the Infinite Cycle
	[33649]		= 28034,			-- Hourglass of the Unraveller
	[23684]		= 19288,			-- Darkmoon Card: Blue Dragon
}



local enchants = {
	[28093]		= 2673,				-- Mongoose
	[27996]		= 2674,				-- Spellsurge
	[20007]		= 1900,				-- Crusader
	[42976]		= 3225,				-- Executioner
--	[11111]		= 2667,				-- FOR TESTING ONLY (Savagery)
}


local ApplyPredefinedCooldowns = true
-- For those who are really sure about their cooldowns.
-- Feel free to add your entries like below.
local PredefinedCooldowns = {
-- [spellid]  	= cooldown,
	[37198]		= 45,				-- Tome of Fiery Redemption  (I'm sure its 45 sec)
	[34473]		= 30,				-- Commendation of Kael'thas (Trinket tooltip says its 30 sec)
}

local defaults = {
        char = {
				showMinimap = true,
				minimapPos = 225,
                combat = true,
                showspells = false,
                verbose = false,
				actionbarscds = true,
                cooldowns = true,
                movablecooldowns = true,
                announce = true,
                barfontsize=7,
                barwidth=130,
                barheight=9,
                barfont=nil,
                bartexture="Aluminium",
                sinkOptions = {
                	sink20OutputSink = "Default",
				},
                -- internal
                enabled = false,
				tracked = {},
				dormant = {},
        }
}

local db
local changed = true
local cooldowns

-- options
Procodile.options = {
        type="group",
		name="Procodile",
        childGroups="tab",
        args={
        		d = {
        			type="description",
					name=L["PROCODILE_DESC"],
        		},
        		bars = {
	        			type="group",
                        name=L["BARS_NAME"],
                        args = {
                        	info = {
                        		type="description",
		                        name=L["BARS_DESC"],
		                        order=0,
                        	},
                                cooldowns = {
                                        type="toggle",
                                        name=L["COOLDOWNS_NAME"],
                                        desc=L["COOLDOWNS_DESC"],
                                        order=1,
                                        get=function() return db.cooldowns end,
                                        set=function() 
                                        		db.cooldowns = not db.cooldowns
                                        		if db.cooldowns then
                                        			Procodile:ShowCooldowns(true)
                                        		else
                                        			Procodile:ShowCooldowns(false)
                                        		end
                                        	end,
                                },
                                movablecooldowns = {
                                        type="toggle",
                                        name=L["MOVABLECOOLDOWNS_NAME"],
                                        desc=L["MOVABLECOOLDOWNS_DESC"],
                                        order=2,
                                        get=function() return db.movablecooldowns end,
                                        set=function() 
                                        		db.movablecooldowns = not db.movablecooldowns
                                        		Procodile:SetMovableCooldowns(db.movablecooldowns)
                                        	end,
                                },
                                announce = {
                                        type="toggle",
                                        name=L["ANNOUNCE_NAME"],
                                        desc=L["ANNOUNCE_DESC"],
                                        order=3,
                                        get=function() return db.announce end,
                                        set=function() db.announce = not db.announce end,
                                },
                        		bartexture = {
                        			type="select",
                        			name=L["BARTEXTURE_NAME"],
                        			desc=L["BARTEXTURE_DESC"],
                        			order=4,
                        			values=media:List('statusbar'),
                        			get=function(i)
                       						for k, v in pairs(media:List('statusbar')) do
												if v == db.bartexture then
													return k
												end
											end
                        				end,
                        			set=function(i, v)
                        					db.bartexture = media:List('statusbar')[v]
                        					Procodile:ReconfigureBars()
										end,
                        		}, 
                        		barfont = {
                        			type="select",
                        			name=L["BARFONT_NAME"],
                        			desc=L["BARFONT_DESC"],
                        			order=5,
                        			values=media:List('font'),
                        			get=function()
                       						for k, v in pairs(media:List('font')) do
												if v == db.barfont then
													return k
												end
											end
                        				end,
                        			set=function(k, v)
                        					db.barfont = media:List('font')[v]
                        					Procodile:ReconfigureBars()
										end,
                        		},                        		
                        		fontsize = {
                        			type="range",
                        			name=L["FONTSIZE_NAME"],
                        			desc=L["FONTSIZE_DESC"],
                        			min=6,
                        			max=20,
                        			step=1,
                        			order=5,
                        			get=function() return db.barfontsize end,
                        			set=function(key, size)
                        					db.barfontsize = size
                        					Procodile:ReconfigureBars()
										end,
                        		},
                        		barwidth = {
                        			type="range",
                        			name=L["BARWIDTH_NAME"],
                        			desc=L["BARWIDTH_DESC"],
                        			min=40,
                        			max=300,
                        			step=1,
                        			order=10,
                        			get=function() return db.barwidth end,
                        			set=function(key, size)
                        					db.barwidth = size
                        					Procodile:ReconfigureBars()
										end,
                        		},
                        		barheight = {
                        			type="range",
                        			name=L["BARHEIGHT_NAME"],
                        			desc=L["BARHEIGHT_DESC"],
                        			min=8,
                        			max=60,
                        			step=1,
                        			order=11,
                        			get=function() return db.barheight end,
                        			set=function(key, size)
                        					db.barheight = size
											Procodile:ReconfigureBars()
                        				end,
                        		},
                        		bartest = {
                        			type="execute",
                        			order=-1,
                        			name=L["BARTEST_NAME"],
                        			desc=L["BARTEST_DESC"],
                        			func=function() Procodile:TestBars() end,
                        		}
                        }
        		},
        		custom = {
        			type="group",
        			name=L["CUSTOM_NAME"],
        			args= {
        				info = {
        					type="description",
        					name=L["CUSTOM_DESC"],
        					order=0,
        				},
        				newcustom = {
        					type="input",
        					name=L["NEWCUSTOM_NAME"],
        					desc=L["NEWCUSTOM_DESC"],
        					order=1,
        					set=function(info, val) 
									local name, rank, icon, cost, isFunnel, powerType, castTime, minRange, maxRange = GetSpellInfo(val)
	        						if name then
	        							Procodile:AddSpell(tonumber(val), name, icon, true)
	        						end
        						end,
        				},
        				removecustom = {
        					type="select",
        					name=L["REMOVECUSTOM_NAME"],
        					desc=L["REMOVECUSTOM_DESC"],
        					order=2,
        					values=function()
        								local customs = {}
        								for index,spell in pairs(db.tracked) do
        									if spell.custom ~= nil then
        										customs[spell.id] = spell.name
        									end
        								end
        								return customs
        							end,
        					set=function(i, v)
       								for index,spell in pairs(db.tracked) do
       									if spell.id == v then
       										table.remove(db.tracked, index)
       										break;
       									end
       								end
        						end,
        				}
        			}	
        		},
                options = {
                       type="group",
                       name=L["OPTIONS_NAME"],
                       args = {
	                     	info = {
	                      		type="description",
		                        name=L["OPTIONS_DESC"],
		                        order=0,
	                      	},
							combat = {
							        type="toggle",
							        name=L["COMBATONLY_NAME"],
							        desc=L["COMBATONLY_DESC"],
							        order=1,
							        get=function() return db.combat end,
							        set=function() db.combat = not db.combat end,
							},
							showspells = {
							        type="toggle",
							        name=L["SHOWSPELLS_NAME"],
							        desc=L["SHOWSPELLS_DESC"],
							        order=2,
							        get=function() return db.showspells end,
							        set=function() db.showspells = not db.showspells end,
							},
							verbose = {
							        type="toggle",
							        name=L["VERBOSE_NAME"],
							        desc=L["VERBOSE_DESC"],
							        order=3,
							        get=function() return db.verbose end,
							        set=function() db.verbose = not db.verbose end,
							},
							showMinimap = {
							        type="toggle",
							        name=L["SHOWMINIMAP_NAME"],
							        desc=L["SHOWMINIMAP_DESC"],
							        order=4,
							        get=function() return db.showMinimap end,
							        set=function() 
										db.showMinimap = not db.showMinimap 
										Procodile:UpdateMinimapButton()
									end,
							},
							actionbarscds = {
							        type="toggle",
							        name=L["ACTIONBARCDS_NAME"],
							        desc=L["ACTIONBARCDS_DESC"],
							        order=5,
							        get=function() return db.actionbarscds end,
							        set=function() 
										db.actionbarscds = not db.actionbarscds
										Procodile:UpdateActionbarCooldowns()
									end,
							},
                       }
                },
                                
        },
}

function Procodile:OnInitialize()
	self:RegisterChatCommand("procodile", "Command")
	self:RegisterChatCommand("proc", "Command")
	self:RegisterChatCommand("proctest", "test")
	self:RegisterChatCommand("procscan", "ScanForProcs")
	
	self.db = LibStub("AceDB-3.0"):New("ProcodileDB", defaults)
	db = self.db.char
	
	self.options.args.output = Procodile:GetSinkAce3OptionsDataTable()
	self.options.args.output.disabled = false
	self:SetSinkStorage(db.sinkOptions)
	
	LibStub("AceConfig-3.0"):RegisterOptionsTable("Procodile", self.options)
	self.optionsFrame = LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Procodile", "Procodile")

	self:SetupBars()
	self:UpdateActionbarCooldowns()
	
	self.Minimap:Load()
	self:UpdateMinimapButton()
end

function Procodile:Command(input)
	for k,v in pairs(self.options.args.output) do
		self:Print(k)
		self:Print(v)
	end

	self:OpenOptions()
end

function Procodile:OpenOptions()
	InterfaceOptionsFrame_OpenToFrame(self.optionsFrame)
end

function Procodile:OnEnable()
	self:RegisterEvent("PLAYER_REGEN_DISABLED")
	self:RegisterEvent("PLAYER_REGEN_ENABLED")
	self:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	self:RegisterEvent("UNIT_INVENTORY_CHANGED")
	self:RegisterEvent("ACTIONBAR_SLOT_CHANGED")
	self:RegisterEvent("UPDATE_SHAPESHIFT_FORM")
	changed = true
	
	-- Clean up tracked spells
	for internalname,proc in pairs(db.tracked) do
		proc.laststarted = 0
		proc.started = 0
	end
	
	-- Check for item procs
	self:ScanForProcs()
	
	-- Should we enable tracking straight away?
	if db.combat and InCombatLockdown() == nil then
		self:Toggle(false)
	else
		self:Toggle(true)
	end
	
	self:ScheduleRepeatingTimer("Tick", 1, nil)
	
end

function Procodile:OnDisable()
	self:CancelAllTimers()
	db.enabled = false
	Procodile:Toggle(false)
end

function Procodile:ScanForProcs()
	
	self:RemoveAllProcCooldownFrames()

	-- Mark all tracked spells as not found after this inventory change
	for index, spell in ipairs(db.tracked) do
		spell.found = false
		
		-- Custom spells should never be automatically removed 
		if spell.custom ~= nil then
			spell.found = true
		end
	end

	-- For each inventory slot (ugly, should refer by IDs given by GetInventorySlotInfo()).
	for slotid = 1, 20 do
	
		local itemlink = GetInventoryItemLink("player", slotid)
		if itemlink ~= nil then
		
			-- Thank you, wowwiki
			local found, _, itemstring = string.find(itemlink, "^|c%x+|H(.+)|h%[.+%]")
			
			if itemstring then
				local _, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = strsplit(":", itemstring)
				local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemlink)
				
				-- Item enchants
				if tonumber(enchantId) ~= 0 then
				
					for spell_id,spell_enchantid in pairs(enchants) do
						if spell_enchantid == tonumber(enchantId) then
							
							-- See if we are already tracking this item
							local exists = false
							for index, spell in pairs(db.tracked) do
								if spell.id == spell_id then
									exists = true
									spell.found = true
								end
							end
							
							-- No, add it
							if not exists then
								self:AddSpell(spell_id, itemName, itemTexture)
							end
							
							break
						end
					end
					
				end

				-- Item proc spells
				for spell_id,value in pairs(items) do
					if type(value) == "table" then
						local tabletype = value['type']
						
						if tabletype == 'sharedproc' then
							for key,spell_itemid in pairs(value) do
								if key ~= 'type' then
									self:RegisterProcItem(spell_itemid, itemId, spell_id, itemName, itemTexture)
								end	
							end
						elseif tabletype == 'conditional' then
							local spell_itemid = value["itemid"]
							local procInfo = value['info']
							local condition = value['condition']
							if condition then
								if spell_itemid == tonumber(itemId) and condition() then
									self:RegisterProcItem(spell_itemid, itemId, spell_id, itemName, itemTexture, procInfo)
									if db.verbose then
										--self:Print("Condition "..procInfo)
									end
								end
							end
						end
					else
						local spell_itemid = value
						self:RegisterProcItem(spell_itemid, itemId, spell_id, itemName, itemTexture)
					end					
				end
			end
			
		end
		
	end
	
	-- Remove spells not found (item removed from inventory)
	for index, spell in pairs(db.tracked) do
		if not spell.found then
			self:RemoveSpell(spell.id)
		end
	end
	
	self:UpdateActionbarCooldowns()
	self.Minimap:UpdateIcon()	
	--self:ScheduleActionbarUpdate()
	
	self.Minimap:RefreshTooltip()
	--ProcodileFu:OnUpdateFuBarText()
end

function Procodile:RegisterProcItem(spell_itemid, itemId, spell_id, itemName, itemTexture, procInfo)
	if spell_itemid == tonumber(itemId) then
		-- See if we are already tracking this item
		local exists = false
		for index, spell in pairs(db.tracked) do
			if spell.id == spell_id then
				exists = true
				spell.found = true
			end
		end
		
		-- No, add it
		if not exists then
			self:AddSpell(spell_id, itemName, itemTexture, nil, procInfo)
		end
		--	break
	end
end

function Procodile:ShowCooldowns(show)
	if show then
		self.cooldowns:Show()
	else
		self.cooldowns:Hide()
	end
end

-- Returns all currently tracked spells
function Procodile:GetTrackedSpells()
	return db.tracked
end

-- Adds a spell to the tracked spells
function Procodile:AddSpell(spellid, itemname, itemicon, iscustom, procInfo)
	-- Attempt to find the spell in dormant
	local found = false
	for index, spell in pairs(db.dormant) do
		if spell.id == spellid then
			found = true
			
			spell.started = 0
			spell.laststarted = 0
			spell.found = true
			table.insert(db.tracked, spell)
			table.remove(db.dormant, index)
			break
		end
	end
	
	if not found then
		-- Spell not found in dormant - create new
		
		-- Loading the cooldown if we know it aleady
		local spellcd = 0
		local knowncd = PredefinedCooldowns[spellid]
		if ApplyPredefinedCooldowns and knowncd then
			spellcd = knowncd
		end
		
		local spell = {
					id = spellid, 
					name = itemname, 
					icon = itemicon, 
					seconds = 0, 
					count = 0, 
					started = 0, 
					totaltime = 0, 
					cooldown = spellcd, 
					laststarted = 0,
					found = true,
					custom = iscustom,
					--info = procInfo,
				}
		if procInfo then
			spell.info = procInfo
		end
		table.insert(db.tracked, spell)
	end
	
	if db.verbose then
		self:Print("adding "..itemname)
	end
end

function Procodile:RemoveSpell(spellid)
	for index, spell in pairs(db.tracked) do
		if spell.id == spellid then
			-- Add to dormant
			table.insert(db.dormant, spell)
			
			-- Remove from tracked
			table.remove(db.tracked, index)
			
			self.cooldowns:RemoveBar(spell.name)
			
			if db.verbose then
				self:Print("removing "..spell.name)
			end
			return
		end
	end
end

function Procodile:Reset()
	totaltime = 0
	for key,proc in pairs(db.tracked) do
		proc.count = 0
		proc.seconds = 0
		proc.started = 0
		proc.totaltime = 0
		proc.laststarted = 0
		proc.cooldown = 0
	end
	
	db.dormant = {}
	db.tracked = {}
	self:Print("|cff22ff22".."Data for all tracked procs has been reset")
	self:ScanForProcs()
	--ProcodileFu:OnUpdateFuBarText()
	self.Minimap:RefreshTooltip()
end

function Procodile:ReconfigureBars()
	self.cooldowns:SetFont(media:Fetch('font', db.barfont), db.barfontsize)
	self.cooldowns:SetWidth(db.barwidth)
	self.cooldowns:SetHeight(db.barheight)
	self.cooldowns:SetTexture(media:Fetch('statusbar', db.bartexture))
end

function Procodile:SetupBars()
	-- Create bar group
	self.cooldowns = self:NewBarGroup("Cooldowns", nil, db.barwidth, db.barheight, "ProcodileCooldowns")
	self.cooldowns:SetFont(media:Fetch('font', db.barfont), db.barfontsize)
	self.cooldowns:SetTexture(media:Fetch('statusbar', db.bartexture))
	self.cooldowns:SetColorAt(1.00, 1.0, 0.2, 0.2, 0.8)
	self.cooldowns:SetColorAt(0.66, 1.0, 0.3, 0.3, 0.8)
	self.cooldowns:SetColorAt(0.33, 1.0, 0.4, 0.4, 0.8)
	self.cooldowns:SetColorAt(0.00, 1.0, 0.5, 0.5, 0.8)
	self.cooldowns.RegisterCallback(self, "AnchorClicked")
	self.cooldowns.RegisterCallback(self,"TimerFinished")
	self.cooldowns:SetUserPlaced(true)
	
	if db.cooldowns then
		self.cooldowns:Show()
	else
		self.cooldowns:Hide()
	end
	
	if db.movablecooldowns then
		self.cooldowns:ShowAnchor()
	else
		self.cooldowns:HideAnchor()
	end
end

local function GetProc(name)
	for key,proc in pairs(db.tracked) do
		if proc.name == name then
			return proc
		end
	end
end

function Procodile:TimerFinished(evt, group, bar)
	if db.announce then
		self:Pour(bar.name.." CD expired!", 1.0, 0.5, 0.5)
	end
end

function Procodile:AnchorClicked(cbk, group, button)
	if button == "RightButton" then
		self:SetMovableCooldowns(false)
	end
end

function Procodile:SetMovableCooldowns(movable)
	db.movablecooldowns = movable
	if movable then
		self.cooldowns:ShowAnchor()
	else
		self.cooldowns:HideAnchor()
	end
end

function Procodile:Tick()
	if db.enabled then
		for key,proc in pairs(db.tracked) do
			if proc.started > 0 then
				proc.seconds = proc.seconds + 1
			end
			proc.totaltime = proc.totaltime + 1
		end
	end
	--self:CheckActionSlots()
	self:PerformScheduledProcScan()
end

function Procodile:TestBars()
	local bar = self.cooldowns:NewTimerBar("Test bar", "Test bar", 10, 10, "Interface\\Icons\\Spell_Holy_WordFortitude")
	bar:SetHeight(db.barheight)
	bar:SetTimer(10, 10)
end

function Procodile:test()
	for key,proc in pairs(db.tracked) do
		self:Print("key="..key)
		
		self:Print("id="..proc.id)
		self:Print("count="..proc.count)
		self:Print("seconds="..proc.seconds)
		self:Print("started="..proc.started)
	end
end

function Procodile:PLAYER_REGEN_ENABLED()
	-- Disable if we are enabled and are set to only track in combat
	if db.enabled and db.combat then
		Procodile:Toggle(false)
	end
end

function Procodile:PLAYER_REGEN_DISABLED()
	-- Enable if we are not enabled and are set to only track in combat
	if not db.enabled and db.combat then
		Procodile:Toggle(true)
	end
end

function Procodile:UNIT_INVENTORY_CHANGED(event, unit)
	if unit == "player" then
		self:ScanForProcs()
		self:ScheduleProcsScan()
	end
end

local DraggingProcSlotState = 0

function Procodile:ACTIONBAR_SLOT_CHANGED(event, slot)
	self:ScheduleActionSlotCheck(slot)
	self:CheckActionSlots()
end

function Procodile:COMBAT_LOG_EVENT_UNFILTERED(event, timestamp, eventtype, srcGUID, srcName, srcFlags, dstGUID, dstName, dstFlags, ...)
	local obj = select(1, ...)
	local match = false
	
	if db.enabled or not db.combat then

		if (dstName and UnitIsUnit(dstName,"player")) 
		then
			if eventtype == 'SPELL_AURA_APPLIED' --[[ or eventtype == 'SPELL_AURA_REFRESH' ]] then
				for internalname,proc in pairs(db.tracked) do
					if proc.id == obj then
						match = true
					
						-- Cooldown record?
						if proc.laststarted > 0 and (proc.cooldown == 0 or (time() - proc.laststarted < proc.cooldown)) then
							proc.cooldown = time() - proc.laststarted
							
							if db.announce and proc.cooldown < 300 then
								self:Pour(proc.name.." new cooldown detected: "..proc.cooldown.."s", 1.0, 0.5, 0.5)
							end
						end
					
						proc.count = proc.count + 1
						proc.started = time()
						proc.laststarted = proc.started
						if db.verbose then
							self:Print("|cff22ff22"..proc.name.." effect started")
						end
						
						self:StartProcCooldownFrames(proc)
						
						-- Reset cooldown bar
						if db.cooldowns and proc.cooldown > 0 then
							local bar = self.cooldowns:GetBar(proc.name)
							if not bar then
								bar = self.cooldowns:NewTimerBar(proc.name, proc.name, proc.cooldown, proc.cooldown, proc.icon)
							end
							bar:SetHeight(db.barheight)
							bar:SetTimer(proc.cooldown, proc.cooldown)
						end
						
						changed = true
						self.Minimap:RefreshTooltip()
					end
				end

				if not match and db.showspells then
					local spellname = select(2, ...)
					self:Print("Spell "..spellname.." ("..obj..") applied.")
				end
			end
			
			if eventtype == 'SPELL_AURA_REMOVED' then
				for internalname,proc in pairs(db.tracked) do
					if proc.id == obj then
						match = true
					
						proc.started = 0
						if db.verbose then
							self:Print("|cff22ff22"..proc.name.." effect ended")
						end
						
						changed = true
					end
				end
				
				if not match and db.showspells then
					local spellname = select(2, ...)
					self:Print("Spell "..spellname.." ("..obj..") removed.")
				end
			end
			
--	        	self:Print("|cff22ff22"..eventtype..', srcGUID='..srcGUID..', dstGUID='..dstGUID..', obj='..obj)
		end
		
	end
end

function Procodile:IsEnabled()
	return db.enabled
end

function Procodile:Toggle(enabled)
	if enabled ~= nil then
		db.enabled = enabled
	else
        db.enabled = not db.enabled
	end

	if db.verbose then
		if db.enabled then
			self:Print("|cff22ff22"..L["TOGGLE_ENABLED"])
		else
			self:Print("|cffff2222"..L["TOGGLE_DISABLED"])
		end
	end
	
	-- Reset some variables we only track while enabled
	if not db.enabled then
       	for internalname,proc in pairs(db.tracked) do
       		-- proc.laststarted = 0
       		-- proc.started = 0
       	end
	end
	
	--ProcodileFu:OnUpdateFuBarText()
	self.Minimap:RefreshTooltip()
end

-- [[ Proc related cooldown frames and action slots ]] --

local CooldownFrames = {}
local ProcActionSlots = {}

function Procodile:IsProcActionSlot(slot) 
	for proc,slots in pairs(ProcActionSlots) do
		for _,procslot in pairs(slots) do 
			if procslot == slot then
				return true
			end
		end
	end
	return false
end

function Procodile:IsNewProcActionSlot(slot) 
	for key,proc in pairs(db.tracked) do
		if SlotMatchesProc(slot,proc) then
			return true
		end
	end
	return false
end

function Procodile:StartProcCooldownFrames(proc)
	-- Firing proc cooldown frames
	local pcdframes = CooldownFrames[proc]
	if pcdframes then
		for key,pcdframe in pairs(pcdframes) do
			pcdframe:SetCooldown(GetTime(), proc.cooldown)
		end
	end
end

-- [[ Updating cooldowns ]] --

function Procodile:UpdateActionbarCooldowns()
	--self:Print("Updating cooldown action slots")
	ClearTable(ProcActionSlots)
	for key,proc in pairs(db.tracked) do
	
		-- Removing old cooldown frames
		local pcdframes = CooldownFrames[proc]
		if pcdframes then
			for key,pcdframe in pairs(pcdframes) do
				if pcdframe then
					pcdframe:Hide()
					pcdframe:SetParent(nil) 
					pcdframes[key] = nil
				end 
			end
		end
		
		-- Not creating cooldown frames if user doesn't want them
		if not db.actionbarscds then
			return
		end
		
		-- Creating new cooldown frames and saving action slots
		local actionbuttons, actionslots = self:GetActionSlotsForProc(proc)
		if actionbuttons then
			cooldownframes = {}
			local pcd_iterator = 1
			for _,button in pairs(actionbuttons) do
				-- Creating frame
				local ProcCooldownFrame = CreateFrame("Cooldown", "ProcCooldownFrame", button, "CooldownFrameTemplate")
				ProcCooldownFrame:SetAllPoints(button)
				-- Saving reference
				cooldownframes[pcd_iterator] = ProcCooldownFrame
				pcd_iterator = pcd_iterator + 1
			end
			CooldownFrames[proc] = cooldownframes
		end
		ProcActionSlots[proc] = actionslots
		
		self:UpdateProcCooldownFrames(proc)
	end
end

function Procodile:UpdateProcCooldownFrames(proc)
	local cooldownRemaining = (proc.laststarted + proc.cooldown) -  time()
	if cooldownRemaining > 0 then
		local pcdframes = CooldownFrames[proc]
		if pcdframes then
			for key,pcdframe in pairs(pcdframes) do
				pcdframe:SetCooldown(GetTime() - (proc.cooldown - cooldownRemaining), proc.cooldown)
			end
		end
	end 
end


function Procodile:RemoveAllProcCooldownFrames()
	for key,proc in pairs(db.tracked) do
		local pcdframes = CooldownFrames[proc]
		if pcdframes then
			for key,pcdframe in pairs(pcdframes) do
				if pcdframe then
					pcdframe:Hide()
					pcdframe:SetParent(nil) 
					pcdframes[key] = nil
				end 
			end
		end
	end
end

-- [[ ActionButton and ActionSlot search for procs ]] --

function Procodile:GetActionSlotsForProc(proc) 
	local bongos = IsAddOnLoaded("Bongos")
	if bongos then
		return self:GetBongosSlotsForProc(proc)
	else
		return self:GetDefaultActionBarSlotsForProc(proc)
	end
end

local ActionBars = {'Action','MultiBarBottomLeft','MultiBarBottomRight','MultiBarRight','MultiBarLeft'}
function Procodile:GetDefaultActionBarSlotsForProc(proc)
	local buttons = {}
	local slots = {}
	for _, barName in pairs(ActionBars) do
        for i = 1, 14 do
            local button = _G[barName .. 'Button' .. i]
			
			if button then
				local slot = ActionButton_GetPagedID(button) or ActionButton_CalculateAction(button) or button:GetAttribute('action') or 0
				self:SelectProcActionSlots(proc, button, buttons, slot, slots)
			end             
        end
    end
	
	return buttons, slots
end

function Procodile:GetBongosSlotsForProc(proc)
	local buttons = {}
	local slots = {}
	
	for i = 1, 120 do
		local buttonName = format('Bongos3ActionButton%d', i)
		local button = _G[buttonName]

		if button then
			local slot = button:GetAttribute('action') or 0
			self:SelectProcActionSlots(proc, button, buttons, slot, slots)
		end 
    end
	
	return buttons, slots
end

function Procodile:SelectProcActionSlots(proc, button, buttons, slot, slots)
	if SlotMatchesProc(slot,proc) then
		table.insert(buttons, 1, button)
		table.insert(slots, 1, slot)
	end
end

function SlotMatchesProc(slot,proc)
	local match = false
	if HasAction(slot) then
		local actionType, id = GetActionInfo(slot)		
		if actionType == 'item' then 
			local itemName, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(id)
			if itemName == proc.name then 
				match = true
			end
		elseif actionType == 'macro' then 
			if GetActionTexture(slot) == proc.icon then 
				match = true
			end
		end
	end
	return match
end

-- [[ Scheduled updates ]] --

local ScheduledSlots = {}

function Procodile:ScheduleActionSlotCheck(slot)
	table.insert(ScheduledSlots, slot)
end

local ActionBarCooldownsNeedUpdate = false
-- This method is dead code
function Procodile:ScheduleActionbarUpdate()
	ActionBarCooldownsNeedUpdate = true
end

function Procodile:CheckActionSlots()
	local update = false
	for _, slot in pairs(ScheduledSlots) do
		if self:IsProcActionSlot(slot) or self:IsNewProcActionSlot(slot) then
			update = true
			break
		end
	end
	ClearTable(ScheduledSlots)
	
	update = update or ActionBarCooldownsNeedUpdate
	if update then 
		self:UpdateActionbarCooldowns()
		ActionBarCooldownsNeedUpdate = false
	end
end

function ClearTable(mytable)
	for k in next, mytable do rawset(mytable, k, nil) end
end


local ProcsNeedRescan = false 

function Procodile:ScheduleProcsScan()
	ProcsNeedRescan = true
end

function Procodile:PerformScheduledProcScan()
	if ProcsNeedRescan then 
		self:ScanForProcs()
		ProcsNeedRescan = false
	end
end

-- [[ Minimap ]] --

function Procodile:SetShowMinimap(enable)
	db.showMinimap = enable or false
	self:UpdateMinimapButton()
end

function Procodile:ShowingMinimap()
	return db.showMinimap
end

function Procodile:UpdateMinimapButton()
	if self:ShowingMinimap() then
		self.Minimap:UpdatePosition()
		self.Minimap:Show()
	else
		self.Minimap:Hide()
	end
end

function Procodile:SetMinimapButtonPosition(angle)
	db.minimapPos = angle
end

function Procodile:GetMinimapButtonPosition()
	return db.minimapPos
end

-- [[ Conditional proc helpers ]] --

local previousForm = -1
local wasInForm = false
function Procodile:UPDATE_SHAPESHIFT_FORM()
	local form = GetShapeshiftForm()
	if form ~= previousForm and form ~= 0 then
		wasInForm = true
		self:OnShapeshift(form)
	elseif form == 0 and previousForm == 0 and wasInForm then
		wasInForm = false
		self:OnShapeshift(form)
	end
	previousForm = form
end

function Procodile:OnShapeshift(form)
	local class, classFileName, classIndex = UnitClass("player")
	if classFileName == "DRUID" then
		--self:Print("Shapeshift change, form: "..form)
		if self:IsDruidWearingFunkyTrinket() then
			self:ScanForProcs()
		end 
	end 
end

function Procodile:IsDruidWearingFunkyTrinket() 
	local trinketId = 30664
	for slotid = 1, 20 do
		local itemlink = GetInventoryItemLink("player", slotid)
		if itemlink ~= nil then
			-- Thank you, wowwiki
			local found, _, itemstring = string.find(itemlink, "^|c%x+|H(.+)|h%[.+%]")
			if itemstring then
				local _, itemId, enchantId, jewelId1, jewelId2, jewelId3, jewelId4, suffixId, uniqueId = strsplit(":", itemstring)
				--local itemName, itemLink, itemRarity, itemLevel, itemMinLevel, itemType, itemSubType, itemStackCount, itemEquipLoc, itemTexture = GetItemInfo(itemlink)
				--self:Print("No match, itemId:".. itemId.." trinketId:"..trinketId)
				if tonumber(itemId) == trinketId then
					return true
				end
			end
		end
	end
	return false
end

function Procodile:IsDruidOutOfForm()
	return GetShapeshiftForm() == 0
end

function Procodile:IsDruidInBearForm()
	return GetShapeshiftForm() == 1
end

function Procodile:IsDruidInCatForm()
	local CatFormSpellId = 768
	return IsFormActive(3, CatFormSpellId) or IsFormActive(4, CatFormSpellId)
end

function Procodile:IsDruidInTreeForm()
	local TreeFormSpellId = 33891
	return IsFormActive(5, TreeFormSpellId) or IsFormActive(6, TreeFormSpellId)
end

function Procodile:IsDruidInMoonkinForm()
	local MoonkinFormSpellId = 24858
	return IsFormActive(5, MoonkinFormSpellId) or IsFormActive(6, MoonkinFormSpellId)
end

function IsFormActive(index, formSpellId)
	local formName = GetSpellInfo(formSpellId)
	local texture, name, isActive, isCastable, spellID = GetShapeshiftFormInfo(index)
	return GetShapeshiftForm() == index and name == formName
end

function Procodile:IsAldorExalted()
	return IsPlayerExalted("The Aldor")
end

function Procodile:IsScryersExalted()
	return IsPlayerExalted("The Scryers")
end

function IsPlayerExalted(factionName)
	local name, standingID = GetFactionStandingByID(factionName)
	--Procodile:Print(name.." standing: "..standingID)
	return tonumber(standingID)	== 8
end

function GetFactionStandingByID(factionName)
	for index = 1, 60 do
		local name, description, standingID = GetFactionInfo(index)
		--Procodile:Print(GetFactionInfo(index))
		if name == factionName then
			return name, standingID
		end
	end
	return 0
end
