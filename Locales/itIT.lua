---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "itIT")
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "Aggiungi nomi dei personaggi e assegna soprannomi personalizzati per i riquadri del raid"
L["Debug"] = "Debug"
L["Display debugging messages in the default chat window"] = "Mostra i messaggi di debug nella finestra chat predefinita"
L["You should never need to enable this"] = "Non dovresti mai dover attivare questa opzione"
L["Add New Entry"] = "Aggiungi nuova voce"
L["Character Name"] = "Nome del personaggio"
L["Nickname"] = "Soprannome"
L["Add"] = "Aggiungi"
L["Import from GRM"] = "Importa da GRM"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "Aggiungi un soprannome a più personaggi della tua gilda contemporaneamente usando i dati di Guild Roster Manager (GRM)"
L["Current Nicknames"] = "Soprannomi attuali"
L["Delete"] = "Elimina"
L["Add to Nickname"] = "Aggiungi al soprannome"
L["Delete Nickname"] = "Elimina soprannome"
L["Open WhoDat options menu"] = "Apri il menu delle opzioni di WhoDat"
L["Opens the Guild Roster Manager character import dialog"] = "Apre il dialogo di importazione dei personaggi di Guild Roster Manager"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM è caricato - l'opzione di importazione dei personaggi è disponibile"
L["Character {character} is already assigned to nickname {nickname}"] = "Il personaggio {character} è già assegnato al soprannome {nickname}"
L["Character {character} is now assigned to nickname {nickname}"] = "Il personaggio {character} è ora assegnato al soprannome {nickname}"
L["Character {character} no longer has nickname {nickname}"] = "Il personaggio {character} non ha più il soprannome {nickname}"
L["Nickname {nickname} has been deleted"] = "Il soprannome {nickname} è stato eliminato"
L["GRM is not yet initialized. Please try again soon."] = "GRM non è ancora inizializzato. Riprova tra poco."
L["GRM Import is complete"] = "L'importazione GRM è completata"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat: Strumento di importazione GRM"
L["Enter the name of a character in your guild to find alts or mains for"] = "Inserisci il nome di un personaggio della tua gilda per trovare i suoi alt o personaggi principali"
L["Enter a nickname for these characters"] = "Inserisci un soprannome per questi personaggi"
L["Import"] = "Importa"
L["{count} character(s) will be imported with nickname {nickname}"] = "{count} personaggio/i verranno importati con il soprannome {nickname}"
