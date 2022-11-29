local sampev = require 'lib.samp.events'
local tds = {172,173,174,2126,2127,2131} --айди текстдравов

function sampev.onShowTextDraw(id, data)
    for i = 1, #tds do
        if id == tds[i] then return false end
    end
end