local servantTeleport = MoveEvent()

function servantTeleport.onStepIn(creature, item, position, fromPosition)
	local player = creature:getPlayer()
	if not player then
		return
	end

	if player:getStorageValue(Storage.ForgottenKnowledge.LloydTimer) >= os.time() then
		local timeremaining = player:getStorageValue(Storage.ForgottenKnowledge.LloydTimer) - os.time()
		if timeremaining > 0 then
			local horasRestantes = math.floor(timeremaining / 3600)
			local minutosRestantes = math.floor((timeremaining % 3600) / 60)
			local segundosRestantes = timeremaining % 60

			local message = "\nYou are still exhausted from your last battle, wait"

			if horasRestantes > 0 then
				message = message .. string.format(' %d hours', horasRestantes)
			end

			if minutosRestantes > 0 then
				message = message .. string.format(' %d minutes', minutosRestantes)
			end

			if segundosRestantes > 0 then
				message = message .. string.format(' %d seconds', segundosRestantes)
			end

			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "You have to wait to challenge this enemy again!"..message..".")
		end
		player:teleportTo(Position(32815, 32872, 13))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		position:sendMagicEffect(CONST_ME_TELEPORT)
		return true
	end
	if player:getStorageValue(Storage.ForgottenKnowledge.GoldenServantCounter) >= 1
	and player:getStorageValue(Storage.ForgottenKnowledge.DiamondServantCounter) >= 1 then
		player:teleportTo(Position(32759, 32875, 14))
		player:getPosition():sendMagicEffect(CONST_ME_ENERGYHIT)
	return true
	else
		player:teleportTo(Position(32815, 32872, 13))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		position:sendMagicEffect(CONST_ME_TELEPORT)
		player:say('Seems that you don\'t absorb enough energy to use this portal.',
		TALKTYPE_MONSTER_SAY, false, nil, position)
	end
	return true
end

servantTeleport:type("stepin")
servantTeleport:aid(26665)
servantTeleport:register()
