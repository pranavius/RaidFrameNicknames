---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "frFR")
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "Ajouter des noms de personnage et attribuer des surnoms personnalisés pour les cadres de raid"
L["Debug"] = "Débogage"
L["Display debugging messages in the default chat window"] = "Afficher les messages de débogage dans la fenêtre de discussion par défaut"
L["You should never need to enable this"] = "Tu ne devrais jamais avoir besoin d'activer ceci"
L["Add New Entry"] = "Ajouter une nouvelle entrée"
L["Character Name"] = "Nom du personnage"
L["Nickname"] = "Surnom"
L["Add"] = "Ajouter"
L["Import from GRM"] = "Importer depuis GRM"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "Ajouter un surnom à plusieurs personnages de ta guilde en même temps à l'aide des données de Guild Roster Manager (GRM)"
L["Current Nicknames"] = "Surnoms actuels"
L["Delete"] = "Supprimer"
L["Add to Nickname"] = "Ajouter au surnom"
L["Delete Nickname"] = "Supprimer le surnom"
L["Open WhoDat options menu"] = "Ouvrir le menu des options de WhoDat"
L["Opens the Guild Roster Manager character import dialog"] = "Ouvre le dialogue d'importation de personnages de Guild Roster Manager"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM est chargé - l'option d'importation de personnages est disponible"
L["Character {character} is already assigned to nickname {nickname}"] = "Le personnage {character} est déjà assigné au surnom {nickname}"
L["Character {character} is now assigned to nickname {nickname}"] = "Le personnage {character} est maintenant assigné au surnom {nickname}"
L["Character {character} no longer has nickname {nickname}"] = "Le personnage {character} n'a plus le surnom {nickname}"
L["Nickname {nickname} has been deleted"] = "Le surnom {nickname} a été supprimé"
L["GRM is not yet initialized. Please try again soon."] = "GRM n'est pas encore initialisé. Réessaie bientôt."
L["GRM Import is complete"] = "L'importation GRM est terminée"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat : Outil d'importation GRM"
L["Enter the name of a character in your guild to find alts or mains for"] = "Entre le nom d'un personnage de ta guilde pour trouver ses alts ou personnages principaux"
L["Enter a nickname for these characters"] = "Entre un surnom pour ces personnages"
L["Import"] = "Importer"
L["{count} character(s) will be imported with nickname {nickname}"] = "{count} personnage(s) seront importés avec le surnom {nickname}"
