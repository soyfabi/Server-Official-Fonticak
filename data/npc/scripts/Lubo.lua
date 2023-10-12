local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "backpack", id = 2854, buy = 25 },
	{ name = "basket", id = 2855, buy = 6 },
	{ name = "bottle", id = 2875, buy = 3 },
	{ name = "bucket", id = 2873, buy = 4 },
	{ name = "candelabrum", id = 2927, buy = 8 },
	{ name = "candlestick", id = 2917, buy = 2 },
	{ name = "closed trap", id = 3481, buy = 280, sell = 75 },
	{ name = "crowbar", id = 3304, buy = 260, sell = 50 },
	{ name = "fishing rod", id = 3483, buy = 150, sell = 40 },
	{ name = "hand auger", id = 31334, buy = 25 },
	{ name = "machete", id = 3308, buy = 35, sell = 6 },
	{ name = "net", id = 31489, buy = 50 },
	{ name = "pick", id = 3456, buy = 50, sell = 15 },
	{ name = "present", id = 2856, buy = 10 },
	{ name = "red apple", id = 3585, buy = 3 },
	{ name = "rope", id = 3003, buy = 50, sell = 15 },
	{ name = "scythe", id = 3453, buy = 50, sell = 10 },
	{ name = "shovel", id = 3457, buy = 50, sell = 8 },
	{ name = "watch", id = 2906, buy = 20, sell = 6 },
	{ name = "waterskin of water", id = 2901, buy = 10, count = 1 },
	{ name = "wooden hammer", id = 3459, sell = 15 },
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

