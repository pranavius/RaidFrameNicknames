---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "zhCN")
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "为团队框架添加角色名称并设置自定义昵称"
L["Debug"] = "调试"
L["Display debugging messages in the default chat window"] = "在默认聊天窗口中显示调试信息"
L["You should never need to enable this"] = "你不需要启用此功能"
L["Add New Entry"] = "添加新条目"
L["Character Name"] = "角色名称"
L["Nickname"] = "昵称"
L["Add"] = "添加"
L["Import from GRM"] = "从 GRM 导入"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "使用 Guild Roster Manager (GRM) 的数据，一次性为公会中的多个角色添加昵称"
L["Current Nicknames"] = "当前昵称"
L["Delete"] = "删除"
L["Add to Nickname"] = "添加至昵称"
L["Delete Nickname"] = "删除昵称"
L["Open WhoDat options menu"] = "打开 WhoDat 选项菜单"
L["Opens the Guild Roster Manager character import dialog"] = "打开 Guild Roster Manager 角色导入对话框"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM 已加载 - 角色导入选项可用"
L["Character {character} is already assigned to nickname {nickname}"] = "角色 {character} 已分配到昵称 {nickname}"
L["Character {character} is now assigned to nickname {nickname}"] = "角色 {character} 现已分配到昵称 {nickname}"
L["Character {character} no longer has nickname {nickname}"] = "角色 {character} 不再拥有昵称 {nickname}"
L["Nickname {nickname} has been deleted"] = "昵称 {nickname} 已删除"
L["GRM is not yet initialized. Please try again soon."] = "GRM 尚未初始化，请稍后再试。"
L["GRM Import is complete"] = "GRM 导入已完成"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat：GRM 导入工具"
L["Enter the name of a character in your guild to find alts or mains for"] = "输入公会中某个角色的名称以查找其小号或主号"
L["Enter a nickname for these characters"] = "为这些角色输入昵称"
L["Import"] = "导入"
L["{count} characters will be imported with nickname {nickname}"] = "将以昵称 {nickname} 导入 {count} 个角色"
