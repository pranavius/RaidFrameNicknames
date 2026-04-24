---@type string, WhoDat
local addonName, WhoDat = ...

---@class WhoDat
WhoDat = LibStub("AceAddon-3.0"):NewAddon(addonName, "AceConsole-3.0", "AceEvent-3.0");

---@class WhoDatGRMUtil
local GRMUtil = {}

---Indicates whether GRM has been loaded
---@return boolean `true` if GRM is loaded, `false` otherwise
function GRMUtil.IsGRMInitialized()
    if not C_AddOns then return false end
    return select(2, C_AddOns.IsAddOnLoaded("Guild_Roster_Manager")) and GRM_API and GRM_API.Initialized == true
end

---Returns a list of all characters associated with a character in GRM
---@param character string Name of the character to fetch main/alts for
---@return string[] 'List of character names associated with the provided character'
function GRMUtil.GetLinkedToons(character)
    -- Make sure the GRM AddOn is loaded before attempting any further action
    if not GRMUtil.IsGRMInitialized() then
        WhoDat:Print("GRM is not yet initialized. Please try again shortly.")
        return {}
    end

    local searchResults = {}
    for _, result in ipairs(GRM_R.GetAllMembersAsArray(character:lower())) do
        if not tContains(searchResults, result.name) then
            tinsert(searchResults, result.name)
        end
        if result.mainName and not tContains(searchResults, result.mainName) then
            tinsert(searchResults, result.mainName)
        end
    end

    if #searchResults > 0 then
        local altGroupID = GRM_API.GetMember(searchResults[1]).altGroup
        -- GRM.GetAltGroup() returns named properties, but character data is indexed numerically, so we can iterate over ipairs to ignore the named properties
        for _, toon in ipairs(GRM.GetAltGroup(altGroupID)) do
            if not tContains(searchResults, toon.name) then
                tinsert(searchResults, toon.name)
            end
        end
    end

    -- Since we don't care about server name, we'll split each search result on the hyphen
    for idx, result in ipairs(searchResults) do
        searchResults[idx] = result:gmatch("([^%-]+)")()
    end

    return searchResults
end

function GRMUtil:OpenDialog()
    local dialog = CreateFrame("Frame", "WhoDatGRMImport", UIParent, "ButtonFrameTemplate")
    dialog:SetPoint("CENTER")
    dialog:SetSize(400, 300)
    dialog:HookScript("OnLoad", function() WhoDat:Print("GRM Import Dialog") end)
    dialog.TitleText:SetText("GRM Import")
    dialog:SetFrameStrata("DIALOG")
end

WhoDat.GRMUtil = GRMUtil