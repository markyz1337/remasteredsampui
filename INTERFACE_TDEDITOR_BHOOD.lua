	
local se = require 'lib.samp.events'

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end
		
	wait(-1)
end


function se.onShowTextDraw(id, data)
	if id == 250 then -- server name
		data.position.x = data.position.x - 10
		data.position.y = data.position.y - 9
	end

	if id == 2123 then -- name text
		data.position.x = data.position.x - 9
		data.position.y = data.position.y - 9
	end
	
	if id == 2124 then -- payday text
		data.position.x = data.position.x - 1
		data.position.y = data.position.y - 9
	end

	if id == 2117 then -- speedometru text
		data.position.x = data.position.x + 60
		data.position.y = data.position.y - 10
		data.letterHeight = data.letterHeight / 0.95
		data.letterWidth = data.letterWidth / 1.35
	end

	return {id, data}
end
