--[[
--

                    

--]]
local function check_member_super(cb_extra, success, result) 
  local receiver = cb_extra.receiver 
  local data = cb_extra.data 
  local msg = cb_extra.msg 
  if success == 0 then 
   send_large_msg(receiver, "Promote me to admin first!") 
  end 
  for k,v in pairs(result) do 
    local member_id = v.peer_id 
    if member_id ~= our_id then 
      -- SuperGroup configuration 
      data[tostring(msg.to.id)] = { 
        group_type = 'SuperGroup', 
      long_id = msg.to.peer_id, 
      moderators = {}, 
        set_owner = member_id , 
        settings = { 
          set_name = string.gsub(msg.to.title, '_', ' '), 
        lock_arabic = 'no', 
        lock_link = "no", 
          flood = 'yes', 
        lock_spam = 'yes', 
        lock_sticker = 'no', 
        member = 'no', 
        public = 'no', 
        lock_rtl = 'no', 
        lock_tgservice = 'yes', 
        lock_contacts = 'no', 
        strict = 'no' 
        } 
      } 
      save_data(_config.moderation.data, data) 
      local groups = 'groups' 
      if not data[tostring(groups)] then 
        data[tostring(groups)] = {} 
        save_data(_config.moderation.data, data) 
      end 
      data[tostring(groups)][tostring(msg.to.id)] = msg.to.id 
      save_data(_config.moderation.data, data) 
     local text = '❗مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗ ف͒ہٰٰيِٰہ☠(#سٰٰٓـوِرسٰٰٓ_ديِٰـٰف͒_مـونسٰـتر)☠ٰتَہَٰمٰ̲ہ 🛃تف͒ہٰٰـ؏ۤـٰٰيِٰہٰل آلبّہوِتَہ🛄ف͒ہٰٰيِٰہ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ : '..msg.to.title..'\n  بّہوِآسٰٰٓطۨہٰٰٰ̲ھہ☑: @'..msg.from.username 
      return reply_msg(msg.id, text, ok_cb, false) 
    end 
  end 
end 

--Check Members #rem supergroup 
local function check_member_superrem(cb_extra, success, result) 
  local receiver = cb_extra.receiver 
  local data = cb_extra.data 
  local msg = cb_extra.msg 
  for k,v in pairs(result) do 
    local member_id = v.id 
    if member_id ~= our_id then 
     -- Group configuration removal 
      data[tostring(msg.to.id)] = nil 
      save_data(_config.moderation.data, data) 
      local groups = 'groups' 
      if not data[tostring(groups)] then 
        data[tostring(groups)] = nil 
        save_data(_config.moderation.data, data) 
      end 
      data[tostring(groups)][tostring(msg.to.id)] = nil 
      save_data(_config.moderation.data, data) 
     local text = '❗مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗فف͒ہٰٰيِٰہ☠(#سٰٰٓـوِرسٰٰٓ_ديِٰـٰف͒_مـونسٰـتر)☠ٰتَہَٰمٰ̲ہ 🛃تہٰٰـ؏ۤـٰٰطيِٰہٰل آلبّہوِتَہ🛄ف͒ہٰٰيِٰہ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ : '..msg.to.title..'\nبّہوِآسٰٰٓطۨہٰٰٰ̲ھہ☑: @'..msg.from.username
      return reply_msg(msg.id, text, ok_cb, false) 
    end 
  end 
end 

--Function to Add supergroup 
local function superadd(msg) 
   local data = load_data(_config.moderation.data) 
   local receiver = get_receiver(msg) 
    channel_get_users(receiver, check_member_super,{receiver = receiver, data = data, msg = msg}) 
end 

--Function to remove supergroup 
local function superrem(msg) 
   local data = load_data(_config.moderation.data) 
    local receiver = get_receiver(msg) 
    channel_get_users(receiver, check_member_superrem,{receiver = receiver, data = data, msg = msg}) 
end 

--Get and output admins and bots in supergroup 
local function callback(cb_extra, success, result) 
local i = 1 
local chat_name = string.gsub(cb_extra.msg.to.print_name, "_", " ") 
local member_type = cb_extra.member_type 
local text = member_type.." for "..chat_name..":\n" 
for k,v in pairsByKeys(result) do 
if not v.first_name then 
   name = " " 
else 
   vname = v.first_name:gsub("‮", "") 
   name = vname:gsub("_", " ") 
   end 
      text = text.."\n"..i.." - "..name.."["..v.peer_id.."]" 
      i = i + 1 
   end 
    send_large_msg(cb_extra.receiver, text) 
end 

--Get and output info about supergroup 
local function callback_info(cb_extra, success, result) 
local title ="[ معـڵـومـٱټ ⇣ ٱڵمجـمۄعة : "..result.title.."]\n\n" 
local admin_num = "✴️ - عـدِدِ الادمـنـية : "..result.admins_count.."\n" 
local user_num = "✴️ - عـدِدِ الاعـضـآء : "..result.participants_count.."\n" 
local kicked_num = "📳 - الاعـضـآء المطرودين : "..result.kicked_count.."\n" 
local channel_id = "🈸 - ايـدي ٱڵمجـمۄعة: "..result.peer_id.."\n" 
if result.username then 
   channel_username = "🈷 - مِعِـرف ٱڵمجـمۄعة : @ "..result.username.."\n" 
else 
   channel_username = "🈷 - مِعِـرف ٱڵمجـمۄعة : لا يَـوَجـدِ" 
end 
local text = title..admin_num..user_num..kicked_num..channel_id..channel_username 
    send_large_msg(cb_extra.receiver, text) 
end 

--Get and output members of supergroup 
local function callback_who(cb_extra, success, result) 
local text = "Members for "..cb_extra.receiver 
local i = 1 
for k,v in pairsByKeys(result) do 
if not v.print_name then 
   name = " " 
else 
   vname = v.print_name:gsub("‮", "") 
   name = vname:gsub("_", " ") 
end 
   if v.username then 
      username = " @"..v.username 
   else 
      username = "" 
   end 
   text = text.."\n"..i.." - "..name.." "..username.." [ "..v.peer_id.." ]\n" 
   --text = text.."\n"..username Channel : @DevPointTeam 
   i = i + 1 
end 
    local file = io.open("./groups/lists/supergroups/"..cb_extra.receiver..".txt", "w") 
    file:write(text) 
    file:flush() 
    file:close() 
    send_document(cb_extra.receiver,"./groups/lists/supergroups/"..cb_extra.receiver..".txt", ok_cb, false) 
   post_msg(cb_extra.receiver, text, ok_cb, false) 
end 

--Get and output list of kicked users for supergroup 
local function callback_kicked(cb_extra, success, result) 
--vardump(result) 
local text = "Kicked Members for SuperGroup "..cb_extra.receiver.."\n\n" 
local i = 1 
for k,v in pairsByKeys(result) do 
if not v.print_name then 
   name = " " 
else 
   vname = v.print_name:gsub("‮", "") 
   name = vname:gsub("_", " ") 
end 
   if v.username then 
      name = name.." @"..v.username 
   end 
   text = text.."\n"..i.." - "..name.." [ "..v.peer_id.." ]\n" 
   i = i + 1 
end 
    local file = io.open("./groups/lists/supergroups/kicked/"..cb_extra.receiver..".txt", "w") 
    file:write(text) 
    file:flush() 
    file:close() 
    send_document(cb_extra.receiver,"./groups/lists/supergroups/kicked/"..cb_extra.receiver..".txt", ok_cb, false) 
   --send_large_msg(cb_extra.receiver, text) 
end 

