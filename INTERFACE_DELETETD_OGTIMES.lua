local sampev = require 'lib.samp.events'
local tds = {216, 217, 2267} --айди текстдравов

function sampev.onShowTextDraw(id, data)
    for i = 1, #tds do
        if id == tds[i] then return false end
    end
end

-- 216 jobgoal
-- 217 jobgoal
-- 2267 nick