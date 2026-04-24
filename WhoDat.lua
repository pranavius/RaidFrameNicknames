---@type string, WhoDat
local addonName, WhoDat = ...

---@class WhoDat
WhoDat = LibStub("AceAddon-3.0"):GetAddon(addonName, true);

---@class Locale
local L = LibStub("AceLocale-3.0"):GetLocale(addonName, true)

---Handler function for adding a new entry in the AddOn options window
---@param char string Name of the character to associate with a nickname
---@param nick string Nickname to be associated with the character
function WhoDat:HandleAddNewEntry(char, nick)
    if char and char ~= "" and nick and nick ~= "" then
        self.db.profile.nicknames[nick] = self.db.profile.nicknames[nick] or {}
        -- Avoid duplicate character names across any nicknames
        for nickname, _ in pairs(self.db.profile.nicknames) do
            for character, _ in pairs(self.db.profile.nicknames[nickname]) do
                if character == char then
                    self:Print("Character "..UNCOMMON_GREEN_COLOR:WrapTextInColorCode(character).." is already assigned to nickname "..GOLD_FONT_COLOR:WrapTextInColorCode(nickname))
                    return
                end
            end
        end
        self.db.profile.nicknames[nick][char] = true
        self:PrintAssocUpdateMessage(char, nick, true)
        self:BuildNicknameEntryList()
        self:UpdateRaidNamesIfSafe()
    end
end

---@class AceConfig.OptionsTable
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
            desc= L["debug_desc"].."\n\n"..PURE_RED_COLOR:WrapTextInColorCode(L["dont_enable_warning"]),
            order = 2,
            get = function(item) return WhoDat.db.profile[item[#item]] end,
            set = function(item, val) WhoDat.db.profile[item[#item]] = val end
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
            get = function() return WhoDat.newName or "" end,
            set = function(_, val) WhoDat.newName = val end
        },
        characterInput = {
            type = "input",
            name = L["char_name"],
            order = 5,
            get = function() return WhoDat.newChar or "" end,
            set = function(_, val) WhoDat.newChar = val end
        },
        addButton = {
            type = "execute",
            name = L["add"],
            width = "half",
            order = 6,
            func = function()
                WhoDat:HandleAddNewEntry(WhoDat.newChar, WhoDat.newName)
                WhoDat.newName = ""
                WhoDat.newChar = ""
            end
        },
        spacerTwo = {
            type = "description",
            name = " ",
            order = 7,
        },
        grmImport = {
            type = "execute",
            name = "Import from GRM",
            desc = "Add a nickname for multiple characters in your guild at once using GRM's database",
            order = 8,
            func = function() WhoDat.GRMUtil:OpenImportDialog() end,
            hidden = function() return not WhoDat.GRMUtil.IsGRMLoaded() end
        },
        spacerThree = {
            type = "description",
            name = " ",
            order = 9,
            hidden = function() return not WhoDat.GRMUtil.IsGRMLoaded() end
        },
        currentEntriesHeader = {
            type = "header",
            name = L["current_nicknames"],
            order = 10,
        },
        -- Nickname groups are populated dynamically on initialization and after each new entry
    }
}

---@class AceDB.Schema
local Defaults = {
    profile = {
        debug = false,
        nicknames = {},
    }
}

---@class AceConfig.OptionsTable
local SlashOptions = {
	type = "group",
	handler = WhoDat,
	get = function(item) return WhoDat.db.profile[item[#item]] end,
	set = function(item, value) WhoDat.db.profile[item[#item]] = value end,
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
                Settings.OpenToCategory(WhoDat.categoryID)
            end,
		},
	},
}

local function registerGRMSlashCommandIfLoaded()
    if WhoDat.GRMUtil.IsGRMLoaded() then
        WhoDat:Print("GRM detected, character import option is available")
        ---@type AceConfig.OptionsTable
        local importCommand = {
            type = "execute",
            name = "import",
            desc = "Opens the Guild Roster Manager character import dialog",
            func = function()
                WhoDat.GRMUtil:OpenImportDialog()
            end
        }

        SlashOptions.args.import = importCommand
    end
end

---@type string[]
local SlashCmds = { "wd", "whodat" }

function WhoDat:OnInitialize()
    -- Load database
	self.db = LibStub("AceDB-3.0"):New("WhoDatDB", Defaults, "Default")

    -- Setup config options
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    local config = LibStub("AceConfig-3.0")
    local registry = LibStub("AceConfigRegistry-3.0")

    registerGRMSlashCommandIfLoaded()
	config:RegisterOptionsTable(addonName, SlashOptions, SlashCmds)
    registry:RegisterOptionsTable(addonName.."Options", Options)
	registry:RegisterOptionsTable(addonName.."Profiles", profiles)
    _, self.categoryID = LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName.."Options", addonName)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions(addonName.."Profiles", "Profiles", addonName);

    self:BuildNicknameEntryList()

    -- Register events
    self:RegisterEvent("GROUP_ROSTER_UPDATE", "UpdateRaidNamesIfSafe")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateRaidNamesIfSafe")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateRaidNamesIfSafe")

    hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
        if frame:IsForbidden() then return end
        if self:IsGroupedUp() then
            if not frame or not frame.unit or not UnitExists(frame.unit) then
                self:PrintDebugMsg("CompactUnitFrame_UpdateName: Unit frame not found")
                return
            end
            local unitName = UnitName(frame.unit)
            -- We only care about units in our party or raid (unit names outside our group are likely secret values anyway)
            if issecretvalue(unitName) then
                self:PrintDebugMsg("Secret unit name found, ignoring")
                return
            elseif not UnitInParty(unitName) and not UnitInRaid(unitName) then
                self:PrintDebugMsg("Unit not in party or raid, ignore", unitName)
                return
            end
            
            local nickname = self:GetNicknameForCharacter(unitName)
            if frame.name and nickname and (frame.__wd_nickname ~= nickname or frame.__wd_nickname ~= frame.name:GetText()) then
                self:PrintDebugMsg("Setting unitName", UNCOMMON_GREEN_COLOR:WrapTextInColorCode(unitName), "to nickname", LEGENDARY_ORANGE_COLOR:WrapTextInColorCode(nickname))
                frame.name:SetText(nickname)
                frame.__wd_nickname = nickname
            elseif frame.name and not nickname and frame.__wd_nickname then
                self:PrintDebugMsg("Removing nickname from unitName", LEGENDARY_ORANGE_COLOR:WrapTextInColorCode(unitName))
                frame.name:SetText(GetUnitName(frame.unit, true))
                frame.__wd_nickname = nil
            end
        end
    end)

    self:PrintDebugMsg("Loaded")
