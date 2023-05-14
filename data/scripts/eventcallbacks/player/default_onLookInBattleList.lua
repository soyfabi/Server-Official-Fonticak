local event = Event()
event.onLookInBattleList = function(self, creature, distance)
	local description = "You see " .. creature:getDescription(distance)
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
	
	-- Look KILL AND DEATH -- 
	if thing:isPlayer() then
		local killStorage = 3000
		local deathStorage = 3001
		local killAmount, deathAmount = thing:getStorageValue(killStorage), thing:getStorageValue(deathStorage)
		if killAmount == -1 then killAmount = 0 end
		if deathAmount == -1 then deathAmount = 0 end
		description = description .. '\nKilled: [' ..killAmount..'] and ' .. 'Dieds: ['..deathAmount..']'
		self:sendTextMessage(MESSAGE_INFO_DESCR, description)
	end
	
	-- Look KD of Player --
	if thing:isPlayer() then
			local KD = (math.max(0, thing:getStorageValue(STORAGEVALUE_KILLS)) + math.max(0, thing:getStorageValue(STORAGEVALUE_ASSISTS))) / math.max(1, thing:getStorageValue(STORAGEVALUE_DEATHS))
			description = string.format("%s\nKD: [%0.2f]", description, KD)
	end
	
	-- Look Show Health Monster in Percentage --
	if thing:isCreature() and thing:isMonster() then
	description = "".. description .."\nHealth: ["..math.floor((thing:getHealth() / thing:getMaxHealth()) * 100).."%]"
	self:sendTextMessage(MESSAGE_INFO_DESCR, description)
    end
	
	-- Look Experience Monsters --
	if thing:isCreature() and thing:isMonster() then
        local exp = thing:getType():getExperience() -- get monster experience
        exp = exp * Game.getExperienceStage(self:getLevel()) -- apply experience stage multiplier
        if configManager.getBoolean(configKeys.STAMINA_SYSTEM) then -- check if stamina system is active on the server
            local staminaMinutes = self:getStamina()
            if staminaMinutes > 2340 and self:isPremium() then -- 'happy hour' check
                exp = exp * 1.5
            elseif staminaMinutes <= 840 then -- low stamina check
                exp = exp * 0.5
            end
        end
        description = string.format("%s\nEstimated of Exp: [%d]", description, exp)
    end
	
	-- Look Shop NPC -- 
	if (thing:isCreature() and thing:isNpc() and distance <= 3) then
		local description = "Are you talking to " .. thing:getDescription(distance)
		self:say("hi", TALKTYPE_PRIVATE_PN, false, thing)
		self:say("trade", TALKTYPE_PRIVATE_PN, false, thing)
		self:sendTextMessage(MESSAGE_INFO_DESCR, description)
		return false
	end
	
	-- Look Inspecting -- 
	if thing:isPlayer() and not self:getGroup():getAccess() then
        thing:sendTextMessage(MESSAGE_STATUS_DEFAULT,"The player [".. self:getName() .. '] looking at you.')
    end
	
	if self:getGroup():getAccess() then
		local str = "%s\nHealth: %d / %d"
		if creature:isPlayer() and creature:getMaxMana() > 0 then
			str = string.format("%s, Mana: %d / %d", str, creature:getMana(), creature:getMaxMana())
		end
		description = string.format(str, description, creature:getHealth(), creature:getMaxHealth()) .. "."

		local position = creature:getPosition()
		description = string.format(
			"%s\nPosition: %d, %d, %d",
			description, position.x, position.y, position.z
		)

		if creature:isPlayer() then
			description = string.format("%s\nIP: %s.", description, thing:getIp())
		end
	end
	-- Look Position -- 
		local position = thing:getPosition()
		description = string.format(
			"%s\nPosition: [X: %d], [Y: %d], [Z: %d].",
			description, position.x, position.y, position.z
		)
	return description
end

event:register()
