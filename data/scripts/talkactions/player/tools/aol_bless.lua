local Bless = TalkAction("!bless", "!bles", "!blessing")
function Bless.onSay(player, words, param)
	local bless = 5
	local allBless = 0
	for i = 1, bless do
		if player:hasBlessing(i) then
			allBless = allBless + 1
		end
	end

	if allBless == bless then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "You already have all blessings.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return false
	end
	
	if player:removeTotalMoney(30000) then
		for i = 1, bless do
			player:addBlessing(i)
		end
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have been blessed by the gods!")
		player:getPosition():sendMagicEffect(CONST_ME_FIREWORK_YELLOW)
	else
		player:sendTextMessage(MESSAGE_STATUS_CONSOLE_RED, "You don't have 30K gold coins for buy bless. Cost: [30K = 3 CC].")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end

	return false
end

Bless:register()

local Aol = TalkAction("!aol", "!ao", "!aool", "!amulet of loss")
local exhaust = {}
local exhaustTime = 2
function Aol.onSay(player, words, param)
	local playerId = player:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        player:sendCancelMessage("This Command is still on cooldown. (0." .. exhaust[playerId] - currentTime .. "s).")
        return false
    end

	if player:removeTotalMoney(10000) then
		player:addItem(3057, 1)
		player:getPosition():sendMagicEffect(CONST_ME_MAGIC_GREEN)
		player:say("You bought an Aol.")
		exhaust[playerId] = currentTime + exhaustTime
	else
		player:sendCancelMessage("You dont have enought 10K gold coins for buy an Aol. Cost: [10K = 1 CC].")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	end
	
	return false
end

Aol:register()

