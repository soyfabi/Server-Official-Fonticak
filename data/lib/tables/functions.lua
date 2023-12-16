-- Exercise Training --
if onExerciseTraining == nil then
	onExerciseTraining = {}
end

function isNumber(str)
	return tonumber(str) ~= nil
end

function firstToUpper(str)
    return (str:gsub("^%l", string.upper))
end

-- Monster Type --
function isInteger(n)
	return (type(n) == "number") and (math.floor(n) == n)
end

function isValidMoney(money)
	return isNumber(money) and money > 0 and money < 4294967296
end

function Tile.isPz(self)
	return self:hasFlag(TILESTATE_PROTECTIONZONE)
end

function Tile.isHouse(self)
	local house = self:getHouse()
	return not not house
end

function Tile:isRopeSpot()
	if not self then
		return false
	end

	if not self:getGround() then
		return false
	end

	if table.contains(ropeSpots, self:getGround():getId()) then
		return true
	end

	for i = 1, self:getTopItemCount() do
		local thing = self:getThing(i)
		if thing and table.contains(specialRopeSpots, thing:getId()) then
			return true
		end
	end

	return false
end

function isInArea(pos, fromPos, toPos)
    if pos.x >= fromPos.x and pos.x <= toPos.x then
        if pos.y >= fromPos.y and pos.y <= toPos.y then
            if pos.z >= fromPos.z and pos.z <= toPos.z then
                return true
            end
        end
    end
    return false
end

function playerExists(name)
	local resultId = db.storeQuery("SELECT `name` FROM `players` WHERE `name` = " .. db.escapeString(name))
	if resultId then
		Result.free(resultId)
		return true
	end
	return false
end

function checkWallArito(item, toPosition)
	if (not item:isItem()) then
		return false
	end
	local wallTile = Tile(Position(33206, 32536, 6))
	if not wallTile or wallTile:getItemCountById(7181) > 0 then
		return false
	end
	local checkEqual = {
		[2886] = {Position(33207, 32537, 6), {5858, -1}, Position(33205, 32537, 6)},
		[3307] = {Position(33205, 32537, 6), {2016, 1}, Position(33207, 32537, 6), 5858}
	}
	local it = checkEqual[item:getId()]
	if (it and it[1] == toPosition and Tile(it[3]):getItemCountById(it[2][1], it[2][2]) > 0) then
		wallTile:getItemById(1085):transform(7181)

		if (it[4]) then
			item:transform(it[4])
		end

		addEvent(
		function()
			if (Tile(Position(33206, 32536, 6)):getItemCountById(7476) > 0) then
				Tile(Position(33206, 32536, 6)):getItemById(7476):transform(1085)
			end
			if (Tile(Position(33205, 32537, 6)):getItemCountById(5858) > 0) then
				Tile(Position(33205, 32537, 6)):getItemById(5858):remove()
			end
		end,
		5 * 60 * 1000
		)
	else
		if (it and it[4] and it[1] == toPosition) then
			item:transform(it[4])
		end
	end
end

function iterateArea(func, from, to)
	for z = from.z, to.z do
		for y = from.y, to.y do
			for x = from.x, to.x do
				func(Position(x, y, z))
			end
		end
	end
end

-- Blessing --
function getBlessingsCost(level)
    if level <= 30 then
        return 2000
    elseif level >= 120 then
        return 20000
    else
        return (level - 20) * 200
    end
end

function roomIsOccupied(centerPosition, rangeX, rangeY)
	local spectators = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	if #spectators ~= 0 then
		return true
	end
	return false
end

function clearBossRoom(playerId, bossId, centerPosition, rangeX, rangeY, exitPosition)
	local spectators,
	spectator = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isPlayer() and spectator.uid == playerId then
			spectator:teleportTo(exitPosition)
			exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
		end

		if spectator:isMonster() then
			spectator:remove()
		end
	end
end

