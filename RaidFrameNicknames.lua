local addonName = "Raid Frame Nicknames"

-- Module
RaidFrameNicknames = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0");

-- Localization
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

local Options = {
    type = "group",
    name = addonName,
    args = {
        usageDesc = {
            type = "description",
            name = L["usage_desc"],
            width = "full",
            order = 0,
        },
        spacer = {
            type = "description",
            name = " ",
            width = "full",
            order = 1,
        },
        debug = {
            type = "toggle",
            name = L["debug"],
            desc= L["debug_desc"].."\n\n|cFFff0000"..L["dont_enable_warning"].."|r",
            order = 2,
            get = function(item) return RaidFrameNicknames.db.profile[item[#item]] end,
            set = function(item, val) RaidFrameNicknames.db.profile[item[#item]] = val end
        },
        newEntryHeader = {
            type = "header",
            name = L["add_new_entry"],
            order = 3,
        },
        nicknameInput = {
            type = "input",
            name = L["nickname"],
            order = 4,
            get = function() return RaidFrameNicknames.newNick or "" end,
            set = function(_, val) RaidFrameNicknames.newNick = val end
        },
        characterInput = {
            type = "input",
            name = L["char_name"],
            order = 5,
            get = function() return RaidFrameNicknames.newChar or "" end,
            set = function(_, val) RaidFrameNicknames.newChar = val end
        },
        addButton = {
            type = "execute",
            name = L["add"],
            width = "half",
            order = 6,
            func = function()
                -- strtrim is a Blizzard-provided global utility function
                local newChar = strtrim(RaidFrameNicknames.newChar)
                local newName = strtrim(RaidFrameNicknames.newNick)
                if newChar and newChar ~= "" and newName and newName ~= "" then
                    RaidFrameNicknames.db.profile.nicknames[newName] = RaidFrameNicknames.db.profile.nicknames[newName] or {}
                    -- Avoid duplicate character names across any nicknames
                    for nickname, _ in pairs(RaidFrameNicknames.db.profile.nicknames) do
                        for character, _ in pairs(RaidFrameNicknames.db.profile.nicknames[nickname]) do
                            if character == newChar then
                                RaidFrameNicknames:Print("Character |cFF1eff00" .. newChar .. "|r is already assigned to nickname |cFF1eff00"..nickname.."|r")
                                return
                            end
                        end
                    end
                    RaidFrameNicknames.db.profile.nicknames[newName][newChar] = true
                    RaidFrameNicknames.newNick = ""
                    RaidFrameNicknames.newChar = ""
                    RaidFrameNicknames:Print("|cFF1eff00" .. newChar .. "|r now has nickname |cFFff8000" .. newName .. "|r.")
                    RaidFrameNicknames:BuildNicknameEntryList()
                    RaidFrameNicknames:UpdateRaidNamesIfSafe()
                end
            end
        },
        spacerTwo = {
            type = "description",
            name = " ",
            order = 7,
        },
        currentEntriesHeader = {
            type = "header",
            name = L["current_nicknames"],
            order = 8,
        },
        -- Nickname groups are populated dynamically on initialization and after each new entry
    }
}

local Defaults = {
    profile = {
        debug = false,
        nicknames = {},
    }
}

local SlashOptions = {
	type = "group",
	handler = RaidFrameNicknames,
	get = function(item) return RaidFrameNicknames.db.profile[item[#item]] end,
	set = function(item, value) RaidFrameNicknames.db.profile[item[#item]] = value end,
	args = {
        debug = {
            type = "toggle",
            name = "debug",
            desc = L["debug_desc"]
        },
		config = {
			type = "execute",
			name = "config",
			desc = L["config_desc"],
			func = function()
                Settings.OpenToCategory(addonName)
            end,
		},
	},
}

local SlashCmds = { "rfn" }

-- Initialization
function RaidFrameNicknames:OnInitialize()
    -- Load database
	self.db = LibStub("AceDB-3.0"):New("RaidFrameNicknamesDB", Defaults, "Default")

    -- Setup config options
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    local config = LibStub("AceConfig-3.0")
    local registry = LibStub("AceConfigRegistry-3.0")

	config:RegisterOptionsTable(addonName, SlashOptions, SlashCmds)
    registry:RegisterOptionsTable("Raid Frame Nicknames Options", Options)
	registry:RegisterOptionsTable("Raid Frame Nicknames Profiles", profiles)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Raid Frame Nicknames Options", addonName)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Raid Frame Nicknames Profiles", "Profiles", addonName);

    self:BuildNicknameEntryList()

    -- Register events
    self:RegisterEvent("GROUP_ROSTER_UPDATE", "UpdateRaidNamesIfSafe")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateRaidNamesIfSafe")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateRaidNamesIfSafe")

    hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
        if frame:IsForbidden() then return end
        if self:IsGroupedUp() then
            if not frame or not frame.unit or not UnitExists(frame.unit) then
                self:Debug_Print("|cFF00ccffCompactUnitFrame_UpdateName|r:", "|cFFc41e3aUnit frame not found|r")
                return
            end
            local unitName = UnitName(frame.unit)
            -- We only care about units in our party or raid
            if not UnitInParty(unitName) and not UnitInRaid(unitName) then
                self:Debug_Print("Ignoring unit not in party or raid:", unitName)
                return

            end

            local nickname = self:GetNicknameForCharacter(unitName)
            if frame.name and nickname and (frame.__rfn_nickname ~= nickname or frame.__rfn_nickname ~= frame.name:GetText()) then
                self:Debug_Print("Setting unitName |cFF1eff00" .. unitName .. "|r to nickname |cFFff8000" .. nickname .. "|r")
                frame.name:SetText(nickname)
                frame.__rfn_nickname = nickname
            elseif frame.name and not nickname and frame.__rfn_nickname then
                self:Debug_Print("Removing nickname from unitName |cFFff8000" .. unitName .. "|r")
                frame.name:SetText(GetUnitName(frame.unit, true))
                frame.__rfn_nickname = nil
            end
        end
    end)

    self:Debug_Print("Loaded")
end

-- Functions
function RaidFrameNicknames:Debug_Print(...)
    if self.db.profile.debug then
		self:Print("|cFF00ccff[Debug] |r ", ...)
	end
end

function RaidFrameNicknames:IsGroupedUp()
    return IsInGroup() or IsInRaid()
end

function RaidFrameNicknames:BuildNicknameEntryList()
    self:Debug_Print("Rebuild nickname list")
    local args = Options.args
    local nicknames = self.db.profile.nicknames

    -- Clear all nickname options args to start fresh
    for argName, _ in pairs(args) do
        if argName:find("group_") then
            args[argName] = nil
        end
    end

    -- Sort nicknames alphabetically into a new table
    local sortedNicknameKeys = {}
    for nickname in pairs(nicknames) do
        table.insert(sortedNicknameKeys, nickname)
    end
    table.sort(sortedNicknameKeys)

    -- Add each nickname group in alphabetical order
    for i, nickname in pairs(sortedNicknameKeys) do
        local nicknameKey = "group_" .. nickname
        args[nicknameKey] = {
            type = "group",
            name = nickname,
            order = i,
            args = {}
        }

        local groupArgs = args[nicknameKey].args
        local charOrder = 1

            -- Delete the whole nickname
            groupArgs["deleteNick_" .. nickname] = {
            type = "execute",
            name = L["delete_nickname"],
            order = charOrder,
            func = function()
                nicknames[nickname] = nil
                self:BuildNicknameEntryList()
            end,
        }

        -- Character list under this nickname
        local characters = nicknames[nickname]
        for character, _ in pairs(characters) do
            groupArgs["char_" .. character] = {
                type = "group",
                name = "",
                inline = true,
                order = charOrder + 1,
                args = {
                    label = {
                        type = "description",
                        name = character,
                        width = "double",
                        order = 1,
                    },
                    delete = {
                        type = "execute",
                        name = L["delete"],
                        width = "half",
                        order = 2,
                        func = function()
                            nicknames[nickname][character] = nil
                            -- If there are no other characters associated with the nickname, delete the nickname itself
                            if not next(nicknames[nickname]) then
                                nicknames[nickname] = nil
                            end
                            self:BuildNicknameEntryList()
                        end,
                    }
                }
            }
            charOrder = charOrder + 1
        end

        -- Input to add a new character to this nickname
        groupArgs["addChar_" .. nickname] = {
            type = "input",
            name = L["add_to_nickname"],
            order = charOrder + 2,
            set = function(_, val)
                val = strtrim(val)
                if val ~= "" then
                    nicknames[nickname][val] = true
                    self:BuildNicknameEntryList()
                end
            end,
            get = function() return "" end,
        }
    end
end

function RaidFrameNicknames:UpdateRaidNamesIfSafe()
    if self:IsGroupedUp() and not InCombatLockdown() then
        C_Timer.After(0.5, function()
            self:Debug_Print("In group/raid and out of combat")
            self:UpdateRaidNames()
        end)
    elseif self:IsGroupedUp() then
        -- Delay update until combat ends
        self:Debug_Print("In group/raid, but currently in combat. Frame updates will trigger upon exiting.")
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
    end
end

function RaidFrameNicknames:PLAYER_REGEN_ENABLED()
    if self:IsGroupedUp() then
        self:Debug_Print("In group/raid and exited combat")
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
        C_Timer.After(0.5, function()
            self:UpdateRaidNames()
        end)
    end
end

function RaidFrameNicknames:UpdateRaidNames()
    self:Debug_Print("Updating party/raid nicknames")

    if not CompactRaidFrameContainer or not CompactRaidFrameContainer.ApplyToFrames then
        self:Debug_Print("|cFF00ccffCompactRaidFrameContainer |cFFc41e3aobject or |cFF00ccffApplyToFrames |cFFc41e3amethod not found|r")
        return
    end

    CompactRaidFrameContainer:ApplyToFrames("normal", function(frame)
        if frame and frame.unit and UnitExists(frame.unit) then
            local unitName = UnitName(frame.unit)
            local nickname = self:GetNicknameForCharacter(unitName)
            
            if nickname and frame.name:GetText() ~= nickname then
                self:Debug_Print("Setting unitName |cFF1eff00" .. unitName .. "|r to nickname |cFFff8000" .. nickname .. "|r")
                frame.name:SetText(nickname)
                frame.__rfn_nickname = nickname
            end
        end
    end)
end

function RaidFrameNicknames:GetNicknameForCharacter(name)
    local nicknames = self.db.profile.nicknames
    local result
    for nickname, chars in pairs(nicknames) do
        if chars[name] then
            return nickname
        end
    end

    -- If a nickname can't be found, return nil
    return
end