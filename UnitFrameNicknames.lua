local addonName = "Unit Frame Nicknames"

-- Module
UnitFrameNicknames = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0");

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
        debug = {
            type = "toggle",
            name = L["debug"],
            desc= L["debug_desc"],
            order = 1,
            get = function(item) return UnitFrameNicknames.db.profile[item[#item]] end,
            set = function(item, val) UnitFrameNicknames.db.profile[item[#item]] = val end
        },
        newEntryHeader = {
            type = "header",
            name = L["add_new_entry"],
            order = 2,
        },
        characterInput = {
            type = "input",
            name = L["char_name"],
            order = 3,
            get = function() return UnitFrameNicknames.newChar or "" end,
            set = function(_, val) UnitFrameNicknames.newChar = val end
        },
        nicknameInput = {
            type = "input",
            name = L["nickname"],
            order = 4,
            get = function() return UnitFrameNicknames.newNick or "" end,
            set = function(_, val) UnitFrameNicknames.newNick = val end
        },
        addButton = {
            type = "execute",
            name = L["add"],
            order = 5,
            func = function()
                local char = UnitFrameNicknames.newChar
                local nn = UnitFrameNicknames.newNick
                if char and char ~= "" and nn and nn ~= "" then
                    UnitFrameNicknames.db.profile.nicknames[char] = nn
                    UnitFrameNicknames.newChar = ""
                    UnitFrameNicknames.newNick = ""
                    UnitFrameNicknames:Debug_Print("New entry: |cFF1eff00" .. char .. "|r now has nickname |cFFff8000" .. nn .. "|r.")
                    UnitFrameNicknames:BuildNicknameEntryList()
                    UnitFrameNicknames:UpdateRaidNamesIfSafe()
                end
            end
        },
        spacer = {
            type = "description",
            name = " ",
            order = 6,
        },
        currentEntriesHeader = {
            type = "header",
            name = L["current_nicknames"],
            order = 7,
        },
        entryList = {
            type = "group",
            inline = true,
            name = "",
            order = 8,
            args = {} -- Populated dynamically on initialization and after each new entry
        }
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
	handler = UnitFrameNicknames,
	get = function(item) return UnitFrameNicknames.db.profile[item[#item]] end,
	set = function(item, value) UnitFrameNicknames.db.profile[item[#item]] = value end,
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

local SlashCmds = { "ufn" }

-- Initialization
function UnitFrameNicknames:OnInitialize()
    -- Load database
	self.db = LibStub("AceDB-3.0"):New("UnitFrameNicknamesDB", Defaults, "Default")

    -- Setup config options
	local profiles = LibStub("AceDBOptions-3.0"):GetOptionsTable(self.db)
    local config = LibStub("AceConfig-3.0")
    local registry = LibStub("AceConfigRegistry-3.0")

	config:RegisterOptionsTable(addonName, SlashOptions, SlashCmds)
    registry:RegisterOptionsTable("Unit Frame Nicknames Options", Options)
	registry:RegisterOptionsTable("Unit Frame Nicknames Profiles", profiles)
    LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Unit Frame Nicknames Options", addonName)
	LibStub("AceConfigDialog-3.0"):AddToBlizOptions("Unit Frame Nicknames Profiles", "Profiles", addonName);

    self:BuildNicknameEntryList()

    -- Register events
    self:RegisterEvent("GROUP_ROSTER_UPDATE", "UpdateRaidNamesIfSafe")
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "UpdateRaidNamesIfSafe")
    self:RegisterEvent("ZONE_CHANGED_NEW_AREA", "UpdateRaidNamesIfSafe")

    hooksecurefunc("CompactUnitFrame_UpdateName", function(frame)
        if not frame or not frame.unit or not UnitExists(frame.unit) then return end
    
        local name = UnitName(frame.unit, true)
        local nickname = self.db.profile.nicknames[name]
    
        if nickname and frame.name and nickname ~= frame.name then
            frame.name:SetText(nickname)
        end
    end)

    self:Debug_Print("Loaded")
end

-- Functions
function UnitFrameNicknames:Debug_Print(msg)
    if self.db.profile.debug then
		self:Print("|cFF00ccff[Debug] |r " .. msg)
	end
end

function UnitFrameNicknames:BuildNicknameEntryList()
    self:Debug_Print("Rebuild nickname list")
    local t = Options.args.entryList.args
    wipe(t) -- Clean old UI nickname entries

    local data = self.db.profile.nicknames or {}
    if not data then
        self:Debug_Print("|cFFc41e3aDatabase not found|r")
        return
    end

    local i = 1
    for char, nick in pairs(data) do
        self:Debug_Print("character: " .. char .. " with nickname: " .. nick) -- Remove after testing
        local key = "entry" .. i
        t[key .. "_value"] = {
            type = "description",
            name = char .. " -> " .. nick,
            width = "double",
            order = i * 10,
        }
        t[key .. "_edit"] = {
            type = "execute",
            name = L["edit"],
            width = "half",
            order = i * 10 + 1,
            func = function()
                UnitFrameNicknames.newChar = char
                UnitFrameNicknames.newNick = nick
                UnitFrameNicknames.db.profile.nicknames[char] = nil
                self:Debug_Print("|cFFe6cc80Editing entry for character: |r" .. char)
            end
        }
        t[key .. "_delete"] = {
            type = "execute",
            name = L["delete"],
            width = "half",
            order = i * 10 + 2,
            func = function()
                UnitFrameNicknames.db.profile.nicknames[char] = nil
                self:Debug_Print("|cFFc41e3aDeleted entry for character:|r |cFF9d9d9d" .. char .. "|r")
                self:BuildNicknameEntryList()
                self:UpdateRaidNamesIfSafe()
            end
        }
        i = i + 1
    end
end

function UnitFrameNicknames:UpdateRaidNamesIfSafe()
    if not InCombatLockdown() then
        self:Debug_Print("Out of combat")
        self:UpdateRaidNames()
    else
        -- Delay update until combat ends
        self:Debug_Print("Currently in combat. Frame updates will trigger upon exiting.")
        self:RegisterEvent("PLAYER_REGEN_ENABLED")
    end
end

function UnitFrameNicknames:PLAYER_REGEN_ENABLED()
    self:Debug_Print("Exited combat")
    self:UnregisterEvent("PLAYER_REGEN_ENABLED")
    self:UpdateRaidNames()
end

function UnitFrameNicknames:UpdateRaidNames()
    self:Debug_Print("Updating party/raid nicknames")
    local nicknames = self.db.profile.nicknames

    if not CompactRaidFrameContainer or not CompactRaidFrameContainer.ApplyToFrames then
        self:Debug_Print("CompactRaidFrameContainer object or ApplyToFrames method not found")
        return
    end

    CompactRaidFrameContainer:ApplyToFrames("normal", function(frame)
        if frame and frame.unit and UnitExists(frame.unit) then
            local name = UnitName(frame.unit)
            local nickname = nicknames[name]
            if nickname and nickname ~= name then
                frame.name:SetText(nickname)
            end
        end
    end)
end