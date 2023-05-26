local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "avalanche rune", id = 3161, buy = 57 },
	{ name = "blank rune", id = 3147, buy = 10 },
	{ name = "chameleon rune", id = 3178, buy = 210 },
	{ name = "convince creature rune", id = 3177, buy = 80 },
	{ name = "cure poison rune", id = 3153, buy = 65 },
	{ name = "destroy field rune", id = 3148, buy = 15 },
	{ name = "dragonfruit", id = 11682, buy = 5 },
	{ name = "egg", id = 3606, buy = 3 },
	{ name = "empty potion flask", id = 283, sell = 5 },
	{ name = "empty potion flask", id = 284, sell = 5 },
	{ name = "empty potion flask", id = 285, sell = 5 },
	{ name = "energy field rune", id = 3164, buy = 38 },
	{ name = "energy wall rune", id = 3166, buy = 85 },
	{ name = "explosion rune", id = 3200, buy = 31 },
	{ name = "fire bomb rune", id = 3192, buy = 147 },
	{ name = "fire field rune", id = 3188, buy = 28 },
	{ name = "fire wall rune", id = 3190, buy = 61 },
	{ name = "great fireball rune", id = 3191, buy = 57 },
	{ name = "great health potion", id = 239, buy = 225 },
	{ name = "great mana potion", id = 238, buy = 144 },
	{ name = "great spirit potion", id = 7642, buy = 228 },
	{ name = "health potion", id = 266, buy = 50 },
	{ name = "heavy magic missile rune", id = 3198, buy = 12 },
	{ name = "intense healing rune", id = 3152, buy = 95 },
	{ name = "light magic missile rune", id = 3174, buy = 4 },
	{ name = "mana potion", id = 268, buy = 56 },
	{ name = "poison field rune", id = 3172, buy = 21 },
	{ name = "poison wall rune", id = 3176, buy = 52 },
	{ name = "stalagmite rune", id = 3179, buy = 12 },
	{ name = "strong health potion", id = 236, buy = 115 },
	{ name = "strong mana potion", id = 237, buy = 93 },
	{ name = "sudden death rune", id = 3155, buy = 135 },
	{ name = "supreme health potion", id = 23375, buy = 625 },
	{ name = "ultimate healing rune", id = 3160, buy = 175 },
	{ name = "ultimate health potion", id = 7643, buy = 379 },
	{ name = "ultimate mana potion", id = 23373, buy = 438 },
	{ name = "ultimate spirit potion", id = 23374, buy = 438 },
	{ name = "vial", id = 2874, sell = 5 }
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
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
