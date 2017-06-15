--[[ 
-- 
             
▀▄ ▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▄▀▀▄▀▄▄▀▀▄▄▀▀▄▄▀ 
▀▄ ▄▀                                         ▀▄ ▄▀ 
▀▄ ▄▀    name : (  ⚡Rode  )                   ▀▄ ▄▀ 
▀▄ ▄▀                     ŘᎧđέ Ṭέαᵯ.          ▀▄ ▄▀ 
▀▄ ▄▀  File name : ( #ar-emoji )              ▀▄ ▄▀ 
▀▄ ▄▀            Dev: @Reda999                ▀▄ ▄▀ 
▀▄ ▄▀             Dev: @ks_iq                 ▀▄ ▄▀
▀▄ ▄▀                                         ▀▄ ▄▀ 
▀▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄▀▄▄▀▀▄▄▀▀▄▄     

]]-- 
local function run(msg, matches) 
    if is_momod(msg) then 
        return 
    end 
    local data = load_data(_config.moderation.data) 
    if data[tostring(msg.to.id)] then 
        if data[tostring(msg.to.id)]['settings'] then 
            if data[tostring(msg.to.id)]['settings']['english'] then 
                lock_english = data[tostring(msg.to.id)]['settings']['english'] 
            end 
        end 
    end 
    local chat = get_receiver(msg) 
    local user = "user#id"..msg.from.id 
    if lock_english == "yes" then 
       delete_msg(msg.id, ok_cb, true) 
    end 
end 
return { 
  patterns = { 
"[Aa](.*)", 
"[Bb](.*)", 
"[Cc](.*)", 
"[Dd](.*)", 
"[Ee](.*)", 
"[Ff](.*)", 
"[Gg](.*)", 
"[Hh](.*)", 
"[Ii](.*)", 
"[Jj](.*)", 
"[Kk](.*)", 
"[Ll](.*)", 
"[Mm](.*)", 
"[Nn](.*)", 
"[Oo](.*)", 
"[Pp](.*)", 
"[Qq](.*)", 
"[Rr](.*)", 
"[Ss](.*)", 
"[Tt](.*)", 
"[Uu](.*)", 
"[Vv](.*)", 
"[Ww](.*)", 
"[Xx](.*)", 
"[Yy](.*)", 
"[Zz](.*)", 
  }, 
  run = run 
} 


--[[ تم التعطيل والتعريب بواسطه @xXxDev_iqxXx

  _____              _           
|  ___|_ _  ___  __| | ___ _ __ 
| |_ / _` |/ _ \/ _` |/ _ \ '__|
|  _| (_| |  __/ (_| |  __/ |   
|_|  \__,_|\___|\__,_|\___|_|   
                    
--]]
