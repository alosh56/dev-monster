do

local function run(msg, matches)

local reply_id = msg['id']
if is_momod(msg) and matches[1] == 'م2' then 
    local ghost = [[
 
 📈أّوٌأّمًر أّدٍأّرةّ أّلَمًجّـمًوٌعٌةّ 📉
🎌✨🎌✨🎌✨🎌✨
💢مًعٌلَوٌمًأّتٌـيِّ : لَعٌرضًـ مًعٌلَوٌمًأّتٌـکْ | 📃
💢مًعٌلَوٌمًأّتٌـ أّلَمًجّـمًوٌعٌةّ : مًعٌلَوٌمًأّتٌـ الکْروٌبً | 💬
💢أّلَأّعٌدٍأّدٍأّتٌـ : لَعٌرضًـّ أّلَأّعٌدٍأّدٍأّتٌـ | 🏁
💢مًوٌقُعٌيِّ : لَمًعٌرفُـةّ مًوٌقُعٌکْ فُـيِّ أّلَکْروٌبً | 👤
🔹أّلَأّعٌضًـأّء : قُأّئمًةّ أّلَأّعٌضًـأّء | 👥
🎌✨🎌✨🎌✨🎌✨
💢رفُـعٌ أّدٍمًنِ : لَلَرفُـعٌ أّدٍمًنِ لَلَبًوٌتٌـ | ➕
💢تٌـنِﺰيِّلَ أّدٍمًنِ : لَتٌـنِﺰيِّلَ أّدٍمًنِ لَلَبًوٌتٌـ | 🔓
💢أّلَأّدٍمًنِيّهّـ : قُأّئمًةّ أّلَأّدٍمًنِيِّهّـ لَلَبًوٌتٌـ | 👥
🎌✨🎌✨🎌✨🎌✨
💢أّلَرأّبًطِ : رأّبًطِ أّلَکْروٌبً | 🔌
💢وٌضًـعٌ رأّبًطِ : لَحًفُـظُ رأّبًطِ أّلَکْروٌبً | 📌
💢رأّبًطِ جّـدٍيِّدٍ : : لَوٌضًـعٌ رأّبًطِ جّـدٍيِّدٍ | 🆕
🎌✨🎌✨🎌✨🎌✨
💢ضًـعٌ قُوٌأّنِيِّنِ  + وٌضًـعٌ قُوٌأّنِيِّنِ : أّلَقُوٌأّنِيِّنِ | ⚙
💢أّلَقُوٌأّنِيِّنِ  : لَعٌرضًـ أّلَقُوٌأّنِيِّنِ | 👁
💢ضًـعٌ وٌضًـفُـ  + وٌضًـعٌ وٌصّـفُـ : أّلَوٌصّـفُـ | 💫
💢ضًـعٌ أّسِـمً  + وٌضًـعٌ أّسِـمً : أّسِـمً | 🎫
💢ضًـعٌ صّـوٌرهّـ  : لَوٌضًـعٌ صّـوٌرهّـ | 🎡
🎌✨🎌✨🎌✨🎌✨
💢حًذِفُـ  ↴ حذف ⛔️
💢أّلَأّدٍمًنِيِّةّ : أّدٍمًنِيِّةّ أّلَبًوٌتٌـ | 👥
💢أّلَوٌصّـفُـ : حًذِفُـ أّلَوٌصّـفُـ | 📃
💢أّلَمًکْتٌـوٌمًيِّنِ : قُأّئمًةّ أّلَکْتٌـمً | 🗣
💢أّلَقُوٌأّنِيِّنِ :  حًذِفُـ أّلَقُوٌأّنِيِّنِ | 🎌
🎌✨🎌✨🎌✨🎌✨
💢️ #Dev @Reda99
💢️ #Bot @city5_bot
  ]]
  reply_msg(reply_id, ghost, ok_cb, false) 
end 

local reply_id = msg['id'] 
if not is_momod(msg) then 
local ghost = "شُـغُلَةّ مًأّلَ کْبًأّر لَتٌـلَغُبً أّنِتٌـ😂😂 !" 
reply_msg(reply_id, ghost, ok_cb, false) 
end 

end 
return { 
patterns ={ 
  "^(م2)$", 
}, 
run = run 
} 
end
--[[ 

            

▀▄ ▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▀▄▄▀▀▄▄▀▀▄▄▀ 
▀▄ ▄▀                                         ▀▄ ▄▀ 
▀▄ ▄▀    name : (  ⚡Rode  )                   ▀▄ ▄▀ 
▀▄ ▄▀                     ŘᎧđέ Ṭέαᵯ.          ▀▄ ▄▀ 
▀▄ ▄▀  File name : ( #ar-he2 )                ▀▄ ▄▀ 
▀▄ ▄▀            Dev: @Reda999                ▀▄ ▄▀ 
▀▄ ▄▀             Dev: @ks_iq                 ▀▄ ▄▀
▀▄ ▄▀                                         ▀▄ ▄▀ 
▀▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄ 


                    
--]] 
