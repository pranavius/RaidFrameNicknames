---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "ptBR")
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "Adicionar nomes de personagem e atribuir apelidos personalizados para os quadros de raida"
L["Debug"] = "Depuração"
L["Display debugging messages in the default chat window"] = "Exibir mensagens de depuração na janela de chat padrão"
L["You should never need to enable this"] = "Você nunca precisará ativar isso"
L["Add New Entry"] = "Adicionar nova entrada"
L["Character Name"] = "Nome do personagem"
L["Nickname"] = "Apelido"
L["Add"] = "Adicionar"
L["Import from GRM"] = "Importar do GRM"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "Adicionar um apelido a vários personagens da sua guilda de uma vez usando dados do Guild Roster Manager (GRM)"
L["Current Nicknames"] = "Apelidos atuais"
L["Delete"] = "Excluir"
L["Add to Nickname"] = "Adicionar ao apelido"
L["Delete Nickname"] = "Excluir apelido"
L["Open WhoDat options menu"] = "Abrir o menu de opções do WhoDat"
L["Opens the Guild Roster Manager character import dialog"] = "Abre o diálogo de importação de personagens do Guild Roster Manager"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM está carregado - a opção de importação de personagens está disponível"
L["Character {character} is already assigned to nickname {nickname}"] = "O personagem {character} já está atribuído ao apelido {nickname}"
L["Character {character} is now assigned to nickname {nickname}"] = "O personagem {character} agora está atribuído ao apelido {nickname}"
L["Character {character} no longer has nickname {nickname}"] = "O personagem {character} não tem mais o apelido {nickname}"
L["Nickname {nickname} has been deleted"] = "O apelido {nickname} foi excluído"
L["GRM is not yet initialized. Please try again soon."] = "GRM ainda não foi inicializado. Tente novamente em breve."
L["GRM Import is complete"] = "A importação do GRM está completa"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat: Ferramenta de importação do GRM"
L["Enter the name of a character in your guild to find alts or mains for"] = "Digite o nome de um personagem da sua guilda para encontrar seus alts ou personagens principais"
L["Enter a nickname for these characters"] = "Digite um apelido para esses personagens"
L["Import"] = "Importar"
L["{count} characters will be imported with nickname {nickname}"] = "{count} personagens serão importados com o apelido {nickname}"
