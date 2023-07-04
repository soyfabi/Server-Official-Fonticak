local fastSpawn = Action()

local fastSpawn = TalkAction("!spawnrate","!spawn", "/spawnrate", "/spawn")
local exhaust = {}
local exhaustTime = 2
function fastSpawn.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This Commands is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end

	local rate = Game.getSpawnRate()
	local text = "[Respawn System]\nThe system works according to the online players, every 100 players increase a x1 spawn rate.\n------------\nThe current spawn where the server is: "

	if rate == 1 then
		text = text .. "Normal!"
	else
		text = text .. rate .."x more faster!"
	end
	
	exhaust[playerId] = currentTime + exhaustTime
	player:popupFYI(text)
	return false
end

fastSpawn:register()