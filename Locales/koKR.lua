---@type string
local addonName = ...

---@class Locale
local L = LibStub("AceLocale-3.0"):NewLocale(addonName, "koKR")
if not L then return end

------------ Options ------------
L["Add character names and assign custom nicknames for raid frames"] = "공격대 프레임에 캐릭터 이름을 추가하고 사용자 지정 별명 지정"
L["Debug"] = "디버그"
L["Display debugging messages in the default chat window"] = "기본 채팅창에 디버그 메시지 표시"
L["You should never need to enable this"] = "이 기능을 활성화할 필요는 없을 것입니다"
L["Add New Entry"] = "새 항목 추가"
L["Character Name"] = "캐릭터 이름"
L["Nickname"] = "별명"
L["Add"] = "추가"
L["Import from GRM"] = "GRM에서 가져오기"
L["Add a nickname for multiple characters in your guild at once using data from Guild Roster Manager (GRM)"] = "Guild Roster Manager (GRM)의 데이터를 사용하여 길드의 여러 캐릭터에게 한 번에 별명 지정"
L["Current Nicknames"] = "현재 별명"
L["Delete"] = "삭제"
L["Add to Nickname"] = "별명에 추가"
L["Delete Nickname"] = "별명 삭제"
L["Open WhoDat options menu"] = "WhoDat 옵션 메뉴 열기"
L["Opens the Guild Roster Manager character import dialog"] = "Guild Roster Manager 캐릭터 가져오기 대화 상자 열기"

--- Chat Messages ---
L["GRM is loaded - character import option is available"] = "GRM이 로드됨 - 캐릭터 가져오기 옵션 사용 가능"
L["Character {character} is already assigned to nickname {nickname}"] = "캐릭터 {character}는 이미 별명 {nickname}에 지정되어 있습니다"
L["Character {character} is now assigned to nickname {nickname}"] = "캐릭터 {character}가 이제 별명 {nickname}에 지정되었습니다"
L["Character {character} no longer has nickname {nickname}"] = "캐릭터 {character}의 별명 {nickname}이 해제되었습니다"
L["Nickname {nickname} has been deleted"] = "별명 {nickname}이 삭제되었습니다"
L["GRM is not yet initialized. Please try again soon."] = "GRM이 아직 초기화되지 않았습니다. 잠시 후 다시 시도해 주세요."
L["GRM Import is complete"] = "GRM 가져오기가 완료되었습니다"

--- GRM Import Tool ---
L["WhoDat: GRM Import Tool"] = "WhoDat: GRM 가져오기 도구"
L["Enter the name of a character in your guild to find alts or mains for"] = "길드에서 부캐 또는 본캐를 찾을 캐릭터 이름 입력"
L["Enter a nickname for these characters"] = "이 캐릭터들의 별명 입력"
L["Import"] = "가져오기"
L["{count} characters will be imported with nickname {nickname}"] = "별명 {nickname}(으)로 {count}명의 캐릭터를 가져옵니다"
