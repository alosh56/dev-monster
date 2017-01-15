--[[ 
-- تم التعطيل والتعريب بواسطه @xXxDev_iqxXx

  _____              _           
|  ___|_ _  ___  __| | ___ _ __ 
| |_ / _` |/ _ \/ _` |/ _ \ '__|
|  _| (_| |  __/ (_| |  __/ |   
|_|  \__,_|\___|\__,_|\___|_|   
                    

]]-- 
local function run(msg, matches) 
    if is_momod(msg) then 
        return 
    end 
    local data = load_data(_config.moderation.data) 
    if data[tostring(msg.to.id)] then 
        if data[tostring(msg.to.id)]['settings'] then 
            if data[tostring(msg.to.id)]['settings']['tag'] then 
                lock_tag = data[tostring(msg.to.id)]['settings']['tag'] 
            end 
        end 
    end 
    local chat = get_receiver(msg) 
    local user = "user#id"..msg.from.id 
    if lock_tag == "yes" then 
       delete_msg(msg.id, ok_cb, true) 
    end 
end 
return { 
  patterns = { 
  "#" 
  }, 
  run = run 
} 

