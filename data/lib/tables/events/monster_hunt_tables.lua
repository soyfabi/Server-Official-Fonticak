MONSTER_HUNT = {
	list = {"Rat", "Rotworm", "Cyclops"},
	days = {
		["Sunday"] = {"13:55"},
		["Monday"] = {"13:55"},
		["Tuesday"] = {"21:18"},
		["Wednesday"] = {"13:55"},
		["Thursday"] = {"13:55"},
		["Friday"] = {"13:55"},
		["Saturday"] = {"13:55"},
	},
	messages = {
		prefix = "[Monster Hunt] ",
		warnInit = "The event will start in %d minute%s. Your goal is to kill as many ministers chosen by the system as possible.",
		init = "The monster chosen by the system was %s. You have 1 hour to kill the most amount of that monster.",
		warnEnd = "Missing %d minute%s for finish the event. Hurry up!",
		final = "The player [%s] was the winner of the event! Congratulations.",
		noWinner = "There were no winners at the event.",
		reward = "You received your reward in the mailbox!",
		kill = "You killed [%d] %s.",
	},
	rewards = {
		{id = 2160, count = 100},
	},
	storages = {
		monster = 891641,
		player = 891642,
	},
	players = {},
}

function MONSTER_HUNT:initEvent()
	setGlobalStorageValue(MONSTER_HUNT.storages.monster, 0)
	Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.warnInit:format(5, "s"))
	--[[addEvent(function()
		Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.warnInit:format(3, "s"))
	end, 2 * 60 * 1000)
	addEvent(function()
		Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.warnInit:format(1, ""))
	end, 4 * 60 * 1000)]]
	addEvent(function()
		local rand = math.random(#MONSTER_HUNT.list)
		setGlobalStorageValue(MONSTER_HUNT.storages.monster, rand)
		Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.init:format(MONSTER_HUNT.list[rand]))
	end, 1 * 60 * 1000)
	return true
end

function MONSTER_HUNT:endEvent()
	Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.warnEnd:format(5, "s"))
	addEvent(function()
		Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.warnEnd:format(3, "s"))
	end, 2 * 60 * 1000)
	addEvent(function()
		Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.warnEnd:format(1, ""))
	end, 4 * 60 * 1000)
	addEvent(function()
		if #MONSTER_HUNT.players == nil then
			Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.noWinner)
			return
		end
		table.sort(MONSTER_HUNT.players, function(a,b) return a[2] > b[2] end)
		local player = Player(MONSTER_HUNT.players[1][1])
		if player then
			Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.final:format(player:getName()))
			player:setStorageValue(MONSTER_HUNT.storages.player, -1)
			for c, d in ipairs(MONSTER_HUNT.rewards) do
				local item = Game.createItem(d.id, d.count)
				player:getInbox():addItemEx(item, INDEX_WHEREEVER, FLAG_NOLIMIT)
				player:sendTextMessage(MESSAGE_EVENT_ADVANCE, MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.reward)
				player:getPosition():sendMagicEffect(30)
			end
		else
			local player = Player(MONSTER_HUNT.players[1][1], true)

			if not player then
				return false
			end

			Game.broadcastMessage(MONSTER_HUNT.messages.prefix .. MONSTER_HUNT.messages.final:format(player:getName()))
			player:setStorageValue(MONSTER_HUNT.storages.player, -1)
			for c, d in ipairs(MONSTER_HUNT.rewards) do
				local item = Game.createItem(d.id, d.count)
				player:getInbox():addItemEx(item, INDEX_WHEREEVER, FLAG_NOLIMIT)
			end
			player:delete()
		end
		for a, b in pairs(MONSTER_HUNT.players) do
			local player = Player(b[1])
			if player then
				player:setStorageValue(MONSTER_HUNT.storages.player, 0)
				MONSTER_HUNT.players[a] = nil
			else
				player = Player(b[1], true)
				player:setStorageValue(MONSTER_HUNT.storages.player, 0)
				MONSTER_HUNT.players[a] = nil
				player:delete()
			end
		end
		setGlobalStorageValue(MONSTER_HUNT.storages.monster, -1)
	end, 5 * 60 * 1000)
	return true
end