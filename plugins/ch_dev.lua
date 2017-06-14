--[[ 
الملف يحتوي ع 11 ملفات مدموجة سوة 
وصايرة عبارة عن سوبر كروب ؟
تقريبا للمطورين الي يفتهمون !!
وتم صنع الملف من قبل  رضا
@Reda999
بوت تواصلي 
@city5_bot
اختصرت الكم الملفات اهنا علمود ميوكف البوت بسرعة 
ولسهولة تغيير الحقوق 
]]
do
            --اتي
local function Ch_Dev(msg, matches)
local reply_id = msg[ id ]
  if matches[1] == "السورس" then
    local ii02ii = [[
يہۧعہۧمہۧل رَوَدِيَ بّوَتْ ع مہۧجہۧمہۧوعآت 5K 🌞✨

≪ تہۧم صہۧنہۧع آلہۧسِوَرَسِ مہۧن قہۧبہۧل آلہۧمہۧطوريَنَ🙁🍷 ≫
 📌🏁REDA @Reda999 📌🏁
 📌🏁team @ks_iq 📌🏁

     
  ≪مہۧعہۧرفہۧ آلہۧمہۧطہۧور 🐸🎈 ≫      🔨           @Reda999  💡
                      
    ≪بہۧوتہۧ آلہۧتہۧوآصہۧل :-*≫  
   
                                          『 @city5_bot 』

              

                                                                
]]
reply_msg(reply_id, ii02ii, ok_cb, false) 
end 

                                                   -- ملف معلومات  سيرفرك ينطيك حجم الورك وكلشي 
if is_sudo(msg) and matches[1] ==  معلومات السيرفر  then 
local text = io.popen("sh ./data/cmd.sh"):read( *all )
  return text
end


                                              -- ملف موقعي للمطور والاونر (المدير) والادمن والعضو
if is_sudo(msg) and matches[1] ==  شنو اني  then 
local text = " آنہۧتہ بہۧآبہۧآ آلہۧمہۧطہۧور  🌞✨ ".."\n".."🆔 - آيہۧديكہۧ : "..msg.from.id.."\n".."✍🏻✨ - آسہۧمہۧكہۧ : "..msg.from.first_name.."\n".." مہۧعہۧرفہۧكہۧ ↩️👲🏻  : @"..msg.from.username.."\n".."🔝 - آسہۧم آلہۧمہجہۧمہۧوعہۧةة ✅ : "..msg.to.title.."\n".. 📱 - رقہۧمہۧكہۧ 😜🙈 :  ..(msg.from.phone or "مآ مہۧحہۧتہۧرمہۧة ومہۧحہۧآفہۧظ رقہۧمہۧة ⛔️‼️")
  return reply_msg(msg.id, text, ok_cb, false) 
   end

if is_owner(msg) and matches[1] ==  شنو اني  then
        local text = " آنہۧتہ عہۧمہۧو آلہۧمہۧديہۧر  🙇🏻🍷 ".."\n".."🆔 - آيہۧديكہۧ : "..msg.from.id.."\n".."✍🏻✨ - آسہۧمہۧكہۧ : "..msg.from.first_name.."\n".." مہۧعہۧرفہۧكہۧ ↩️👲🏻  : @"..msg.from.username.."\n".."🔝 - آسہۧم آلہۧمہجہۧمہۧوعہۧةة ✅ : "..msg.to.title.."\n".. 📱 - رقہۧمہۧكہۧ 😜🙈 :  ..(msg.from.phone or "مآ مہۧحہۧتہۧرمہۧة ومہۧحہۧآفہۧظ رقہۧمہۧة ⛔️‼️")
        return reply_msg(msg.id, text, ok_cb, false) 
     end 
     
