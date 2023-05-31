-- Theodore Loveless' key

local theThievesKey = Action()

local position = Position(32359, 32788, 6)

function theThievesKey.onUse(player, item, fromPosition, target, toPosition, isHotkey)
	if player:getStorageValue(Storage.ThievesGuild.Mission06) == 2 then
		if target.actionid == 51394 and item.itemid == 7934 then
			player:removeItem(7934, 1)
			player:teleportTo(position)
			player:say('In your haste you break the key while slipping in.', TALKTYPE_MONSTER_SAY, false, player, position)
			return true
		end
	end
	return false
end

theThievesKey:id(7934)
theThievesKey:register()