local voices = { {text = 'Stop by and rest a while, tired adventurer! Have a look at my wares!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Of course, just browse through my wares.", cid)
	end
	
	local addonProgress = player:getStorageValue(Storage.OutfitQuest.Citizen.AddonBackpack)
	if msgcontains(msg, 'addon') or msgcontains(msg, 'outfit')
			or (addonProgress == 1 and msgcontains(msg, 'leather'))
			or ((addonProgress == 1 or addonProgress == 2) and msgcontains(msg, 'backpack')) then
		if addonProgress < 1 then
			npcHandler:say('Sorry, the backpack I wear is not for sale. It\'s handmade from rare minotaur leather.', cid)
			npcHandler.topic[cid] = 1
		elseif addonProgress == 1 then
			npcHandler:say('Ah, right, almost forgot about the backpack! Have you brought me 100 pieces of minotaur leather as requested?', cid)
			npcHandler.topic[cid] = 3
		elseif addonProgress == 2 then
			if player:getStorageValue(Storage.OutfitQuest.Citizen.AddonBackpackTimer) < os.time() then
				npcHandler:say('Just in time! Your backpack is finished. Here you go, I hope you like it.', cid)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				player:setStorageValue(Storage.OutfitQuest.Ref, math.min(0, player:getStorageValue(Storage.OutfitQuest.Ref) - 1))
				player:setStorageValue(Storage.OutfitQuest.Citizen.MissionBackpack, 0)
				player:setStorageValue(Storage.OutfitQuest.Citizen.AddonBackpack, 3)

				player:addOutfitAddon(136, 1)
				player:addOutfitAddon(128, 1)
			else
				npcHandler:say('Uh... I didn\'t expect you to return that early. Sorry, but I\'m not finished yet with your backpack. I\'m doing the best I can, promised.', cid)
			end
		elseif addonProgress == 3 then
			npcHandler:say('Sorry, but I can only make one backpack per person, else I\'d have to close my shop and open a leather manufactory.', cid)
		end
		return true
	end

	if npcHandler.topic[cid] == 1 then
		if msgcontains(msg, 'backpack') or msgcontains(msg, 'minotaur') or msgcontains(msg, 'leather') then
			npcHandler:say('Well, if you really like this backpack, I could make one for you, but minotaur leather is hard to come by these days. Are you willing to put some work into this?', cid)
			npcHandler.topic[cid] = 2
		end

	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'yes') then
			player:setStorageValue(Storage.OutfitQuest.Ref, math.max(0, player:getStorageValue(Storage.OutfitQuest.Ref)) + 1)
			player:setStorageValue(Storage.OutfitQuest.Citizen.AddonBackpack, 1)
			player:setStorageValue(Storage.OutfitQuest.Citizen.MissionBackpack, 1)
			npcHandler:say('Alright then, if you bring me 100 pieces of fine minotaur leather I will see what I can do for you. You probably have to kill really many minotaurs though... so good luck!', cid)
			npcHandler:releaseFocus(cid)
		else
			npcHandler:say('Sorry, but I don\'t run a welfare office, you know... no pain, no gain.', cid)
		end
		npcHandler.topic[cid] = 0

	elseif npcHandler.topic[cid] == 3 then
		if msgcontains(msg, 'yes') then
			if player:getItemCount(5878) < 100 then
				npcHandler:say('Sorry, but that\'s not enough leather yet to make one of these backpacks. Would you rather like to buy a normal backpack for 10 gold?', cid)
			else
				npcHandler:say('Great! Alright, I need a while to finish this backpack for you. Come ask me later, okay?', cid)

				player:removeItem(5878, 100)

				player:setStorageValue(Storage.OutfitQuest.Citizen.MissionBackpack, 2)
				player:setStorageValue(Storage.OutfitQuest.Citizen.AddonBackpack, 2)
				player:setStorageValue(Storage.OutfitQuest.Citizen.AddonBackpackTimer, os.time() + 2 * 60 * 60)
			end
		else
			npcHandler:say('I know, it\'s quite some work... don\'t lose heart, just keep killing minotaurs and you\'ll eventually get lucky. Would you rather like to buy a normal backpack for 10 gold?', cid)
		end
		npcHandler.topic[cid] = 0
	end
	
	-- The paradox tower quest
	if msgcontains(msg, "crunors cottage") then
		npcHandler:say("Ah yes, I remember my grandfather talking about that name. This house used to be an inn a long time ago. My family bought it from some of these flower guys.", cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "flower guys") then
		npcHandler:say("Oh, I mean druids of course. They sold the cottage to my family after some of them died in an accident or something like that.", cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "accident") then
		npcHandler:say("As far as I can remember the story, a pet escaped its stable behind the inn. It got somehow involved with powerful magic at a ritual and was transformed in some way.", cid)
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, "stable") then
		if player:getStorageValue(Storage.Quest.U7_24.TheParadoxTower.TheFearedHugo) == 3 then
			-- Questlog: The Feared Hugo (Completed)
			player:setStorageValue(Storage.Quest.U7_24.TheParadoxTower.TheFearedHugo, 4)
		end
		npcHandler:say("My grandpa told me, in the old days there were some behind this cottage. Nothing big though, just small ones, for chicken or rabbits.", cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I am selling equipment for adventurers. If you need anything, let me know.'})
keywordHandler:addKeyword({'dog'}, StdModule.say, {npcHandler = npcHandler, text = 'This is Ruffy my dog, please don\'t do him any harm.'})
keywordHandler:addKeyword({'offer'}, StdModule.say, {npcHandler = npcHandler, text = 'I sell torches, fishing rods, worms, ropes, water hoses, backpacks, apples, and maps.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'I am Lubo, the owner of this shop.'})
keywordHandler:addKeyword({'maps'}, StdModule.say, {npcHandler = npcHandler, text = 'Oh! I\'m sorry, I sold the last one just five minutes ago.'})
keywordHandler:addKeyword({'hat'}, StdModule.say, {npcHandler = npcHandler, text = 'My hat? Hanna made this one for me.'})
keywordHandler:addKeyword({'finger'}, StdModule.say, {npcHandler = npcHandler, text = 'Oh, you sure mean this old story about the mage Dago, who lost two fingers when he conjured a dragon.'})
keywordHandler:addKeyword({'pet'}, StdModule.say, {npcHandler = npcHandler, text = 'There are some strange stories about a magicians pet names. Ask Hoggle about it.'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome to my adventurer shop, |PLAYERNAME|! What do you need? Ask me for a {trade} to look at my wares.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