if is_momod(msg) and matches[1] ==  شنو اني  then
        local text = " آنہۧتہ بہۧن عہۧمہۧيے آلآدمہۧن  🐸🍷 ".."\n".."🆔 - آيہۧديكہۧ : "..msg.from.id.."\n".."✍🏻✨ - آسہۧمہۧكہۧ : "..msg.from.first_name.."\n".." مہۧعہۧرفہۧكہۧ ↩️👲🏻  : @"..msg.from.username.."\n".."🔝 - آسہۧم آلہۧمہجہۧمہۧوعہۧةة ✅ : "..msg.to.title.."\n".. 📱 - رقہۧمہۧكہۧ 😜🙈 :  ..(msg.from.phone or "مآ مہۧحہۧتہۧرمہۧة ومہۧحہۧآفہۧظ رقہۧمہۧة ⛔️‼️")
        return reply_msg(msg.id, text, ok_cb, false) 
     end 
     
if not is_momod(msg) and matches[1] ==  شنو اني  then
        local text = " آنہۧتہ ولہۧيہۧديے آلعہۧضہۧو   🐸🍷 ".."\n".."🆔 - آيہۧديكہۧ : "..msg.from.id.."\n".."✍🏻✨ - آسہۧمہۧكہۧ : "..msg.from.first_name.."\n".." مہۧعہۧرفہۧكہۧ ↩️👲🏻  : @"..msg.from.username.."\n".."🔝 - آسہۧم آلہۧمہجہۧمہۧوعہۧةة ✅ : "..msg.to.title.."\n".. 📱 - رقہۧمہۧكہۧ 😜🙈 :  ..(msg.from.phone or "مآ مہۧحہۧتہۧرمہۧة ومہۧحہۧآفہۧظ رقہۧمہۧة ⛔️‼️")
        return reply_msg(msg.id, text, ok_cb, false) 
     end 
-- للفوك انتهينا من ملف شنو اني 


                                                     -- ملف المطور ينادي المطور خلي ايديك ومعرفك 
  if matches[1] == "@Reda999" then -- خلي معرفك مكان معرفي
  local sudo =  189039418
  -- خلي الايدي مالتك مكان  ايديي
 local r = get_receiver(msg)
  send_large_msg(r, "آنہٰتہٰظہٰر حہٰبہٰيہٰبہٰيے 🙂⁉️هہٰسہٰه آروح آصہٰيہٰحہٰلہٰكہٰ مہٰطہٰوريے 🙊🤖")
  send_large_msg("user#id"..sudo, "📝 لہٰك آسہٰتہٰآذيے  🕵  يہٰردوكہٰ ضہٰروريے  🤖🍷\n\n ".." 👲🏻 مہٰعہٰرفہٰ آلہٰمہٰحہٰتآجہٰك  : @"..msg.from.username.."\n 🆔 آلآيہٰديے   : "..msg.from.id.."\n 📝 آسہٰم آلہٰمہٰجہٰمہٰوعہٰة  : "..msg.to.title.."\n 🆔 آيہٰديے آلہٰمہٰجہٰمہٰوعہٰة  : "..msg.from.id.. \n 🕑 آلہٰوقہٰت :  ..os.date(  %T* , os.time()).. \n 📅  آلہٰتہٰآريہٰخ  :  ..os.date( !%A, %B %d, %Y*\n , timestamp))
end

                               -- ملف الاصدار تابع لسورس رودي
                               
  if matches[1] == "الاصدار" then
        local text = " ✋🏻🤖   آلہٰسہٰورس    DevRode \n\n  🏌 آلآصہٰدآر 👲🏻 V1  \n\n⁉️🤖   مہٰوقہٰع آلہٰمہٰصہٰدر  \n \n \n\n⁉️🕵   مہٰطہٰور آلہٰسہٰورس  : @Reda999 \n\n👾   بہٰوتہٰ تہٰوآصہٰل آلہٰمہٰطہٰوريہٰن  :  @city5_bot \n \n🎸🤖   "
        return reply_msg(msg.id, text, ok_cb, false) 
     end
     
     
  if matches[1] == "معلوماتي" then          -- ملف الاينفو معلوماتي 