function clearRoom(centerPosition, rangeX, rangeY, resetGlobalStorage)
	local spectators,
	spectator = Game.getSpectators(centerPosition, false, false, rangeX, rangeX, rangeY, rangeY)
	for i = 1, #spectators do
		spectator = spectators[i]
		if spectator:isMonster() then
			spectator:remove()
		end
	end
	if getGlobalStorageValue(resetGlobalStorage) == 1 then
		setGlobalStorageValue(resetGlobalStorage, -1)
	end
end

function clearForgotten(fromPosition, toPosition, exitPosition, storage)
	for x = fromPosition.x, toPosition.x do
		for y = fromPosition.y, toPosition.y do
			for z = fromPosition.z, toPosition.z do
				if Tile(Position(x, y, z)) then
					local creature = Tile(Position(x, y, z)):getTopCreature()
					if creature then
						if creature:isPlayer() then
							creature:teleportTo(exitPosition)
							exitPosition:sendMagicEffect(CONST_ME_TELEPORT)
							creature:say("Time out! You were teleported out by strange forces.", TALKTYPE_MONSTER_SAY)
						elseif creature:isMonster() then
							creature:remove()
						end
					end
				end
			end
		end
	end
	setGlobalStorageValue(storage, 0)
end

function isPlayerInArea(fromPos, toPos)
	for _x = fromPos.x, toPos.x do
		for _y = fromPos.y, toPos.y do
			for _z = fromPos.z, toPos.z do
				creature = getTopCreature({x = _x, y = _y, z = _z})
				if (isPlayer(creature.uid)) then
					return true
				end
			end
		end
	end
	return false
end

function cleanAreaQuest(frompos, topos, itemtable, blockmonsters)
	if not itemtable then
		itemtable = {}
	end
	if not blockmonsters then
		blockmonsters = {}
	end
	for _x = frompos.x, topos.x do
		for _y = frompos.y, topos.y do
			for _z = frompos.z, topos.z do
				local tile = Tile(Position(_x, _y, _z))
				if tile then
					local itc = tile:getItems()
					if itc and tile:getItemCount() > 0 then
						for _, pid in pairs(itc) do
							local itp = ItemType(pid:getId())
							if itp and itp:isCorpse() then
								pid:remove()
							end
						end
					end
					for _, pid in pairs(itemtable) do
						local _until = tile:getItemCountById(pid)
						if _until > 0 then
							for i = 1, _until do
								local it = tile:getItemById(pid)
								if it then
									it:remove()
								end
							end
						end
					end
					local mtempc = tile:getCreatures()
					if mtempc and tile:getCreatureCount() > 0 then
						for _, pid in pairs(mtempc) do
							if pid:isMonster() and not table.contains(blockmonsters, pid:getName():lower()) then
								-- broadcastMessage(pid:getName())
								pid:remove()
							end
						end
					end
				end
			end
		end
	end
	return true
end

function checkWeightAndBackpackRoom(player, itemWeight, message)
	local backpack = player:getSlotItem(CONST_SLOT_BACKPACK)
	if not backpack or backpack:getEmptySlots(true) < 1 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message .. ", but you have no room to take it.")
		return false
	end
	if (player:getFreeCapacity() / 100) < itemWeight then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE,
		message .. ". Weighing " .. itemWeight .. " oz, it is too heavy for you to carry.")
		return false
	end
	return true
end

function doCreatureSayWithRadius(cid, text, type, radiusx, radiusy, position)
	if not position then
		position = Creature(cid):getPosition()
	end
	
	local spectators, spectator = Game.getSpectators(position, false, true, radiusx, radiusx, radiusy, radiusy)
	for i = 1, #spectators do
		spectator = spectators[i]
		spectator:say(text, type, false, spectator, position)
	end
end

