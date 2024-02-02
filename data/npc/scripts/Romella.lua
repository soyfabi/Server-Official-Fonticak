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
	{ name = "axe", id = 3274, buy = 20, sell = 7 },
	{ name = "small axe", id = 3462, sell = 5 },
	{ name = "battle axe", id = 3266, buy = 235, sell = 80 },
	{ name = "battle hammer", id = 3305, buy = 350, sell = 120 },
	{ name = "bone club", id = 3337, sell = 5 },
	{ name = "swampling club", id = 17824, sell = 40 },
	{ name = "studded club", id = 3336, sell = 10 },
	{ name = "bone sword", id = 3338, buy = 75, sell = 20 },
	{ name = "carlin sword", id = 3283, buy = 473, sell = 118 },
	{ name = "club", id = 3270, buy = 5, sell = 1 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "dagger", id = 3267, buy = 5, sell = 2 },
	{ name = "double axe", id = 3275, sell = 260 },
	{ name = "durable exercise axe", id = 35280, buy = 945000, count = 1800 },
	{ name = "durable exercise bow", id = 35282, buy = 945000, count = 1800 },
	{ name = "durable exercise club", id = 35281, buy = 945000, count = 1800 },
	{ name = "durable exercise sword", id = 35279, buy = 945000, count = 1800 },
	{ name = "exercise axe", id = 28553, buy = 262500, count = 500 },
	{ name = "exercise bow", id = 28555, buy = 262500, count = 500 },
	{ name = "exercise club", id = 28554, buy = 262500, count = 500 },
	{ name = "exercise sword", id = 28552, buy = 262500, count = 500 },
	{ name = "fire sword", id = 3280, sell = 1000 },
	{ name = "halberd", id = 3269, sell = 400 },
	{ name = "hand axe", id = 3268, buy = 8, sell = 4 },
	{ name = "hatchet", id = 3276, sell = 25 },
	{ name = "katana", id = 3300, sell = 35 },
	{ name = "lasting exercise axe", id = 35286, buy = 7560000, count = 14400 },
	{ name = "lasting exercise bow", id = 35288, buy = 7560000, count = 14400 },
	{ name = "lasting exercise club", id = 35287, buy = 7560000, count = 14400 },
	{ name = "lasting exercise sword", id = 35285, buy = 7560000, count = 14400 },
	{ name = "longsword", id = 3285, buy = 160, sell = 51 },
	{ name = "mace", id = 3286, buy = 90, sell = 30 },
	{ name = "morning star", id = 3282, buy = 430, sell = 100 },
	{ name = "orcish axe", id = 3316, sell = 350 },
	{ name = "rapier", id = 3272, buy = 15, sell = 5 },
	{ name = "sabre", id = 3273, buy = 35, sell = 12 },
	{ name = "short sword", id = 3294, buy = 26, sell = 10 },
	{ name = "sickle", id = 3293, buy = 7, sell = 3 },
	{ name = "spike sword", id = 3271, buy = 8000, sell = 240 },
	{ name = "sword", id = 3264, buy = 85, sell = 25 },
	{ name = "throwing knife", id = 3298, buy = 25, sell = 2 },
	{ name = "two handed sword", id = 3265, buy = 950, sell = 450 },
	{ name = "war hammer", id = 3279, buy = 10000, sell = 470 }
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
	if not checkExhaustShop(player) then
        return false
    end
	local items = setNewTradeTable(getTable(player))
	if not ignoreCap and player:getFreeCapacity() < ItemType(items[item].itemId):getWeight(amount) then
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'You don\'t have enough cap.')
	end
	if not player:removeMoneyNpc(items[item].buyPrice * amount) then
		selfSay("You don't have enough money.", cid)
	else
		local itemCharges = items[item].count or 0
        player:addItem(items[item].itemId, amount, false, itemCharges)
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'Bought '..amount..'x '..items[item].realName..' for '..items[item].buyPrice * amount..' gold coins.')
	end
	return true
end

local function onSell(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	if not checkExhaustShop(player) then
        return true
    end
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
		npcHandler:say("I sell {weapons} at a good price I even buy, don't leave without having bought one.", cid)
	end
	return true
end

-- Basic
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "I am Romella and I will be serving you today."})
keywordHandler:addAliasKeyword({'job'})

keywordHandler:addKeyword({'weapons'}, StdModule.say, {npcHandler = npcHandler, text = "I have many weapons to offer. If you'd like to see my offers, ask me for a {trade}."})
keywordHandler:addKeyword({'offers'}, StdModule.say, {npcHandler = npcHandler, text = "I sell and buy weapons. If you'd like to see my offers, ask me for a {trade}."})
keywordHandler:addAliasKeyword({'ware'})

keywordHandler:addKeyword({'army'}, StdModule.say, {npcHandler = npcHandler, text = "Our warehouse is the main supplier of the local garrison."})
keywordHandler:addKeyword({'news'}, StdModule.say, {npcHandler = npcHandler, text = "It says the amazons are looking for a certain magical weapon in this area."})
keywordHandler:addKeyword({'amazons'}, StdModule.say, {npcHandler = npcHandler, text = "I wonder how they finance themselves. I bet they are secretly trading in some strange stuff."})
keywordHandler:addKeyword({'ferumbras'}, StdModule.say, {npcHandler = npcHandler, text = "Make sure to buy some extra weapons before facing that one."})
keywordHandler:addKeyword({'excalibug'}, StdModule.say, {npcHandler = npcHandler, text = "I heard the amazons are after it."})
keywordHandler:addKeyword({'swamps'}, StdModule.say, {npcHandler = npcHandler, text = "Don't go exploring without weapons. Especially you'll need a machete."})
npcHandler:setMessage(MESSAGE_GREET, "I welcome thee, |PLAYERNAME|! I suppose you are looking for a trade in fine weapons!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Goodbye and please bring more gold next time <chuckles>. I mean, it would be nice to see you again.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
