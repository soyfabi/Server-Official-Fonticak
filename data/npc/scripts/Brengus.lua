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
	{ name = "arrow", id = 3447, buy = 3 },
	{ name = "axe", id = 3274, buy = 20, sell = 7 },
	{ name = "banana sash", id = 11511, sell = 55 },
	{ name = "banana staff", id = 3348, sell = 1000 },
	{ name = "bast skirt", id = 3560, sell = 750 },
	{ name = "battle axe", id = 3266, buy = 235, sell = 80 },
	{ name = "battle hammer", id = 3305, buy = 350, sell = 120 },
	{ name = "battle shield", id = 3413, sell = 95 },
	{ name = "blue quiver", id = 35848, buy = 400 },
	{ name = "bolt", id = 3446, buy = 4 },
	{ name = "bone club", id = 3337, sell = 5 },
	{ name = "bone sword", id = 3338, buy = 75, sell = 20 },
	{ name = "bonelord helmet", id = 3408, sell = 2200 },
	{ name = "bow", id = 3350, buy = 400, sell = 100 },
	{ name = "brass armor", id = 3359, buy = 450, sell = 150 },
	{ name = "brass helmet", id = 3354, buy = 120, sell = 30 },
	{ name = "brass legs", id = 3372, buy = 195, sell = 49 },
	{ name = "brass shield", id = 3411, buy = 65, sell = 25 },
	{ name = "carlin sword", id = 3283, buy = 473, sell = 118 },
	{ name = "chain armor", id = 3358, buy = 200, sell = 70 },
	{ name = "chain helmet", id = 3352, buy = 52, sell = 17 },
	{ name = "chain legs", id = 3558, buy = 80, sell = 25 },
	{ name = "charmer's tiara", id = 3407, sell = 900 },
	{ name = "club", id = 3270, buy = 5, sell = 1 },
	{ name = "coat", id = 3562, buy = 8, sell = 1 },
	{ name = "copper shield", id = 3430, sell = 50 },
	{ name = "crimson sword", id = 7385, buy = 610 },
	{ name = "crocodile boots", id = 3556, sell = 1000 },
	{ name = "crossbow", id = 3349, buy = 500, sell = 120 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "crystalline arrow", id = 15793, buy = 20 },
	{ name = "dagger", id = 3267, buy = 5, sell = 2 },
	{ name = "diamond arrow", id = 35901, buy = 100 },
	{ name = "double axe", id = 3275, sell = 260 },
	{ name = "doublet", id = 3379, buy = 16, sell = 3 },
	{ name = "drill bolt", id = 16142, buy = 12 },
	{ name = "durable exercise axe", id = 35280, buy = 945000, count = 1800 },
	{ name = "durable exercise bow", id = 35282, buy = 945000, count = 1800 },
	{ name = "durable exercise club", id = 35281, buy = 945000, count = 1800 },
	{ name = "durable exercise sword", id = 35279, buy = 945000, count = 1800 },
	{ name = "dwarven shield", id = 3425, buy = 500, sell = 100 },
	{ name = "earth arrow", id = 774, buy = 5 },
	{ name = "envenomed arrow", id = 16143, buy = 12 },
	{ name = "exercise axe", id = 28553, buy = 262500, count = 500 },
	{ name = "exercise bow", id = 28555, buy = 262500, count = 500 },
	{ name = "exercise club", id = 28554, buy = 262500, count = 500 },
	{ name = "exercise sword", id = 28552, buy = 262500, count = 500 },
	{ name = "feather headdress", id = 3406, sell = 850 },
	{ name = "fire sword", id = 3280, sell = 1000 },
	{ name = "flaming arrow", id = 763, buy = 5 },
	{ name = "flash arrow", id = 761, buy = 5 },
	{ name = "halberd", id = 3269, sell = 400 },
	{ name = "hand axe", id = 3268, buy = 8, sell = 4 },
	{ name = "hatchet", id = 3276, sell = 25 },
	{ name = "horseman helmet", id = 3405, sell = 280 },
	{ name = "hunting spear", id = 3347, sell = 25 },
	{ name = "iron helmet", id = 3353, buy = 390, sell = 150 },
	{ name = "jacket", id = 3561, buy = 12, sell = 1 },
	{ name = "katana", id = 3300, sell = 35 },
	{ name = "kongra's shoulderpad", id = 11471, sell = 100 },
	{ name = "lasting exercise axe", id = 35286, buy = 7560000, count = 14400 },
	{ name = "lasting exercise bow", id = 35288, buy = 7560000, count = 14400 },
	{ name = "lasting exercise club", id = 35287, buy = 7560000, count = 14400 },
	{ name = "lasting exercise sword", id = 35285, buy = 7560000, count = 14400 },
	{ name = "leather armor", id = 3361, buy = 35, sell = 12 },
	{ name = "leather boots", id = 3552, buy = 10, sell = 2 },
	{ name = "leather helmet", id = 3355, buy = 12, sell = 4 },
	{ name = "leather legs", id = 3559, buy = 10, sell = 9 },
	{ name = "legion helmet", id = 3374, sell = 22 },
	{ name = "leopard armor", id = 3404, sell = 300 },
	{ name = "longsword", id = 3285, buy = 160, sell = 51 },
	{ name = "mace", id = 3286, buy = 90, sell = 30 },
	{ name = "morning star", id = 3282, buy = 430, sell = 100 },
	{ name = "onyx arrow", id = 7365, buy = 7 },
	{ name = "orcish axe", id = 3316, sell = 350 },
	{ name = "piercing bolt", id = 7363, buy = 5 },
	{ name = "plate armor", id = 3357, buy = 1200, sell = 400 },
	{ name = "plate legs", id = 3557, sell = 115 },
	{ name = "plate shield", id = 3410, buy = 125, sell = 45 },
	{ name = "power bolt", id = 3450, buy = 7 },
	{ name = "prismatic bolt", id = 16141, buy = 20 },
	{ name = "quiver", id = 35562, buy = 400 },
	{ name = "rapier", id = 3272, buy = 15, sell = 5 },
	{ name = "red quiver", id = 35849, buy = 400 },
	{ name = "royal spear", id = 7378, buy = 15 },
	{ name = "sabre", id = 3273, buy = 35 },
	{ name = "scale armor", id = 3377, buy = 260 },
	{ name = "shiver arrow", id = 762, buy = 5 },
	{ name = "short sword", id = 3294, buy = 26 },
	{ name = "sickle", id = 3293, buy = 7 },
	{ name = "sniper arrow", id = 7364, buy = 5 },
	{ name = "soldier helmet", id = 3375, buy = 110 },
	{ name = "spear", id = 3277, buy = 9 },
	{ name = "spectral bolt", id = 35902, buy = 70 },
	{ name = "spike sword", id = 3271, buy = 8000 },
	{ name = "steel helmet", id = 3351, buy = 580 },
	{ name = "steel shield", id = 3409, buy = 240 },
	{ name = "studded armor", id = 3378, buy = 90 },
	{ name = "studded helmet", id = 3376, buy = 63 },
	{ name = "studded legs", id = 3362, buy = 50 },
	{ name = "studded shield", id = 3426, buy = 50 },
	{ name = "sword", id = 3264, buy = 85 },
	{ name = "tarsal arrow", id = 14251, buy = 6 },
	{ name = "throwing knife", id = 3298, buy = 25 },
	{ name = "throwing star", id = 3287, buy = 42 },
	{ name = "tusk shield", id = 3443, sell = 850 },
	{ name = "two handed sword", id = 3265, buy = 950 },
	{ name = "viking helmet", id = 3367, buy = 265 },
	{ name = "viking shield", id = 3431, buy = 260 },
	{ name = "vortex bolt", id = 14252, buy = 6 },
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

local function creatureSayCallback(cid, type, msg)
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local player = Player(cid)
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Keep in mind you won't find better offers here. Just browse through my wares.", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
