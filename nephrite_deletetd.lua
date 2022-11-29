local sampev = require 'lib.samp.events'
local tds = {0,1,43,44,45,81,82,83,84,2078,2089,2070,2071,2091,2082,2083,2069,2113} --айди текстдравов

function sampev.onShowTextDraw(id, data)
    for i = 1, #tds do
        if id == tds[i] then return false end
    end
end