--Begin supergroup locks 
local function lock_group_ads(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_ads_lock = data[tostring(target)]['settings']['lock_ads'] 
  if group_ads_lock == 'yes' then 
   return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ ❗️ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ 🅾آلروِآبّہطۨہٰٰ بّہآلف͒ہٰٰ؏ۤـہٰٰل مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰلة🅾 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰة \n‼️🚸   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ    @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ  : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_ads'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰـبّہآ بّہڪٰྀہٰٰ ❗️ٖ ف͒ہٰٰيِٰہٰ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰــمٰ̲ہ🛃 قྀ̲ہٰٰٰف͒ہٰٰل آلروِآبّہطۨہ🛄ٰٰ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰة\n‼️🚸   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ🚹ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  end 
end 

local function unlock_group_ads(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_ads_lock = data[tostring(target)]['settings']['lock_ads'] 
  if group_ads_lock == 'no' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ ♊️آلروِآبّہطۨہٰٰ بّہآلف͒ہٰٰ؏ۤـہٰٰل مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰة♊️ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰة ٖ \n   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮   @'..msg.from.username ..'\n🆔 آيِٰہٰديِٰہٰڪٰྀہٰٰٖ : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_ads'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہ❗️ٰٰٖ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ ⚛ف͒ہٰٰتَہَٰحہٰٰ آلروِآبّہطۨہ🛃ٰٰ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰة \n‼️🚸   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ🚹ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
end 
end

local function lock_group_all(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_all_lock = data[tostring(target)]['settings']['all'] 
  if group_all_lock == 'yes' then 
    return '  ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ جْۧمٰ̲ہيِٰہٰ؏ۤـہٰٰ آلوِسٰٰٓآئطۨہٰٰ🚫 بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِلة🚫\n  بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['all'] = 'yes' 
    save_data(_config.moderation.data, data) 
   return '  ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ 📵قྀ̲ہٰٰٰف͒ہٰٰل جْۧمٰ̲ہيِٰہٰ؏ۤـہٰٰ آلوِسٰٰٓآئطۨہٰٰ📵\n  بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function unlock_group_all(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_all_lock = data[tostring(target)]['settings']['all'] 
  if group_all_lock == 'no' then 
  return '  ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ ❗️جْۧمٰ̲ہيِٰہٰ؏ۤـہٰٰ آلوِسٰٰٓآئطۨہٰٰ⛔️ بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰٰ̲ھہ⛔\n‼️🚸   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['all'] = 'no' 
    save_data(_config.moderation.data, data) 
   return ' ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ ⭕️ف͒ہٰٰتَہَٰحہٰٰ جْۧمٰ̲ہيِٰہٰ؏ۤـہٰٰ آلوِسٰٰٓآئطۨہٰٰ⭕\n‼️🚸  بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ  @'..msg.from.usernam..'\n   آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ: '..msg.from.ide
  end 
end 

local function lock_group_leave(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_leave_lock = data[tostring(target)]['settings']['leave'] 
  if group_leave_lock == 'yes' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ آلمٰ̲ہغہٰٰآدرٰ̲ھہ بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِلٰ̲ھہ\n‼️🚸    بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ  @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['leave'] = 'yes' 
    save_data(_config.moderation.data, data) 
  return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ 📴تَہَٰمٰ̲ہ قྀ̲ہٰٰٰف͒ہٰٰل آلمٰ̲ہغہٰٰآدرٰ̲ھہ⚛ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ\n‼️🚸    بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function unlock_group_leave(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_leave_lock = data[tostring(target)]['settings']['leave'] 
  if group_leave_lock == 'no' then 
    return '  ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ آلمٰ̲ہغہٰٰآدرٰ̲ھہ بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِلٰ̲ھہ\n‼️🚸   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ: '..msg.from.id
  else 
    data[tostring(target)]['settings']['leave'] = 'no' 
    save_data(_config.moderation.data, data) 
   return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ ‼️ف͒ہٰٰتَہَٰحہٰٰ آلمٰ̲ہغہٰٰآدرٰ̲ھہ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ\n‼️🚸   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.idm.id 
  end 
end 

local function lock_group_operator(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_operator_lock = data[tostring(target)]['settings']['operator'] 
  if group_operator_lock == 'yes' then 
    return 'operator is already locked 🔐\n👮 Order by :️ @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['operator'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return 'operator has been locked 🔐\n👮 Order by :️ @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function unlock_group_operator(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_operator_lock = data[tostring(target)]['settings']['operator'] 
  if group_operator_lock == 'no' then 
    return 'operator is not locked 🔓\n👮 Order by :️ @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['operator'] = 'no' 
    save_data(_config.moderation.data, data) 
    return 'operator has been unlocked 🔓\n👮 Order by :️ @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_reply(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_reply_lock = data[tostring(target)]['settings']['reply'] 
  if group_reply_lock == 'yes' then 
  return '  ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠🔇 آلردوِد غہٰٰيِٰہٰر مٰ̲ہفہٰٰ؏ۤـہٰٰلٰ̲ھہ بّہآلف͒ہٰٰ؏ۤـہٰٰل دآخٰ̐ہل آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ🔕\n  بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id.id 
  else 
    data[tostring(target)]['settings']['reply'] = 'yes' 
    save_data(_config.moderation.data, data) 
  return ' ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ 🎶آلردوِد آلآنَِٰہٰ مٰ̲ہ؏ۤـہٰٰطۨہٰٰلة دآخٰ̐ہل آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ 🔇\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function unlock_group_reply(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_reply_lock = data[tostring(target)]['settings']['reply'] 
  if group_reply_lock == 'no' then 
  return ' ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠🔊 آلردوِد تَہَٰ؏ۤـہٰٰمٰ̲ہل بّہآلف͒ہٰٰ؏ۤـہٰٰل دآخٰ̐ہل آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ✔️🔝  ☑️\n  بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['reply'] = 'no' 
    save_data(_config.moderation.data, data) 
   return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠🎶 آلردوِد آلآنَِٰہٰ تَہَٰ؏ۤـہٰٰمٰ̲ہل دآخٰ̐ہل آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ☑️\n‼️🚸   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function lock_group_username(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_username_lock = data[tostring(target)]['settings']['username'] 
  if group_username_lock == 'yes' then 
   return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ آلمٰ̲ہ؏ۤـہٰٰرف͒ہٰٰ 🔘بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِل🔘 دآخٰ̐ہل آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['username'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return ' ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ🔘 قྀ̲ہٰٰٰف͒ہٰٰل آلمٰ̲ہ؏ۤـہٰٰرف͒ہٰٰ🔘 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n  بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ  @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function unlock_group_username(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_username_lock = data[tostring(target)]['settings']['username'] 
  if group_username_lock == 'no' then 
  return ' ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ آلمٰ̲ہ؏ۤـہٰٰرف͒ہٰٰآتَہَٰ🔸 بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰٰ̲ھہ🔸 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ 🔵\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['username'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ🔹 ف͒ہٰٰتَہَٰحہٰٰ آلمٰ̲ہ؏ۤـہٰٰرف͒ہٰٰ🔹 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function lock_group_media(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_media_lock = data[tostring(target)]['settings']['media'] 
  if group_media_lock == 'yes' then 
   return ' ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ 🎶آلمٰ̲ہيِٰہٰديِٰہٰآ ➰بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِلٰ̲ھہ✖️ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ✔️\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['media'] = 'yes' 
    save_data(_config.moderation.data, data) 
  return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ➿ قྀ̲ہٰٰٰف͒ہٰٰل آلمٰ̲ہيِٰہٰديِٰہٰآ🎵 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  end 
end 

local function unlock_group_media(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_media_lock = data[tostring(target)]['settings']['media'] 
  if group_media_lock == 'no' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠🎶 آلمٰ̲ہيِٰہٰديِٰہٰآ🔹بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰٰ̲ھہ🔹 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['media'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ➿ قྀ̲ہٰٰٰف͒ہٰٰل آلمٰ̲ہيِٰہٰديِٰہٰآ🎵 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function lock_group_fosh(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_fosh_lock = data[tostring(target)]['settings']['fosh'] 
  if group_fosh_lock == 'yes' then 
  return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠♎️ آلڪٰྀہٰٰٖلمٰ̲ہآتَہَٰ آلسٰٰٓيِٰہٰئة♋️ بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِلة✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['fosh'] = 'yes' 
    save_data(_config.moderation.data, data) 
  return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ 🔘قྀ̲ہٰٰٰف͒ہٰٰل آلڪٰྀہٰٰٖلمٰ̲ہآتَہَٰ آلسٰٰٓيِٰہٰئة🔚 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function unlock_group_fosh(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_fosh_lock = data[tostring(target)]['settings']['fosh'] 
  if group_fosh_lock == 'no' then 
   return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠➿ آلڪٰྀہٰٰٖلمٰ̲ہآتَہَٰ آلسٰٰٓيِٰہٰئٰ̲ھہ➿ بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ    @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['fosh'] = 'no' 
    save_data(_config.moderation.data, data) 
   return ' ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ🔛 ف͒ہٰٰتَہَٰحہٰٰ آلڪٰྀہٰٰٖلمٰ̲ہآتَہَٰ آلسٰٰٓيِٰہٰئٰ̲ھہ🔘 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ✔️\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function lock_group_join(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_join_lock = data[tostring(target)]['settings']['join'] 
  if group_join_lock == 'yes' then 
   return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ 🔹آلدخٰ̐ہوِل بّہآلرآبّہطۨہٰٰ🔹بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِلٰ̲ھہ ✔\nبّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['join'] = 'yes' 
    save_data(_config.moderation.data, data) 
   return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ 🔘قྀ̲ہٰٰٰف͒ہٰٰل آلدخٰ̐ہوِل بّہآلرآبّہطۨہٰٰ🔘ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔️\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  end 
end 

local function unlock_group_join(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_join_lock = data[tostring(target)]['settings']['join'] 
  if group_join_lock == 'no' then 
   return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ 🔹آلدخٰ̐ہوِل بّہآلرآبّہطۨہٰٰ🔹بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰٰ̲ھہ ✔️\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ  @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id
  else 
    data[tostring(target)]['settings']['join'] = 'no' 
    save_data(_config.moderation.data, data) 
    return ' ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ 🔛 ف͒ہٰٰتَہَٰحہٰٰ آلدخٰ̐ہوِل بّہآلرآبّہطۨہٰٰ🔹 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.i
  end 
end 

local function lock_group_fwd(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_fwd_lock = data[tostring(target)]['settings']['fwd'] 
  if group_fwd_lock == 'yes' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ ♊️ألتَہَٰوِجْۧيِٰہٰٰ̲ھہ بّہآلف͒ہٰٰ؏ۤـہٰٰل مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِلٰ̲ھہ♊️ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰة \nبّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👨‍🔧ٰٰٖ  @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ: '..msg.from.id 
  else 
    data[tostring(target)]['settings']['fwd'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ ♊️تَہَٰمٰ̲ہ قྀ̲ہٰٰٰف͒ہٰٰل آلتَہَٰوِجْۧيِٰہٰٰ̲ھہ♊️ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰة \nبّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  end 
end 

local function unlock_group_fwd(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_fwd_lock = data[tostring(target)]['settings']['fwd'] 
  if group_fwd_lock == 'no' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ ♊️آلتَہَٰوِجْۧيِٰہٰٰ̲ھہ بّہآلف͒ہٰٰ؏ۤـہٰٰل مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰ♊️ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰة \n‼️🚸   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ    @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ  : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['fwd'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ ♊️تَہَٰمٰ̲ہ ف͒ہٰٰتَہَٰحہٰٰ آلتَہَٰوِجْۧيِٰہٰٰ̲ھہ♊️ ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰة \n‼️🚸   بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ    @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ  : '..msg.from.id 
  end 
end 

local function lock_group_english(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_english_lock = data[tostring(target)]['settings']['english'] 
  if group_english_lock == 'yes' then 
    return '❗️☻ ٱڵـغة الانكليزية بٲڵـتاكيد مۘقفولة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['english'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم قفـڵ ٱڵـغة الانكليزية\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function unlock_group_english(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_english_lock = data[tostring(target)]['settings']['english'] 
  if group_english_lock == 'no' then 
    return '❗️☻ ٱڵـغة الانكليزية بٲڵـتاكيد مۘفتوحة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['english'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم فـتـۧح ٱڵـغة الانكليزية\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_emoji(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_emoji_lock = data[tostring(target)]['settings']['emoji'] 
  if group_emoji_lock == 'yes' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠🔗 آلسٰٰٓمٰ̲ہآيِٰہٰلآتَہَٰ بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِلٰ̲ھہ ✔️\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['emoji'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return ' ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ 🔹قྀ̲ہٰٰٰف͒ہٰٰل آلسٰٰٓمٰ̲ہآيِٰہٰلآتَہَٰ⛓🔹 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ: '..msg.from.id 
  end 
end 

local function unlock_group_emoji(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_emoji_lock = data[tostring(target)]['settings']['emoji'] 
  if group_emoji_lock == 'no' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠➰ آلسٰٰٓمٰ̲ہآيِٰہٰلآتَہَٰ بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد ➰مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰٰ̲ھہ ✔️\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ: '..msg.from.id 
  else 
    data[tostring(target)]['settings']['emoji'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰـمٰ̲ہ 🔹ف͒ہٰٰتَہَٰحہٰٰ آلسٰٰٓمٰ̲ہآيِٰہٰلآتَہَٰ🔸 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ✔️\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  end 
end 

local function lock_group_tag(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_tag_lock = data[tostring(target)]['settings']['tag'] 
  if group_tag_lock == 'yes' then 
    return '  ❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ آلــ#ـتَہَٰآڪٰྀہٰٰٖ بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِل ✔\nبّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ  @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['tag'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠🔶 تَہَٰمٰ̲ہ قྀ̲ہٰٰٰف͒ہٰٰل آلتَہَٰـ#ـآڪٰྀہٰٰٖ🔷 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\n آيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  end 
end 

local function unlock_group_tag(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_tag_lock = data[tostring(target)]['settings']['tag'] 
  if group_tag_lock == 'no' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ آلتَہَٰـ#ـآڪٰྀہٰٰٖ بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['tag'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ 🔹ف͒ہٰٰتَہَٰحہٰٰ آلــ#ـتَہَٰآڪٰྀہٰٰٖ 🔸ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  end 
end 

local function unlock_group_all(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_all_lock = data[tostring(target)]['settings']['all'] 
  if group_all_lock == 'no' then 
    return '❗️☻ جـمـيع ٱڵـوسـآئط بٱڵـتٱكيد مۘفتوحة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['all'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم فـتـۧح جـمـيع ٱڵـوسـآئط\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_spam(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  if not is_owner(msg) then 
    return "للمشرفين فقط ⛔️😴✋🏿" 
  end 
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam'] 
  if group_spam_lock == 'yes' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ آلڪٰྀہٰٰٖلآيِٰہٰشِٰہٰٰ 🕹بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہقྀ̲ہٰٰٰف͒ہٰٰوِلٰ̲ھہ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ  @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_spam'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ 🕹قྀ̲ہٰٰٰف͒ہٰٰل آلڪٰྀہٰٰٖلآيِٰہٰشِٰہٰٰ🎈 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ  @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  end 
end 

local function unlock_group_spam(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_spam_lock = data[tostring(target)]['settings']['lock_spam'] 
  if group_spam_lock == 'no' then 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ آلڪٰྀہٰٰٖلآيِٰہٰشِٰہٰٰ 🖲بّہآلتَہَٰآڪٰྀہٰٰٖيِٰہٰد مٰ̲ہف͒ہٰٰتَہَٰوِحہٰٰٰ̲ھہ✔\nبّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_spam'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️مٰ̲ہرحہٰٰبّہآ بّہڪٰྀہٰٰٖ❗️ ف͒ہٰٰيِٰہٰ ☠(#سٰٰٓوِرسٰٰٓ_ديِٰہٰف͒ہٰٰ_مٰ̲ہوِنَِٰہٰسٰٰٓتَہَٰر)☠ تَہَٰمٰ̲ہ 🖲ف͒ہٰٰتَہَٰحہٰٰ آلڪٰྀہٰٰٖلآيِٰہٰشِٰہٰٰ🎈 ف͒ہٰٰيِٰہٰ آلمٰ̲ہجْۧمٰ̲ہوِ؏ۤـہٰٰٰ̲ھہ ✔\n  بّہوِآسٰٰٓطۨہٰٰتَہَٰڪٰྀہ👮ٰٰٖ   @'..msg.from.username ..'\nآيِٰہٰديِٰہٰڪٰྀہٰٰ🆔ٖ : '..msg.from.id 
  end 
end 

local function lock_group_flood(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_flood_lock = data[tostring(target)]['settings']['flood'] 
  if group_flood_lock == 'yes' then 
    return '❗️☻ ٱڵـتْكِرَارَ بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['flood'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم قفـڵ ٱڵـتْكِرَارَ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function unlock_group_flood(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_flood_lock = data[tostring(target)]['settings']['flood'] 
  if group_flood_lock == 'no' then 
    return '❗️☻ ٱڵـتْكِرَارَ بٱڵفعـل مۧفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['flood'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم فـتـۧح ٱڵـتْكِرَارَ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_arabic(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic'] 
  if group_arabic_lock == 'yes' then 
    return '❗️☻ ٱڵـغة الْعرَبّيَُه بٲڵـتاكيد مۘقفولة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_arabic'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم قفـڵ ٱڵـغة الْعرَبّيَةِ\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function unlock_group_arabic(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_arabic_lock = data[tostring(target)]['settings']['lock_arabic'] 
  if group_arabic_lock == 'no' then 
    return '❗️☻ ٱڵـغة الْعرَبّيَةِ بٲڵـتاكيد مۘفتوحة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_arabic'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم فـتـۧح ٱڵـغة الْعرَبّيَةِ\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_membermod(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_member_lock = data[tostring(target)]['settings']['lock_member'] 
  if group_member_lock == 'yes' then 
    return '❗️☻ اضُافَةِ الُاْعضُاء بٲڵـتاكيد مۘقفولة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_member'] = 'yes' 
    save_data(_config.moderation.data, data) 
  end 
  return '❗️☻ تـۖم قفـڵ ٱضُافَةِ الُاْعضُاءِ\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
end 

local function unlock_group_membermod(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_member_lock = data[tostring(target)]['settings']['lock_member'] 
  if group_member_lock == 'no' then 
    return '❗️☻ ٱضُافَةِ الُاْعضُاءِ بٲڵـتاكيد مۘفتوحة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_member'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم فـتـۧح ٱضُافَةِ الُاْعضُاء\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_rtl(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl'] 
  if group_rtl_lock == 'yes' then 
    return '❗️☻ ٱڵـرتـل بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_rtl'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم قفـڵ ٱڵـرتـل فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function unlock_group_rtl(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_rtl_lock = data[tostring(target)]['settings']['lock_rtl'] 
  if group_rtl_lock == 'no' then 
    return '❗️☻ ٱڵـرتـل بٱڵفعـل مۧفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_rtl'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم فـتـۧح ٱڵـرتـل فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_tgservice(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice'] 
  if group_tgservice_lock == 'yes' then 
    return '❗️☻ ٱشعـآرآت ٱڵدخول بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_tgservice'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم قفـڵ ٱشعـآرآت ٱڵدخول\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function unlock_group_tgservice(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_tgservice_lock = data[tostring(target)]['settings']['lock_tgservice'] 
  if group_tgservice_lock == 'no' then 
    return '❗️☻ ٱشعـآرآت ٱڵدخول بٱڵتٲكيد مۘفتوحة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_tgservice'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم فـتـۧح ٱشعـآرآت ٱڵدخول\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_sticker(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker'] 
  if group_sticker_lock == 'yes' then 
    return '❗️☻ ٱڵـملصقاټ بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_sticker'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم قفـڵ ٱڵـملصقاټ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function unlock_group_sticker(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_sticker_lock = data[tostring(target)]['settings']['lock_sticker'] 
  if group_sticker_lock == 'no' then 
    return '❗️☻ ٱڵـملصقاټ بٱڵفعـل مۧفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_sticker'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم فـتـۧح ٱڵـملصقاټ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_bots(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots'] 
  if group_bots_lock == 'yes' then 
    return '❗️☻ ٱڵـبوتاټ بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_bots'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم قفـڵ ٱڵـبوتاټ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function unlock_group_bots(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_bots_lock = data[tostring(target)]['settings']['lock_bots'] 
  if group_bots_lock == 'no' then 
    return '❗️☻ ٱڵـبوتاټ بٱڵفعـل مۘفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_bots'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️☻ تـۖم فـتـۧح ٱڵـبوتاټ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function lock_group_contacts(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts'] 
  if group_contacts_lock == 'yes' then 
    return '📵❗️ جـهـاة الاتـصـال بٱڵفعل مۘقفلة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_contacts'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '📵❗️ تـۖم قفـۧل جـﮩـهـﮩـاة الاتـصـال\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function unlock_group_contacts(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_contacts_lock = data[tostring(target)]['settings']['lock_contacts'] 
  if group_contacts_lock == 'no' then 
    return '📵❗️ جـهـاة الاتصال بٱڵفعل مۘفتوحة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['lock_contacts'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '📵❗️ تـۖم فـتـۧح جـﮩـهـﮩـاة الاتـصـال\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function enable_strict_rules(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_strict_lock = data[tostring(target)]['settings']['strict'] 
  if group_strict_lock == 'yes' then 
    return '❗️🛡 ٱڵحمايۧة بـٱڵـتٲكيـد مۘفعلـة \n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['strict'] = 'yes' 
    save_data(_config.moderation.data, data) 
    return '❗️🛡 تـۖم تفعيل ٱڵحمايۧة فيۧ ٱڵمجمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 

local function disable_strict_rules(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_strict_lock = data[tostring(target)]['settings']['strict'] 
  if group_strict_lock == 'no' then 
    return '❗️🛡 ٱڵحمايۧة بـٱڵـتٲكيـد مۘعطلـة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  else 
    data[tostring(target)]['settings']['strict'] = 'no' 
    save_data(_config.moderation.data, data) 
    return '❗️🛡 تـۖم تعطيل ٱڵحمايۧة فيۧ ٱڵمجمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
  end 
end 
--End supergroup locks 

--'Set supergroup rules' function 
local function set_rulesmod(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local data_cat = 'rules' 
  data[tostring(target)][data_cat] = rules 
  save_data(_config.moderation.data, data) 
  return '🚸❗️ تـۖم اضافـة قوانين ڵڵـمجـمۄعة' 
end 

--'Get supergroup rules' function 
local function get_rules(msg, data) 
  local data_cat = 'rules' 
  if not data[tostring(msg.to.id)][data_cat] then 
    return '⛔️❗️ لايوجد قوانين فيۧ ٱڵمجـمۄعة' 
  end 
  local rules = data[tostring(msg.to.id)][data_cat] 
  local group_name = data[tostring(msg.to.id)]['settings']['set_name'] 
  local rules = group_name..' قوانين ٱڵمجـمۄعة:\n\n'..rules:gsub("/n", " ") 
  return rules 
end 

--Set supergroup to public or not public function 
local function set_public_membermod(msg, data, target) 
  if not is_momod(msg) then 
    return "للمشرفين فقط ⛔️😴✋🏿" 
  end 
  local group_public_lock = data[tostring(target)]['settings']['public'] 
  local long_id = data[tostring(target)]['long_id'] 
  if not long_id then 
   data[tostring(target)]['long_id'] = msg.to.peer_id 
   save_data(_config.moderation.data, data) 
  end 
  if group_public_lock == 'yes' then 
    return 'Group is already public' 
  else 
    data[tostring(target)]['settings']['public'] = 'yes' 
    save_data(_config.moderation.data, data) 
  end 
  return 'SuperGroup is now: public' 
end 

local function unset_public_membermod(msg, data, target) 
  if not is_momod(msg) then 
    return 
  end 
  local group_public_lock = data[tostring(target)]['settings']['public'] 
  local long_id = data[tostring(target)]['long_id'] 
  if not long_id then 
   data[tostring(target)]['long_id'] = msg.to.peer_id 
   save_data(_config.moderation.data, data) 
  end 
  if group_public_lock == 'no' then 
    return 'Group is not public' 
  else 
    data[tostring(target)]['settings']['public'] = 'no' 
   data[tostring(target)]['long_id'] = msg.to.long_id 
    save_data(_config.moderation.data, data) 
    return 'SuperGroup is now: not public' 
  end 
end 

--Show supergroup settings; function 
function show_supergroup_settingsmod(msg, target) 
    if not is_momod(msg) then 
       return 
     end 
   local data = load_data(_config.moderation.data) 
    if data[tostring(target)] then 
        if data[tostring(target)]['settings']['flood_msg_max'] then 
           NUM_MSG_MAX = tonumber(data[tostring(target)]['settings']['flood_msg_max']) 
           print('custom'..NUM_MSG_MAX) 
         else 
           NUM_MSG_MAX = 5 
         end 
    end 
    local bots_protection = "Yes" 
    if data[tostring(target)]['settings']['lock_bots'] then 
       bots_protection = data[tostring(target)]['settings']['lock_bots'] 
      end 
   if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['public'] then 
         data[tostring(target)]['settings']['public'] = 'no' 
      end 
   end 
   if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['lock_rtl'] then 
         data[tostring(target)]['settings']['lock_rtl'] = 'no' 
      end 
        end 
      if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['lock_tgservice'] then 
         data[tostring(target)]['settings']['lock_tgservice'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['tag'] then 
         data[tostring(target)]['settings']['tag'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['emoji'] then 
         data[tostring(target)]['settings']['emoji'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['english'] then 
         data[tostring(target)]['settings']['english'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['fwd'] then 
         data[tostring(target)]['settings']['fwd'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['reply'] then 
         data[tostring(target)]['settings']['reply'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['join'] then 
         data[tostring(target)]['settings']['join'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['fosh'] then 
         data[tostring(target)]['settings']['fosh'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['username'] then 
         data[tostring(target)]['settings']['username'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['media'] then 
         data[tostring(target)]['settings']['media'] = 'no' 
      end 
   end 
     if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['leave'] then 
         data[tostring(target)]['settings']['leave'] = 'no' 
      end 
   end 
   if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['lock_member'] then 
         data[tostring(target)]['settings']['lock_member'] = 'no' 
      end 
   end 
   if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['all'] then 
         data[tostring(target)]['settings']['all'] = 'no' 
      end 
   end 
   if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['operator'] then 
         data[tostring(target)]['settings']['operator'] = 'no' 
      end 
   end 
   if data[tostring(target)]['settings'] then 
      if not data[tostring(target)]['settings']['etehad'] then 
         data[tostring(target)]['settings']['etehad'] = 'no' 
      end 
   end 
  local gp_type = data[tostring(msg.to.id)]['group_type'] 
  local settings = data[tostring(target)]['settings'] 
  local text = "️SuperGroups Settings: ⇣ ⇣\n☻Group name : "..msg.to.title.."\n〰➖〰➖〰➖〰➖〰\n🔗 links : "..settings.lock_link.."\n🔐 flood: "..settings.flood.."\n👾Flood sensitivity : "..NUM_MSG_MAX.."\n📊 spam: "..settings.lock_spam.."\n👤 Member: "..settings.lock_member.."\n🎡 sticker: "..settings.lock_sticker.."\n🤖 bots: "..bots_protection.."\n↩️ fwd(forward): "..settings.fwd.."\n🏧 badword: "..settings.fosh.."\n🚶 leave: "..settings.leave.."\n🔕 all: "..settings.all.."\n〰➖〰➖〰➖〰➖〰\n️About Group: ↯️\n〰➖〰➖〰➖〰➖〰\nGroup type: "..gp_type.."\n✳️Public: "..settings.public.."\n⛔️Strict settings: "..settings.strict.."\n〰➖〰➖〰➖〰➖〰\n\n🔱 channel bot :- @MUSIC_TEXAS 🔊" 
  return text 
end 

local function promote_admin(receiver, member_username, user_id) 
  local data = load_data(_config.moderation.data) 
  local group = string.gsub(receiver, 'channel#id', '') 
  local member_tag_username = string.gsub(member_username, '@', '(at)') 
  if not data[group] then 
    return 
  end 
  if data[group]['moderators'][tostring(user_id)] then 
    return send_large_msg(receiver, member_username..' ⛔️❗️ هـذا الشـخـص بـٱڵـتٲكيد ادمـۧن') 
  end 
  data[group]['moderators'][tostring(user_id)] = member_tag_username 
  save_data(_config.moderation.data, data) 
end 

local function demote_admin(receiver, member_username, user_id) 
  local data = load_data(_config.moderation.data) 
  local group = string.gsub(receiver, 'channel#id', '') 
  if not data[group] then 
    return 
  end 
  if not data[group]['moderators'][tostring(user_id)] then 
    return send_large_msg(receiver, member_tag_username..' ⛔️❗️ هـذا الشـخـص ڵـيس ادمـۧن') 
  end 
  data[group]['moderators'][tostring(user_id)] = nil 
  save_data(_config.moderation.data, data) 
end 

local function promote2(receiver, member_username, user_id) 
  local data = load_data(_config.moderation.data) 
  local group = string.gsub(receiver, 'channel#id', '') 
  local member_tag_username = string.gsub(member_username, '@', '(at)') 
  if not data[group] then 
    return send_large_msg(receiver, 'SuperGroup is not added.') 
  end 
  if data[group]['moderators'][tostring(user_id)] then 
    return send_large_msg(receiver, member_username..' ⛔️❗️ هـذا الشـخـص بـٱڵـتٲكيد ادمـۧن.') 
  end 
  data[group]['moderators'][tostring(user_id)] = member_tag_username 
  save_data(_config.moderation.data, data) 
  send_large_msg(receiver, member_username..' ⚜ تـۖم رفـعـك ٲدمـن فيۧ ٱڵمجـمۄعة.') 
end 

local function demote2(receiver, member_username, user_id) 
  local data = load_data(_config.moderation.data) 
  local group = string.gsub(receiver, 'channel#id', '') 
  if not data[group] then 
    return send_large_msg(receiver, 'Group is not added.') 
  end 
  if not data[group]['moderators'][tostring(user_id)] then 
    return send_large_msg(receiver, member_tag_username..' ⛔️❗️ هـذا الشـخـص ڵـيس ادمـۧن.') 
  end 
  data[group]['moderators'][tostring(user_id)] = nil 
  save_data(_config.moderation.data, data) 
  send_large_msg(receiver, member_username..' ⛔️❗️ تـۖم تـنـزيڵ ٲدمـن مـۧن ٱڵمجـمۄعة') 
end 

local function modlist(msg) 
  local data = load_data(_config.moderation.data) 
  local groups = "groups" 
  if not data[tostring(groups)][tostring(msg.to.id)] then 
    return 'SuperGroup is not added.' 
  end 
  -- determine if table is empty 
  if next(data[tostring(msg.to.id)]['moderators']) == nil then 
    return '⛔️❗️ لايوجد ادمنية فيۧ ٱڵمجـمۄعة' 
  end 
  local i = 1 
  local message = '\nList of moderators for ' .. string.gsub(msg.to.print_name, '_', ' ') .. ':\n' 
  for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do 
    message = message ..i..' - '..v..' [' ..k.. '] \n' 
    i = i + 1 
  end 
  return message 
end 

-- Start by reply actions 
function get_message_callback(extra, success, result) 
   local get_cmd = extra.get_cmd 
   local msg = extra.msg 
   local data = load_data(_config.moderation.data) 
   local print_name = user_print_name(msg.from):gsub("‮", "") 
   local name_log = print_name:gsub("_", " ") 
    if get_cmd == "id" and not result.action then 
      local channel = 'channel#id'..result.to.peer_id 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id for: ["..result.from.peer_id.."]") 
      id1 = send_large_msg(channel, result.from.peer_id) 
   elseif get_cmd == 'id' and result.action then 
      local action = result.action.type 
      if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then 
         if result.action.user then 
            user_id = result.action.user.peer_id 
         else 
            user_id = result.peer_id 
         end 
         local channel = 'channel#id'..result.to.peer_id 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id by service msg for: ["..user_id.."]") 
         id1 = send_large_msg(channel, user_id) 
      end 
    elseif get_cmd == "idfrom" then 
      local channel = 'channel#id'..result.to.peer_id 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] obtained id for msg fwd from: ["..result.fwd_from.peer_id.."]") 
      id2 = send_large_msg(channel, result.fwd_from.peer_id) 
    elseif get_cmd == 'channel_block' and not result.action then 
      local member_id = result.from.peer_id 
      local channel_id = result.to.peer_id 
    if member_id == msg.from.id then 
      return send_large_msg("channel#id"..channel_id, "Leave using kickme command") 
    end 
    if is_momod2(member_id, channel_id) and not is_admin2(msg.from.id) then 
            return send_large_msg("channel#id"..channel_id, "⛔️❗️لُايَحق لك طړډ (ٱلٲدمنية|ٱڵمدير).") 
    end 
    if is_admin2(member_id) then 
         return send_large_msg("channel#id"..channel_id, "⛔���❗️لُايَحق لك طړډ (ٱلٲدمنية|ٱڵمدير).") 
    end 
      --savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..user_id.."] by reply") 
      kick_user(member_id, channel_id) 
   elseif get_cmd == 'channel_block' and result.action and result.action.type == 'chat_add_user' then 
      local user_id = result.action.user.peer_id 
      local channel_id = result.to.peer_id 
    if member_id == msg.from.id then 
      return send_large_msg("channel#id"..channel_id, "Leave using kickme command") 
    end 
    if is_momod2(member_id, channel_id) and not is_admin2(msg.from.id) then 
            return send_large_msg("channel#id"..channel_id, "⛔️❗️لُايَحق لك طړډ (ٱلٲدمنية|ٱڵمدير).") 
    end 
    if is_admin2(member_id) then 
         return send_large_msg("channel#id"..channel_id, "⛔️❗️لُايَحق لك طړډ (ٱلٲدمنية|ٱڵمدير).") 
    end 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..user_id.."] by reply to sev. msg.") 
      kick_user(user_id, channel_id) 
   elseif get_cmd == "del" then 
      delete_msg(result.id, ok_cb, false) 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] deleted a message by reply") 
   elseif get_cmd == "setadmin" then 
      local user_id = result.from.peer_id 
      local channel_id = "channel#id"..result.to.peer_id 
      channel_set_admin(channel_id, "user#id"..user_id, ok_cb, false) 
      if result.from.username then 
         text = "@"..result.from.username.." ⚜ تـۖم رفـعـك ٲدآري فيۧ ٱڵمجـمۄعة" 
      else 
         text = "[ "..user_id.." ] ⚜ تـۖم رفـعـك ٲدآري فيۧ ٱڵمجـمۄعة" 
      end 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] set: ["..user_id.."] as admin by reply") 
      send_large_msg(channel_id, text) 
   elseif get_cmd == "demoteadmin" then 
      local user_id = result.from.peer_id 
      local channel_id = "channel#id"..result.to.peer_id 
      if is_admin2(result.from.peer_id) then 
         return send_large_msg(channel_id, "⛔️❗️لُايَحق لك تنزيل (ٱلٲدمنية|ٱڵمدير).") 
      end 
      channel_demote(channel_id, "user#id"..user_id, ok_cb, false) 
      if result.from.username then 
         text = "@"..result.from.username.." ⚜ تـۖم تـنـزيڵ ٲدآري مـۧن ٱڵمجـمۄعة" 
      else 
         text = "[ "..user_id.." ] ⚜ تـۖم تـنـزيڵ ٲدآري مـۧن ٱڵمجـمۄعة" 
      end 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted: ["..user_id.."] from admin by reply") 
      send_large_msg(channel_id, text) 
   elseif get_cmd == "setowner" then 
      local group_owner = data[tostring(result.to.peer_id)]['set_owner'] 
      if group_owner then 
      local channel_id = 'channel#id'..result.to.peer_id 
         if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then 
            local user = "user#id"..group_owner 
            channel_demote(channel_id, user, ok_cb, false) 
         end 
         local user_id = "user#id"..result.from.peer_id 
         channel_set_admin(channel_id, user_id, ok_cb, false) 
         data[tostring(result.to.peer_id)]['set_owner'] = tostring(result.from.peer_id) 
         save_data(_config.moderation.data, data) 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] set: ["..result.from.peer_id.."] as owner by reply") 
         if result.from.username then 
            text = "@"..result.from.username.." [ "..result.from.peer_id.." ] ⚜ تـۖم رفـعـك مـډيـر ٱڵمجـمۄعة ." 
         else 
            text = "[ "..result.from.peer_id.." ] ⚜ تـۖم رفـعـك مـډيـر ٱڵمجـمۄعة " 
         end 
         send_large_msg(channel_id, text) 
      end 
   elseif get_cmd == "promote" then 
      local receiver = result.to.peer_id 
      local full_name = (result.from.first_name or '')..' '..(result.from.last_name or '') 
      local member_name = full_name:gsub("‮", "") 
      local member_username = member_name:gsub("_", " ") 
      if result.from.username then 
         member_username = '@'.. result.from.username 
      end 
      local member_id = result.from.peer_id 
      if result.to.peer_type == 'channel' then 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted mod: @"..member_username.."["..result.from.peer_id.."] by reply") 
      promote2("channel#id"..result.to.peer_id, member_username, member_id) 
       --channel_set_mod(channel_id, user, ok_cb, false) 
      end 
   elseif get_cmd == "demote" then 
      local full_name = (result.from.first_name or '')..' '..(result.from.last_name or '') 
      local member_name = full_name:gsub("‮", "") 
      local member_username = member_name:gsub("_", " ") 
    if result.from.username then 
      member_username = '@'.. result.from.username 
    end 
      local member_id = result.from.peer_id 
      --local user = "user#id"..result.peer_id 
      savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted mod: @"..member_username.."["..result.from.peer_id.."] by reply") 
      demote2("channel#id"..result.to.peer_id, member_username, member_id) 
      --channel_demote(channel_id, user, ok_cb, false) 
   elseif get_cmd == 'mute_user' then 
      if result.service then 
         local action = result.action.type 
         if action == 'chat_add_user' or action == 'chat_del_user' or action == 'chat_rename' or action == 'chat_change_photo' then 
            if result.action.user then 
               user_id = result.action.user.peer_id 
            end 
         end 
         if action == 'chat_add_user_link' then 
            if result.from then 
               user_id = result.from.peer_id 
            end 
         end 
      else 
         user_id = result.from.peer_id 
      end 
      local receiver = extra.receiver 
      local chat_id = msg.to.id 
      print(user_id) 
      print(chat_id) 
      if is_muted_user(chat_id, user_id) then 
         unmute_user(chat_id, user_id) 
         send_large_msg(receiver, "["..user_id.."] removed from the muted user list") 
      elseif is_admin1(msg) then 
         mute_user(chat_id, user_id) 
         send_large_msg(receiver, " ["..user_id.."] added to the muted user list") 
      end 
   end 
end 
-- End by reply actions 

--By ID actions 
local function cb_user_info(extra, success, result) 
   local receiver = extra.receiver 
   local user_id = result.peer_id 
   local get_cmd = extra.get_cmd 
   local data = load_data(_config.moderation.data) 
   --[[if get_cmd == "setadmin" then 
      local user_id = "user#id"..result.peer_id 
      channel_set_admin(receiver, user_id, ok_cb, false) 
      if result.username then 
         text = "@"..result.username.." has been set as an admin" 
      else 
         text = "[ "..result.peer_id.." ] has been set as an admin" 
      end 
         send_large_msg(receiver, text)]] 
   if get_cmd == "demoteadmin" then 
      if is_admin2(result.peer_id) then 
         return send_large_msg(receiver, "⛔️❗️لُايَحق لك تنزيل (ٱلٲدمنية|ٱڵمدير).") 
      end 
      local user_id = "user#id"..result.peer_id 
      channel_demote(receiver, user_id, ok_cb, false) 
      if result.username then 
         text = "@"..result.username.. " ⚜ تـۖم تـنـزيڵ ٲدآري مـۧن ٱڵمجـمۄعة" 
         send_large_msg(receiver, text) 
      else 
         text = "[ "..result.peer_id.." ] ⚜ تـۖم تـنـزيڵ ٲدآري مـۧن ٱڵمجـمۄعة" 
         send_large_msg(receiver, text) 
      end 
   elseif get_cmd == "promote" then 
      if result.username then 
         member_username = "@"..result.username 
      else 
         member_username = string.gsub(result.print_name, '_', ' ') 
      end 
      promote2(receiver, member_username, user_id) 
   elseif get_cmd == "demote" then 
      if result.username then 
         member_username = "@"..result.username 
      else 
         member_username = string.gsub(result.print_name, '_', ' ') 
      end 
      demote2(receiver, member_username, user_id) 
   end 
end 

-- Begin resolve username actions 
local function callbackres(extra, success, result) 
  local member_id = result.peer_id 
  local member_username = "@"..result.username 
  local get_cmd = extra.get_cmd 
   if get_cmd == "res" then 
      local user = result.peer_id 
      local name = string.gsub(result.print_name, "_", " ") 
      local channel = 'channel#id'..extra.channelid 
      send_large_msg(channel, user..'\n'..name) 
      return user 
   elseif get_cmd == "id" then 
      local user = result.peer_id 
      local channel = 'channel#id'..extra.channelid 
      send_large_msg(channel, user) 
      return user 
  elseif get_cmd == "invite" then 
    local receiver = extra.channel 
    local user_id = "user#id"..result.peer_id 
    channel_invite(receiver, user_id, ok_cb, false) 
   --[[elseif get_cmd == "channel_block" then 
      local user_id = result.peer_id 
      local channel_id = extra.channelid 
    local sender = extra.sender 
    if member_id == sender then 
      return send_large_msg("channel#id"..channel_id, "Leave using kickme command") 
    end 
      if is_momod2(member_id, channel_id) and not is_admin2(sender) then 
            return send_large_msg("channel#id"..channel_id, "You can't kick mods/owner/admins") 
    end 
    if is_admin2(member_id) then 
         return send_large_msg("channel#id"..channel_id, "You can't kick other admins") 
    end 
      kick_user(user_id, channel_id) 
   elseif get_cmd == "setadmin" then 
      local user_id = "user#id"..result.peer_id 
      local channel_id = extra.channel 
      channel_set_admin(channel_id, user_id, ok_cb, false) 
      if result.username then 
         text = "@"..result.username.." has been set as an admin" 
         send_large_msg(channel_id, text) 
      else 
         text = "@"..result.peer_id.." has been set as an admin" 
         send_large_msg(channel_id, text) 
      end 
      elseif Dev = @IQ_ABS 
   elseif get_cmd == "setowner" then 
      local receiver = extra.channel 
      local channel = string.gsub(receiver, 'channel#id', '') 
      local from_id = extra.from_id 
      local group_owner = data[tostring(channel)]['set_owner'] 
      if group_owner then 
         local user = "user#id"..group_owner 
         if not is_admin2(group_owner) and not is_support(group_owner) then 
            channel_demote(receiver, user, ok_cb, false) 
         end 
         local user_id = "user#id"..result.peer_id 
         channel_set_admin(receiver, user_id, ok_cb, false) 
         data[tostring(channel)]['set_owner'] = tostring(result.peer_id) 
         save_data(_config.moderation.data, data) 
         savelog(channel, name_log.." ["..from_id.."] set ["..result.peer_id.."] as owner by username") 
      if result.username then 
         text = member_username.." [ "..result.peer_id.." ] added as owner" 
      else 
         text = "[ "..result.peer_id.." ] added as owner" 
      end 
      send_large_msg(receiver, text) 
  end]] 
   elseif get_cmd == "promote" then 
      local receiver = extra.channel 
      local user_id = result.peer_id 
      --local user = "user#id"..result.peer_id 
      promote2(receiver, member_username, user_id) 
      --channel_set_mod(receiver, user, ok_cb, false) 
   elseif get_cmd == "demote" then 
      local receiver = extra.channel 
      local user_id = result.peer_id 
      local user = "user#id"..result.peer_id 
      demote2(receiver, member_username, user_id) 
   elseif get_cmd == "demoteadmin" then 
      local user_id = "user#id"..result.peer_id 
      local channel_id = extra.channel 
      if is_admin2(result.peer_id) then 
         return send_large_msg(channel_id, "⛔️❗️لُايَحق لك تنزيل (ٱلٲدمنية|ٱڵمدير).") 
      end 
      channel_demote(channel_id, user_id, ok_cb, false) 
      if result.username then 
         text = "@"..result.username.." ⚜ تـۖم تـنـزيڵ ٲدآري مـۧن ٱڵمجـمۄعة" 
         send_large_msg(channel_id, text) 
      else 
         text = "@"..result.peer_id.." ⚜ تـۖم تـنـزيڵ ٲدآري مـۧن ٱڵمجـمۄعة" 
         send_large_msg(channel_id, text) 
      end 
      local receiver = extra.channel 
      local user_id = result.peer_id 
      demote_admin(receiver, member_username, user_id) 
   elseif get_cmd == 'mute_user' then 
      local user_id = result.peer_id 
      local receiver = extra.receiver 
      local chat_id = string.gsub(receiver, 'channel#id', '') 
      if is_muted_user(chat_id, user_id) then 
         unmute_user(chat_id, user_id) 
         send_large_msg(receiver, " ["..user_id.."] removed from muted user list") 
      elseif is_owner(extra.msg) then 
         mute_user(chat_id, user_id) 
         send_large_msg(receiver, " ["..user_id.."] added to muted user list") 
      end 
   end 
end 
--End resolve username actions 

--Begin non-channel_invite username actions 
local function in_channel_cb(cb_extra, success, result) 
  local get_cmd = cb_extra.get_cmd 
  local receiver = cb_extra.receiver 
  local msg = cb_extra.msg 
  local data = load_data(_config.moderation.data) 
  local print_name = user_print_name(cb_extra.msg.from):gsub("‮", "") 
  local name_log = print_name:gsub("_", " ") 
  local member = cb_extra.username 
  local memberid = cb_extra.user_id 
  if member then 
    text = '⛔️❗️ لُايوجد هذا ألشخص @'..member..' فيۧ ٲڵمجـمۄعة.' 
  else 
    text = '⛔️❗️ لُايوجد هذا ألشخص ['..memberid..'] فيۧ ٲڵمجـمۄعة.' 
  end 
if get_cmd == "channel_block" then 
  for k,v in pairs(result) do 
    vusername = v.username 
    vpeer_id = tostring(v.peer_id) 
    if vusername == member or vpeer_id == memberid then 
     local user_id = v.peer_id 
     local channel_id = cb_extra.msg.to.id 
     local sender = cb_extra.msg.from.id 
      if user_id == sender then 
        return send_large_msg("channel#id"..channel_id, "Leave using kickme command") 
      end 
      if is_momod2(user_id, channel_id) and not is_admin2(sender) then 
        return send_large_msg("channel#id"..channel_id, "⛔️❗️لُايَحق لك طړډ (ٱلٲدمنية|ٱڵمدير).") 
      end 
      if is_admin2(user_id) then 
        return send_large_msg("channel#id"..channel_id, "⛔️❗️ لُايَحـق لك طـړډ ٱلٲدمنية") 
      end 
      if v.username then 
        text = "" 
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: @"..v.username.." ["..v.peer_id.."]") 
      else 
        text = "" 
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: ["..v.peer_id.."]") 
      end 
      kick_user(user_id, channel_id) 
      return 
    end 
  end 
elseif get_cmd == "setadmin" then 
   for k,v in pairs(result) do 
    vusername = v.username 
    vpeer_id = tostring(v.peer_id) 
    if vusername == member or vpeer_id == memberid then 
      local user_id = "user#id"..v.peer_id 
      local channel_id = "channel#id"..cb_extra.msg.to.id 
      channel_set_admin(channel_id, user_id, ok_cb, false) 
      if v.username then 
        text = "@"..v.username.." ["..v.peer_id.."] ⚜ تـۖم رفـعـك ٲدآري فيۧ ٱڵمجـمۄعة " 
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin @"..v.username.." ["..v.peer_id.."]") 
      else 
        text = "["..v.peer_id.."] ⚜ تـۖم رفـعـك ٲدآري فيۧ ٱڵمجـمۄعة " 
        savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin "..v.peer_id) 
      end 
     if v.username then 
      member_username = "@"..v.username 
     else 
      member_username = string.gsub(v.print_name, '_', ' ') 
     end 
      local receiver = channel_id 
      local user_id = v.peer_id 
      promote_admin(receiver, member_username, user_id) 

    end 
    send_large_msg(channel_id, text) 
    return 
 end 
 elseif get_cmd == 'رفع مشرف' then 
   for k,v in pairs(result) do 
      vusername = v.username 
      vpeer_id = tostring(v.peer_id) 
      if vusername == member or vpeer_id == memberid then 
         local channel = string.gsub(receiver, 'channel#id', '') 
         local from_id = cb_extra.msg.from.id 
         local group_owner = data[tostring(channel)]['set_owner'] 
         if group_owner then 
            if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then 
               local user = "user#id"..group_owner 
               channel_demote(receiver, user, ok_cb, false) 
            end 
               local user_id = "user#id"..v.peer_id 
               channel_set_admin(receiver, user_id, ok_cb, false) 
               data[tostring(channel)]['set_owner'] = tostring(v.peer_id) 
               save_data(_config.moderation.data, data) 
               savelog(channel, name_log.."["..from_id.."] set ["..v.peer_id.."] as owner by username") 
            if result.username then 
               text = member_username.." ["..v.peer_id.."] ⚜ تـۖم رفـعـك مـډيـر ٱڵمجـمۄعة ." 
            else 
               text = "["..v.peer_id.."] ⚜ تـۖم رفـعـك مـډيـر ٱڵمجـمۄعة ." 
            end 
         end 
      elseif memberid and vusername ~= member and vpeer_id ~= memberid then 
         local channel = string.gsub(receiver, 'channel#id', '') 
         local from_id = cb_extra.msg.from.id 
         local group_owner = data[tostring(channel)]['set_owner'] 
         if group_owner then 
            if not is_admin2(tonumber(group_owner)) and not is_support(tonumber(group_owner)) then 
               local user = "user#id"..group_owner 
               channel_demote(receiver, user, ok_cb, false) 
            end 
            data[tostring(channel)]['set_owner'] = tostring(memberid) 
            save_data(_config.moderation.data, data) 
            savelog(channel, name_log.."["..from_id.."] set ["..memberid.."] as owner by username") 
            text = "["..memberid.."] ⚜ تـۖم رفـعـك مـډيـر ٱڵمجـمۄعة ." 
         end 
      end 
   end 
 end 
send_large_msg(receiver, text) 
end 
--End non-channel_invite username actions 

-- DEV - @IQ_ABS 

--'Set supergroup photo' function 
local function set_supergroup_photo(msg, success, result) 
  local data = load_data(_config.moderation.data) 
  if not data[tostring(msg.to.id)] then 
      return 
  end 
  local receiver = get_receiver(msg) 
  if success then 
    local file = 'data/photos/channel_photo_'..msg.to.id..'.jpg' 
    print('File downloaded to:', result) 
    os.rename(result, file) 
    print('File moved to:', file) 
    channel_set_photo(receiver, file, ok_cb, false) 
    data[tostring(msg.to.id)]['settings']['set_photo'] = file 
    save_data(_config.moderation.data, data) 
    send_large_msg(receiver, '🎢❗️ تـۖم تغيير صـۄرة ٱڵمجـمۄعة', ok_cb, false) 
  else 
    print('Error downloading: '..msg.id) 
    send_large_msg(receiver, 'Failed, please try again!', ok_cb, false) 
  end 
end 

--Run function 
local function IQ_ABS(msg, matches) 
   if msg.to.type == 'chat' then 
      if matches[1] == 'تحويل سوبر' then 
         if not is_admin1(msg) then 
            return 
         end 
         local receiver = get_receiver(msg) 
         chat_upgrade(receiver, ok_cb, false) 
      end 
   elseif msg.to.type == 'channel'then 
      if matches[1] == 'تحويل سوبر' then 
         if not is_admin1(msg) then 
            return 
         end 
         return "❗️☻ ٱڵمجـمۄعة بـٱڵـتٲكيد خـٲرقـة." 
      end 
   end 
   if msg.to.type == 'channel' then 
   local support_id = msg.from.id 
   local receiver = get_receiver(msg) 
   local print_name = user_print_name(msg.from):gsub("‮", "") 
   local name_log = print_name:gsub("_", " ") 
   local data = load_data(_config.moderation.data) 
         if matches[1] == 'تفعيل' and not matches[2] then 
         if not is_admin1(msg) and not is_support(support_id) then 
            return 
         end 
         if is_super_group(msg) then 
        local iDev1 = "◥❗️☻ٱڵمجـمۄعة ،بٱڵتاكيد ،مۧفعڵـة◤" 
         return send_large_msg(receiver, iDev1) 
         end 
         print("SuperGroup "..msg.to.print_name.."("..msg.to.id..") added") 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] added SuperGroup") 
         superadd(msg) 
         set_mutes(msg.to.id) 
         channel_set_admin(receiver, 'user#id'..msg.from.id, ok_cb, false) 
      end 
      if matches[1] == 'تفعيل' and is_admin1(msg) and not matches[2] then 
         if not is_super_group(msg) then 
           local iDev1 = "☂🚸 هذَا ٱڵمجـمۄعة معطـۧڵـۧة ❗️ حسناً انۧا سوف ٱفعۧل ألبوټ فيۧ هذه ٱڵمجـمۄعة." 
           return send_large_msg(receiver, iDev1) 
         end 
         print("SuperGroup "..msg.to.print_name.."("..msg.to.id..") removed") 
         superrem(msg) 
         rem_mutes(msg.to.id) 
      end 
      if matches[1] == 'الغاء تفعيل' and is_admin1(msg) and not matches[2] then 
         if not is_super_group(msg) then 
            return reply_msg(msg.id, "◥❗️☻ ٱڵمجمۄعة ،ڵيۧس ،مفعۧلـۧة ◤", ok_cb, false) 
         end 
         print("SuperGroup "..msg.to.print_name.."("..msg.to.id..") removed") 
         superrem(msg) 
         rem_mutes(msg.to.id) 
      end 

      if not data[tostring(msg.to.id)] then 
         return 
      end--@DevPointTeam = Dont Remove 
      if matches[1] == "معلومات المجموعة" then 
         if not is_owner(msg) then 
            return 
         end 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup info") 
         channel_info(receiver, callback_info, {receiver = receiver, msg = msg}) 
      end 

      if matches[1] == "الادارين" then 
         if not is_owner(msg) and not is_support(msg.from.id) then 
            return 
         end 
         member_type = 'Admins' 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup Admins list") 
         admins = channel_get_admins(receiver,callback, {receiver = receiver, msg = msg, member_type = member_type}) 
      end 

      if matches[1] == "المشرف" then 
         local group_owner = data[tostring(msg.to.id)]['set_owner'] 
         if not group_owner then 
            return "⛔️❗️ لايوجد مـډيـر فيۧ ٱڵمجـمۄعة\nيـمکـنك وضع مـډيـر فيۧ ٱڵمجـمۄعة بٲرسال /setowner + المعرف او بالرد." 
         end 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] used /owner") 
         return "❗️🚸 ايدي مـۧډيـۧړ ٱڵمجـمۄعة  ["..group_owner..']' 
      end 

      if matches[1] == "الادمنية" then 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group modlist") 
         return modlist(msg) 
         -- channel_get_admins(receiver,callback, {receiver = receiver}) 
      end 

      if matches[1] == "كشف بوت" and is_momod(msg) then 
         member_type = 'Bots' 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup bots list") 
         channel_get_bots(receiver, callback, {receiver = receiver, msg = msg, member_type = member_type}) 
      end 

      if matches[1] == "عدد الاعضاء" and not matches[2] and is_momod(msg) then 
         local user_id = msg.from.peer_id 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup users list") 
         channel_get_users(receiver, callback_who, {receiver = receiver}) 
      end 

      if matches[1] == "المطرودين" and is_momod(msg) then 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested Kicked users list") 
         channel_get_kicked(receiver, callback_kicked, {receiver = receiver}) 
      end 

      if matches[1] == 'del' and is_momod(msg) then 
         if type(msg.reply_id) ~= "nil" then 
            local cbreply_extra = { 
               get_cmd = 'del', 
               msg = msg 
            } 
            delete_msg(msg.id, ok_cb, false) 
            get_message(msg.reply_id, get_message_callback, cbreply_extra) 
         end 
      end 

      if matches[1] == 'طرد' or matches[1] == 'طرد' and is_momod(msg) then 
         if type(msg.reply_id) ~= "nil" then 
            local cbreply_extra = { 
               get_cmd = 'channel_block', 
               msg = msg 
            } 
            get_message(msg.reply_id, get_message_callback, cbreply_extra) 
         elseif matches[1] == 'طرد' or matches[1] == 'طرد' and string.match(matches[2], '^%d+$') then 
            --[[local user_id = matches[2] 
            local channel_id = msg.to.id Dev = PROX 
            if is_momod2(user_id, channel_id) and not is_admin2(user_id) then 
               return send_large_msg(receiver, "You can't kick mods/owner/admins") 
            end 
            @DEV_PROX - MASCO 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: [ user#id"..user_id.." ]") 
            kick_user(user_id, channel_id)]] 
            local   get_cmd = 'channel_block' 
            local   msg = msg 
            local user_id = matches[2] 
            channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id}) 
         elseif msg.text:match("@[%a%d]") then 
         --[[local cbres_extra = { 
               channelid = msg.to.id, 
               get_cmd = 'channel_block', 
               sender = msg.from.id Dev = PROX 
            } 
             local username = matches[2] 
            local username = string.gsub(matches[2], '@', '') 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] kicked: @"..username) 
            resolve_username(username, callbackres, cbres_extra)]] 
         local get_cmd = 'channel_block' 
         local msg = msg 
         local username = matches[2] 
         local username = string.gsub(matches[2], '@', '') 
         channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username}) 
         end 
      end 

      if matches[1] == 'ايدي' then 
         if type(msg.reply_id) ~= "nil" and is_momod(msg) and not matches[2] then 
            local cbreply_extra = { 
               get_cmd = 'ايدي', 
               msg = msg 
            } 
            get_message(msg.reply_id, get_message_callback, cbreply_extra) 
         elseif type(msg.reply_id) ~= "nil" and matches[2] == "from" and is_momod(msg) then 
            local cbreply_extra = { 
               get_cmd = 'idfrom', 
               msg = msg 
            } 
            get_message(msg.reply_id, get_message_callback, cbreply_extra) 
         elseif msg.text:match("@[%a%d]") then 
            local cbres_extra = { 
               channelid = msg.to.id, 
               get_cmd = 'ايدي' 
            } 
            local username = matches[2] 
            local username = username:gsub("@","") 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested ID for: @"..username) 
            resolve_username(username,  callbackres, cbres_extra) 
         else 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup ID") 
local iq_abs = '🈷 - ٱيـۧډيک : '..msg.from.id..'\n'
..'🈶 - مۘعرفک : @'..msg.from.username..'\n'
..'🈸 - ٱسـۧمـک ٲلٲول : '..(msg.from.first_name or '')..'\n'
..'🈸 - ٱسـۧمـک ٲلثـآنيَ : '..(msg.from.lastname or '')..'\n'
..'🈚️ - ٱيډي ٱڵمجـمۄعة : '..msg.to.id..'\n'
..'📳 - ٱسـۨم ٱڵمجـمۄعة : '..msg.to.title..'\n'
..'📴 - رقــۖـمــۗـک : '..(msg.from.phone or " لُايَوَجْدِ ⛔️‼️"..'\n'
..'📨 - ٱڵـرسـآلـةٌ : '..msg.text..'\n'
..'⏱ - ٲڵـوقـت : '..os.date(' %T', os.time()))..'\n'
..'📆 - ٱڵـتاريـخ : '.. os.date('!%A %B:%d:%Y\n', timestamp)..'\n' 
reply_msg(msg.id, iq_abs, ok_cb, false)
         end 
      end 

      if matches[1] == 'مغادرة' then 
         if msg.to.type == 'channel' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] left via kickme") 
            channel_kick("channel#id"..msg.to.id, "user#id"..msg.from.id, ok_cb, false) 
         end 
      end 

      if matches[1] == 'رابط جديد' and is_momod(msg)then 
         local function callback_link (extra , success, result) 
         local receiver = get_receiver(msg) 
            if success == 0 then 
               send_large_msg(receiver, 'عذرا لايمكنك تغيير الرابط.. ❗️⛔️\nالمجموعة ليس من صنع البوت\n\nيمكنك وضع رابط جديد بارسال (وضع رابط) لصنع رابط جديد') 
               data[tostring(msg.to.id)]['settings']['set_link'] = nil 
               save_data(_config.moderation.data, data) 
            else 
               send_large_msg(receiver, "❗️🚸 تـۖم صـنـع رآبـط جـډيـډ\nٱرسـڵ (الرابط) لٲضهار ٱڵـرآبـط ٱڵـجـډيـډ") 
               data[tostring(msg.to.id)]['settings']['set_link'] = result 
               save_data(_config.moderation.data, data) 
            end 
         end 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] attempted to create a new SuperGroup link") 
         export_channel_link(receiver, callback_link, false) 
      end 

      if matches[1] == 'وضع رابط' and is_owner(msg) then 
         data[tostring(msg.to.id)]['settings']['set_link'] = 'waiting' 
         save_data(_config.moderation.data, data) 
         return "❗️🚸 رجآءً ٱرسڵ رٱبط ٱڵمجموعة ٱڵجديد" 
      end 

      if msg.text then 
         if msg.text:match("^(https://telegram.me/joinchat/%S+)$") and data[tostring(msg.to.id)]['settings']['set_link'] == 'waiting' and is_owner(msg) then 
            data[tostring(msg.to.id)]['settings']['set_link'] = msg.text 
            save_data(_config.moderation.data, data) 
            return "❗️🚸 تـۖم حفـۨظ ٱڵـرابط ٱرسـل  (الرابط)  ڵـعـړض ٱڵـرآبـط ٱڵجديد" 
         end 
      end 

      if matches[1] == 'الرابط' then 
         if not is_momod(msg) then 
            return 
         end 
         local group_link = data[tostring(msg.to.id)]['settings']['set_link'] 
         if not group_link then 
            return "❗️🚸 لُايَوَجْدِ رآبـط ڵـلمجـمۄعة ⚠️ ٱرسـڵ  (رابط جديد)   ڵـصنع رابـط جـډيـډ ⚠️  لاكن ٲذٱ ڵـم تـڪـن ٱڵمجـمۄعة مـۧن صـناعـة ٱڵـبۄت ٱرسـڵ  (وضع رابط)  ☑️🔕" 
         end 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group link ["..group_link.."]") 
         return "🔗 رآبــط ٱڵمجـمۄعة  ["..msg.to.title.."] :\n"..group_link 
      end 

      if matches[1] == "invite" and is_sudo(msg) then 
         local cbres_extra = { 
            channel = get_receiver(msg), 
            get_cmd = "invite" 
         } 
         local username = matches[2] 
         local username = username:gsub("@","") 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] invited @"..username) 
         resolve_username(username,  callbackres, cbres_extra) 
      end 

      if matches[1] == 'res' and is_owner(msg) then 
         local cbres_extra = { 
            channelid = msg.to.id, 
            get_cmd = 'res' 
         } 
         local username = matches[2] 
         local username = username:gsub("@","") 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] resolved username: @"..username) 
         resolve_username(username,  callbackres, cbres_extra) 
      end 

      --[[if matches[1] == 'kick' and is_momod(msg) then 
         local receiver = channel..matches[3] 
         local user = "user#id"..matches[2] 
         chaannel_kick(receiver, user, ok_cb, false) 
         @DevProx 
      end]] 

         if matches[1] == 'رفع اداري' then 
            if not is_support(msg.from.id) and not is_owner(msg) then 
               return 
            end 
         if type(msg.reply_id) ~= "nil" then 
            local cbreply_extra = { 
               get_cmd = 'setadmin', 
               msg = msg 
            } 
            setadmin = get_message(msg.reply_id, get_message_callback, cbreply_extra) 
         elseif matches[1] == 'setadmin' and string.match(matches[2], '^%d+$') then 
         --[[]   local receiver = get_receiver(msg) 
            local user_id = "user#id"..matches[2] 
            local get_cmd = 'setadmin' Dev   =   Point 
            user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd})]] 
            local   get_cmd = 'setadmin' 
            local   msg = msg 
            local user_id = matches[2] 
            channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id}) 
         elseif matches[1] == 'رفع اداري' and not string.match(matches[2], '^%d+$') then 
            --[[local cbres_extra = { 
               channel = get_receiver(msg), 
               get_cmd = 'setadmin' 
            } 
            local username = matches[2] 
            local username = string.gsub(matches[2], '@', '') 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] set admin @"..username) 
            resolve_username(username, callbackres, cbres_extra)]] 
            local   get_cmd = 'setadmin' 
            local   msg = msg 
            local username = matches[2] 
            local username = string.gsub(matches[2], '@', '') 
            channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username}) 
         end 
      end 

      if matches[1] == 'تنزيل اداري' then 
         if not is_support(msg.from.id) and not is_owner(msg) then 
            return 
         end 
         if type(msg.reply_id) ~= "nil" then 
            local cbreply_extra = { 
               get_cmd = 'demoteadmin', 
               msg = msg 
            } 
            demoteadmin = get_message(msg.reply_id, get_message_callback, cbreply_extra) 
         elseif matches[1] == 'demoteadmin' and string.match(matches[2], '^%d+$') then 
            local receiver = get_receiver(msg) 
            local user_id = "user#id"..matches[2] 
            local get_cmd = 'demoteadmin' 
            user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd}) 
         elseif matches[1] == 'تنزيل اداري' and not string.match(matches[2], '^%d+$') then 
            local cbres_extra = { 
               channel = get_receiver(msg), 
               get_cmd = 'demoteadmin' 
            } 
            local username = matches[2] 
            local username = string.gsub(matches[2], '@', '') 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted admin @"..username) 
            resolve_username(username, callbackres, cbres_extra) 
         end 
      end 

      if matches[1] == 'رفع مشرف' and is_owner(msg) then 
         if type(msg.reply_id) ~= "nil" then 
            local cbreply_extra = { 
               get_cmd = 'setowner', 
               msg = msg 
            } 
            setowner = get_message(msg.reply_id, get_message_callback, cbreply_extra) 
         elseif matches[1] == 'setowner' and string.match(matches[2], '^%d+$') then 
      --[[   local group_owner = data[tostring(msg.to.id)]['set_owner'] 
            if group_owner then 
               local receiver = get_receiver(msg) 
               local user_id = "user#id"..group_owner 
               if not is_admin2(group_owner) and not is_support(group_owner) then 
                  channel_demote(receiver, user_id, ok_cb, false) 
               end 
               local user = "user#id"..matches[2] 
               channel_set_admin(receiver, user, ok_cb, false) 
               data[tostring(msg.to.id)]['set_owner'] = tostring(matches[2]) 
               save_data(_config.moderation.data, data) 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set ["..matches[2].."] as owner") 
               local text = "[ "..matches[2].." ] added as owner" 
               return text Dev    =   Prox 
            end]] 
            local   get_cmd = 'setowner' 
            local   msg = msg 
            local user_id = matches[2] 
            channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, user_id=user_id}) 
         elseif matches[1] == 'setowner' and not string.match(matches[2], '^%d+$') then 
            local   get_cmd = 'setowner' 
            local   msg = msg 
            local username = matches[2] 
            local username = string.gsub(matches[2], '@', '') 
            channel_get_users (receiver, in_channel_cb, {get_cmd=get_cmd, receiver=receiver, msg=msg, username=username}) 
         end 
      end 

      if matches[1] == 'رفع ادمن' then 
        if not is_momod(msg) then 
            return 
         end 
         if not is_owner(msg) then 
            return "للمشرفين فقط ⛔️😴✋🏿" 
         end 
         if type(msg.reply_id) ~= "nil" then 
            local cbreply_extra = { 
               get_cmd = 'promote', 
               msg = msg 
            } 
            promote = get_message(msg.reply_id, get_message_callback, cbreply_extra) 
         elseif matches[1] == 'promote' and string.match(matches[2], '^%d+$') then 
            local receiver = get_receiver(msg) 
            local user_id = "user#id"..matches[2] 
            local get_cmd = 'promote' 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted user#id"..matches[2]) 
            user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd}) 
         elseif matches[1] == 'رفع ادمن' and not string.match(matches[2], '^%d+$') then 
            local cbres_extra = { 
               channel = get_receiver(msg), 
               get_cmd = 'promote', 
            } 
            local username = matches[2] 
            local username = string.gsub(matches[2], '@', '') 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] promoted @"..username) 
            return resolve_username(username, callbackres, cbres_extra) 
         end 
      end 

      if matches[1] == 'mp' and is_sudo(msg) then 
         channel = get_receiver(msg) 
         user_id = 'user#id'..matches[2] 
         channel_set_mod(channel, user_id, ok_cb, false) 
         return "ok" 
      end 
      if matches[1] == 'md' and is_sudo(msg) then 
         channel = get_receiver(msg) 
         user_id = 'user#id'..matches[2] 
         channel_demote(channel, user_id, ok_cb, false) 
         return "ok" 
      end 

      if matches[1] == 'تنزيل ادمن' then 
         if not is_momod(msg) then 
            return 
         end 
         if not is_owner(msg) then 
            return "للمشرفين فقط ⛔️😴✋🏿" 
         end 
         if type(msg.reply_id) ~= "nil" then 
            local cbreply_extra = { 
               get_cmd = 'demote', 
               msg = msg 
            } 
            demote = get_message(msg.reply_id, get_message_callback, cbreply_extra) 
         elseif matches[1] == 'demote' and string.match(matches[2], '^%d+$') then 
            local receiver = get_receiver(msg) 
            local user_id = "user#id"..matches[2] 
            local get_cmd = 'demote' 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted user#id"..matches[2]) 
            user_info(user_id, cb_user_info, {receiver = receiver, get_cmd = get_cmd}) 
         elseif not string.match(matches[2], '^%d+$') then 
            local cbres_extra = { 
               channel = get_receiver(msg), 
               get_cmd = 'demote' 
            } 
            local username = matches[2] 
            local username = string.gsub(matches[2], '@', '') 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] demoted @"..username) 
            return resolve_username(username, callbackres, cbres_extra) 
         end 
      end 

      if matches[1] == "ضع اسم" and is_momod(msg) then 
         local receiver = get_receiver(msg) 
         local set_name = string.gsub(matches[2], '_', '') 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] renamed SuperGroup to: "..matches[2]) 
         rename_channel(receiver, set_name, ok_cb, false) 
      end 

      if msg.service and msg.action.type == 'chat_rename' then 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] renamed SuperGroup to: "..msg.to.title) 
         data[tostring(msg.to.id)]['settings']['set_name'] = msg.to.title 
         save_data(_config.moderation.data, data) 
      end 

      if matches[1] == "ضع وصف" and is_momod(msg) then 
         local receiver = get_receiver(msg) 
         local about_text = matches[2] 
         local data_cat = 'description' 
         local target = msg.to.id 
         data[tostring(target)][data_cat] = about_text 
         save_data(_config.moderation.data, data) 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup description to: "..about_text) 
         channel_set_about(receiver, about_text, ok_cb, false) 
         return "تـۖم صـنع وصـف ڵـلمجـمۄعةِ.\n\nادخـل ڵـلدرډشـة مــرة ٱخرى ڵـمشـاهدت التغـييـراټ." 
      end 

      if matches[1] == "ضع معرف" and is_admin1(msg) then 
         local function ok_username_cb (extra, success, result) 
            local receiver = extra.receiver 
            if success == 1 then 
               send_large_msg(receiver, "تم اضافة معرف للمجموعة🔴👋.\n\nادخل للمجموعة مره اخرى لترى التغيرات. ") 
            elseif success == 0 then 
               send_large_msg(receiver, "فشل في تعيين معرف للمجموعه ⚠️ قد يكون المعرف مستخدم صابقا او حساب البوت محضور .") 
            end 
         end 
         local username = string.gsub(matches[2], '@', '') 
         channel_set_username(receiver, username, ok_username_cb, {receiver=receiver}) 
      end 

      if matches[1] == 'ضع قوانين' and is_momod(msg) then 
         rules = matches[2] 
         local target = msg.to.id 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] has changed group rules to ["..matches[2].."]") 
         return set_rulesmod(msg, data, target) 
      end 

      if msg.media then 
         if msg.media.type == 'photo' and data[tostring(msg.to.id)]['settings']['set_photo'] == 'waiting' and is_momod(msg) then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] set new SuperGroup photo") 
            load_photo(msg.id, set_supergroup_photo, msg) 
            return 
         end 
      end 
      if matches[1] == 'ضع صورة' and is_momod(msg) then 
         data[tostring(msg.to.id)]['settings']['set_photo'] = 'waiting' 
         save_data(_config.moderation.data, data) 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] started setting new SuperGroup photo") 
         return '🎢❗️رَجـآء أرسَل صوٌرة المجًموًعة الجٌدَيدة الًان' 
      end 

      if matches[1] == 'حذف' then 
         if not is_momod(msg) then 
            return 
         end 
         if not is_momod(msg) then 
            return "للمشرفين فقط ⛔️😴✋🏿" 
         end 
         if matches[2] == 'الادمنية' then 
            if next(data[tostring(msg.to.id)]['moderators']) == nil then 
               return "⛔️❗️ لايوجد ادمنية فيۧ ٱڵمجـمۄعة" 
            end 
            for k,v in pairs(data[tostring(msg.to.id)]['moderators']) do 
               data[tostring(msg.to.id)]['moderators'][tostring(k)] = nil 
               save_data(_config.moderation.data, data) 
            end 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned modlist") 
            return '⛔️❗️ تـۖم حـذف جـميـع الادمنية' 
         end 
         if matches[2] == 'القوانين' then 
            local data_cat = 'rules' 
            if data[tostring(msg.to.id)][data_cat] == nil then 
               return "⛔️❗️ لا��وجد قوانين فيۧ ٱڵمجـمۄعة" 
            end 
            data[tostring(msg.to.id)][data_cat] = nil 
            save_data(_config.moderation.data, data) 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned rules") 
            return '⛔️❗️ تـۖم حـذف قوانين ٱڵمجـمۅعة' 
         end 
         if matches[2] == 'الوصف' then 
            local receiver = get_receiver(msg) 
            local about_text = ' ' 
            local data_cat = 'description' 
            if data[tostring(msg.to.id)][data_cat] == nil then 
               return '⛔️❗️ لايوجد وصــف فيۧ ٱڵمجـمۄعة' 
            end 
            data[tostring(msg.to.id)][data_cat] = nil 
            save_data(_config.moderation.data, data) 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] cleaned about") 
            channel_set_about(receiver, about_text, ok_cb, false) 
            return "⛔️❗️ تـۖم حـذف وصــف ٱڵمجـمۅعة" 
         end 
         if matches[2] == 'المكتومين' then 
            chat_id = msg.to.id 
            local hash =  'mute_user:'..chat_id 
               redis:del(hash) 
            return "⛔️❗️ تـۖم حـذف ٱڵـمـكـتـومـيـن" 
         end 
         if matches[2] == 'المعرف' and is_admin1(msg) then 
            local function ok_username_cb (extra, success, result) 
               local receiver = extra.receiver 
               if success == 1 then 
                  send_large_msg(receiver, "⛔️❗️ تـۖم حـذف معرف ٱڵمجـمۅعة") 
               elseif success == 0 then 
                  send_large_msg(receiver, "⛔️❗️ فشل حــذف معرف ڵـڵـمجـمۄعة") 
               end 
            end 
            local username = "" 
            channel_set_username(receiver, username, ok_username_cb, {receiver=receiver}) 
         end 
      end 

      if matches[1] == 'قفل' and is_momod(msg) then 
         local target = msg.to.id 
              if matches[2] == 'all' then 
         local safemode ={ 
        lock_group_links(msg, data, target), 
      lock_group_tag(msg, data, target), 
      lock_group_spam(msg, data, target), 
      lock_group_flood(msg, data, target), 
      lock_group_arabic(msg, data, target), 
      lock_group_membermod(msg, data, target), 
      lock_group_rtl(msg, data, target), 
      lock_group_tgservice(msg, data, target), 
      lock_group_sticker(msg, data, target), 
      lock_group_contacts(msg, data, target), 
      lock_group_english(msg, data, target), 
      lock_group_fwd(msg, data, target), 
      lock_group_reply(msg, data, target), 
      lock_group_join(msg, data, target), 
      lock_group_emoji(msg, data, target), 
      lock_group_username(msg, data, target), 
      lock_group_fosh(msg, data, target), 
      lock_group_media(msg, data, target), 
      lock_group_leave(msg, data, target), 
      lock_group_bots(msg, data, target), 
      lock_group_operator(msg, data, target), 
         } 
         return lock_group_all(msg, data, target), safemode 
      end 
              if matches[2] == 'etehad' then 
         local etehad ={ 
        unlock_group_links(msg, data, target), 
      lock_group_tag(msg, data, target), 
      lock_group_spam(msg, data, target), 
      lock_group_flood(msg, data, target), 
      unlock_group_arabic(msg, data, target), 
      lock_group_membermod(msg, data, target), 
      unlock_group_rtl(msg, data, target), 
      lock_group_tgservice(msg, data, target), 
      lock_group_sticker(msg, data, target), 
      unlock_group_contacts(msg, data, target), 
      unlock_group_english(msg, data, target), 
      unlock_group_fwd(msg, data, target), 
      unlock_group_reply(msg, data, target), 
      lock_group_join(msg, data, target), 
      unlock_group_emoji(msg, data, target), 
      unlock_group_username(msg, data, target), 
      lock_group_fosh(msg, data, target), 
      unlock_group_media(msg, data, target), 
      lock_group_leave(msg, data, target), 
      lock_group_bots(msg, data, target), 
      unlock_group_operator(msg, data, target), 
         } 
         return lock_group_etehad(msg, data, target), etehad 
      end 
        	if matches[2] == 'الروابط' then
				        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked ads ")
				        return lock_group_ads(msg, data, target) 
         end 
         if matches[2] == 'الدخول' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked join ") 
            return lock_group_join(msg, data, target) 
         end 
         if matches[2] == 'التاك' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked tag ") 
            return lock_group_tag(msg, data, target) 
         end 
         if matches[2] == 'التفليش' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked spam ") 
            return lock_group_spam(msg, data, target) 
         end 
         if matches[2] == 'التكرار' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked flood ") 
            return lock_group_flood(msg, data, target) 
         end 
         if matches[2] == 'العربية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked arabic ") 
            return lock_group_arabic(msg, data, target) 
         end 
         if matches[2] == 'الاضافة' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked member ") 
            return lock_group_membermod(msg, data, target) 
         end 
         if matches[2]:lower() == 'اضافة جماعية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked rtl chars. in names") 
            return lock_group_rtl(msg, data, target) 
         end 
         if matches[2] == 'اشعارات الدخول' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked Tgservice Actions") 
            return lock_group_tgservice(msg, data, target) 
         end 
         if matches[2] == 'الملصقات' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked sticker posting") 
            return lock_group_sticker(msg, data, target) 
         end 
         if matches[2] == 'جهات اتصال' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked contact posting") 
            return lock_group_contacts(msg, data, target) 
         end 
         if matches[2] == 'الحماية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked enabled strict settings") 
            return enable_strict_rules(msg, data, target) 
         end 
         if matches[2] == 'الانكليزية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked english") 
            return lock_group_english(msg, data, target) 
         end 
         if matches[2] == 'التوجية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked fwd") 
            return lock_group_fwd(msg, data, target) 
         end 
         if matches[2] == 'الردود' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked reply") 
            return lock_group_reply(msg, data, target) 
         end 
         if matches[2] == 'السمايلات' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked emoji") 
            return lock_group_emoji(msg, data, target) 
         end 
         if matches[2] == 'كلمات سيئة' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked fosh") 
            return lock_group_fosh(msg, data, target) 
         end 
         if matches[2] == 'الميديا' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked media") 
            return lock_group_media(msg, data, target) 
         end 
         if matches[2] == 'المعرف' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked username") 
            return lock_group_username(msg, data, target) 
         end 
         if matches[2] == 'مغادرة' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked leave") 
            return lock_group_leave(msg, data, target) 
         end 
         if matches[2] == 'البوتات' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked bots") 
            return lock_group_bots(msg, data, target) 
         end 
         if matches[2] == 'operator' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked operator") 
            return lock_group_operator(msg, data, target) 
         end 
      end 

      if matches[1] == 'فتح' and is_momod(msg) then 
         local target = msg.to.id 
              if matches[2] == 'all' then 
         local dsafemode ={ 
        unlock_group_links(msg, data, target), 
      unlock_group_tag(msg, data, target), 
      unlock_group_spam(msg, data, target), 
      unlock_group_flood(msg, data, target), 
      unlock_group_arabic(msg, data, target), 
      unlock_group_membermod(msg, data, target), 
      unlock_group_rtl(msg, data, target), 
      unlock_group_tgservice(msg, data, target), 
      unlock_group_sticker(msg, data, target), 
      unlock_group_contacts(msg, data, target), 
      unlock_group_english(msg, data, target), 
      unlock_group_fwd(msg, data, target), 
      unlock_group_reply(msg, data, target), 
      unlock_group_join(msg, data, target), 
      unlock_group_emoji(msg, data, target), 
      unlock_group_username(msg, data, target), 
      unlock_group_fosh(msg, data, target), 
      unlock_group_media(msg, data, target), 
      unlock_group_leave(msg, data, target), 
      unlock_group_bots(msg, data, target), 
      unlock_group_operator(msg, data, target), 
         } 
         return unlock_group_all(msg, data, target), dsafemode 
      end 
        if matches[2] == 'etehad' then 
         local detehad ={ 
        lock_group_links(msg, data, target), 
      unlock_group_tag(msg, data, target), 
      lock_group_spam(msg, data, target), 
      lock_group_flood(msg, data, target), 
      unlock_group_arabic(msg, data, target), 
      unlock_group_membermod(msg, data, target), 
      unlock_group_rtl(msg, data, target), 
      unlock_group_tgservice(msg, data, target), 
      unlock_group_sticker(msg, data, target), 
      unlock_group_contacts(msg, data, target), 
      unlock_group_english(msg, data, target), 
      unlock_group_fwd(msg, data, target), 
      unlock_group_reply(msg, data, target), 
      unlock_group_join(msg, data, target), 
      unlock_group_emoji(msg, data, target), 
      unlock_group_username(msg, data, target), 
      unlock_group_fosh(msg, data, target), 
      unlock_group_media(msg, data, target), 
      unlock_group_leave(msg, data, target), 
      unlock_group_bots(msg, data, target), 
      unlock_group_operator(msg, data, target), 
         } 
         return unlock_group_etehad(msg, data, target), detehad 
      end 
            	if matches[2] == 'الروابط' then
				        savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked ads join ")
				        return unlock_group_ads(msg, data, target) 
         end 
         if matches[2] == 'الدخول' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked join") 
            return unlock_group_join(msg, data, target) 
         end 
         if matches[2] == 'التاك' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked tag") 
            return unlock_group_tag(msg, data, target) 
         end 
         if matches[2] == 'التفليش' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked spam") 
            return unlock_group_spam(msg, data, target) 
         end 
         if matches[2] == 'التكرار' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked flood") 
            return unlock_group_flood(msg, data, target) 
         end 
         if matches[2] == 'العربية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked Arabic") 
            return unlock_group_arabic(msg, data, target) 
         end 
         if matches[2] == 'الاضافة' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked member ") 
            return unlock_group_membermod(msg, data, target) 
         end 
         if matches[2]:lower() == 'اضافة جماعية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked RTL chars. in names") 
            return unlock_group_rtl(msg, data, target) 
         end 
            if matches[2] == 'اشعارات الدخول' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked tgservice actions") 
            return unlock_group_tgservice(msg, data, target) 
         end 
         if matches[2] == 'الملصقات' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked sticker posting") 
            return unlock_group_sticker(msg, data, target) 
         end 
         if matches[2] == 'جهات اتصال' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked contact posting") 
            return unlock_group_contacts(msg, data, target) 
         end 
         if matches[2] == 'الحماية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked disabled strict settings") 
            return disable_strict_rules(msg, data, target) 
         end 
         if matches[2] == 'الانكليزية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked english") 
            return unlock_group_english(msg, data, target) 
         end 
         if matches[2] == 'التوجية' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked fwd") 
            return unlock_group_fwd(msg, data, target) 
         end 
         if matches[2] == 'الردود' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked reply") 
            return unlock_group_reply(msg, data, target) 
         end 
         if matches[2] == 'السمايلات' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked disabled emoji") 
            return unlock_group_emoji(msg, data, target) 
         end 
         if matches[2] == 'كلمات سيئة' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked fosh") 
            return unlock_group_fosh(msg, data, target) 
         end 
         if matches[2] == 'الميديا' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] unlocked media") 
            return unlock_group_media(msg, data, target) 
         end 
         if matches[2] == 'المعرف' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked disabled username") 
            return unlock_group_username(msg, data, target) 
         end 
         if matches[2] == 'مغادرة' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked leave") 
            return unlock_group_leave(msg, data, target) 
         end 
         if matches[2] == 'البوتات' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked bots") 
            return unlock_group_bots(msg, data, target) 
         end 
         if matches[2] == 'operator' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] locked operator") 
            return unlock_group_operator(msg, data, target) 
         end 
      end 

      if matches[1] == 'ضع التكرار' then 
         if not is_momod(msg) then 
            return 
         end 
         if tonumber(matches[2]) < 5 or tonumber(matches[2]) > 20 then 
            return "🚷❗️ الرقم خـطـأْ .\nيمكنك اختيار عـدد ٱڵـتْكِرَارَ مابين [5-20]" 
         end 
         local flood_max = matches[2] 
         data[tostring(msg.to.id)]['settings']['flood_msg_max'] = flood_max 
         save_data(_config.moderation.data, data) 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] set flood to ["..matches[2].."]") 
         return '🚷❗️ تـۧم وضـع ٱڵـتْكِرَارَ  :- '..matches[2] 
      end 
      if matches[1] == 'public' and is_momod(msg) then 
         local target = msg.to.id 
         if matches[2] == 'yes' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] set group to: public") 
            return set_public_membermod(msg, data, target) 
         end 
         if matches[2] == 'no' then 
            savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: not public") 
            return unset_public_membermod(msg, data, target) 
         end 
      end 

      if matches[1] == 'قفل' and is_owner(msg) then 
         local chat_id = msg.to.id 
         if matches[2] == 'الصوتيات' then 
         local msg_type = 'Audio' 
            if not is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type) 
               mute(chat_id, msg_type) 
                   return '❗️☻ تـۖم قفـڵ ٱڵـصوټ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
                   return '❗️☻ ٱڵـصوټ بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'الصور' then 
         local msg_type = 'Photo' 
            if not is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type) 
               mute(chat_id, msg_type) 
               return '❗️☻ تـۖم قفـڵ ٱڵـصـۄر فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵـصـۄر بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'الفيديوهات' then 
         local msg_type = 'Video' 
            if not is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type) 
               mute(chat_id, msg_type) 
               return '❗️☻ تـۖم قفـڵ ٱڵـفيډيۄ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return ' ❗️☻ ٱڵـفيډيۄ بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'المتحركة' then 
         local msg_type = 'Gifs' 
            if not is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type) 
               mute(chat_id, msg_type) 
               return '❗️☻ تـۖم قفـڵ ٱڵـمتحركة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵـمتحركة بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'الملفات' then 
         local msg_type = 'Documents' 
            if not is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type) 
               mute(chat_id, msg_type) 
               return '❗️☻ تـۖم قفـڵ ٱڵـمٌلفـآټ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵـمٌلفـآټ بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'الكتابة' then 
         local msg_type = 'Text' 
            if not is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type) 
               mute(chat_id, msg_type) 
               return '❗️☻ تـۖم قفـڵ ٱڵـكِتـآبة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵكِتـآبة بٱڵفعـل مۘقفلة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'المحادثة' then 
         local msg_type = 'All' 
            if not is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: mute "..msg_type) 
               mute(chat_id, msg_type) 
               return '❗️☻ تـۖم قفـڵ جـمـيع ٱڵـوسـآئط\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ جـمـيع ٱڵـوسـآئط بٱڵـتٱكيد مۘقفلة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
      end 
      if matches[1] == 'فتح' and is_momod(msg) then 
         local chat_id = msg.to.id 
         if matches[2] == 'الصوتيات' then 
         local msg_type = 'Audio' 
            if is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type) 
               unmute(chat_id, msg_type) 
               return '❗️��� تـۖم فـتـۧح ٱڵـصوټ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n���� SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵـصوټ بٱڵفعـل مۧفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'الصور' then 
         local msg_type = 'Photo' 
            if is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type) 
               unmute(chat_id, msg_type) 
               return '❗️☻ تـۖم فـتـۧح ٱڵـصـۄر فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵـصـۄر بٱڵفعـل مۧفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username ..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'الفيديوهات' then 
         local msg_type = 'Video' 
            if is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type) 
               unmute(chat_id, msg_type) 
               return '❗️☻ تـۖم فـتـۧح ٱڵـفيډيۄ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵـفيډيۄ بٱڵفعـل مۧفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'المتحركة' then 
         local msg_type = 'Gifs' 
            if is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type) 
               unmute(chat_id, msg_type) 
               return '❗️☻ تـۖم فـتـۧح ٱڵـمتحركة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵـمتحركة بٱڵفعـل مۧفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'الملفات' then 
         local msg_type = 'Documents' 
            if is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type) 
               unmute(chat_id, msg_type) 
               return '❗️☻ تـۖم فـتـۧح ٱڵـمٌلفـآټ فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵـمٌلفـآټ بٱڵفعـل مۧفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'الكتابة' then 
         local msg_type = 'Text' 
            if is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute message") 
               unmute(chat_id, msg_type) 
               return '❗️☻ تـۖم فـتـۧح ٱڵكِتـآبة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ ٱڵكِتـآبة بٱڵفعـل مۧفتوحة فيۧ ٱڵمجـمۄعة\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
         if matches[2] == 'المحادثة' then 
         local msg_type = 'All' 
            if is_muted(chat_id, msg_type..': yes') then 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] set SuperGroup to: unmute "..msg_type) 
               unmute(chat_id, msg_type) 
               return '❗️☻ تـۖم فـتـۧح جـمـيع ٱڵـوسـآئط\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            else 
               return '❗️☻ جـمـيع ٱڵـوسـآئط بٱڵـتٱكيد مۘفتوحة\n‼️🚸   SEND BY   @'..msg.from.username..'\n🆔 SEND BY ID : '..msg.from.id 
            end 
         end 
      end 

      if matches[1] == "كتم" or matches[1] == "كتم" and is_momod(msg) then 
         local chat_id = msg.to.id 
         local hash = "mute_user"..chat_id 
         local user_id = "" 
         if type(msg.reply_id) ~= "nil" then 
            local receiver = get_receiver(msg) 
            local get_cmd = "mute_user" 
            muteuser = get_message(msg.reply_id, get_message_callback, {receiver = receiver, get_cmd = get_cmd, msg = msg}) 
         elseif matches[1] == "كتم" or matches[1] == "كتم" and string.match(matches[2], '^%d+$') then 
            local user_id = matches[2] 
            if is_muted_user(chat_id, user_id) then 
               unmute_user(chat_id, user_id) 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] removed ["..user_id.."] from the muted users list") 
               return "["..user_id.."] ⛔️❗️ تـۖم ألـغآء كـتـم ٲلعضـو" 
            elseif is_momod(msg) then 
               mute_user(chat_id, user_id) 
               savelog(msg.to.id, name_log.." ["..msg.from.id.."] added ["..user_id.."] to the muted users list") 
               return "["..user_id.."] ⛔️❗️ تـۖم كـتـم ٲلعضـو" 
            end 
         elseif matches[1] == "كتم" or matches[1] == "كتم" and not string.match(matches[2], '^%d+$') then 
            local receiver = get_receiver(msg) 
            local get_cmd = "mute_user" 
            local username = matches[2] 
            local username = string.gsub(matches[2], '@', '') 
            resolve_username(username, callbackres, {receiver = receiver, get_cmd = get_cmd, msg=msg}) 
         end 
      end 

      if matches[1] == "اعدادات الكتم" and is_momod(msg) then 
         local chat_id = msg.to.id 
         if not has_mutes(chat_id) then 
            set_mutes(chat_id) 
            return mutes_list(chat_id) 
         end 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup muteslist") 
         return mutes_list(chat_id) 
      end 
      if matches[1] == "المكتومين" and is_momod(msg) then 
         local chat_id = msg.to.id 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup mutelist") 
         return muted_user_list(chat_id) 
      end 

      if matches[1] == 'الاعدادات' and is_momod(msg) then 
         local target = msg.to.id 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested SuperGroup settings ") 
         return show_supergroup_settingsmod(msg, target) 
      end 

      if matches[1] == 'القوانين' then 
         savelog(msg.to.id, name_log.." ["..msg.from.id.."] requested group rules") 
         return get_rules(msg, data) 
      end 

