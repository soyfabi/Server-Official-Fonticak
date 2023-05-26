local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)
npcHandler:onCreatureAppear(cid)
end
function onCreatureDisappear(cid)
npcHandler:onCreatureDisappear(cid)
end
function onCreatureSay(cid, type, msg)
npcHandler:onCreatureSay(cid, type, msg)
end
function onThink()
npcHandler:onThink()
end

local playerTopic = {}
local function greetCallback(cid)
	local player = Player(cid)
	if player:getStorageValue(Storage.Kilmaresh.First.Acesso) < 1 then
		npcHandler:setMessage(MESSAGE_GREET, "How could I help you?") -- It needs to be revised, it's not the same as the global
		playerTopic[cid] = 1
	elseif (player:getStorageValue(Storage.Kilmaresh.First.jamesfrancisTask) >= 0 and player:getStorageValue(Storage.KilmareshQuest.First.jamesfrancisTask) <= 50)
	and player:getStorageValue(Storage.Kilmaresh.First.Mission) < 3 then
		npcHandler:setMessage(MESSAGE_GREET, "How could I help you?") -- It needs to be revised, it's not the same as the global
		playerTopic[cid] = 15
	elseif player:getStorageValue(Storage.Kilmaresh.First.Mission) == 4 then
		npcHandler:setMessage(MESSAGE_GREET, "How could I help you?") -- It needs to be revised, it's not the same as the global
		player:setStorageValue(Kilmaresh)
		playerTopic[cid] = 20
	end
	npcHandler:addFocus(cid)
	return true
end

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "amber", id = 32626, sell = 20000 },
	{ name = "amber with a bug", id = 32624, sell = 41000 },
	{ name = "amber with a dragonfly", id = 32625, sell = 56000 },
	{ name = "ancient coin", id = 24390, sell = 350 },
	{ name = "black pearl", id = 3027, buy = 560, sell = 280 },
	{ name = "blue crystal shard", id = 16119, sell = 1500 },
	{ name = "blue crystal splinter", id = 16124, sell = 400 },
	{ name = "bronze goblet", id = 5807, buy = 2000 },
	{ name = "brown crystal splinter", id = 16123, sell = 400 },
	{ name = "brown giant shimmering pearl", id = 282, sell = 3000 },
	{ name = "coral brooch", id = 24391, sell = 750 },
	{ name = "crunor idol", id = 30055, sell = 30000 },
	{ name = "cyan crystal fragment", id = 16125, sell = 800 },
	{ name = "dragon figurine", id = 30053, sell = 45000 },
	{ name = "gemmed figurine", id = 24392, sell = 3500 },
	{ name = "giant amethyst", id = 30061, sell = 60000 },
	{ name = "giant emerald", id = 30060, sell = 90000 },
	{ name = "giant ruby", id = 30059, sell = 70000 },
	{ name = "giant sapphire", id = 30061, sell = 50000 },
	{ name = "giant topaz", id = 32623, sell = 80000 },
	{ name = "gold ingot", id = 9058, sell = 5000 },
	{ name = "gold nugget", id = 3040, sell = 850 },
	{ name = "golden amulet", id = 3013, buy = 6600 },
	{ name = "golden goblet", id = 5805, buy = 5000 },
	{ name = "green crystal fragment", id = 16127, sell = 800 },
	{ name = "green crystal shard", id = 16121, sell = 1500 },
	{ name = "green crystal splinter", id = 16122, sell = 400 },
	{ name = "green giant shimmering pearl", id = 281, sell = 3000 },
	{ name = "lion figurine", id = 33781, sell = 10000 },
	{ name = "onyx chip", id = 22193, sell = 400 },
	{ name = "opal", id = 22194, sell = 500 },
	{ name = "ornate locket", id = 30056, sell = 18000 },
	{ name = "prismatic quartz", id = 24962, sell = 450 },
	{ name = "red crystal fragment", id = 16126, sell = 800 },
	{ name = "ruby necklace", id = 3016, buy = 3560 },
	{ name = "silver goblet", id = 5806, buy = 3000 },
	{ name = "skull coin", id = 32583, sell = 12000 },
	{ name = "small amethyst", id = 3033, buy = 400, sell = 200 },
	{ name = "small diamond", id = 3028, buy = 600, sell = 300 },
	{ name = "small emerald", id = 3032, buy = 500, sell = 250 },
	{ name = "small enchanted amethyst", id = 678, sell = 200 },
	{ name = "small enchanted emerald", id = 677, sell = 250 },
	{ name = "small enchanted ruby", id = 676, sell = 250 },
	{ name = "small enchanted sapphire", id = 675, sell = 250 },
	{ name = "small ruby", id = 3030, buy = 500, sell = 250 },
	{ name = "small sapphire", id = 3029, buy = 500, sell = 250 },
	{ name = "small topaz", id = 9057, sell = 200 },
	{ name = "tiger eye", id = 24961, sell = 350 },
	{ name = "unicorn figurine", id = 30054, sell = 50000 },
	{ name = "violet crystal shard", id = 16120, sell = 1500 },
	{ name = "wedding ring", id = 3004, buy = 990 },
	{ name = "white silk flower", id = 34008, sell = 9000 },
	{ name = "white pearl", id = 3026, buy = 320 }
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
	local player = Player(cid)
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Keep in mind you won't find better offers here. Just browse through my wares.", cid)
	end
	if msgcontains(msg, "daughter") and player:getStorageValue(Storage.TheSecretLibrary.Peacock) == 1 then
	npcHandler:say({"I always feared that I lost her. And yet, all those years, I still had a gleam of hope. I'm devastated to learn about her fate - but at least I have certainty now. Thank you for telling me."}, cid)
	player:setStorageValue(Storage.TheSecretLibrary.Peacock, 2)
	npcHandler.topic[cid] = 1
	playerTopic[cid] = 1
	end
	return true
end


npcHandler:setMessage(MESSAGE_WALKAWAY, 'Well, bye then.')
npcHandler:setCallback(CALLBACK_ONADDFOCUS, onAddFocus)
npcHandler:setCallback(CALLBACK_ONRELEASEFOCUS, onReleaseFocus)
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