end

---Prints text when WhoDat is in debug mode
---@param...any Arguments to print to the chat window
function WhoDat:PrintDebugMsg(...)
    if self.db.profile.debug then
		self:Print(HEIRLOOM_BLUE_COLOR:WrapTextInColorCode("[Debug]"), ...)
	end
end

---Prints a message to the chat window when a character is associated with a nickname
---@param character string Name of the character to assign a nickname to
---@param nickname string Nickname to be assigned
---@param isAdding boolean `true` if associating a character with a nickname and `false` if disassociating
function WhoDat:PrintAssocUpdateMessage(character, nickname, isAdding)
    if isAdding then
        self:Print(UNCOMMON_GREEN_COLOR:WrapTextInColorCode(character), "now has nickname", LEGENDARY_ORANGE_COLOR:WrapTextInColorCode(nickname))
    else
        self:Print(GOLD_FONT_COLOR:WrapTextInColorCode(character), "no longer has nickname", LEGENDARY_ORANGE_COLOR:WrapTextInColorCode(nickname))
    end
end

---Prints a message to the chat window when a nickname has been deleted from the AddOn configuration
---@param nickname string The deleted nickname
function WhoDat:PrintNicknameDeletionMessage(nickname)
    self:Print("Nickname", ERROR_COLOR:WrapTextInColorCode(nickname), "has been deleted")
end

---@return boolean `true` if the user is in a party or raid, `false` otherwise
function WhoDat:IsGroupedUp()
    return IsInGroup() or IsInRaid()
end

