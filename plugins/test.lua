—]]
do 
local function iq_100k(msg, matches) 
local w = matches[1]
local r = reply_msg
local rr = msg['id']
local o = ok_cb
local f = false
local rdod = "on" ..msg.to.id
------------------------------------------------
if is_momod(msg) and w=="فتح الردود" then
local rdod = "on" ..msg.to.id
redis:set(rdod,true)
r(rr, "تم ✔️ تشغيل الردود 🔊 ", o, f) 
end
if is_momod(msg) and w=="قفل الردود" then
redis:del(rdod)
r(rr, "تم ✔️ تعطيل الردود 🔇", o, f) 
end
------------------------------------------------
