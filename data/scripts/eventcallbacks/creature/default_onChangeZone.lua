local event = Event()

local exhaust = {}
local exhaustTime = 20

function event.onChangeZone(self, fromZone, toZone)
    if not self then
        return false
    end
	
	local playerId = self:getId()
    local currentTime = os.time()
    if exhaust[playerId] and exhaust[playerId] > currentTime then
        return false
    end
	
	-- Blessing Protect --
	if not self:hasBlessing(5) then
		if not self then return false end
		if toZone == ZONE_NORMAL then
			if self:getSlotItem(CONST_SLOT_NECKLACE) and self:getSlotItem(CONST_SLOT_NECKLACE):getId() == 3057 then
				return false
			end
			if self:getBankBalance() > 10000 then
				self:popupFYI("[PROTECT BLESS]\n\nBe careful you have NO Bless.\nTo buy bless use the command: !bless\nor you could lose everything, or use an Amulet of loss.\nIn the bank you have:\n["..self:getBankBalance().." gold coins].")
			else
				self:popupFYI("[PROTECT BLESS]\n\nBe careful you have NO Bless.\nTo buy bless use the command: !bless\nor you could lose everything, or use an Amulet of loss.")
			end
			exhaust[playerId] = currentTime + exhaustTime
		end
	end
	
    local playerId = self:getId()
    local event = staminaBonus.eventsPz[playerId]
	
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
                    staminaBonus.eventsPz[playerId] = addEvent(addStamina, delay * 60 * 1000, nil, playerId, delay * 60 * 1000)
                end
            else
                if event then
                    self:sendTextMessage(MESSAGE_STATUS_SMALL, "You are no longer refilling stamina, since you left a regeneration zone.")
                    stopEvent(event)
                    staminaBonus.eventsPz[playerId] = nil
                end
            end
            return not configManager.getBoolean(configKeys.STAMINA_PZ)
        end
    end
    return false
end

event:register()