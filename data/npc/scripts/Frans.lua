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
	{ name = "animate dead rune", id = 3203, buy = 375 },
	{ name = "blank rune", id = 3147, buy = 10 },
	{ name = "chameleon rune", id = 3178, buy = 210 },
	{ name = "convince creature rune", id = 3177, buy = 80 },
	{ name = "cure poison rune", id = 3153, buy = 65 },
	{ name = "disintegrate rune", id = 3197, buy = 26 },
	{ name = "destroy field rune", id = 3148, buy = 15 },
	{ name = "durable exercise rod", id = 35283, buy = 945000, count = 1800 },
	{ name = "durable exercise wand", id = 35284, buy = 945000, count = 1800 },
	{ name = "empty potion flask", id = 283, sell = 5 },
	{ name = "empty potion flask", id = 284, sell = 5 },
	{ name = "empty potion flask", id = 285, sell = 5 },
	{ name = "glacial rod", id = 16118, sell = 6500 },
	{ name = "energy bomb rune", id = 3149, buy = 162 },
	{ name = "energy field rune", id = 3164, buy = 38 },
	{ name = "energy wall rune", id = 3166, buy = 85 },
	{ name = "exercise rod", id = 28556, buy = 262500, count = 500 },
	{ name = "exercise wand", id = 28557, buy = 262500, count = 500 },
	{ name = "explosion rune", id = 3200, buy = 31 },
	{ name = "fire bomb rune", id = 3192, buy = 147 },
	{ name = "fire field rune", id = 3188, buy = 28 },
	{ name = "fire wall rune", id = 3190, buy = 61 },
	{ name = "fireball rune", id = 3189, buy = 30 },
	{ name = "great fireball rune", id = 3191, buy = 57 },
	{ name = "great health potion", id = 239, buy = 225 },
	{ name = "great mana potion", id = 238, buy = 144 },
	{ name = "great spirit potion", id = 7642, buy = 228 },
	{ name = "hailstorm rod", id = 3067, buy = 15000, sell = 3000 },
	{ name = "health potion", id = 266, buy = 50 },
	{ name = "heavy magic missile rune", id = 3198, buy = 12 },
	{ name = "holy missile rune", id = 3182, buy = 16 },
	{ name = "intense healing rune", id = 3152, buy = 95 },
	{ name = "lasting exercise rod", id = 35289, buy = 7560000, count = 14400 },
	{ name = "lasting exercise wand", id = 35290, buy = 7560000, count = 14400 },
	{ name = "icicle rune", id = 3158, buy = 30 },
	{ name = "intense healing rune", id = 3152, buy = 95 },
	{ name = "light magic missile rune", id = 3174, buy = 4 },
	{ name = "magic wall rune", id = 3180, buy = 80 },
	{ name = "mana potion", id = 268, buy = 56 },
	{ name = "moonlight rod", id = 3070, buy = 1000, sell = 200 },
	{ name = "muck rod", id = 16117, sell = 6000 },
	{ name = "necrotic rod", id = 3069, buy = 5000, sell = 1000 },
	{ name = "northwind rod", id = 8083, buy = 7500, sell = 1500 },
	{ name = "paralyze rune", id = 3165, buy = 500 },
	{ name = "poison bomb rune", id = 3173, buy = 110 },
	{ name = "poison field rune", id = 3172, buy = 21 },
	{ name = "poison wall rune", id = 3176, buy = 52 },
	{ name = "snakebite rod", id = 3066, buy = 500 },
	{ name = "soulfire rune", id = 3195, buy = 80 },
	{ name = "spellbook", id = 3059, buy = 150 },
	{ name = "spellwand", id = 651, sell = 299 },
	{ name = "springsprout rod", id = 8084, buy = 18000, sell = 3600 },
	{ name = "stalagmite rune", id = 3179, buy = 12 },
	{ name = "strong health potion", id = 236, buy = 115 },
	{ name = "strong mana potion", id = 237, buy = 93 },
	{ name = "sudden death rune", id = 3155, buy = 135 },
	{ name = "terra rod", id = 3065, buy = 10000, sell = 2000 },
	{ name = "thunderstorm rune", id = 3202, buy = 45 },
	{ name = "ultimate healing rune", id = 3160, buy = 175 },
	{ name = "ultimate health potion", id = 7643, buy = 379 },
	{ name = "vial", id = 2874, sell = 5 },
	{ name = "underworld rod", id = 8082, buy = 30000, sell = 4400 },
	{ name = "wand of cosmic energy", id = 3073, buy = 10000, sell = 2200 },
	{ name = "wand of decay", id = 3072, buy = 5000, sell = 1000 },
	{ name = "wand of defiance", id = 16096, sell = 6500 },
	{ name = "wand of draconia", id = 8093, buy = 7500, sell = 1500 },
	{ name = "wand of dragonbreath", id = 3075, buy = 1000, sell = 200 },
	{ name = "wand of inferno", id = 3071, buy = 15000, sell = 3000 },
	{ name = "wand of starstorm", id = 8092, buy = 18000, sell = 3600 },
	{ name = "wand of voodoo", id = 8094, buy = 22000, sell = 4400 },
	{ name = "wand of vortex", id = 3074, buy = 500 },
	{ name = "wild growth rune", id = 3156, buy = 160 }
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
		player:addItem(items[item].itemId, amount)
		return player:sendTextMessage(MESSAGE_INFO_DESCR, 'Bought '..amount..'x '..items[item].realName..' for '..items[item].buyPrice * amount..' gold coins.')
	end
	return true
end

local function onSell(cid, item, subType, amount, ignoreCap, inBackpacks)
	local player = Player(cid)
	if not checkExhaustShop(player) then
        return false
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
