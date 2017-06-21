--[[
ملاحضه الي مشتغل عده الملف
ميرفع وينزل مطور
تروح لصطر 21 تمسح ايدي القديم وتخلي ايدك
جرب الملف وشوف تم تعديل بواصطه @kasper_dev
--]]
local function getindex(t,id) 
for i,v in pairs(t) do 
if v == id then 
return i 
end 
end 
return nil 
end 
 
function reload_plugins( ) 
  plugins = {} 
  load_plugins() 
end 
   function run(msg, matches) 
    if tonumber (msg.from.id) == 189039418 then
       if matches[1]:lower() == "addsudo" or matches[1]:lower() == "اضف مطور" then 
          table.insert(_config.sudo_users, tonumber(matches[2])) 
      print(matches[2]..' تم ✅ رفعه مطور بالبوت 👤👾') 
     save_config() 
     reload_plugins(true) 
      return matches[2]..' تم ✅ رفعه مطور بالبوت 👤👾' 
   elseif matches[1]:lower() == "remsudo" or matches[1]:lower() == "حذف مطور" then 
      local k = tonumber(matches[2]) 
          table.remove(_config.sudo_users, getindex( _config.sudo_users, k)) 
      print(matches[2]..' تم ✅ تنزله مطور بالبوت 👤👾') 
     save_config() 
     reload_plugins(true) 
      return matches[2]..' تم ✅ تنزله مطور بالبوت 👤👾' 
      end 
   end 
end 
return { 
patterns = { 
"^[!/#](addsudo) (%d+)$", 
"^[!/#](remsudo) (%d+)$" 
"^[!/#](اضف مطور)  (%d+)$",
"^[!/#](حذف مطور) (%d+)$"
}, 
run = run 
}