--      if matches[1] == 'help' and not is_owner(msg) then 
--         text = "للمشرفين فقط ⛔️😴✋🏿" 
--         reply_msg(msg.id, text, ok_cb, false) 
--      elseif matches[1] == 'help' and is_owner(msg) then 
--         local name_log = user_print_name(msg.from) 
--         savelog(msg.to.id, name_log.." ["..msg.from.id.."] Used /superhelp") 
--         return super_help() 
--      end 

      if matches[1] == 'peer_id' and is_admin1(msg)then 
         text = msg.to.peer_id 
         reply_msg(msg.id, text, ok_cb, false) 
         post_large_msg(receiver, text) 
      end 

      if matches[1] == 'msg.to.id' and is_admin1(msg) then 
         text = msg.to.id 
         reply_msg(msg.id, text, ok_cb, false) 
         post_large_msg(receiver, text) 
      end 

      --Admin Join Service Message 
      if msg.service then 
      local action = msg.action.type 
         if action == 'chat_add_user_link' then 
            if is_owner2(msg.from.id) then 
               local receiver = get_receiver(msg) 
               local user = "user#id"..msg.from.id 
               savelog(msg.to.id, name_log.." Admin ["..msg.from.id.."] joined the SuperGroup via link") 
               channel_set_admin(receiver, user, ok_cb, false) 
            end 
            if is_support(msg.from.id) and not is_owner2(msg.from.id) then 
               local receiver = get_receiver(msg) 
               local user = "user#id"..msg.from.id 
               savelog(msg.to.id, name_log.." Support member ["..msg.from.id.."] joined the SuperGroup") 
               channel_set_mod(receiver, user, ok_cb, false) 
            end 
         end 
         if action == 'chat_add_user' then 
            if is_owner2(msg.action.user.id) then 
               local receiver = get_receiver(msg) 
               local user = "user#id"..msg.action.user.id 
               savelog(msg.to.id, name_log.." Admin ["..msg.action.user.id.."] added to the SuperGroup by [ "..msg.from.id.." ]") 
               channel_set_admin(receiver, user, ok_cb, false) 
            end 
            if is_support(msg.action.user.id) and not is_owner2(msg.action.user.id) then 
               local receiver = get_receiver(msg) 
               local user = "user#id"..msg.action.user.id 
               savelog(msg.to.id, name_log.." Support member ["..msg.action.user.id.."] added to the SuperGroup by [ "..msg.from.id.." ]") 
               channel_set_mod(receiver, user, ok_cb, false) 
            end 
         end 
      end 
      if matches[1] == 'msg.to.peer_id' then 
         post_large_msg(receiver, msg.to.peer_id) 
      end 
   end 
