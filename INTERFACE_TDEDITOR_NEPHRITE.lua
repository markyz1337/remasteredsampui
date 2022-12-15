
local se = require 'lib.samp.events'

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end
		
	wait(-1)
end


function se.onShowTextDraw(id, data)
	if id == 47 then -- server name
		data.position.x = data.position.x - 10
		data.position.y = data.position.y - 9
	end
	
	if id == 129 then -- inventar boxul de jos
        data.boxColor = 0xFF000000
	end

	if id == 130 then -- inventar veh accs misc etc
		data.position.x = data.position.x - 432
		data.position.y = data.position.y - 73
		data.style = 3
        data.boxColor = 0xFF000000
	end
	
	if id == 131 then -- inventar veh accs misc etc
		data.position.x = data.position.x - 432
		data.position.y = data.position.y - 73
		data.style = 3
        data.boxColor = 0xFF000000
	end
	
	if id == 132 then -- inventar veh accs misc etc
		data.position.x = data.position.x - 432
		data.position.y = data.position.y - 73
		data.style = 3
        data.boxColor = 0xFF000000
	end
	
	if id == 133 then -- inventar veh accs misc etc
		data.position.x = data.position.x - 432
		data.position.y = data.position.y - 73
		data.style = 3
        data.boxColor = 0xFF000000
	end
	
	if id == 134 then -- inventar veh accs misc etc
		data.position.x = data.position.x - 432
		data.position.y = data.position.y - 73
		data.style = 3
        data.boxColor = 0xFF000000
	end
	
	if id == 2168 then -- inventory vehicles
		data.style = 3
        data.boxColor = 0xFF000000
	end
	
	if id == 2170 then -- inventory numele jucatorului
		data.style = 3
        data.boxColor = 0xFF000000
	end
	
	if id == 2174 then -- inventory hunger
		data.style = 3
	end
	
	if id == 2178 then -- inventory hunger
		data.style = 3
	end
	
	if id == 2177 then -- inventory thirst
		data.style = 3
	end
	
	if id == 2179 then -- inventory thirst
		data.style = 3
	end
	
	if id == 2180 then -- inventory level
		data.style = 3
	end
	
	if id == 2079 then -- payday text
		data.position.x = data.position.x - 10
		data.position.y = data.position.y - 9
	end
	
	if id == 2051 then  -- collect honey text
		data.position.x = data.position.x - 10
		data.position.y = data.position.y - 9
	end
	
	if id == 2119 then -- harvest farm text
		data.position.x = data.position.x - 10
		data.position.y = data.position.y - 9
	end
	
	if id == 2084 then -- speedometru text
		data.position.x = data.position.x - 1
		data.position.y = data.position.y - 4
		data.letterHeight = data.letterHeight / 1.22
		data.letterWidth = data.letterWidth * 1.15
		data.style = 3
	end
	
	if id == 2080 then -- find player text
		data.position.x = data.position.x - 10
		data.position.y = data.position.y + 55
		data.letterHeight = data.letterHeight / 1.19
		data.letterWidth = data.letterWidth / 1.19
	end
	
	if id == 14 then -- friends
		data.position.x = data.position.x - 30
		data.position.y = data.position.y - 40
		data.letterHeight = data.letterHeight / 1.19
		data.letterWidth = data.letterWidth / 1.19
	end
	
	if id == 2111 then -- friends
		data.position.x = data.position.x - 30
		data.position.y = data.position.y - 40
		data.letterHeight = data.letterHeight / 1.19
		data.letterWidth = data.letterWidth / 1.19
	end
	
	if id == 2112 then -- friends
		data.position.x = data.position.x - 30
		data.position.y = data.position.y - 40
		data.letterHeight = data.letterHeight / 1.19
		data.letterWidth = data.letterWidth / 1.19
	end

	if id == 2114 then -- REWARD TEXTUL
		data.position.y = data.position.y + 600
	end
	
	return {id, data}
end
