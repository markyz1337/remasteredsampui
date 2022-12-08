
local se = require 'lib.samp.events'

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end
		
	wait(-1)
end


function se.onShowTextDraw(id, data)
	if id == 0 then -- server name
		data.position.x = data.position.x + 10
		data.position.y = data.position.y - 11
		data.letterHeight = data.letterHeight * 1.27
		data.letterWidth = data.letterWidth / 1.06
		data.style = 3
		data.letterColor = -00000001
	end

	if id == 2054 then -- speedometru text combustibil
		data.position.x = data.position.x + 45
		data.position.y = data.position.y + 255
		data.letterHeight = data.letterHeight / 1.19
		data.letterWidth = data.letterWidth / 2.54
		data.style = 2
	end


	if id == 2056 then -- speedometru text kilometraj
		data.position.x = data.position.x + 45
		data.position.y = data.position.y + 195
		data.letterHeight = data.letterHeight / 1.15
		data.letterWidth = data.letterWidth / 2.54
		data.style = 2
	end
	
	if id == 2059 then -- speedometru text descuiat
		data.position.x = data.position.x + 50
		data.position.y = data.position.y + 178
		data.letterHeight = data.letterHeight / 1.19
		data.letterWidth = data.letterWidth / 2.54
		data.style = 2
	end
	
	if id == 2053 then -- find player text
		data.position.x = data.position.x - 10
		data.position.y = data.position.y + 55
		data.letterHeight = data.letterHeight / 1.19
		data.letterWidth = data.letterWidth / 1.19
	end

	if id == 2078 then -- reward text
		data.position.x = data.position.x + 278
		data.position.y = data.position.y - 14
		data.letterHeight = data.letterHeight / 1.29
		data.letterWidth = data.letterWidth / 1.36
		data.style = 2
	end
	
	if id == 2065 then -- friends
		data.position.x = data.position.x + 200
		data.position.y = data.position.y - 275
		data.letterHeight = data.letterHeight / 1.19
		data.letterWidth = data.letterWidth / 1.19
	end
	
	if id == 2082 then -- JobGoal
		data.position.x = data.position.x - 24
		data.position.y = data.position.y + 12
		data.letterHeight = data.letterHeight / 1.49
		data.letterWidth = data.letterWidth /1.59
	end
	
	if id == 2083 then -- JobGoal
		data.position.x = data.position.x - 24
		data.position.y = data.position.y + 12
		data.letterHeight = data.letterHeight / 1.49
		data.letterWidth = data.letterWidth /1.59
	end
	
	if id == 2080 then -- JobGoal
		data.position.x = data.position.x - 24
		data.position.y = data.position.y + 1
		data.letterHeight = data.letterHeight / 1.49
		data.letterWidth = data.letterWidth /1.59
	end
	
	if id == 2081 then -- JobGoal
		data.position.x = data.position.x - 24
		data.position.y = data.position.y + 1
		data.letterHeight = data.letterHeight / 1.49
		data.letterWidth = data.letterWidth /1.59
	end
	
	if id == 2084 then -- JobGoal
		data.position.x = data.position.x - 24
		data.position.y = data.position.y - 11
		data.letterHeight = data.letterHeight / 1.49
		data.letterWidth = data.letterWidth /1.59
	end
	
	if id == 2085 then -- JobGoal
		data.position.x = data.position.x - 24
		data.position.y = data.position.y - 11
		data.letterHeight = data.letterHeight / 1.49
		data.letterWidth = data.letterWidth /1.59
	end

	if id == 20000 then -- REWARD TEXTUL
		data.position.y = data.position.y + 600
	end
	
	return {id, data}
end