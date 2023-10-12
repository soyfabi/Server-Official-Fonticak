local theOutlawPowerSwitch = Action()

local exhaust = {}
local exhaustTime = 2

function theOutlawPowerSwitch.onUse(player, item, fromPosition, target, toPosition, isHotkey)
    
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
		player:sendCancelMessage("You are on cooldown, now wait (0." .. exhaust[playerId] - currentTime .. "s).")
		return true
	end
	
	local wallID = 1271
    local wallPosition = Position({x = 32604, y = 32216, z = 9})
    local power2pos = Position({x = 32613, y = 32220, z = 10})
    local power1pos = Position({x = 32594, y = 32214, z = 9})
    local power1 = power1pos:getTile()
    local wallTile = wallPosition:getTile()

    if item.itemid == 2772 and power1:getItemById(3050) then
        if wallTile and wallTile:getItemById(wallID) then
            power1:getItemById(3050):moveTo(power2pos)
            wallTile:getItemById(wallID):remove()
            power1pos:sendMagicEffect(CONST_ME_MAGIC_GREEN)
			player:say('*rrrshhh*', TALKTYPE_MONSTER_SAY, false, player, wallPosition)	
            addEvent(function()
				Position(wallPosition):hasCreature({x = 32604, y = 32217, z = 9})
                Game.createItem(wallID, 1, wallPosition)
            end, 30000)
        end
    end

	exhaust[playerId] = currentTime + exhaustTime
    player:say("Place a power ring on the table.")
    item:transform(item.itemid == 2772 and 2773 or 2772)
    return true
end

theOutlawPowerSwitch:uid(3401)
theOutlawPowerSwitch:register()