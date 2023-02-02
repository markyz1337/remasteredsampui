
local se = require 'lib.samp.events'

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end
		
	wait(-1)
end


function se.onShowTextDraw(id, data)
	if id == 4 then -- o text
		data.position.x = data.position.x - 5
		data.position.y = data.position.y - 6
		data.letterHeight = data.letterHeight * 1.30
		data.letterWidth = data.letterWidth * 1.15
		data.style = 3
	end

	if id == 3 then -- g text
		data.position.x = data.position.x - 1.8
		data.position.y = data.position.y - 4
		data.letterHeight = data.letterHeight / 1.75
		data.letterWidth = data.letterWidth / 2.14
		data.style = 3
	end

	if id == 5 then -- times text
		data.position.x = data.position.x - 5
		data.position.y = data.position.y - 10
		data.letterWidth = data.letterWidth / 1.20
		data.style = 3
	end

	if id == 6 then -- earth tex
		data.position.x = data.position.x - 10
		data.position.y = data.position.y - 10
		data.style = 3
	end


	if id == 2056 then -- speedometru text kilometraj
		data.position.x = data.position.x + 45
		data.position.y = data.position.y + 195
		data.letterHeight = data.letterHeight / 1.15
		data.letterWidth = data.letterWidth / 2.54
		data.style = 2
	end
	
	return {id, data}
end