function Player:doCheckBossRoom(bossName, fromPos, toPos)
	if self then
		for x = fromPos.x, toPos.x do
			for y = fromPos.y, toPos.y do
				for z = fromPos.z, toPos.z do
					local sqm = Tile(Position(x, y, z))
					if sqm then
						if sqm:getTopCreature() and sqm:getTopCreature():isPlayer() then
							self:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You must wait. Someone is challenging '..bossName..' now.')
							return false
						end
					end
				end
			end
		end
		-- Room cleaning
		for x = fromPos.x, toPos.x do
			for y = fromPos.y, toPos.y do
				for z = fromPos.z, toPos.z do
					local sqm = Tile(Position(x, y, z))
					if sqm and sqm:getTopCreature() then
						local monster = sqm:getTopCreature()
						if monster then
							monster:remove()
						end
					end
				end
			end
		end
	end
	return true
end

-- Can be used in every boss
function kickPlayersAfterTime(players, fromPos, toPos, exit)
	for _, pid in pairs(players) do
		local player = Player(pid)
		if player and player:getPosition():isInRange(fromPos, toPos) then
			player:teleportTo(exit)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, 'You were kicked by exceding time inside the boss room.')
		end
	end
end

function isInRange(pos, fromPos, toPos)
return pos.x >= fromPos.x and pos.y >= fromPos.y
	and pos.z >= fromPos.z and pos.x <= toPos.x
	and pos.y <= toPos.y and pos.z <= toPos.z
end

--Boss entry
if not bosssPlayers then
	bosssPlayers = {
		addPlayers = function (self, cid)
			local player = Player(cid)
			if not player then return false end
			if not self.players then
				self.players = {}
			end
			self.players[player:getId()] = 1
		end,
		removePlayer = function (self, cid)
			local player = Player(cid)
			if not player then return false end
			if not self.players then return false end
			self.players[player:getId()] = nil
		end,
		getPlayersCount = function (self)
			if not self.players then return 0 end
			local c = 0
			for _ in pairs(self.players) do c = c + 1 end
			return c
		end
	}
end

function kickerPlayerRoomAfferMin(playername, fromPosition, toPosition, teleportPos, message, monsterName, minutes,
			firstCall, itemtable, blockmonsters)
	local players = false
	if type(playername) == table then
		players = true
	end
	local player = false
	if not players then
		player = Player(playername)
	end
	local monster = {}
	if monsterName ~= "" then
		monster = getMonstersInArea(fromPosition, toPosition, monsterName)
	end
	if player == false and players == false then
		return false
	end
	if not players and player then
		if player:getPosition():isInRange(fromPosition, toPosition) and minutes == 0 then
			if monsterName ~= "" then
				for _, pid in pairs(monster) do
					if pid:isMonster() then
						if pid:getStorageValue("playername") == playername then
							pid:remove()
						end
					end
				end
			else
				if not itemtable then
					itemtable = {}
				end
				if not blockmonsters then
					blockmonsters = {}
				end
				cleanAreaQuest(fromPosition, toPosition, itemtable, blockmonsters)
			end
			player:teleportTo(teleportPos, true)
			player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
			return true
		end
	else
		if minutes == 0 then
			if monsterName ~= "" then
				for _, pid in pairs(monster) do
					if pid:isMonster() then
						if pid:getStorageValue("playername") == playername then
							pid:remove()
						end
					end
				end
			else
				if not itemtable then
					itemtable = {}
				end
				if not blockmonsters then
					blockmonsters = {}
				end
				cleanAreaQuest(fromPosition, toPosition, itemtable, blockmonsters)
			end
			for _, pid in pairs(playername) do
				local player = Player(pid)
				if player and player:getPosition():isInRange(fromPosition, toPosition) then
					player:teleportTo(teleportPos, true)
					player:sendTextMessage(MESSAGE_EVENT_ADVANCE, message)
				end
			end
			return true
		end
	end
	local min = 60 -- Use the 60 for 1 minute
	if (firstCall) then
		addEvent( kickerPlayerRoomAfferMin, 1000, playername, fromPosition, toPosition, teleportPos, message,
				monsterName, minutes, false, itemtable, blockmonsters)
	else
		local subt = minutes - 1
		if (monsterName ~= "") then
			if minutes > 3 and table.maxn(monster) == 0 then
				subt = 2
			end
		end
		addEvent(kickerPlayerRoomAfferMin, min * 1000, playername, fromPosition, toPosition, teleportPos, message,
				monsterName, subt, false, itemtable, blockmonsters)
	end
