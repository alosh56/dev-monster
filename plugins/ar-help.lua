do

local function run(msg, matches)

local reply_id = msg['id']
if is_momod(msg) and matches[1] == 'الاوامر' then 
    local ghost = [[
            
  💢آهـ,ـلَأّ وٌسِـهّـلَأّ بًکْ عٌﺰيِّﺰيِّ

💢هـ,ـنـ,ـآكـ,ـ ثـ,ـلـآثـ,ـةّ آۅآمـ,ـر

🎌✨🎌✨🎌✨🎌✨
💢- مً1📛📛 أّوٌأّمًر حًمًأّيِّةّ أّلَمًجّـمًوٌعٌة

💢- مً2🔧🔧 أّوٌأّمًر أّدٍأّرةّ أّلَمًجّـمًوٌعٌةّ
            
💢-مً أّلَمًطِوٌر🎐🎐 أّلَأّوٌأّمًر أّلَخِـأّصّـة بًأّلَمًطِوٌر
 
💢-مٌ3🔈🔇الُاوَامٌـــرَ الٌُخاصّةِ بّالُرَدِوَدِ
🎌✨🎌✨🎌✨🎌✨
💢️ #Dev @Reda999
💢️ #Bot @city5_bot
🎌🏁🎌🏁🎌🏁🎌✨
    ]]
  reply_msg(reply_id, ghost, ok_cb, false) 
end 

local reply_id = msg['id'] 
if not is_momod(msg) then 
local ghost = "فقط لُلُادِمٌنَيَةِ وَالُمٌدِرَء!" 
reply_msg(reply_id, ghost, ok_cb, false) 
end 

end 
return { 
patterns ={ 
  "^(الاوامر)$", 
}, 
run = run 
} 
end
--[[

  


                    
--]]
