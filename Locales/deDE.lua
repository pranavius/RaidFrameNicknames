---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "deDE")
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "Charakternamen hinzufügen und benutzerdefinierte Spitznamen für Schlachtzugrahmen vergeben"
L["Debug"] = "Debug"
L["Display debugging messages in the default chat window"] = "Debugmeldungen im Standard-Chatfenster anzeigen"
L["You should never need to enable this"] = "Du solltest das niemals aktivieren müssen"
L["Add New Entry"] = "Neuen Eintrag hinzufügen"
L["Character Name"] = "Charaktername"
L["Nickname"] = "Spitzname"
L["Add"] = "Hinzufügen"
L["Import from GRM"] = "Von GRM importieren"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "Mehreren Charakteren in deiner Gilde gleichzeitig einen Spitznamen vergeben, mithilfe von Daten aus dem Guild Roster Manager (GRM)"
L["Current Nicknames"] = "Aktuelle Spitznamen"
L["Delete"] = "Löschen"
L["Add to Nickname"] = "Zu Spitzname hinzufügen"
L["Delete Nickname"] = "Spitzname löschen"
L["Open WhoDat options menu"] = "WhoDat-Optionsmenü öffnen"
L["Opens the Guild Roster Manager character import dialog"] = "Öffnet den Charakterimport-Dialog des Guild Roster Manager"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM ist geladen – Charakterimport-Option ist verfügbar"
L["Character {character} is already assigned to nickname {nickname}"] = "Charakter {character} ist bereits dem Spitznamen {nickname} zugewiesen"
L["Character {character} is now assigned to nickname {nickname}"] = "Charakter {character} ist nun dem Spitznamen {nickname} zugewiesen"
L["Character {character} no longer has nickname {nickname}"] = "Charakter {character} hat nicht mehr den Spitznamen {nickname}"
L["Nickname {nickname} has been deleted"] = "Spitzname {nickname} wurde gelöscht"
L["GRM is not yet initialized. Please try again soon."] = "GRM ist noch nicht initialisiert. Bitte versuche es in Kürze erneut."
L["GRM Import is complete"] = "GRM-Import ist abgeschlossen"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat: GRM-Importwerkzeug"
L["Enter the name of a character in your guild to find alts or mains for"] = "Den Namen eines Charakters in deiner Gilde eingeben, um seine Twinks oder Hauptcharaktere zu finden"
L["Enter a nickname for these characters"] = "Einen Spitznamen für diese Charaktere eingeben"
L["Import"] = "Importieren"
L["{count} characters will be imported with nickname {nickname}"] = "{count} Charaktere werden mit dem Spitznamen {nickname} importiert"