end

function getMonstersInArea(fromPos, toPos, monsterName, ignoreMonsterId)
	local monsters = {}
	for _x = fromPos.x, toPos.x do
		for _y = fromPos.y, toPos.y do
			for _z = fromPos.z, toPos.z do
				local tile = Tile(Position(_x, _y, _z))
				if tile and tile:getTopCreature() then
					for _, pid in pairs(tile:getCreatures()) do
						local mt = Monster(pid)
						if not ignoreMonsterId then
							if (mt and mt:isMonster() and mt:getName():lower() == monsterName:lower() and not mt:getMaster()) then
								monsters[#monsters + 1] = mt
							end
						else
							if (mt and mt:isMonster() and mt:getName():lower() == monsterName:lower()
							and not mt:getMaster() and ignoreMonsterId ~= mt:getId()) then
								monsters[#monsters + 1] = mt
							end
						end
					end
				end
			end
		end
	end
	return monsters
end

function placeSpawnRandom(fromPositon, toPosition, monsterName, ammount, hasCall, storage, value, removestorage,
			sharedHP, event, message)
	for _x = fromPositon.x, toPosition.x do
		for _y = fromPositon.y, toPosition.y do
			for _z = fromPositon.z, toPosition.z do
				local tile = Tile(Position(_x, _y, _z))
				if not removestorage then
					if tile and tile:getTopCreature() and tile:getTopCreature():isMonster() and
					tile:getTopCreature():getName() == monsterName
					then
						tile:getTopCreature():remove()
					end
				else
					if tile and tile:getTopCreature() and tile:getTopCreature():isMonster() and
					tile:getTopCreature():getStorageValue(storage) == value
					then
						tile:getTopCreature():remove()
					end
				end
			end
		end
	end
	if ammount and ammount > 0 then
		local summoned = 0
		local tm = os.time()
		repeat
			local tile = false
			-- repeat
			local position = {
				x = math.random(fromPositon.x, toPosition.x),
				y = math.random(fromPositon.y, toPosition.y),
				z = math.random(fromPositon.z, toPosition.z)
			}
			-- tile = Tile(position)
			-- passing = tile and #tile:getItems() <= 0
			-- until (passing == true)
			local monster = Game.createMonster(monsterName, position)
			if monster then
				summoned = summoned + 1
				-- Set first spawn
				monster:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
				if (hasCall) then
					monster:setStorage(storage, value)
					if sharedHP then
						monster:beginSharedLife(tm)
						monster:registerEvent("sharedLife")
					end
					if event then
						monster:registerEvent(event)
					end
					local function SendMessage(mit, message)
						if not Monster(mit) then
							return false
						end
						Monster(mit):say(message, TALKTYPE_MONSTER_SAY)
					end
					if message then
						addEvent(SendMessage, 200, monster:getId(), message)
					end
				end
			end
		until (summoned == ammount)
	end
end

function Player.getPremiumPoints(self)
    local resultId = db.storeQuery(string.format('SELECT premium_points FROM `accounts` WHERE `id` = %d', self:getAccountId()))
    if not resultId then
        return 0
    end
    local value = result.getNumber(resultId, "premium_points")
    result.free(resultId)
    return value
end

function Player.addPremiumPoints(self, amount)
    return db.query(string.format("UPDATE `accounts` SET `premium_points` = `premium_points` + %d WHERE `id` = %d", amount, self:getAccountId()))
end

function Player.removePremiumPoints(self, amount)
    if self:getPremiumPoints() >= amount then
        db.query(string.format("UPDATE `accounts` SET `premium_points` = `premium_points` - %d WHERE `id` = %d", amount, self:getAccountId()))
        return true
    else
        self:sendCancelMessage("You don't own ".. amount .. " points to be removed.")
        self:getPosition():sendMagicEffect(CONST_ME_POFF)
        return false
    end
end

function Player.setPremiumPoints(self, amount)
	return db.query(string.format("UPDATE `accounts` SET `premium_points` = %d WHERE `id` = %d", amount, self:getAccountId()))
end

function Guild.getLevel(guild)
    local resultId = db.storeQuery(string.format('SELECT `level` FROM `guilds` WHERE `id` = %d', guild:getId()))
    if not resultId then
        return 0
    end

    local value = result.getNumber(resultId, "level")
    result.free(resultId)
	return value
end

function Guild.addLevel(guild, amount)
	return db.query(string.format("UPDATE `guilds` SET `level` = `level` + %d WHERE `id` = %d", amount, guild:getId()))
end

function Guild.getExperience(guild)
    local resultId = db.storeQuery(string.format('SELECT `experience` FROM `guilds` WHERE `id` = %d', guild:getId()))
    if not resultId then
        return 0
    end

    local value = result.getNumber(resultId, "experience")
    result.free(resultId)
	return value
end

function Guild.addExperience(guild, amount)
	return db.query(string.format("UPDATE `guilds` SET `experience` = `experience` + %d WHERE `id` = %d", amount, guild:getId()))
end

function Guild.setBankBalance(guild, amount)
	return db.query(string.format("UPDATE `guilds` SET `balance` = `balance` + %d WHERE `id` = %d", amount, guild:getId()))
end

function Guild.getBankBalance(guild)
    local resultId = db.storeQuery(string.format('SELECT `balance` FROM `guilds` WHERE `id` = %d', guild:getId()))
    if not resultId then
        return 0
    end

    local value = result.getNumber(resultId, "balance")
    result.free(resultId)
	return value
end

function Player.addDevotion(self, amount)
	return db.query(string.format("UPDATE `players` SET `devotion` = `devotion` + %d WHERE `id` = %d", amount, self:getGuid()))
end

function Player.getDevotion(self)
    local resultId = db.storeQuery(string.format('SELECT `devotion` FROM `players` WHERE `id` = %d', self:getGuid()))
    if not resultId then
        return 0
    end

    local value = result.getNumber(resultId, "devotion")
    result.free(resultId)
	return value
end

function Player.addMagicLevel(self, amt)
    local new = self:getBaseMagicLevel() + amt
    local manaSpent = self:getManaSpent()
    self:addManaSpent(self:getVocation():getRequiredManaSpent(new + 1) - manaSpent)
end

function Player.checkGnomeRank(self)
	local points = self:getStorageValue(Storage.BigfootBurden.Rank)
	local questProgress = self:getStorageValue(Storage.BigfootBurden.QuestLine)
	if points >= 30 and points < 120 then
		if questProgress <= 25 then
			self:setStorageValue(Storage.BigfootBurden.QuestLine, 26)
			self:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			self:addAchievement("Gnome Little Helper")
		end
	elseif points >= 120 and points < 480 then
		if questProgress <= 26 then
			self:setStorageValue(Storage.BigfootBurden.QuestLine, 27)
			self:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			self:addAchievement("Gnome Little Helper")
			self:addAchievement("Gnome Friend")
		end
	elseif points >= 480 and points < 1440 then
		if questProgress <= 27 then
			self:setStorageValue(Storage.BigfootBurden.QuestLine, 28)
			self:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			self:addAchievement("Gnome Little Helper")
			self:addAchievement("Gnome Friend")
			self:addAchievement("Gnomelike")
		end
	elseif points >= 1440 then
		if questProgress <= 29 then
			self:setStorageValue(Storage.BigfootBurden.QuestLine, 30)
			self:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			self:addAchievement("Gnome Little Helper")
			self:addAchievement("Gnome Friend")
			self:addAchievement("Gnomelike")
			self:addAchievement("Honorary Gnome")
		end
	end
	return true
end

function Position:compare(position)
	return self.x == position.x and self.y == position.y and self.z == position.z
end