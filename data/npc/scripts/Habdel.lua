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
	{ name = "battle axe", id = 3266, buy = 235, sell = 80 },
	{ name = "battle hammer", id = 3305, buy = 350, sell = 120 },
	{ name = "bone club", id = 3337, sell = 5 },
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
	{ name = "sabre", id = 3273, buy = 35 },
	{ name = "short sword", id = 3294, buy = 26 },
	{ name = "sickle", id = 3293, buy = 7 },
	{ name = "spike sword", id = 3271, buy = 8000 },
	{ name = "sword", id = 3264, buy = 25 },
	{ name = "throwing knife", id = 3298, buy = 25 },
	{ name = "throwing star", id = 3287, buy = 42 },
	{ name = "two handed sword", id = 3265, buy = 950 },
	{ name = "war hammer", id = 3279, buy = 10000 }
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
		npcHandler:say("This is all I offer in terms of armor, weapons and defense.", cid)
	end
	
	if msgcontains(msg, 'outfit') then
		if player:getSex() == PLAYERSEX_FEMALE then
			npcHandler:say('My scimitar? Well, mylady, I do not want to sound rude, but I don\'t think a scimitar would fit to your beautiful outfit. If you are looking for an accessory, why don\'t you talk to Ishina?', cid)
			return true
		end
		if player:getStorageValue(Storage.OutfitQuest.firstOrientalAddon) < 1 then
			npcHandler:say('My scimitar? Yes, that is a true masterpiece. Of course I could make one for you, but I have a small request. Would you fulfil a task for me?', cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'comb') then
		if player:getSex() == PLAYERSEX_FEMALE then
			npcHandler:say('Comb? This is a weapon shop.', cid)
			return true
		end
		if player:getStorageValue(Storage.OutfitQuest.firstOrientalAddon) == 1 then
			npcHandler:say('Have you brought a mermaid\'s comb for Ishina?', cid)
			npcHandler.topic[cid] = 3
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say({
				'Listen, um... I know that Ishina has been wanting a comb for a long time... not just any comb, but a mermaid\'s comb. She said it prevents split ends... or something. ...',
				'Do you think you could get one for me so I can give it to her? I really would appreciate it.'
			}, cid)
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 2 then
			player:setStorageValue(Storage.OutfitQuest.DefaultStart, 1)
			player:setStorageValue(Storage.OutfitQuest.firstOrientalAddon, 1)
			npcHandler:say('Brilliant! I will wait for you to return with a mermaid\'s comb then.', cid)
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
			npcHandler:say('Yeah! That\'s it! I can\'t wait to give it to her! Oh - but first, I\'ll fulfil my promise: Here is your scimitar! Thanks again!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] ~= 0 then
		npcHandler:say('Ah well. Doesn\'t matter.', cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'weapons'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell the finest weapons in town. If you\'d like to see my offers, ask me for a {trade}.'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome |PLAYERNAME|! See the fine {weapons} I sell.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye. Come back soon.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye. Come back soon.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
