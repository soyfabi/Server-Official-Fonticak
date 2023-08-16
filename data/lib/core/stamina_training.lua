-- Increase Stamina when Attacking Trainer
staminaBonus = {
	target = 'Training Fonticak',
	period = configManager.getNumber(configKeys.STAMINA_TRAINER_DELAY) * 1000, -- time on miliseconds trainers
	bonus = configManager.getNumber(configKeys.STAMINA_TRAINER_GAIN), -- gain stamina trainers
	eventsTrainer = {}, -- stamina in trainers
	eventsPz = {} -- stamina in Pz
}

function addStamina(playerId, ...)
	-- Creature:onTargetCombat
	if playerId then
		local player = Player(playerId)
		if configManager.getBoolean(configKeys.STAMINA_TRAINER) then
		
			if player:getStamina() == 2520 then
				return true
			end
			
			if not player then
				staminaBonus.eventsTrainer[playerId] = nil
			else
				local target = player:getTarget()
				if not target or target:getName() ~= staminaBonus.target then
					staminaBonus.eventsTrainer[playerId] = nil
				else
					player:setStamina(player:getStamina() + staminaBonus.bonus)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, string.format("%i of stamina has been refilled.", configManager.getNumber(configKeys.STAMINA_TRAINER_GAIN)))
					staminaBonus.eventsTrainer[playerId] = addEvent(addStamina, staminaBonus.period, playerId)
				end
			end
		end
		return not configManager.getBoolean(configKeys.STAMINA_TRAINER)
	end



-- Player:onChangeZone
	local localPlayerId, delay = ...

	if localPlayerId and delay then
		if not staminaBonus.eventsPz[localPlayerId] then return false end
		stopEvent(staminaBonus.eventsPz[localPlayerId])

		local player = Player(localPlayerId)
		if not player then
			staminaBonus.eventsPz[localPlayerId] = nil
			return false
		end

		local actualStamina = player:getStamina()

		if actualStamina > 2400 and actualStamina < 2520 then
			delay = configManager.getNumber(configKeys.STAMINA_GREEN_DELAY) * 60 * 1000 -- Stamina Green 12 min.
		elseif actualStamina == 2520 then
			player:sendTextMessage(MESSAGE_STATUS_SMALL, "You are no longer refilling stamina, \z
                                                         because your stamina is already full.")
			staminaBonus.eventsPz[localPlayerId] = nil
			return false
		end

		player:setStamina(player:getStamina() + configManager.getNumber(configKeys.STAMINA_PZ_GAIN))
		player:sendTextMessage(MESSAGE_STATUS_SMALL,
                               string.format("%i of stamina has been refilled.",
                                             configManager.getNumber(configKeys.STAMINA_PZ_GAIN)
                               )
        )
		staminaBonus.eventsPz[localPlayerId] = addEvent(addStamina, delay, nil, localPlayerId, delay)
		return true
	end
	return false
end