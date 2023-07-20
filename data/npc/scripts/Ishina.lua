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
	{ name = "amber", id = 32626, sell = 20000 },
	{ name = "amber with a bug", id = 32624, sell = 41000 },
	{ name = "amber with a dragonfly", id = 32625, sell = 56000 },
	{ name = "ancient coin", id = 24390, sell = 350 },
	{ name = "black pearl", id = 3027, buy = 560, sell = 280 },
	{ name = "blue crystal shard", id = 16119, sell = 1500 },
	{ name = "blue crystal splinter", id = 16124, sell = 400 },
	{ name = "bronze goblet", id = 5807, buy = 2000 },
	{ name = "brown crystal splinter", id = 16123, sell = 400 },
	{ name = "brown giant shimmering pearl", id = 282, sell = 3000 },
	{ name = "coral brooch", id = 24391, sell = 750 },
	{ name = "crunor idol", id = 30055, sell = 30000 },
	{ name = "cyan crystal fragment", id = 16125, sell = 800 },
	{ name = "dragon figurine", id = 30053, sell = 45000 },
	{ name = "gemmed figurine", id = 24392, sell = 3500 },
	{ name = "giant amethyst", id = 30061, sell = 60000 },
	{ name = "giant emerald", id = 30060, sell = 90000 },
	{ name = "giant ruby", id = 30059, sell = 70000 },
	{ name = "giant sapphire", id = 30061, sell = 50000 },
	{ name = "giant topaz", id = 32623, sell = 80000 },
	{ name = "gold ingot", id = 9058, sell = 5000 },
	{ name = "gold nugget", id = 3040, sell = 850 },
	{ name = "golden amulet", id = 3013, buy = 6600 },
	{ name = "golden goblet", id = 5805, buy = 5000 },
	{ name = "green crystal fragment", id = 16127, sell = 800 },
	{ name = "green crystal shard", id = 16121, sell = 1500 },
	{ name = "green crystal splinter", id = 16122, sell = 400 },
	{ name = "green giant shimmering pearl", id = 281, sell = 3000 },
	{ name = "lion figurine", id = 33781, sell = 10000 },
	{ name = "onyx chip", id = 22193, sell = 400 },
	{ name = "opal", id = 22194, sell = 500 },
	{ name = "ornate locket", id = 30056, sell = 18000 },
	{ name = "prismatic quartz", id = 24962, sell = 450 },
	{ name = "red crystal fragment", id = 16126, sell = 800 },
	{ name = "ruby necklace", id = 3016, buy = 3560 },
	{ name = "silver goblet", id = 5806, buy = 3000 },
	{ name = "skull coin", id = 32583, sell = 12000 },
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
	{ name = "tiger eye", id = 24961, sell = 350 },
	{ name = "unicorn figurine", id = 30054, sell = 50000 },
	{ name = "violet crystal shard", id = 16120, sell = 1500 },
	{ name = "white silk flower", id = 34008, sell = 9000 },
	{ name = "wedding ring", id = 3004, buy = 990 },
	{ name = "white pearl", id = 3026, buy = 320 }
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
		npcHandler:say("This is all I offer.", cid)
	end

	if msgcontains(msg, 'outfit') then
		if player:getSex() == PLAYERSEX_MALE then
			npcHandler:say('My jewelled belt? <giggles> That\'s not very manly. Maybe you\'d prefer a scimitar like Habdel has.', cid)
			return true
		end

		if player:getStorageValue(Storage.OutfitQuest.firstOrientalAddon) < 1 then
			npcHandler:say('My jewelled belt? Of course I could make one for you, but I have a small request. Would you fulfil a task for me?', cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'comb') then
		if player:getSex() == PLAYERSEX_MALE then
			npcHandler:say('Comb? This is a jewellery shop.', cid)
			return true
		end

		if player:getStorageValue(Storage.OutfitQuest.firstOrientalAddon) == 1 then
			npcHandler:say('Have you brought me a mermaid\'s comb?', cid)
			npcHandler.topic[cid] = 3
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say({
				'Listen, um... I have been wanting a comb for a long time... not just any comb, but a mermaid\'s comb. Having a mermaid\'s comb means never having split ends again! ...',
				'You know what that means to a girl! Could you please bring me such a comb? I really would appreciate it.'
			}, cid)
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 2 then
			player:setStorageValue(Storage.OutfitQuest.DefaultStart, 1)
			player:setStorageValue(Storage.OutfitQuest.firstOrientalAddon, 1)
			npcHandler:say('Yay! I will wait for you to return with a mermaid\'s comb then.', cid)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 3 then
			if not player:removeItem(5945, 1) then
				npcHandler:say('No... that\'s not it.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			player:setStorageValue(Storage.OutfitQuest.firstOrientalAddon, 2)
			player:addOutfitAddon(150, 1)
			player:addOutfitAddon(146, 1)
			player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
			npcHandler:say('Yeah! That\'s it! I can\'t wait to comb my hair! Oh - but first, I\'ll fulfil my promise: Here is your jewelled belt! Thanks again!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] ~= 0 then
		npcHandler:say('Oh... okay.', cid)
		npcHandler.topic[cid] = 0
	end

	return true
end

keywordHandler:addKeyword({'need'}, StdModule.say, {npcHandler = npcHandler, text = 'I am a jeweller. Maybe you want to have a look at my wonderful {offers}.'})
keywordHandler:addKeyword({'offers'}, StdModule.say, {npcHandler = npcHandler, text = 'Well, I sell gems and {goblets}. If you\'d like to see my offers, ask me for a {trade}.'})
keywordHandler:addKeyword({'goblets'}, StdModule.say, {npcHandler = npcHandler, text = 'Ah, our newest import! We have golden goblets, silver goblets and bronze goblets. All of them have space for a hand-written dedication.'})

npcHandler:setMessage(MESSAGE_GREET, 'Be greeted, |PLAYERNAME|. Which of my fine gems do you {need}?')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Daraman\'s blessings and good bye.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Daraman\'s blessings and good bye.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
