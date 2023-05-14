local event = Event()
function event.onChangeZone(self, fromZone, toZone)
	local event = staminaBonus.eventsPz[self:getId()]
	if configManager.getBoolean(configKeys.STAMINA_PZ) then
		if toZone == ZONE_PROTECTION then
			if self:getStamina() < 2520 then
				if not event then
						local delay = configManager.getNumber(configKeys.STAMINA_ORANGE_DELAY)
						if self:getStamina() > 2400 and self:getStamina() <= 2520 then
							delay = configManager.getNumber(configKeys.STAMINA_GREEN_DELAY)
						end
						self:sendTextMessage(MESSAGE_STATUS_SMALL,
                                             string.format("In protection zone. Every %i minutes, gain %i stamina.",
                                                           delay, configManager.getNumber(configKeys.STAMINA_PZ_GAIN)
                                             )
                        )
						staminaBonus.eventsPz[self:getId()] = addEvent(addStamina, delay * 60 * 1000, nil, self:getId(), delay * 60 * 1000)
					end
				end
				else
				if event then
					self:sendTextMessage(MESSAGE_STATUS_SMALL, "You are no longer refilling stamina, since you left a regeneration zone.")
					stopEvent(event)
					staminaBonus.eventsPz[self:getId()] = nil
					end
			end
			return not configManager.getBoolean(configKeys.STAMINA_PZ)
		end
	return false
end

event:register()
