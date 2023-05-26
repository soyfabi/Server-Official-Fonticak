local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'General equipment and all sorts of goods. Visit my store!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "basket", id = 2855, buy = 6 },
	{ name = "bottle", id = 2875, buy = 3 },
	{ name = "bucket", id = 2873, buy = 4 },
	{ name = "candelaburm", id = 2911, buy = 8 },
	{ name = "candlestick", id = 2917, buy = 2 },
	{ name = "closed trap", id = 3481, buy = 280, sell = 75 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "cup", id = 2881, buy = 3 },
	{ name = "document", id = 2818, buy = 12 },
	{ name = "fishing rod", id = 3483, buy = 150, sell = 40 },
	{ name = "hand auger", id = 31334, buy = 25 },
	{ name = "machete", id = 3308, buy = 35, sell = 6 },
	{ name = "net", id = 31489, buy = 50 },
	{ name = "parchment", id = 2817, buy = 8 },
	{ name = "pick", id = 3456, buy = 50, sell = 15 },
	{ name = "plate", id = 2905, buy = 6 },
	{ name = "present", id = 3218, buy = 10 },
	{ name = "purple backpack", id = 2868, buy = 20 },
	{ name = "purple bag", id = 2860, buy = 5 },
	{ name = "rope", id = 3003, buy = 50, sell = 15 },
	{ name = "scroll", id = 2815, buy = 5 },
	{ name = "scythe", id = 3453, buy = 50, sell = 10 },
	{ name = "shovel", id = 3457, buy = 50, sell = 8 },
	{ name = "torch", id = 2920, buy = 2 },
	{ name = "vial of oil", id = 2874, buy = 20, count = 7 },
	{ name = "watch", id = 2906, buy = 20, sell = 6 },
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
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local player = Player(cid)
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Keep in mind you won't find better offers here. Just browse through my wares.", cid)
	end
	if msgcontains(msg, "football") then
		npcHandler:say("Do you want to buy a football for 111 gold?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			local player = Player(cid)
			if player:getMoney() + player:getBankBalance() >= 111 then
				npcHandler:say("Here it is.", cid)
				player:addItem(2990, 1)
				player:removeMoneyNpc(111)
			else
				npcHandler:say("You don't have enough money.", cid)
			end
			npcHandler.topic[cid] = 0
		end
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Oh, please come in, |PLAYERNAME|. What can I do for you? If you need adventure equipment, ask me for a {trade}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, just browse through my wares. {Footballs} have to be purchased separately.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
