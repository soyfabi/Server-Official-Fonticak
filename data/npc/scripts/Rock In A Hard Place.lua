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
	{ name = "animate dead rune", id = 3203, buy = 375 },
	{ name = "arrow", id = 3447, buy = 3 },
	{ name = "avalanche rune", id = 3161, buy = 57 },
	{ name = "axe", id = 3274, buy = 20, sell = 7 },
	{ name = "backpack", id = 2854, buy = 20 },
	{ name = "basket", id = 2855, buy = 6 },
	{ name = "battle axe", id = 3266, buy = 235, sell = 80 },
	{ name = "battle hammer", id = 3305, buy = 350, sell = 120 },
	{ name = "battle shield", id = 3413, sell = 95 },
	{ name = "blank rune", id = 3147, buy = 10 },
	{ name = "blue quiver", id = 35848, buy = 400 },
	{ name = "bolt", id = 3446, buy = 4 },
	{ name = "bone club", id = 3337, sell = 5 },
	{ name = "bone sword", id = 3338, buy = 75, sell = 20 },
	{ name = "bottle", id = 2875, buy = 3 },
	{ name = "bow", id = 3350, buy = 400, sell = 100 },
	{ name = "brass armor", id = 3359, buy = 450, sell = 150 },
	{ name = "brass helmet", id = 3354, buy = 120, sell = 30 },
	{ name = "brass legs", id = 3372, buy = 195, sell = 49 },
	{ name = "brass shield", id = 3411, buy = 65, sell = 25 },
	{ name = "bucket", id = 2873, buy = 4 },
	{ name = "calopteryx cape", id = 14086, sell = 15000 },
	{ name = "candelabrum", id = 2911, buy = 8 },
	{ name = "candlestick", id = 2917, buy = 2 },
	{ name = "carapace shield", id = 14088, sell = 32000 },
	{ name = "carlin sword", id = 3283, buy = 473, sell = 118 },
	{ name = "chain armor", id = 3358, buy = 200, sell = 70 },
	{ name = "chain helmet", id = 3352, buy = 52, sell = 17 },
	{ name = "chain legs", id = 3558, buy = 80, sell = 25 },
	{ name = "chameleon rune", id = 3178, buy = 210 },
	{ name = "closed trap", id = 3481, buy = 280, sell = 75 },
	{ name = "club", id = 3270, buy = 5, sell = 1 },
	{ name = "coat", id = 3562, buy = 8, sell = 1 },
	{ name = "compound eye", id = 14083, sell = 150 },
	{ name = "convince creature rune", id = 3177, buy = 80 },
	{ name = "copper shield", id = 3430, sell = 50 },
	{ name = "crawler head plating", id = 14079, sell = 210 },
	{ name = "crossbow", id = 3349, buy = 500, sell = 120 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "crowbar", id = 3304, buy = 260 },
	{ name = "crystalline arrow", id = 15793, buy = 20 },
	{ name = "cure poison rune", id = 3153, buy = 65 },
	{ name = "dagger", id = 3267, buy = 5, sell = 2 },
	{ name = "deepling axe", id = 13991, sell = 40000 },
	{ name = "deepling breaktime snack", id = 14011, sell = 90 },
	{ name = "deepling claw", id = 14044, sell = 430 },
	{ name = "deepling guard belt buckle", id = 14010, sell = 230 },
	{ name = "deepling ridge", id = 14041, sell = 360 },
	{ name = "deepling scales", id = 14017, sell = 80 },
	{ name = "deepling squelcher", id = 14250, sell = 7000 },
	{ name = "deepling staff", id = 13987, sell = 4000 },
	{ name = "deepling warts", id = 14012, sell = 180 },
	{ name = "deeptags", id = 14013, sell = 290 },
	{ name = "depth calcei", id = 13997, sell = 25000 },
	{ name = "depth galea", id = 13995, sell = 35000 },
	{ name = "depth lorica", id = 13994, sell = 30000 },
	{ name = "depth ocrea", id = 13996, sell = 16000 },
	{ name = "depth scutum", id = 13998, sell = 36000 },
	{ name = "desintegrate rune", id = 3197, buy = 26 },
	{ name = "destroy field rune", id = 3148, buy = 15 },
	{ name = "diamond arrow", id = 35901, buy = 100 },
	{ name = "double axe", id = 3275, sell = 260 },
	{ name = "doublet", id = 3379, buy = 16, sell = 3 },
	{ name = "drill bolt", id = 16142, buy = 12 },
	{ name = "dung ball", id = 14225, sell = 130 },
	{ name = "dwarven shield", id = 3425, buy = 500, sell = 100 },
	{ name = "earth arrow", id = 774, buy = 5 },
	{ name = "empty potion flask", id = 283, sell = 5 },
	{ name = "empty potion flask", id = 284, sell = 5 },
	{ name = "empty potion flask", id = 285, sell = 5 },
	{ name = "energy bomb rune", id = 3149, buy = 203 },
	{ name = "energy field rune", id = 3164, buy = 38 },
	{ name = "energy wall rune", id = 3166, buy = 85 },
	{ name = "envenomed arrow", id = 16143, buy = 12 },
	{ name = "explosion rune", id = 3200, buy = 31 },
	{ name = "eye of a deepling", id = 12730, sell = 150 },
	{ name = "fire bomb rune", id = 3192, buy = 147 },
	{ name = "fire field rune", id = 3188, buy = 28 },
	{ name = "fire sword", id = 3280, sell = 1000 },
	{ name = "fire wall rune", id = 3190, buy = 61 },
	{ name = "fireball rune", id = 3189, buy = 30 },
	{ name = "fishing rod", id = 3483, buy = 150, sell = 40 },
	{ name = "flaming arrow", id = 763, buy = 5 },
	{ name = "flash arrow", id = 761, buy = 5 },
	{ name = "grasshopper legs", id = 14087, sell = 15000 },
	{ name = "great fireball rune", id = 3191, buy = 57 },
	{ name = "great health potion", id = 239, buy = 225 },
	{ name = "great mana potion", id = 238, buy = 144 },
	{ name = "great spirit potion", id = 7642, buy = 228 },
	{ name = "guardian axe", id = 14043, sell = 9000 },
	{ name = "halberd", id = 3269, sell = 400 },
	{ name = "hand auger", id = 31334, buy = 25 },
	{ name = "hand axe", id = 3268, buy = 8, sell = 4 },
	{ name = "hatchet", id = 3276, sell = 25 },
	{ name = "health potion", id = 266, buy = 50 },
	{ name = "heavy magic missile rune", id = 3198, buy = 12 },
	{ name = "hive bow", id = 14246, sell = 28000 },
	{ name = "hive scythe", id = 14089, sell = 17000 },
	{ name = "holy missile rune", id = 3182, buy = 16 },
	{ name = "icicle rune", id = 3158, buy = 30 },
	{ name = "intense healing rune", id = 3152, buy = 95 },
	{ name = "iron helmet", id = 3353, buy = 390, sell = 150 },
	{ name = "jacket", id = 3561, buy = 12, sell = 1 },
	{ name = "katana", id = 3300, sell = 35 },
	{ name = "key to the drowned library", id = 14009, sell = 330 },
	{ name = "kollos shell", id = 14077, sell = 420 },
	{ name = "label", id = 3507, buy = 1 },
	{ name = "leather armor", id = 3361, buy = 35, sell = 12 },
	{ name = "leather boots", id = 3552, buy = 10, sell = 2 },
	{ name = "leather helmet", id = 3355, buy = 12, sell = 4 },
	{ name = "leather legs", id = 3559, buy = 10, sell = 9 },
	{ name = "legion helmet", id = 3374, sell = 22 },
	{ name = "letter", id = 3505, buy = 8 },
	{ name = "light magic missile rune", id = 3174, buy = 4 },
	{ name = "longsword", id = 3285, buy = 160, sell = 51 },
	{ name = "mace", id = 3286, buy = 90, sell = 30 },
	{ name = "machete", id = 3308, buy = 35, sell = 6 },
	{ name = "magic wall rune", id = 3180, buy = 116 },
	{ name = "mana potion", id = 268, buy = 56 },
	{ name = "morning star", id = 3282, buy = 430, sell = 100 },
	{ name = "necklace of the deep", id = 13990, sell = 3000 },
	{ name = "net", id = 31489, buy = 50 },
	{ name = "onyx arrow", id = 7365, buy = 7 },
	{ name = "orcish axe", id = 3316, sell = 350 },
	{ name = "ornate chestplate", id = 13993, sell = 60000 },
	{ name = "ornate crossbow", id = 14247, sell = 12000 },
	{ name = "ornate legs", id = 13999, sell = 40000 },
	{ name = "ornate mace", id = 14001, sell = 42000 },
	{ name = "ornate shield", id = 14000, sell = 42000 },
	{ name = "paralyze rune", id = 3165, buy = 700 },
	{ name = "parcel", id = 3503, buy = 15 },
	{ name = "pick", id = 3456, buy = 50, sell = 15 },
	{ name = "piercing bolt", id = 7363, buy = 5 },
	{ name = "plate armor", id = 3357, buy = 1200, sell = 400 },
	{ name = "plate legs", id = 3557, sell = 115 },
	{ name = "plate shield", id = 3410, buy = 125, sell = 45 },
	{ name = "poison bomb rune", id = 3173, buy = 85 },
	{ name = "poison field rune", id = 3172, buy = 21 },
	{ name = "poison wall rune", id = 3176, buy = 52 },
	{ name = "power bolt", id = 3450, buy = 7 },
	{ name = "present", id = 2856, buy = 10 },
	{ name = "prismatic bolt", id = 16141, buy = 20 },
	{ name = "quiver", id = 35562, buy = 400 },
	{ name = "rapier", id = 3272, buy = 15, sell = 5 },
	{ name = "red quiver", id = 35849, buy = 400 },
	{ name = "rope", id = 3003, buy = 50, sell = 15 },
	{ name = "royal spear", id = 7378, buy = 15 },
	{ name = "sabre", id = 3273, buy = 35, sell = 12 },
	{ name = "scale armor", id = 3377, buy = 260, sell = 75 },
	{ name = "scythe", id = 3453, buy = 50, sell = 10 },
	{ name = "shiver arrow", id = 762, buy = 5 },
	{ name = "short sword", id = 3294, buy = 26, sell = 10 },
	{ name = "shovel", id = 3457, buy = 50, sell = 8 },
	{ name = "sickle", id = 3293, buy = 7, sell = 3 },
	{ name = "small axe", id = 3462, sell = 5 },
	{ name = "sniper arrow", id = 7364, buy = 5 },
	{ name = "soldier helmet", id = 3375, buy = 110, sell = 16 },
	{ name = "soulfire rune", id = 3195, buy = 46 },
	{ name = "spear", id = 3277, buy = 9, sell = 3 },
	{ name = "spectral bolt", id = 35902, buy = 70 },
	{ name = "spellsinger's seal", id = 14008, sell = 280 },
	{ name = "spidris mandible", id = 14082, sell = 450 },
	{ name = "spike sword", id = 3271, buy = 8000, sell = 240 },
	{ name = "spitter nose", id = 14078, sell = 340 },
	{ name = "stalagmite rune", id = 3179, buy = 12 },
	{ name = "steel helmet", id = 3351, buy = 580, sell = 293 },
	{ name = "steel shield", id = 3409, buy = 240, sell = 80 },
	{ name = "stone shower rune", id = 3175, buy = 37 },
	{ name = "strong health potion", id = 236, buy = 115 },
	{ name = "strong mana potion", id = 237, buy = 93 },
	{ name = "studded armor", id = 3378, buy = 90, sell = 25 },
	{ name = "studded club", id = 3336, sell = 10 },
	{ name = "studded helmet", id = 3376, buy = 63, sell = 20 },
	{ name = "studded legs", id = 3362, buy = 50, sell = 15 },
	{ name = "studded shield", id = 3426, buy = 50, sell = 16 },
	{ name = "sudden death rune", id = 3155, buy = 135 },
	{ name = "supreme health potion", id = 23375, buy = 625 },
	{ name = "swampling club", id = 17824, sell = 40 },
	{ name = "swarmer antenna", id = 14076, sell = 130 },
	{ name = "sword", id = 3264, buy = 85, sell = 25 },
	{ name = "tarsal arrow", id = 14251, buy = 6 },
	{ name = "throwing knife", id = 3298, buy = 25, sell = 2 },
	{ name = "throwing star", id = 3287, buy = 42 },
	{ name = "thunderstorm rune", id = 3202, buy = 47 },
	{ name = "torch", id = 2920, buy = 2 },
	{ name = "two handed sword", id = 3265, buy = 950, sell = 450 },
	{ name = "ultimate healing rune", id = 3160, buy = 175 },
	{ name = "ultimate health potion", id = 7643, buy = 379 },
	{ name = "ultimate mana potion", id = 23373, buy = 438 },
	{ name = "ultimate spirit potion", id = 23374, buy = 438 },
	{ name = "vial", id = 2874, sell = 5 },
	{ name = "viking helmet", id = 3367, buy = 265, sell = 66 },
	{ name = "viking shield", id = 3431, buy = 260, sell = 85 },
	{ name = "vortex bolt", id = 14252, buy = 6 },
	{ name = "war hammer", id = 3279, buy = 10000, sell = 470 },
	{ name = "warrior's axe", id = 14040, sell = 11000 },
	{ name = "warrior's shield", id = 14042, sell = 9000 },
	{ name = "waspoid claw", id = 14080, sell = 320 },
	{ name = "waspoid wing", id = 14081, sell = 190 },
	{ name = "watch", id = 2906, buy = 20, sell = 6 },
	{ name = "wild growth rune", id = 3156, buy = 160 },
	{ name = "wooden hammer", id = 3459, sell = 15 },
	{ name = "wooden shield", id = 3412, buy = 15, sell = 5 },
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
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:addModule(FocusModule:new())
