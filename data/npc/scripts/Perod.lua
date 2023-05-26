local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Stop by before embarking on your great adventure! Distance weapons and general equipment on sale today!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "arrow", id = 3447, buy = 3 },
	{ name = "black book", id = 2838, buy = 15 },
	{ name = "blue book", id = 2844, sell = 20 },
	{ name = "blue quiver", id = 35848, buy = 400 },
	{ name = "bolt", id = 3446, buy = 4 },
	{ name = "bottle", id = 2875, buy = 3 },
	{ name = "bow", id = 3350, buy = 400, sell = 400 },
	{ name = "brown book", id = 2837, buy = 15 },
	{ name = "bucket", id = 2873, buy = 4 },
	{ name = "camouflage backpack", id = 2872, buy = 20 },
	{ name = "camouflage bag", id = 2864, buy = 5 },
	{ name = "candelabrum", id = 2912, buy = 8 },
	{ name = "candlestick", id = 2917, buy = 2 },
	{ name = "closed trap", id = 3481, buy = 280 },
	{ name = "crossbow", id = 3349, buy = 500, sell = 500 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "crystalline arrow", id = 15793, buy = 20 },
	{ name = "cup", id = 2884, buy = 2 },
	{ name = "diamond arrow", id = 35901, buy = 100 },
	{ name = "document", id = 2818, buy = 12 },
	{ name = "drill bolt", id = 16142, buy = 12 },
	{ name = "earth arrow", id = 774, buy = 5 },
	{ name = "envenomed arrow", id = 16143, buy = 12 },
	{ name = "fishing rod", id = 3483, buy = 150, sell = 40 },
	{ name = "flaming arrow", id = 763, buy = 5 },
	{ name = "flash arrow", id = 761, buy = 5 },
	{ name = "gemmed book", id = 2842, sell = 100 },
	{ name = "green book", id = 2846, sell = 15 },
	{ name = "greeting card", id = 6386, buy = 30 },
	{ name = "grey small book", id = 2839, buy = 15 },
	{ name = "hand auger", id = 31334, buy = 25 },
	{ name = "inkwell", id = 3509, buy = 10, sell = 8 },
	{ name = "jug", id = 7244, buy = 10 },
	{ name = "machete", id = 3308, buy = 40, sell = 6 },
	{ name = "mug", id = 2880, buy = 4 },
	{ name = "net", id = 31489, buy = 50 },
	{ name = "onyx arrow", id = 7365, buy = 7 },
	{ name = "orange book", id = 2843, sell = 30 },
	{ name = "parchment", id = 2817, buy = 8 },
	{ name = "pick", id = 3456, buy = 50, sell = 15 },
	{ name = "piercing bolt", id = 7363, buy = 5 },
	{ name = "plate", id = 2905, buy = 6 },
	{ name = "power bolt", id = 3450, buy = 7 },
	{ name = "present", id = 2856, buy = 10 },
	{ name = "prismatic bolt", id = 16141, buy = 20 },
	{ name = "quiver", id = 35562, buy = 400 },
	{ name = "red quiver", id = 35849, buy = 400 },
	{ name = "rope", id = 3003, buy = 50, sell = 15 },
	{ name = "royal spear", id = 7378, buy = 15 },
	{ name = "scroll", id = 2815, buy = 5 },
	{ name = "scythe", id = 3453, buy = 50, sell = 10 },
	{ name = "shiver arrow", id = 762, buy = 5 },
	{ name = "shovel", id = 3457, buy = 50, sell = 8 },
	{ name = "sniper arrow", id = 7364, buy = 5 },
	{ name = "spear", id = 3277, buy = 10, sell = 10 },
	{ name = "spectral bolt", id = 35902, buy = 70 },
	{ name = "tarsal arrow", id = 14251, buy = 6 },
	{ name = "throwing star", id = 3287, buy = 42 },
	{ name = "torch", id = 2920, buy = 2 },
	{ name = "vortex bolt", id = 14252, buy = 6 },
	{ name = "watch", id = 6092, buy = 20 },
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

npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye, |PLAYERNAME|.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye, |PLAYERNAME|.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
