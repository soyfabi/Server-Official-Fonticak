local exp = Action()

function exp.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local xpPot = expPotion[item:getId()]
	if not xpPot then
		return false
	end

	if player:getStorageValue(Storage.STORAGEVALUE_POTIONXP_ID) >= 1 or player:getStorageValue(Storage.STORAGEVALUE_POTIONXP_TEMPO) > os.time() then
		player:sendCancelMessage("You already have a double experience activated.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	--[[if not item:remove() then
		player:sendCancelMessage("You don't have any kind of experience potion.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end]]

	player:sendCancelMessage("You activate an experience bonus of +".. xpPot.exp .."% for ".. xpPot.tempo .." hour".. (xpPot.tempo > 1 and "s" or "") ..".")
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
	player:setStorageValue(Storage.STORAGEVALUE_POTIONXP_ID, item:getId())
	player:setStorageValue(Storage.STORAGEVALUE_POTIONXP_TEMPO, os.time() + 5000)
	local idPlayer = player:getId()
	
	local INTERVAL = 2 
	
	local function executeEffect()
        local player = Player(idPlayer)
        if player then
            player:getPosition():sendMagicEffect(CONST_ME_MAGIC_RED)
        end
    end

    local effectTimer = nil

    effectTimer = addEvent(function()
        executeEffect()
        effectTimer = addEvent(executeEffect, INTERVAL * 1000)
    end, INTERVAL * 1000)
		
	addEvent(function()
		local player = Player(idPlayer)
		if player then
			player:clearStorageValue(Storage.STORAGEVALUE_POTIONXP_ID)
			player:clearStorageValue(Storage.STORAGEVALUE_POTIONXP_TEMPO)
			player:sendCancelMessage("Your time with double experience is over.")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
			stopEvent(effectTimer)
		end
	end, 5000)
	return true
end

for i, value in pairs(expPotion) do
	exp:id(i)
end

exp:register()

local event = Event()
event.onGainExperience = function(self, source, exp, rawExp)

	local xpPotion = 0
	if self:getStorageValue(Storage.STORAGEVALUE_POTIONXP_TEMPO) > os.time() then
		local potion = expPotion[self:getStorageValue(Storage.STORAGEVALUE_POTIONXP_ID)]
		if potion then
			xpPotion = exp * potion.exp / 100
		end
	end
	
	return exp + xpPotion
end

event:register()

local xp = CreatureEvent("XpBonus")
function xp.onLogin(player)
	
	-- XP Potion
	if player:getStorageValue(Storage.STORAGEVALUE_POTIONXP_ID) ~= -1 and player:getStorageValue(Storage.STORAGEVALUE_POTIONXP_TEMPO) <= os.time() then
		player:clearStorageValue(Storage.STORAGEVALUE_POTIONXP_ID)
		player:clearStorageValue(Storage.STORAGEVALUE_POTIONXP_TEMPO)
		player:sendCancelMessage("Your time with double experience is over.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	elseif player:getStorageValue(Storage.STORAGEVALUE_POTIONXP_ID) ~= -1 and player:getStorageValue(Storage.STORAGEVALUE_POTIONXP_TEMPO) > os.time() then
		local idPlayer = player:getId()
		addEvent(function()
			local player = Player(idPlayer)
			if player then
				player:clearStorageValue(Storage.STORAGEVALUE_POTIONXP_ID)
				player:clearStorageValue(Storage.STORAGEVALUE_POTIONXP_TEMPO)
				player:sendCancelMessage("Your time with double experience is over.")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		end, (player:getStorageValue(Storage.STORAGEVALUE_POTIONXP_TEMPO) - os.time()) * 2)
	end
	
	-- Loot Potion
	if player:getStorageValue(Storage.STORAGEVALUE_LOOT_ID) ~= -1 and player:getStorageValue(Storage.STORAGEVALUE_LOOT_TEMPO) <= os.time() then
		player:clearStorageValue(Storage.STORAGEVALUE_LOOT_ID)
		player:clearStorageValue(Storage.STORAGEVALUE_LOOT_TEMPO)
		player:sendCancelMessage("O seu tempo de loot bônus pela poção acabou!")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
	elseif player:getStorageValue(STORAGEVALUE_LOOT_ID) ~= -1 and player:getStorageValue(Storage.STORAGEVALUE_LOOT_TEMPO) > os.time() then
		local idPlayer = player:getId()
		addEvent(function()
			local player = Player(idPlayer)
			if player then
				player:clearStorageValue(Storage.STORAGEVALUE_LOOT_ID)
				player:clearStorageValue(Storage.STORAGEVALUE_LOOT_TEMPO)
				player:sendCancelMessage("O seu tempo de loot bônus pela poção acabou!")
				player:getPosition():sendMagicEffect(CONST_ME_POFF)
			end
		end, (player:getStorageValue(Storage.STORAGEVALUE_LOOT_TEMPO) - os.time()) * 1000)
	end

	return true
end

xp:register()

local loot = Action()

function loot.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	local lootPot = lootPotion[item:getId()]
	if not lootPot then
		return false
	end

	if player:getStorageValue(Storage.STORAGEVALUE_LOOT_ID) >= 1 or player:getStorageValue(Storage.STORAGEVALUE_LOOT_TEMPO) > os.time() then
		player:sendCancelMessage("Você já possui algum bônus de loot.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end

	--[[if not item:remove() then
		player:sendCancelMessage("Você não possui nenhum tipo de poção de loot bônus.")
		player:getPosition():sendMagicEffect(CONST_ME_POFF)
		return true
	end]]


	player:sendCancelMessage("Você ativou um bônus de loot de +".. lootPot.exp .."% por ".. lootPot.tempo .." hora".. (lootPot.tempo > 1 and "s" or "") ..".")
	player:getPosition():sendMagicEffect(31)
	player:setStorageValue(Storage.STORAGEVALUE_LOOT_ID, item:getId())
	player:setStorageValue(Storage.STORAGEVALUE_LOOT_TEMPO, os.time() + 2 * 1000)
	local idPlayer = player:getId()
	addEvent(function()
		local player = Player(idPlayer)
		if player then
			player:clearStorageValue(Storage.STORAGEVALUE_LOOT_ID)
			player:clearStorageValue(Storage.STORAGEVALUE_LOOT_TEMPO)
			player:sendCancelMessage("O seu tempo de loot bônus pela poção acabou!")
			player:getPosition():sendMagicEffect(CONST_ME_POFF)
		end
	end, 2 * 1000)
	return true
end

for i, value in pairs(lootPotion) do
	loot:id(i)
end
loot:register()