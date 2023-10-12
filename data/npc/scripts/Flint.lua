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
	{ name = "alloy legs", id = 21168, sell = 11000 },
	{ name = "axe", id = 3274, buy = 20, sell = 7 },
	{ name = "battle axe", id = 3266, buy = 235, sell = 80 },
	{ name = "battle hammer", id = 3305, buy = 350, sell = 120 },
	{ name = "battle shield", id = 3413, sell = 95 },
	{ name = "bone club", id = 3337, sell = 5 },
	{ name = "bone sword", id = 3338, buy = 75, sell = 20 },
	{ name = "brass armor", id = 3359, buy = 450, sell = 150 },
	{ name = "brass helmet", id = 3354, buy = 120, sell = 30 },
	{ name = "brass legs", id = 3372, buy = 195, sell = 49 },
	{ name = "brass shield", id = 3411, buy = 65, sell = 25 },
	{ name = "carlin sword", id = 3283, buy = 473, sell = 118 },
	{ name = "chain armor", id = 3358, buy = 200, sell = 70 },
	{ name = "chain helmet", id = 3352, buy = 52, sell = 17 },
	{ name = "chain legs", id = 3558, buy = 80, sell = 25 },
	{ name = "club", id = 3270, buy = 5, sell = 1 },
	{ name = "coat", id = 3562, buy = 8, sell = 1 },
	{ name = "copper shield", id = 3430, sell = 50 },
	{ name = "cowtana", id = 21177, sell = 2500 },
	{ name = "crest of the deep seas", id = 21892, sell = 10000 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "dagger", id = 3267, buy = 5, sell = 2 },
	{ name = "double axe", id = 3275, sell = 260 },
	{ name = "doublet", id = 3379, buy = 16, sell = 3 },
	{ name = "durable exercise axe", id = 35280, buy = 945000, count = 1800 },
	{ name = "durable exercise bow", id = 35282, buy = 945000, count = 1800 },
	{ name = "durable exercise club", id = 35281, buy = 945000, count = 1800 },
	{ name = "durable exercise sword", id = 35279, buy = 945000, count = 1800 },
	{ name = "dwarven shield", id = 3425, buy = 500, sell = 100 },
	{ name = "execowtioner axe", id = 21176, sell = 12000 },
	{ name = "exercise axe", id = 28553, buy = 262500, count = 500 },
	{ name = "exercise bow", id = 28555, buy = 262500, count = 500 },
	{ name = "exercise club", id = 28554, buy = 262500, count = 500 },
	{ name = "exercise sword", id = 28552, buy = 262500, count = 500 },
	{ name = "fire sword", id = 3280, sell = 1000 },
	{ name = "gearwheel chain", id = 21170, sell = 5000 },
	{ name = "glooth amulet", id = 21183, sell = 2000 },
	{ name = "glooth axe", id = 21180, sell = 1500 },
	{ name = "glooth blade", id = 21179, sell = 1500 },
	{ name = "glooth cap", id = 21164, sell = 7000 },
	{ name = "glooth club", id = 21178, sell = 1500 },
	{ name = "glooth whip", id = 21172, sell = 2500 },
	{ name = "halberd", id = 3269, sell = 400 },
	{ name = "hand axe", id = 3268, buy = 8, sell = 4 },
	{ name = "hatchet", id = 3276, sell = 25 },
	{ name = "heat core", id = 21167, sell = 10000 },
	{ name = "iron helmet", id = 3353, buy = 390, sell = 150 },
	{ name = "jacket", id = 3561, buy = 12, sell = 1 },
	{ name = "katana", id = 3300, sell = 35 },
	{ name = "lasting exercise axe", id = 35286, buy = 7560000, count = 14400 },
	{ name = "lasting exercise bow", id = 35288, buy = 7560000, count = 14400 },
	{ name = "lasting exercise club", id = 35287, buy = 7560000, count = 14400 },
	{ name = "lasting exercise sword", id = 35285, buy = 7560000, count = 14400 },
	{ name = "leather armor", id = 3361, buy = 35, sell = 12 },
	{ name = "leather boots", id = 3552, buy = 10, sell = 2 },
	{ name = "leather helmet", id = 3355, buy = 12, sell = 4 },
	{ name = "leather legs", id = 3559, buy = 10, sell = 9 },
	{ name = "legion helmet", id = 3374, sell = 22 },
	{ name = "longsword", id = 3285, buy = 160, sell = 51 },
	{ name = "mace", id = 3286, buy = 90, sell = 30 },
	{ name = "metal bat", id = 21171, sell = 9000 },
	{ name = "metal spats", id = 21169, sell = 2000 },
	{ name = "mino lance", id = 21174, sell = 7000 },
	{ name = "mino shield", id = 21175, sell = 3000 },
	{ name = "mooh'tah plate", id = 21166, sell = 6000 },
	{ name = "moohtant cudgel", id = 21173, sell = 14000 },
	{ name = "morning star", id = 3282, buy = 430, sell = 100 },
	{ name = "orcish axe", id = 3316, sell = 350 },
	{ name = "plate armor", id = 3357, buy = 1200, sell = 400 },
	{ name = "plate legs", id = 3557, sell = 115 },
	{ name = "plate shield", id = 3410, buy = 125, sell = 45 },
	{ name = "rapier", id = 3272, buy = 15, sell = 5 },
	{ name = "rubber cap", id = 21165, sell = 11000 },
	{ name = "sabre", id = 3273, buy = 35, sell = 12 },
	{ name = "scale armor", id = 3377, buy = 260, sell = 75 },
	{ name = "short sword", id = 3294, buy = 26, sell = 10 },
	{ name = "sickle", id = 3293, buy = 7, sell = 3 },
	{ name = "small axe", id = 3462, sell = 5 },
	{ name = "soldier helmet", id = 3375, buy = 110, sell = 16 },
	{ name = "spike sword", id = 3271, buy = 8000, sell = 240 },
	{ name = "steel helmet", id = 3351, buy = 580, sell = 293 },
	{ name = "steel shield", id = 3409, buy = 240, sell = 80 },
	{ name = "studded armor", id = 3378, buy = 90, sell = 25 },
	{ name = "studded club", id = 3336, sell = 10 },
	{ name = "studded helmet", id = 3376, buy = 63 },
	{ name = "studded legs", id = 3362, buy = 50 },
	{ name = "studded shield", id = 3426, buy = 50 },
	{ name = "sword", id = 3264, buy = 85 },
	{ name = "throwing knife", id = 3298, buy = 25 },
	{ name = "two handed sword", id = 3265, buy = 950 },
	{ name = "viking helmet", id = 3367, buy = 265 },
	{ name = "viking shield", id = 3431, buy = 260 },
	{ name = "war hammer", id = 3279, buy = 10000 },
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

local function greetCallback(cid)
	npcHandler:setMessage(MESSAGE_GREET, "Hello, citizen. If you need {equipment}, ask for a {trade}.")
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
		npcHandler:say("I sell and buy all types of {armor}, {swords}, {wands}, etc.", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
