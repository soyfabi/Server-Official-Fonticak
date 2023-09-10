local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Psst! Over here!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function getTable(player)
	local itemsList = {}
	local buyList = {
		{name = "exploding cookie", id = 130, buy = 100, count = 1},
		{name = "toy mouse", id = 123, buy = 16000, sell = 16000},
		{name = "special flask", id = 135, buy = 5000, count = 1},
		{name = "empty beer bottle", id = 138, buy = 600, count = 1},
		{name = "cigar", id = 141, buy = 2000, count = 1},
		{name = "bale of white cloth", id = 142, buy = 6000, count = 1},
		{name = "suspicious signet ring", id = 349, buy = 15000, count = 1},
		{name = "technomancer beard", id = 396, buy = 5000, count = 1},
		{name = "family signet ring", id = 406, buy = 15000, count = 1},
		{name = "bill", id = 3216, buy = 8000, count = 1},
		{name = "letterbag", id = 3217, buy = 8000, count = 1},
		{name = "spyreport", id = 3232, buy = 3000, count = 1},
		{name = "tear of daraman", id = 3233, buy = 16000, count = 1},
		{name = "cookbook", id = 3234, buy = 150, count = 1},
		{name = "whisper moss", id = 4827, buy = 18000, count = 1},
		{name = "giant ape's hair", id = 4832, buy = 24000, count = 1},
		{name = "family brooch", id = 4834, buy = 1000, count = 1},
		{name = "snake destroyer", id = 4835, buy = 8000, count = 1},
		{name = "spectral dress", id = 4836, buy = 15000, count = 1},
		{name = "memory stone", id = 4841, buy = 3000, count = 1},
		{name = "sheet of tracing paper", id = 4843, buy = 500, count = 1},
		{name = " wrinkled parchment", id = 4846, buy = 4000, count = 1},
		{name = "funeral urn", id = 4847, buy = 6000, count = 1},
		{name = "wolf tooth chain", id = 5940, buy = 10000, count = 1},
		{name = "damaged logbook", id = 6124, buy = 40000, count = 1},
		{name = "memory crystal", id = 7281, buy = 500, count = 1},
		{name = "ring of the count", id = 7924, buy = 10000, count = 1},
		{name = "fishnapped goldfish", id = 7936, buy = 7000, count = 1},
		{name = "blood crystal", id = 8453, buy = 50000, count = 1},
		{name = "ghost's tear", id = 8746, buy = 50000, count = 1},
		{name = "alchemists' formulas", id = 8818, buy = 8000, count = 1},
		{name = "ghost charm", id = 8822, buy = 20000, count = 1},
		{name = "special polish", id = 9107, buy = 600, count = 1},
		{name = "formula for a memory potion", id = 9188, buy = 5000, count = 1},
		{name = "bundle of rags", id = 9191, buy = 5000, count = 1},
		{name = "animal fetish", id = 9236, buy = 10000, count = 1},
		{name = "shadow orb", id = 9237, buy = 12500, count = 1},
		{name = "dark essence", id = 9238, buy = 17000, count = 1},
		{name = "worm queen tooth", id = 9239, buy = 12500, count = 1},
		{name = "deep crystal", id = 9240, buy = 13000, count = 1},
		{name = "bloodkiss flower", id = 9241, buy = 10000, count = 1},
		{name = "golem blueprint", id = 9247, buy = 13500, count = 1},
		{name = "stabilizer", id = 9248, buy = 12500, count = 1},
		{name = "mago mechanic core", id = 9249, buy = 13000, count = 1},
		{name = "elemental crystal", id = 9251, buy = 8000, count = 1},
		{name = "old power core", id = 9252, buy = 13000, count = 1},
		{name = "golem head", id = 9255, buy = 25000, count = 1},
		{name = "nautical map", id = 9308, buy = 5250, count = 1},
		{name = "machine crate", id = 9390, buy = 8500, count = 1},
		{name = "fan club membership card", id = 9391, buy = 10000, count = 1},
		{name = "headache pill", id = 9537, buy = 350, count = 1},
		{name = "plans for a strange device", id = 9696, buy = 1000, count = 1},
		{name = "carrying device", id = 9698, buy = 1000, count = 1},
		{name = "filled carrying device", id = 9699, buy = 1000, count = 1},
		{name = "flask of crown polisher", id = 10009, buy = 700, count = 1},
		{name = "map to the unknown", id = 10011, buy = 650, count = 1},
		{name = "almanac of magic", id = 10025, buy = 600, count = 1},
		{name = "soul contract", id = 10028, buy = 666, count = 1},
		{name = "flask of poison", id = 10183, buy = 1000, count = 1},
		{name = "", id = 10187, buy = 1000, count = 1},
		{name = "flask of extra greasy oil", id = 10189, buy = 1000, count = 1},
		{name = "lump of clay", id = 11329, buy = 1000, count = 1},
		{name = "unworked sacred wood", id = 11339, buy = 550, count = 1},
		{name = "sacred earth", id = 11341, buy = 1000, count = 1},
		{name = "faded last will", id = 11544, buy = 600, count = 1},
		{name = "exquisite silk", id = 11545, buy = 4000, count = 1},
		{name = "spectral cloth", id = 11546, buy = 4000, count = 1},
		{name = "exquisite wood", id = 11547, buy = 4000, count = 1},
		{name = "strong sinew", id = 11548, buy = 4000, count = 1},
		{name = "old iron", id = 11549, buy = 4000, count = 1},
		{name = "flexible dragon scale", id = 11550, buy = 4000, count = 1},
		{name = "mystic root", id = 11551, buy = 4000, count = 1},
		{name = "magic crystal", id = 11552, buy = 4000, count = 1},
		{name = "strange powder", id = 13974, buy = 5000, count = 1},
		{name = "sceptre of sun and sea", id = 31414, buy = 50000, count = 1},
		{name = "ivory lyre", id = 31447, buy = 5000, count = 1}
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
	if player:getStorageValue(Storage.ThievesGuild.Mission08) == 3  then
		if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local player = Player(cid)
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("If you have lost an item, I have everything you are looking for here!", cid)
		end
	else
		npcHandler:say("In order to trade with me, first complete {The Thieves Guild Quest}.", cid)
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hi there, |PLAYERNAME|! You look like you are eager to {trade}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye, |PLAYERNAME|")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
