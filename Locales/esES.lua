---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "esES")
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "Añadir nombres de personaje y asignar apodos personalizados para los marcos de banda"
L["Debug"] = "Depuración"
L["Display debugging messages in the default chat window"] = "Mostrar mensajes de depuración en la ventana de chat predeterminada"
L["You should never need to enable this"] = "No deberías necesitar activar esto nunca"
L["Add New Entry"] = "Añadir nueva entrada"
L["Character Name"] = "Nombre del personaje"
L["Nickname"] = "Apodo"
L["Add"] = "Añadir"
L["Import from GRM"] = "Importar desde GRM"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "Añadir un apodo a múltiples personajes de tu hermandad a la vez usando datos del Guild Roster Manager (GRM)"
L["Current Nicknames"] = "Apodos actuales"
L["Delete"] = "Eliminar"
L["Add to Nickname"] = "Añadir al apodo"
L["Delete Nickname"] = "Eliminar apodo"
L["Open WhoDat options menu"] = "Abrir el menú de opciones de WhoDat"
L["Opens the Guild Roster Manager character import dialog"] = "Abre el diálogo de importación de personajes del Guild Roster Manager"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM está cargado - la opción de importación de personajes está disponible"
L["Character {character} is already assigned to nickname {nickname}"] = "El personaje {character} ya está asignado al apodo {nickname}"
L["Character {character} is now assigned to nickname {nickname}"] = "El personaje {character} ahora está asignado al apodo {nickname}"
L["Character {character} no longer has nickname {nickname}"] = "El personaje {character} ya no tiene el apodo {nickname}"
L["Nickname {nickname} has been deleted"] = "El apodo {nickname} ha sido eliminado"
L["GRM is not yet initialized. Please try again soon."] = "GRM todavía no está inicializado. Por favor, inténtalo de nuevo en breve."
L["GRM Import is complete"] = "La importación de GRM ha finalizado"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat: Herramienta de importación de GRM"
L["Enter the name of a character in your guild to find alts or mains for"] = "Introduce el nombre de un personaje de tu hermandad para encontrar sus alts o personajes principales"
L["Enter a nickname for these characters"] = "Introduce un apodo para estos personajes"
L["Import"] = "Importar"
L["{count} character(s) will be imported with nickname {nickname}"] = "{count} personaje(s) se importarán con el apodo {nickname}"