end 

local function pre_process(msg) 
  if not msg.text and msg.media then 
    msg.text = '['..msg.media.type..']' 
  end 
  return msg 
end 

return { 
  patterns = { 
   "^(تفعيل)$", 
   "^(الغاء تفعيل)$", 
   --"^([Mm]ove) (.*)$", 
   "^(معلومات المجموعة)$", 
   "^(الادارين)$", 
   "^(المشرف)$", 
   "^(الادمنية)$", 
   "^(كشف بوت)$", 
   "^(عدد الاعضاء)$", 
   "^(المطرودين)$", 
        "^(طرد) (.*)", 
   "^(طرد)", 
       "^(طرد (.*)", 
   "^(طرد)", 
   "^(تحويل سوبر)$", 
   "^(ايدي)$", 
   "^(ايدي) (.*)$", 
   "^(مغادرة)$", 
   "^(رابط جديد)$", 
   "^(وضع رابط)$", 
   "^(الرابط)$", 
   "^([Rr]es) (.*)$", 
   "^(رفع اداري) (.*)$", 
   "^(رفع اداري)", 
   "^(تنزيل اداري) (.*)$", 
   "^(تنزيل اداري)", 
   "^(رفع مشرف) (.*)$", 
   "^(رفع مشرف)$", 
   "^(رفع ادمن) (.*)$", 
   "^(رفع ادمن)", 
   "^(تنزيل ادمن) (.*)$", 
   "^(تنزيل ادمن)", 
   "^(ضع اسم) (.*)$", 
   "^(ضع وصف) (.*)$", 
   "^(ضع قوانين) (.*)$", 
   "^(ضع صورة)$", 
   "^(ضع معرف) (.*)$", 
   "^([Dd]el)$", 
   "^(قفل) (.*)$", 
   "^(فتح) (.*)$", 
   "^(قفل) ([^%s]+)$", 
   "^(فتح) ([^%s]+)$", 
   "^(كتم)$", 
   "^(كتم) (.*)$", 
   "^(كتم)$", 
   "^(كتم) (.*)$", 
   --"^([Pp]ublic) (.*)$", 
   "^(الاعدادات)$", 
   "^(القوانين)$", 
   "^(ضع التكرار) (%d+)$", 
   "^(حذف) (.*)$", 
   "^([Hh]elp)$", 
   "^(اعدادات الكتم)$", 
   "^(المكتومين)$", 
    --"(mp) (.*)", 
   --"(md) (.*)", 
    "^(https://telegram.me/joinchat/%S+)$", 
   "msg.to.peer_id", 
   "%[(document)%]", 
   "%[(photo)%]", 
   "%[(video)%]", 
   "%[(audio)%]", 
   "%[(contact)%]", 
   "^!!tgservice (.+)$", 
  }, 
  run = IQ_ABS, 
  pre_process = pre_process 
} 

--[[ تم التعطيل والتعريب بواسطه @xXxDev_iqxXx

  _____              _           
|  ___|_ _  ___  __| | ___ _ __ 
| |_ / _` |/ _ \/ _` |/ _ \ '__|
|  _| (_| |  __/ (_| |  __/ |   
|_|  \__,_|\___|\__,_|\___|_|   
                    
--]]
