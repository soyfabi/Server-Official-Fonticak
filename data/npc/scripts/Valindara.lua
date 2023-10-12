local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Im eager for a bath in the lake.'},{text = 'Im interested in shiny precious things, if you have some.'},{text = 'No, you cant have this cloak.'} }
npcHandler:addModule(VoiceModule:new(voices))

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "amber", id = 32626, sell = 20000 },
	{ name = "amber with a bug", id = 32624, sell = 41000 },
	{ name = "amber with a dragonfly", id = 32625, sell = 56000 },
	{ name = "ancient coin", id = 24390, sell = 350 },
	{ name = "animate dead rune", id = 3203, buy = 375 },
	{ name = "avalanche rune", id = 3161, buy = 57 },
	{ name = "bar of gold", id = 14112, sell = 10000 },
	{ name = "black pearl", id = 3027, buy = 560, sell = 280 },
	{ name = "blue crystal shard", id = 16119, sell = 1500 },
	{ name = "blue crystal splinter", id = 16124, sell = 400 },
	{ name = "blue rose", id = 3659, sell = 200 },
	{ name = "bronze goblet", id = 5807, buy = 2000 },
	{ name = "brown crystal splinter", id = 16123, sell = 400 },
	{ name = "brown giant shimmering pearl", id = 282, sell = 3000 },
	{ name = "butterfly ring", id = 25698, sell = 2000 },
	{ name = "chameleon rune", id = 3178, buy = 210 },
	{ name = "colourful snail shell", id = 25696, sell = 250 },
	{ name = "convince creature rune", id = 3177, buy = 80 },
	{ name = "coral brooch", id = 24391, sell = 750 },
	{ name = "crunor idol", id = 30055, sell = 30000 },
	{ name = "cure poison rune", id = 3153, buy = 65 },
	{ name = "cyan crystal fragment", id = 16125, sell = 800 },
	{ name = "dandelion seeds", id = 25695, sell = 200 },
	{ name = "destroy field rune", id = 3148, buy = 15 },
	{ name = "diamond", id = 32770, sell = 15000 },
	{ name = "disintegrate rune", id = 3197, buy = 26 },
	{ name = "dragon figurine", id = 30053, sell = 45000 },
	{ name = "dream blossom staff", id = 25700, sell = 5000 },
	{ name = "empty potion flask", id = 283, sell = 5 },
	{ name = "empty potion flask", id = 284, sell = 5 },
	{ name = "empty potion flask", id = 285, sell = 5 },
	{ name = "energy bomb rune", id = 3149, buy = 203 },
	{ name = "energy field rune", id = 3164, buy = 38 },
	{ name = "energy wall rune", id = 3166, buy = 85 },
	{ name = "explosion rune", id = 3200, buy = 31 },
	{ name = "fairy wings", id = 25694, sell = 200 },
	{ name = "fern", id = 3737, sell = 20 },
	{ name = "fire bomb rune", id = 3192, buy = 147 },
	{ name = "fire field rune", id = 3188, buy = 28 },
	{ name = "fire wall rune", id = 3190, buy = 61 },
	{ name = "fireball rune", id = 3189, buy = 30 },
	{ name = "gemmed figurine", id = 24392, sell = 3500 },
	{ name = "giant amethyst", id = 30061, sell = 60000 },
	{ name = "giant emerald", id = 30060, sell = 90000 },
	{ name = "giant ruby", id = 30059, sell = 70000 },
	{ name = "giant sapphire", id = 30061, sell = 50000 },
	{ name = "giant topaz", id = 32623, sell = 80000 },
	{ name = "goat grass", id = 3674, sell = 50 },
	{ name = "gold ingot", id = 9058, sell = 5000 },
	{ name = "gold nugget", id = 3040, sell = 850 },
	{ name = "golden amulet", id = 3013, buy = 6600 },
	{ name = "golden figurine", id = 5799, sell = 3000 },
	{ name = "golden goblet", id = 5805, buy = 5000 },
	{ name = "great fireball rune", id = 3191, buy = 57 },
	{ name = "great health potion", id = 239, buy = 225 },
	{ name = "great mana potion", id = 238, buy = 144 },
	{ name = "great spirit potion", id = 7642, buy = 228 },
	{ name = "green crystal fragment", id = 16127, sell = 800 },
	{ name = "green crystal shard", id = 16121, sell = 1500 },
	{ name = "green crystal splinter", id = 16122, sell = 400 },
	{ name = "green giant shimmering pearl", id = 281, sell = 3000 },
	{ name = "health potion", id = 266, buy = 50 },
	{ name = "heavy magic missile rune", id = 3198, buy = 12 },
	{ name = "hexagonal ruby", id = 30180, sell = 30000 },
	{ name = "hibiscus dress", id = 8045, sell = 3000 },
	{ name = "holy missile rune", id = 3182, buy = 16 },
	{ name = "icicle rune", id = 3158, buy = 30 },
	{ name = "intense healing rune", id = 3152, buy = 95 },
	{ name = "leaf star", id = 25735, sell = 50 },
	{ name = "light magic missile rune", id = 3174, buy = 4 },
	{ name = "magic wall rune", id = 3180, buy = 116 },
	{ name = "mana potion", id = 268, buy = 56 },
	{ name = "mandrake", id = 5014, sell = 5000 },
	{ name = "moonstone", id = 32771, sell = 13000 },
	{ name = "onyx chip", id = 22193, sell = 500 },
	{ name = "opal", id = 22194, sell = 500 },
	{ name = "ornate lion figurine", id = 33781, sell = 10000 },
	{ name = "ornate locket", id = 30056, sell = 18000 },
	{ name = "panpipes", id = 2953, sell = 150 },
	{ name = "paralyse rune", id = 3165, buy = 700 },
	{ name = "poison bomb rune", id = 3173, buy = 85 },
	{ name = "poison field rune", id = 3172, buy = 21 },
	{ name = "poison wall rune", id = 3176, buy = 52 },
	{ name = "powder herb", id = 3739, sell = 10 },
	{ name = "prismatic quartz", id = 24962, sell = 450 },
	{ name = "rainbow quartz", id = 25737, sell = 500 },
	{ name = "red crystal fragment", id = 16126, sell = 800 },
	{ name = "red rose", id = 3658, sell = 10 },
	{ name = "ruby necklace", id = 3016, buy = 3560 },
	{ name = "shimmering beatles", id = 25693, sell = 150 },
	{ name = "silver goblet", id = 5806, buy = 3000 },
	{ name = "skull coin", id = 32583, sell = 12000 },
	{ name = "sling herb", id = 3738, sell = 10 },
	{ name = "small amethyst", id = 3033, buy = 400, sell = 200 },
	{ name = "small diamond", id = 3028, buy = 600, sell = 300 },
	{ name = "small emerald", id = 3032, buy = 500, sell = 250 },
	{ name = "small enchanted amethyst", id = 678, sell = 200 },
	{ name = "small enchanted emerald", id = 677, sell = 250 },
	{ name = "small enchanted ruby", id = 676, sell = 250 },
	{ name = "small enchanted sapphire", id = 675, sell = 250 },
	{ name = "small ruby", id = 3030, buy = 500, sell = 250 },
	{ name = "small sapphire", id = 3029, buy = 500, sell = 250 },
	{ name = "small topaz", id = 9057, sell = 200 },
	{ name = "soulfire rune", id = 3195, buy = 46 },
	{ name = "stalagmite rune", id = 3179, buy = 12 },
	{ name = "star herb", id = 3736, sell = 15 },
	{ name = "stone herb", id = 3735, sell = 20 },
	{ name = "stone shower rune", id = 3175, buy = 37 },
	{ name = "strong health potion", id = 236, buy = 115 },
	{ name = "strong mana potion", id = 237, buy = 93 },
	{ name = "sudden death rune", id = 3155, buy = 135 },
	{ name = "summer dress", id = 8046, sell = 1500 },
	{ name = "supreme health potion", id = 23375, buy = 625 },
	{ name = "thunderstorm rune", id = 3202, buy = 47 },
	{ name = "tiger eye", id = 24961, sell = 350 },
	{ name = "ultimate healing rune", id = 3160, buy = 175 },
	{ name = "ultimate health potion", id = 7643, buy = 379 },
	{ name = "ultimate mana potion", id = 23373, buy = 438 },
	{ name = "ultimate spirit potion", id = 23374, buy = 438 },
	{ name = "unicorn figurine", id = 30054, sell = 50000 },
	{ name = "vial", id = 2874, sell = 5 },
	{ name = "violet crystal shard", id = 16120, sell = 1500 },
	{ name = "watering can", id = 650, buy = 50 },
	{ name = "watermelon tourmaline", id = 33780, sell = 230000 },
	{ name = "wedding ring", id = 3004, buy = 990, sell = 100 },
	{ name = "white gem", id = 32769, sell = 12000 },
	{ name = "white pearl", id = 3026, buy = 320, sell = 160 },
	{ name = "white silk flower", id = 34008, sell = 9000 },
	{ name = "wild flowers", id = 25691, sell = 120 },
	{ name = "wild growth rune", id = 3156, buy = 160 },
	{ name = "wood cape", id = 3575, sell = 5000 },
	{ name = "wooden spellbook", id = 25699, sell = 12000 }
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
		npcHandler:say("Of course, just browse through my wares. Or do you want to look only at {potions}, {wands} or {runes}?", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)

npcHandler:setMessage(MESSAGE_GREET, "Greatings, mortal beigin.")
npcHandler:setMessage(MESSAGE_SENDTRADE, "Yes, i have some potions and runes if you are interested. Or do you want to buy only potions or only runes?oh if you want sell or buy gems, your may also ask me.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May enlightenment be your path, |PLAYERNAME|.")
npcHandler:addModule(FocusModule:new())