local memo =  🆔 - آيہۧديكہ  :  ..msg.from.id.. \n 
.. 🤖 - مہۧعہۧرفہۧكہ 🙂: @ ..msg.from.username.. \n 
.. 📝 - آسہۧمہۧكہ آلآولہۧ 🙊 :  ..(msg.from.first_name or   ).. \n 
.. 🕵 - آسہۧمہۧكہ آلہۧثہۧآنہۧيے 💋😳 :  ..(msg.from.lastname or   ).. \n 
.. 🆔 - آيہۧديے آلمہۧجہۧمہۧوعہۧةة 😉 :  ..msg.to.id.. \n 
.. 🔝 - آسہۧم آلمہۧجہۧمہۧوعہۧةة 📝 :  ..msg.to.title.. \n 
.. ⚠️ - رقہۧمہۧكہ 😜🙈 :  ..(msg.from.phone or "لآ يہٰوجہٰد ⛔️‼️".. \n 
.. 📨 - آلہۧرسہۧآيہۧلہ 📋 :  ..msg.text.. \n 
.. ⏱ - آلہۧوقہۧت  🕒:  ..os.date(  %T , os.time())).. \n 
.. 📆 - آلہۧتآريہۧخ 📅 :  .. os.date( !%A %B:%d:%Y\n , timestamp).. \n  
.."🤖 المطور 🕵 : @Reda999 🙇🏻🍷".."\n"
reply_msg(msg.id, memo, ok_cb, false)
  end
     
  if matches[1] == "كرر" then     --  هذا ملف تكرار بامر كرر + الكلام = البوت يكتبة   
local Memo = matches[2]
return Memo
end
    
  if matches[1] == "جلب ملف" then     --  هذا الملف هو يجيبلك ملف من السيرفر بدون متدخل عليه 
    local file = matches[2]
    if is_sudo(msg) then --sudo only !
      local receiver = get_receiver(msg)
      send_document(receiver, "./plugins/"..file..".lua", ok_cb, false)
      else 
        return nil
   end
end


  if matches[1] == "send" then 
    local file = matches[2] 
    if is_sudo(msg) then 
      local receiver = get_receiver(msg) 
      send_document(receiver, "./plugins/"..file..".lua", ok_cb, false) 
    end 
  end 
 
 
local reply_id = msg [ id ]             -- ملف الي يحجي ويه البوت خاص  انسخ السطر وخلي معرفك وبوت تواصل والقناة اذا عندك 
if ( msg.text ) then

  if ( msg.to.type == "user" ) then

    local text = "آهہۧلآ وسہۧهہۧلآ بہۧكہ/ي 🌞✨ @"..msg.from.username.. \n\n آنہۧتہ آلآن🏃🏻تہۧتہۧحہۧدثہ مہۧع بہۧوتہ رودي  🤖✅ \n\n لہۧلتہۧحہۧدث مہۧع آلہۧمہۧطہۧور 🕵 \n\n 🌞☄ Dev @Reda999\n\n لہۧسہۧتہ آنہۧآ آلہۧمہۧطہۧور آلہۧوحہۧيہۧد 🌚🍷\n لہۧكہۧننہۧيے آفہۧضہلہۧهم 🐸🍷 \n\n      reply_msg(reply_id, text, ok_cb, false)
 end 
 
 
  if matches[1] == "رست" and is_sudo(msg) then   -- ملف رست وحدث وريديس اذا كان البوت شغال استخدمها تفيدك  يعني اذا ساعتين وبوتك يوكف 
    return os.execute("./launch.sh"):read( *all ) -- اكتب رست قبل متصيرين ساعتين حيزيد ساعتين  
  elseif matches[1] == "حدث" and is_sudo(msg) then 
     return io.popen("git pull"):read( *all ) 
  elseif  matches[1] == "ريديس" and is_sudo(msg) then 
    return io.popen("redis-server"):read( *all ) 
  end 
end 

end
return {
  patterns = {
    "^(السورس)$",
    "^(معلومات السيرفر)$",
    "^(شنو اني)$",
    "^(@Reda999)$",
    "^(الاصدار)$",
    "^(معلوماتي)$",
    "^(كرر)(.+)",
    "^(جلب ملف) (.*)$",
    "^(send) (.*)$",
    "^(رست)$", 
    "^(حدث)$", 
    "^(ريديس)$",    
    "(.*)$",

  },
  run = Ch_Dev
}
end
--[[ 
الى كل مطور ؟
سوي هيج ملفات بس لا تنكر !
اذكر الي سواه بالاول ؟
#حبكم 
ميمو مشآكل العراقي 
@ii02ii
]]--
