do

local function run(msg, matches)

local reply_id = msg['id']
if is_momod(msg) and matches[1] == 'الاوامر' then 
    local ghost = [[
  🔹أهلا وسهلا 🙇🏻💕

🔹توجد ثلاثة قوائم للاوامر    

🔹تستخدم الاوامر بدون [/!#]

🔹➖🔸➖🔹➖🔸➖🔹➖🔸
🔹- م1 === اوامر ادارة المجموعة

🔹- م2 === اوامر حماية المجموعة

🔹- م المطور === الاوامر الخاصة بالمطور
🔹➖🔸➖🔹➖🔸➖🔹➖🔸
♦️ #Dev @xXxDev_iqxXx 🚴
♦️ #channel : @Team_faeder  🚴
♦️ #Bot @ll750kll_bot 🚴

    ]]
  reply_msg(reply_id, ghost, ok_cb, false) 
end 

local reply_id = msg['id'] 
if not is_momod(msg) then 
local ghost = "Only Owner 🙂❌ !" 
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
--[[ تم التعطيل والتعريب بواسطه @xXxDev_iqxXx

  _____              _           
|  ___|_ _  ___  __| | ___ _ __ 
| |_ / _` |/ _ \/ _` |/ _ \ '__|
|  _| (_| |  __/ (_| |  __/ |   
|_|  \__,_|\___|\__,_|\___|_|   
                    
--]]