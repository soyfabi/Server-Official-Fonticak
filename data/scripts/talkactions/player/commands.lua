local commands = TalkAction("!commands","!commandos", "/commands", "!command")
local exhaust = {}
local exhaustTime = 2
function commands.onSay(player, words, param)

	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This Commands is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end
	
	local commands = Settings.playerTalkactionsCommands
	player:popupFYI(commands)
	exhaust[playerId] = currentTime + exhaustTime
	
	return false
end

commands:register()
