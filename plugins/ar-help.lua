do

local function run(msg, matches)

local reply_id = msg['id']
if is_momod(msg) and matches[1] == 'الاوامر' then 
    local ghost = [[
  🔹أهلا وسهلا 🙇🏻💕
📌 sourse dev rode 📌
🔹توجد ثلاثة قوائم للاوامر 

🔹تستخدم الاوامر بدون [/!#]

🔹➖🔸➖🔹➖🔸➖🔹➖🔸
🔹- 🔧م1 === اوامر ادارة المجموعة

🔹- 🔒م2 === اوامر حماية المجموعة

🔹- 📣م المطور === الاوامر الخاصة بالمطور
🔹➖🔸➖🔹➖🔸➖🔹➖🔸
♦️ #Dev @Reda999
♦️ #Bot @city5_bot

    ]]
  reply_msg(reply_id, ghost, ok_cb, false) 
end 

local reply_id = msg['id'] 
if not is_momod(msg) then 
local ghost = "فقط للادمنية والمدراء🙂❌ !" 
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