---Builds the nickname management section of the AddOn options window
function WhoDat:BuildNicknameEntryList()
    self:PrintDebugMsg("Rebuild nickname list")
    ---@type table<string, AceConfig.OptionsTable>
    local args = Options.args
    local nicknames = self.db.profile.nicknames

    -- Clear all nickname options args to start fresh
    for arg, _ in pairs(args) do
        if arg:find("group_") then
            args[arg] = nil
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
        local nicknameKey = "group_"..nickname
        args[nicknameKey] = {
            type = "group",
            name = nickname,
            order = i,
            args = {}
        }

        local groupArgs = args[nicknameKey].args
        local charOrder = 1

            -- Delete the whole nickname
            groupArgs["deleteNickname_"..nickname] = {
            type = "execute",
            name = L["delete_nickname"],
            order = charOrder,
            func = function()
                nicknames[nickname] = nil
                self:PrintNicknameDeletionMessage(nickname)
                self:BuildNicknameEntryList()
            end,
        }

        -- Character list under this nickname
        local characters = nicknames[nickname]
        for character, _ in pairs(characters) do
            groupArgs["character_"..character] = {
                type = "group",
                name = "",
                inline = true,
                order = charOrder + 1,
                args = {
                    label = {
                        type = "description",
                        name = character,
                        width = 0.75,
                        order = 1,
                    },
                    delete = {
                        type = "execute",
                        name = L["delete"],
                        desc = "Disassociate character "..character.." from "..nickname,
                        width = "half",
                        order = 2,
                        func = function()
                            nicknames[nickname][character] = nil
                            WhoDat:PrintAssocUpdateMessage(character, nickname, false)
                            -- If there are no other characters associated with the nickname, delete the nickname itself
                            if not next(nicknames[nickname]) then
                                nicknames[nickname] = nil
                                self:PrintNicknameDeletionMessage(nickname)
                            end
                            self:BuildNicknameEntryList()
                        end,
                    }
                }
            }
            charOrder = charOrder + 1
        end

        -- Input to add a new character to this nickname
        groupArgs["addCharacter_"..nickname] = {
            type = "input",
            name = L["add_to_nickname"],
            order = charOrder + 2,
            set = function(_, val)
                val = strtrim(val)
                self:HandleAddNewEntry(val, nickname)
            end,
            get = function() return "" end,
        }
    end
end

---Checks that the user is in a party/raid and out of combat before updating nicknames on raid frames
function WhoDat:UpdateRaidNamesIfSafe()
    if self:IsGroupedUp() and not InCombatLockdown() then
        self:UpdateRaidNames()
    elseif self:IsGroupedUp() then
        -- Delay update until combat ends
        self:PrintDebugMsg("In group/raid, but currently in combat. Frame updates will trigger upon exiting.")
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
    end
end

---Callback function executed when there PLAYER_REGEN_ENABLED event fires
function WhoDat:PLAYER_REGEN_ENABLED()
    if self:IsGroupedUp() then
        self:PrintDebugMsg("In group/raid and exited combat")
        self:UnregisterEvent("PLAYER_REGEN_ENABLED")
        self:UpdateRaidNames()
    end
end

---Scans all party/raid members and updates nicknames for applicable characters as needed
function WhoDat:UpdateRaidNames()
    C_Timer.After(0.5, function()
        self:PrintDebugMsg("Updating party/raid nicknames")
    
        if not CompactRaidFrameContainer or not CompactRaidFrameContainer.ApplyToFrames then
            self:PrintDebugMsg("CompactRaidFrameContainer or ApplyToFrames method not found")
            return
        end
    
        CompactRaidFrameContainer:ApplyToFrames("normal", function(frame)
            if frame and frame.unit and UnitExists(frame.unit) then
                local unitName = UnitName(frame.unit)
                local nickname = self:GetNicknameForCharacter(unitName)
                
                if nickname and frame.name:GetText() ~= nickname then
                    self:PrintDebugMsg("Setting unitName", UNCOMMON_GREEN_COLOR:WrapTextInColorCode(unitName), "to nickname", LEGENDARY_ORANGE_COLOR:WrapTextInColorCode(nickname))
                    frame.name:SetText(nickname)
                    frame.__wd_nickname = nickname
                end
            end
        end)
    end)
end

---@param name string Character to fetch a nickname for
---@return string? nickname
function WhoDat:GetNicknameForCharacter(name)
    local nicknames = self.db.profile.nicknames
    for nickname, chars in pairs(nicknames) do
        if chars[name] then
            return nickname
        end
    end

    -- If a nickname can't be found, return nil
    return nil
end

WDUtils = {
    GetNickname = function(character)
        return WhoDat:GetNicknameForCharacter(character) or character
    end,
    IsGroupedUp = function()
        return WhoDat:IsGroupedUp()
    end,
    -- For testing only
    _GetGRMAlts = function(character)
        return WhoDat.GRMUtil.GetLinkedToons(character)
    end
}
