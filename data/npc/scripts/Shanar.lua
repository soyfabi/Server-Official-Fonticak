local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'Fine elven armor and weapons. Have a look.' },
	{ text = 'Looking for protective spells for druids? I can teach you.' }
}

npcHandler:addModule(VoiceModule:new(voices))

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "axe", id = 3274, buy = 20, sell = 7 },
	{ name = "battle axe", id = 3266, buy = 235, sell = 80 },
	{ name = "battle hammer", id = 3305, buy = 350, sell = 120 },
	{ name = "battle shield", id = 3413, sell = 95 },
	{ name = "bone sword", id = 3338, buy = 75 },
	{ name = "brass armor", id = 3359, buy = 450, sell = 150 },
	{ name = "brass helmet", id = 3354, buy = 120, sell = 30 },
	{ name = "brass legs", id = 3372, buy = 195, sell = 49 },
	{ name = "brass shield", id = 3411, buy = 65, sell = 16 },
	{ name = "carlin sword", id = 3283, buy = 473 },
	{ name = "chain armor", id = 3358, buy = 200, sell = 70 },
	{ name = "chain helmet", id = 3352, buy = 52, sell = 17 },
	{ name = "chain legs", id = 3558, buy = 80, sell = 20 },
	{ name = "club", id = 3270, buy = 5 },
	{ name = "dagger", id = 3267, buy = 5, sell = 2 },
	{ name = "devil helmet", id = 3356, sell = 450 },
	{ name = "dragon shield", id = 3416, sell = 360 },
	{ name = "durable exercise axe", id = 35280, buy = 945000, count = 1800 },
	{ name = "durable exercise bow", id = 35282, buy = 945000, count = 1800 },
	{ name = "durable exercise club", id = 35281, buy = 945000, count = 1800 },
	{ name = "durable exercise sword", id = 35279, buy = 945000, count = 1800 },
	{ name = "exercise axe", id = 28553, buy = 262500, count = 500 },
	{ name = "exercise bow", id = 28555, buy = 262500, count = 500 },
	{ name = "exercise club", id = 28554, buy = 262500, count = 500 },
	{ name = "exercise sword", id = 28552, buy = 262500, count = 500 },
	{ name = "fire sword", id = 3280, sell = 1000 },
	{ name = "guardian shield", id = 3415, sell = 180 },
	{ name = "iron helmet", id = 3353, sell = 145 },
	{ name = "knight armor", id = 3370, sell = 875 },
	{ name = "knight legs", id = 3371, sell = 375 },
	{ name = "lasting exercise axe", id = 35286, buy = 7560000, count = 14400 },
	{ name = "lasting exercise bow", id = 35288, buy = 7560000, count = 14400 },
	{ name = "lasting exercise club", id = 35287, buy = 7560000, count = 14400 },
	{ name = "lasting exercise sword", id = 35285, buy = 7560000, count = 14400 },
	{ name = "leather armor", id = 3361, buy = 35, sell = 12 },
	{ name = "leather helmet", id = 3355, buy = 12, sell = 4 },
	{ name = "leather legs", id = 3559, sell = 1 },
	{ name = "longsword", id = 3285, buy = 160, sell = 51 },
	{ name = "mace", id = 3286, sell = 23 },
	{ name = "machete", id = 3308, buy = 35 },
	{ name = "rapier", id = 3272, buy = 15 },
	{ name = "sabre", id = 3273, buy = 35 },
	{ name = "spear", id = 3277, buy = 10 },
	{ name = "staff", id = 3289, buy = 40 },
	{ name = "steel shield", id = 3409, buy = 240 },
	{ name = "throwing knife", id = 3298, buy = 25 },
	{ name = "wooden shield", id = 3412, buy = 15 }
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
		npcHandler:say("Of course, just browse through my wares. Or do you want to look only at {equipment}, {weapons}?", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

local focusModule = FocusModule:new()
focusModule:addGreetMessage({'hi', 'hello', 'ashari'})
focusModule:addFarewellMessage({'bye', 'farewell', 'asgha thrazi'})
npcHandler:addModule(focusModule)










