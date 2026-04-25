---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "enUS", true, true)
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "Add character names and assign custom nicknames for raid frames"
L["Debug"] = "Debug"
L["Display debugging messages in the default chat window"] = "Display debugging messages in the default chat window"
L["You should never need to enable this"] = "You should never need to enable this"
L["Add New Entry"] = "Add New Entry"
L["Character Name"] = "Character Name"
L["Nickname"] = "Nickname"
L["Add"] = "Add"
L["Import from GRM"] = "Import from GRM"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"
L["Current Nicknames"] = "Current Nicknames"
L["Delete"] = "Delete"
L["Add to Nickname"] = "Add to Nickname"
L["Delete Nickname"] = "Delete Nickname"
L["Open WhoDat options menu"] = "Open WhoDat options menu"
L["Opens the Guild Roster Manager character import dialog"] = "Opens the Guild Roster Manager character import dialog"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM is loaded - character import option is available"
L["Character {character} is already assigned to nickname {nickname}"] = "Character {character} is already assigned to nickname {nickname}"
L["Character {character} is now assigned to nickname {nickname}"] = "Character {character} is now assigned to nickname {nickname}"
L["Character {character} no longer has nickname {nickname}"] = "Character {character} no longer has nickname {nickname}"
L["Nickname {nickname} has been deleted"] = "Nickname {nickname} has been deleted"
L["GRM is not yet initialized. Please try again soon."] = "GRM is not yet initialized. Please try again soon."
L["GRM Import is complete"] = "GRM Import is complete"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat: GRM Import Tool"
L["Enter the name of a character in your guild to find alts or mains for"] = "Enter the name of a character in your guild to find alts or mains for"
L["Enter a nickname for these characters"] = "Enter a nickname for these characters"
L["Import"] = "Import"
L["{count} characters will be imported with nickname {nickname}"] = "{count} characters will be imported with nickname {nickname}"
