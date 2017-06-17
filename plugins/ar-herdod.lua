do

local function run(msg, matches)

local reply_id = msg['id']
if is_momod(msg) and matches[1] == 'م3' then 
    local ghost = [[
 
 
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
  reply_msg(reply_id, ghost, ok_cb, false) 
end 

local reply_id = msg['id'] 
if not is_momod(msg) then 
local ghost = "شُـغُلَةّ مًأّلَ کْبًأّر لَتٌـلَغُبً أّنِتٌـ😂😂 !" 
reply_msg(reply_id, ghost, ok_cb, false) 
end 
