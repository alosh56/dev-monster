do

local function run(msg, matches)
local reply_id = msg['id']
if is_momod(msg) and matches[1]== 'م3' then
local S = [[  

💢ٱهےـِلَٱ وٌسًےـهےـِلَٱ بّےـ ـكےـ💢
💢أّوٌأّمًر أّلَردٍوٌدٍ فُـيِّ أّلَمًجّـمًوٌعٌهّـ💢
🎌✨🎌✨🎌✨🎌✨
💢🔒قُفُـلَ أّلَردٍوٌدٍ :::لَتٌـعٌطِيِّلَ أّلَردٍوٌد
💢🔓فُـتٌـحً أّلَردٍوٌدٍ :::لَتٌـشُـغُيِّلَ أّلَردٍوٌدٍ 
🎌✨🎌✨🎌✨🎌✨
💢أّوٌأّمًر أّضًـأّفُـةّ وٌحًذِفُـ أّلَردٍوٌدٍ💢
ٍ🎌✨🎌✨🎌✨🎌✨
💢ردٍ أّضًـفُـ أّلَکْلَمًةّ أّلَجّـوٌأّبً✅
💢ردٍ حًذِفُـ أّلَکْلَمًةّ 🚫
🎌✨🎌✨🎌✨🎌✨
💢️ #DΣV @Reda999
💢️ #BӨT @city5_bot
🎌✨🎌✨🎌✨🎌✨ َ 
]]
reply_msg(reply_id, S, ok_cb, false) 
end

if not is_momod(msg) then
local S = "  للمشرفــــٰين 🕵🏻 فقـــط عزيــزي♥️❗️ "
reply_msg(reply_id, S, ok_cb, false)
end

end
return {
description = "Help list", 
usage = "Help list",
patterns = {
"^(م3)$",
},
run = run 
}
end
