function Game.broadcastMessage(message, messageType)
	if not messageType then
		messageType = MESSAGE_STATUS_WARNING
	end

	for _, player in ipairs(Game.getPlayers()) do
		player:sendTextMessage(messageType, message)
	end
end

function Game.convertIpToString(ip)
	local band = bit.band
	local rshift = bit.rshift
	return string.format("%d.%d.%d.%d",
		band(ip, 0xFF),
		band(rshift(ip, 8), 0xFF),
		band(rshift(ip, 16), 0xFF),
		rshift(ip, 24)
	)
end

function Game.getReverseDirection(direction)
	if direction == WEST then
		return EAST
	elseif direction == EAST then
		return WEST
	elseif direction == NORTH then
		return SOUTH
	elseif direction == SOUTH then
		return NORTH
	elseif direction == NORTHWEST then
		return SOUTHEAST
	elseif direction == NORTHEAST then
		return SOUTHWEST
	elseif direction == SOUTHWEST then
		return NORTHEAST
	elseif direction == SOUTHEAST then
		return NORTHWEST
	end
	return NORTH
end

function Game.getSkillType(weaponType)
	if weaponType == WEAPON_CLUB then
		return SKILL_CLUB
	elseif weaponType == WEAPON_SWORD then
		return SKILL_SWORD
	elseif weaponType == WEAPON_AXE then
		return SKILL_AXE
	elseif weaponType == WEAPON_DISTANCE then
		return SKILL_DISTANCE
	elseif weaponType == WEAPON_SHIELD then
		return SKILL_SHIELD
	end
	return SKILL_FIST
end

if not globalStorageTable then
	globalStorageTable = {}
end

function Game.getStorageValue(key)
	return globalStorageTable[key]
end

function Game.setStorageValue(key, value)
	globalStorageTable[key] = value
end

do
	local quests = {}
	local missions = {}
	local trackedQuests = {}

	function Game.getQuests() return quests end
	function Game.getMissions() return missions end
	function Game.getTrackedQuests() return trackedQuests end

	function Game.getQuestById(id) return quests[id] end
	function Game.getMissionById(id) return missions[id] end

	function Game.clearQuests()
		quests = {}
		missions = {}
		for playerId, _ in pairs(trackedQuests) do
			local player = Player(playerId)
			if player then
				player:sendQuestTracker({})
			end
		end
		trackedQuests = {}
		return true
	end

	function Game.createQuest(name, quest)
		if not isScriptsInterface() then
			return
		end

		if type(quest) == "table" then
			setmetatable(quest, Quest)
			quest.id = -1
			quest.name = name
			if type(quest.missions) ~= "table" then
				quest.missions = {}
			end

			return quest
		end

		quest = setmetatable({}, Quest)
		quest.id = -1
		quest.name = name
		quest.storageId = 0
		quest.storageValue = 0
		quest.missions = {}
		return quest
	end

	function Game.isQuestStorage(key, value, oldValue)
		for _, quest in pairs(quests) do
			if quest.storageId == key then
				if quest.storageValue == value then
					return true
				end
				return true
			end
		end

		for _, mission in pairs(missions) do
			if mission.storageId == key then
				if value >= mission.startValue and value <= mission.endValue then
					return true
				end
				return true
			end
		end
		return false
	end
end
