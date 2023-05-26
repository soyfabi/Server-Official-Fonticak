local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function getTable(player)
local itemsList = {}
	
local buyList = {	-- Sellable items
	{ name = "basket", id = 2855, buy = 6 },
	{ name = "bottle", id = 2875, buy = 3 },
	{ name = "bucket", id = 2873, buy = 4 },
	{ name = "candelabrum", id = 2912, buy = 8 },
	{ name = "candlestick", id = 2917, buy = 2 },
	{ name = "closed trap", id = 3481, buy = 280, sell = 75 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "cup", id = 2881, buy = 2 },
	{ name = "deed of ownership", id = 7866, buy = 1000 },
	{ name = "document", id = 2818, buy = 12 },
	{ name = "fishing rod", id = 3483, buy = 40, sell = 40 },
	{ name = "golden backpack", id = 2871, buy = 10 },
	{ name = "golden bag", id = 2863, buy = 4 },
	{ name = "hand auger", id = 31334, buy = 25 },
	{ name = "machete", id = 3308, buy = 6, sell = 6 },
	{ name = "net", id = 31489, buy = 50 },
	{ name = "parchment", id = 2817, buy = 8 },
	{ name = "pick", id = 3456, buy = 50, sell = 15 },
	{ name = "plate", id = 2905, buy = 6 },
	{ name = "present", id = 2856, buy = 10 },
	{ name = "rope", id = 3003, buy = 50, sell = 15 },
	{ name = "scroll", id = 2815, buy = 5 },
	{ name = "scythe", id = 3453, buy = 50, sell = 10 },
	{ name = "shovel", id = 3457, buy = 10, sell = 8 },
	{ name = "torch", id = 2920, buy = 2 },
	{ name = "vial of oil", id = 2874, buy = 20, count = 7 },
	{ name = "watch", id = 2906, buy = 20, sell = 6 },
	{ name = "waterskin of water", id = 2901, buy = 40, count = 1 },
	{ name = "wooden hammer", id = 3459, sell = 15 },
	{ name = "worm", id = 3492, buy = 1 }
}

	for i = 1, #buyList do
		table.insert(itemsList, buyList[i])
	end
	return itemsList
end

local function setNewTradeTable(table)
	local items, item = {}
	for i = 1, #table do
		item = table[i]
		items[item.id] = {itemId = item.id, buyPrice = item.buy, sellPrice = item.sell, subType = 0, realName = item.name}
	end
	return items
end

local function onBuy(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	local items = setNewTradeTable(getTable(player))
	if not ignoreCap and player:getFreeCapacity() < ItemType(items[item].itemId):getWeight(amount) then
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'You don\'t have enough cap.')
	end
	if not player:removeMoneyNpc(items[item].buyPrice * amount) then
		selfSay("You don't have enough money.", cid)
	else
		player:addItem(items[item].itemId, amount)
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'Bought '..amount..'x '..items[item].realName..' for '..items[item].buyPrice * amount..' gold coins.')
	end
	return true
end

local function onSell(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	local items = setNewTradeTable(getTable(player))
	if items[item].sellPrice and player:removeItem(items[item].itemId, amount) then
		player:addMoney(items[item].sellPrice * amount)
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'Sold '..amount..'x '..items[item].realName..' for '..items[item].sellPrice * amount..' gold coins.')
	else
		selfSay("You don't have item to sell.", cid)
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Keep in mind you won't find better offers here. Just browse through my wares.", cid)
	end
	local player = Player(cid)
	if msgcontains(msg, 'documents') then
		if player:getStorageValue(Storage.thievesGuild.Mission04) == 2 then
			player:setStorageValue(Storage.thievesGuild.Mission04, 3)
			npcHandler:say({
				'You need some forged documents? But I will only forge something for a friend. ...',
				'The nomads at the northern oasis killed someone dear to me. Go and kill at least one of them, then we talk about your document.'
			}, cid)
		elseif player:getStorageValue(Storage.thievesGuild.Mission04) == 4 then
			npcHandler:say('The slayer of my enemies is my friend! For a mere 1000 gold I will create the documents you need. Are you interested?', cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'mission') or msgcontains(msg, 'quest') then
		if player:getStorageValue(Storage.QuestChests.StealFromThieves) < 1 then
			npcHandler:say({
				"What are you talking about?? I was robbed!!!! Someone catch those filthy thieves!!!!! GUARDS! ...",
				"<nothing happens>....<SIGH> Like usual, they hide at the slightest sign of trouble! YOU! Want to earn some quick money?"
			}, cid)
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(Storage.QuestChests.StealFromThieves) == 1 or player:getStorageValue(Storage.QuestChests.StealFromThieves) == 2 then
			npcHandler:say('Did you find my stuff?', cid)
			npcHandler.topic[cid] = 3
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			if player:removeMoneyNpc(1000) then
				player:addItem(7866, 1)
				player:setStorageValue(Storage.thievesGuild.Mission04, 5)
				npcHandler:say('And here they are! Now forget where you got them from.', cid)
			else
				npcHandler:say('You don\'t have enough money.', cid)
			end
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"Of course you do! Go hunt down the thieves and bring back the stuff they have stolen from me. ...",
				" I saw them running out of town and then to the north. Maybe they hide at the oasis."
			}, cid)
			npcHandler.topic[cid] = 0
			player:setStorageValue(Storage.QuestChests.StealFromThieves, 1)
		elseif npcHandler.topic[cid] == 3 then
			if player:removeItem(235, 1) then
				npcHandler:say('GREAT! If you ever need a job as my personal security guard, let me know. Here is the reward I promised you.', cid)
				player:setStorageValue(Storage.QuestChests.StealFromThieves, 3)
				player:addItem(3031, 100)
				player:addItem(3725, 100)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say('Come back when you find my stuff.', cid)
				npcHandler.topic[cid] = 0
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
