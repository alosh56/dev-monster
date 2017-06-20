--[[
__________________________________
|  |__________________________|  |
|  |                          |  |
|  |By : @AhMaD_X7            |  | 
|  |CH : @B7_78               |  |
|  |DeV : @TawaslAhmad_BoT    |  |
|  |De2 : @sofey_iq           |  |
|  |__________________________|  |
|__|__________________________|__|
--]] 
function speedo(msg, matches)

if not is_sudo(msg) then

return 

end

text = io.popen("speedtest-cli "):read('*all')

  return 'جـاري تسـريـع البـوت 🚀🌀'

end

return {

  patterns = {

    '^تسريع البوت$'

  },

  run = speedo,

  moderated = true

}

--[[
__________________________________
|  |__________________________|  |
|  |                          |  |
|  |By : @AhMaD_X7            |  | 
|  |CH : @B7_78               |  |
|  |DeV : @TawaslAhmad_BoT    |  |
|  |De3 : @sofey_iq           |  |
|  |__________________________|  |
|__|__________________________|__|
--]] 