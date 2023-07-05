--[[local monster_hunt = CreatureEvent("MonsterHunt")
function monster_hunt.onKill(player, target)

	if getGlobalStorageValue(MONSTER_HUNT.storages.monster) == nil then
		return true
	end

	if not player or not target then
		return true
	end

	if player:getStorageValue(MONSTER_HUNT.storages.player) == -1 then
		player:setStorageValue(MONSTER_HUNT.storages.player, 0)
	end

	--if player:getStorageValue(MONSTER_HUNT.storages.player) == 1 then
		if target:isMonster() and target:getName() then--:lower() == (MONSTER_HUNT.list[getGlobalStorageValue(MONSTER_HUNT.storages.monster)]):lower() then
			--player:setStorageValue(MONSTER_HUNT.storages.player, player:getStorageValue(MONSTER_HUNT.storages.player) + 1)
			player:sendTextMessage(MESSAGE_STATUS_CONSOLE_ORANGE, MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.kill:format(player:getStorageValue(MONSTER_HUNT.storages.player), target:getName()))
			--table.insert(MONSTER_HUNT.players, {player:getId(), player:getStorageValue(MONSTER_HUNT.storages.player)})
		end
	--end

	return true
end

monster_hunt:register()

monster_huntlogin = CreatureEvent("MonsterHuntLogin")
function monster_huntlogin.onLogin(player)
	player:registerEvent("MonsterHunt")
	
	-- Monster Hunt
	if getGlobalStorageValue(MONSTER_HUNT.storages.monster) == nil then
		player:setStorageValue(MONSTER_HUNT.storages.player, 0)
	end
	
	if player:getStorageValue(MONSTER_HUNT.storages.player) == -1 then
		player:setStorageValue(MONSTER_HUNT.storages.player, 0)
	end
	
	return true
end

monster_huntlogin:register()

local monsterthink = GlobalEvent("MonsterThink")
function monsterthink.onThink(interval)
	if MONSTER_HUNT.days[os.date("%A")] then
		local hrs = tostring(os.date("%X")):sub(1, 5)
		if isInArray(MONSTER_HUNT.days[os.date("%A")], hrs) then
			MONSTER_HUNT:initEvent()
		end
	end
	return true
end

monsterthink:interval(1000) -- 8 hours
monsterthink:register()


local monstertimer = GlobalEvent("MonsterHunter")
function onTime(interval)
	MONSTER_HUNT:endEvent()
	return true
end

monstertimer:interval(180000)
monstertimer:register()
]]