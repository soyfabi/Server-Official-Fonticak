local bastionAccess = Action()

function bastionAccess.onUse(player, item, fromPosition, target, toPosition, isHotkey)

	if target.itemid ~= 27836 then
		return false
	end
	
	local currentTime = os.date("%H:%M") -- get current server time in format HH:MM
	if currentTime >= "20:00" and currentTime <= "22:59" then
		if target:getId() == 27836 and player:getStorageValue(Storage.TheSecretLibrary.FalconBastionAccess) == 1 then
			player:teleportTo(Position{x = 33357, y = 31308, z = 4})
			player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You mix the chalk with a drop of your blood and a bit of water and renew the symbol on the floor.")
		else
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Nothing happens. Maybe something more is required here.")
		end
	else
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You can only cross when it is night.")
	end
	return true
end

bastionAccess:id(28468)
bastionAccess:register()
