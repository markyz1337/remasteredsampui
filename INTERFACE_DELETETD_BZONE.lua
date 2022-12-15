local sampev = require 'lib.samp.events'
local tds = {2057,2,3,44,2086,2087,2076,2077,2055} --айди текстдравов

function sampev.onShowTextDraw(id, data)
    for i = 1, #tds do
        if id == tds[i] then return false end
    end
end
