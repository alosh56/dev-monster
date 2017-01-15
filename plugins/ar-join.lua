--[[ 
$ :) 
-- تم التعطيل والتعريب بواسطه @xXxDev_iqxXx

  _____              _           
|  ___|_ _  ___  __| | ___ _ __ 
| |_ / _` |/ _ \/ _` |/ _ \ '__|
|  _| (_| |  __/ (_| |  __/ |   
|_|  \__,_|\___|\__,_|\___|_|   
                    

]]-- 
local function run (msg, matches) 
local data = load_data(_config.moderation.data) 
   if matches[1] == 'chat_add_user_link' then 
        local user_id = msg.from.id 
        if data[tostring(msg.to.id)] then 
        if data[tostring(msg.to.id)]['settings'] then 
        if data[tostring(msg.to.id)]['settings']['join'] == 'yes' then 
      kick_user(user_id, msg.to.id) 
    end 
   end 
end 
 end 
 end 
return { 
  patterns = { 
    "^!!tgservice (chat_add_user_link)$" 
  }, 
  run = run 
} 
