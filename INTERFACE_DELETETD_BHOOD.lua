local sampev = require 'lib.samp.events'
local tds = {239,240,241,2114,2118,2119} --айди текстдравов

function sampev.onShowTextDraw(id, data)
    for i = 1, #tds do
        if id == tds[i] then return false end
    end
end
