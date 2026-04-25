---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhTW")
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "為團隊框架新增角色名稱並設定自訂暱稱"
L["Debug"] = "除錯"
L["Display debugging messages in the default chat window"] = "在預設聊天視窗中顯示除錯訊息"
L["You should never need to enable this"] = "你不需要啟用此功能"
L["Add New Entry"] = "新增條目"
L["Character Name"] = "角色名稱"
L["Nickname"] = "暱稱"
L["Add"] = "新增"
L["Import from GRM"] = "從 GRM 匯入"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "使用 Guild Roster Manager (GRM) 的資料，一次為公會中的多個角色新增暱稱"
L["Current Nicknames"] = "目前暱稱"
L["Delete"] = "刪除"
L["Add to Nickname"] = "新增至暱稱"
L["Delete Nickname"] = "刪除暱稱"
L["Open WhoDat options menu"] = "開啟 WhoDat 選項選單"
L["Opens the Guild Roster Manager character import dialog"] = "開啟 Guild Roster Manager 角色匯入對話框"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM 已載入 - 角色匯入選項可用"
L["Character {character} is already assigned to nickname {nickname}"] = "角色 {character} 已指定為暱稱 {nickname}"
L["Character {character} is now assigned to nickname {nickname}"] = "角色 {character} 現已指定為暱稱 {nickname}"
L["Character {character} no longer has nickname {nickname}"] = "角色 {character} 不再擁有暱稱 {nickname}"
L["Nickname {nickname} has been deleted"] = "暱稱 {nickname} 已刪除"
L["GRM is not yet initialized. Please try again soon."] = "GRM 尚未初始化，請稍後再試。"
L["GRM Import is complete"] = "GRM 匯入已完成"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat：GRM 匯入工具"
L["Enter the name of a character in your guild to find alts or mains for"] = "輸入公會中某個角色的名稱以尋找其小號或主號"
L["Enter a nickname for these characters"] = "為這些角色輸入暱稱"
L["Import"] = "匯入"
L["{count} characters will be imported with nickname {nickname}"] = "將以暱稱 {nickname} 匯入 {count} 個角色"
