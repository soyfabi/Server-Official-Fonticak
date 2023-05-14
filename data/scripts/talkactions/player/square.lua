function Game.guildLeaderSquare(playerId)
	player = Player(playerId)
	if not player then
		return false
	end

	local playerId = player:getId()

	spectators = Game.getSpectators(player:getPosition(), true, true, 0, 7, 0, 7)
	for _, viewers in ipairs(spectators) do
		if player:getGuildLevel() == 3 then
			viewers:sendCreatureSquare(playerId, 215)
		end
	end
	
	addEvent(Game.guildLeaderSquare, 500, playerId)
end



local squarelider = configManager.getBoolean(configKeys.GUILD_SQUARE)
local square = TalkAction("!target","!square")

squareGuild = {}

function repetirSquare(id, color)
    if not squareGuild[id] then
        return false
    end

    squareId = Player(squareGuild[id].target)

    if not squareId then
        return false
    end

    espectator = Game.getSpectators(squareId:getPosition(), true, true, 0, 7, 0, 7)
    for _, viewers in ipairs(espectator) do
        if viewers:getGuild() and viewers:getGuild():getId() == id then
            viewers:sendCreatureSquare(squareId, squareGuild[id].color)
        end
    end

    addEvent(repetirSquare, 500, id, color)
end

function square.onSay(player, words, param)
if squarelider then
    if player:getStorageValue(984145) > os.time() then
        player:sendCancelMessage("You need to wait for the cooldown.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    if not param then
        player:sendCancelMessage("You need to inform the player.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local target = Player(param)
    if not target then
        player:sendCancelMessage("This player does not exist or is not online.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    local guild = player:getGuild()
    
    if not guild then
        player:sendCancelMessage("You need to be part of a guild to use this command.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    if player:getGuildLevel() < 2 then
        player:sendCancelMessage("You must be a (Leader or Vice Leader) to use this command.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    if target:getGuild() and target:getGuild():getId() == guild:getId() then
        player:sendCancelMessage("You cannot target a target from the same guild as yours.")
        player:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end

    squareGuild[guild:getId()] = {target = param, color = 204}
    repetirSquare(guild:getId(), 204)
    player:setStorageValue(984145, os.time() + 1 * 1)
    player:sendCancelMessage("The player ".. target:getName() .. " was placed highlighted until it turns off.")
    target:sendCancelMessage("You were placed player marked ".. player:getName() .." of the guild ".. guild:getName() ..".")
    target:getPosition():sendMagicEffect(7)
end
    return false
end

square:separator(" ")
square:register()


local sqlogin = CreatureEvent("sqlogin")
function sqlogin.onLogin(player)
	if configManager.getBoolean(configKeys.GUILD_SQUARE) and player:getAccountType() < ACCOUNT_TYPE_GAMEMASTER then
		Game.guildLeaderSquare(player:getId())
	end
	return true
end

sqlogin:register()