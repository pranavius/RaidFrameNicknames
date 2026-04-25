---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ruRU")
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "Добавить имена персонажей и назначить пользовательские псевдонимы для рейдовых фреймов"
L["Debug"] = "Отладка"
L["Display debugging messages in the default chat window"] = "Отображать отладочные сообщения в стандартном окне чата"
L["You should never need to enable this"] = "Тебе никогда не придётся включать это"
L["Add New Entry"] = "Добавить новую запись"
L["Character Name"] = "Имя персонажа"
L["Nickname"] = "Псевдоним"
L["Add"] = "Добавить"
L["Import from GRM"] = "Импортировать из GRM"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "Назначить псевдоним нескольким персонажам своей гильдии одновременно, используя данные Guild Roster Manager (GRM)"
L["Current Nicknames"] = "Текущие псевдонимы"
L["Delete"] = "Удалить"
L["Add to Nickname"] = "Добавить к псевдониму"
L["Delete Nickname"] = "Удалить псевдоним"
L["Open WhoDat options menu"] = "Открыть меню настроек WhoDat"
L["Opens the Guild Roster Manager character import dialog"] = "Открывает диалог импорта персонажей Guild Roster Manager"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM загружен — доступна опция импорта персонажей"
L["Character {character} is already assigned to nickname {nickname}"] = "Персонаж {character} уже привязан к псевдониму {nickname}"
L["Character {character} is now assigned to nickname {nickname}"] = "Персонаж {character} теперь привязан к псевдониму {nickname}"
L["Character {character} no longer has nickname {nickname}"] = "Персонаж {character} больше не имеет псевдонима {nickname}"
L["Nickname {nickname} has been deleted"] = "Псевдоним {nickname} удалён"
L["GRM is not yet initialized. Please try again soon."] = "GRM ещё не инициализирован. Пожалуйста, попробуй снова чуть позже."
L["GRM Import is complete"] = "Импорт GRM завершён"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat: инструмент импорта GRM"
L["Enter the name of a character in your guild to find alts or mains for"] = "Введи имя персонажа в своей гильдии, чтобы найти его альтов или мэйнов"
L["Enter a nickname for these characters"] = "Введи псевдоним для этих персонажей"
L["Import"] = "Импортировать"
L["{count} character(s) will be imported with nickname {nickname}"] = "Будет импортировано {count} персонаж(ей) с псевдонимом {nickname}"
