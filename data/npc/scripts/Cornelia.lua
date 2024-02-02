local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Quality armors for sale!'} }
npcHandler:addModule(VoiceModule:new(voices))

keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = "I run this armoury. If you want to protect your life, you better buy my wares."})


local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "battle shield", id = 3413, sell = 95 },
	{ name = "brass armor", id = 3359, buy = 450, sell = 150 },
	{ name = "brass helmet", id = 3354, buy = 120, sell = 30 },
	{ name = "brass legs", id = 3372, buy = 195, sell = 49 },
	{ name = "brass shield", id = 3411, buy = 65, sell = 25 },
	{ name = "chain armor", id = 3358, buy = 200, sell = 70 },
	{ name = "chain helmet", id = 3352, buy = 52, sell = 17 },
	{ name = "chain legs", id = 3558, buy = 80, sell = 25 },
	{ name = "coat", id = 3562, buy = 8, sell = 1 },
	{ name = "copper shield", id = 3430, sell = 50 },
	{ name = "doublet", id = 3379, buy = 16, sell = 3 },
	{ name = "dwarven shield", id = 3425, buy = 500, sell = 100 },
	{ name = "iron helmet", id = 3353, buy = 390, sell = 150 },
	{ name = "jacket", id = 3561, buy = 12, sell = 1 },
	{ name = "leather armor", id = 3361, buy = 35, sell = 12 },
	{ name = "leather boots", id = 3552, buy = 10, sell = 2 },
	{ name = "leather helmet", id = 3355, buy = 12, sell = 4 },
	{ name = "leather legs", id = 3559, buy = 10, sell = 9 },
	{ name = "legion helmet", id = 3374, sell = 22 },
	{ name = "plate armor", id = 3357, buy = 1200, sell = 400 },
	{ name = "plate legs", id = 3557, sell = 115 },
	{ name = "plate shield", id = 3410, buy = 125, sell = 45 },
	{ name = "scale armor", id = 3377, buy = 260, sell = 75 },
	{ name = "small axe", id = 3462, sell = 5 },
	{ name = "soldier helmet", id = 3375, buy = 110, sell = 16 },
	{ name = "steel helmet", id = 3351, buy = 580, sell = 293 },
	{ name = "steel shield", id = 3409, buy = 240, sell = 80 },
	{ name = "studded armor", id = 3378, buy = 90, sell = 25 },
	{ name = "studded helmet", id = 3376, buy = 63, sell = 20 },
	{ name = "studded legs", id = 3362, buy = 50, sell = 15 },
	{ name = "studded shield", id = 3426, buy = 50, sell = 16 },
	{ name = "viking helmet", id = 3367, buy = 265, sell = 66 },
	{ name = "viking shield", id = 3431, buy = 260, sell = 85 },
	{ name = "wooden shield", id = 3412, buy = 15, sell = 5 }
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
	if not npcHandler:isFocused(cid) then
		return false
	end
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local player = Player(cid)
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("I buy {equipment} I even sell.", cid)
	end
	local player = Player(cid)
	if isInArray({"addon", "armor"}, msg) then
		if player:getStorageValue(Storage.OutfitQuest.WarriorShoulderAddon) == 5 then
			player:setStorageValue(Storage.OutfitQuest.WarriorShoulderAddon, 6)
			player:setStorageValue(Storage.OutfitQuest.WarriorShoulderTimer, os.time() + (player:getSex() == PLAYERSEX_FEMALE and 3600 or 7200))
			npcHandler:say('Ah, you must be the hero Trisha talked about. I\'ll prepare the shoulder spikes for you. Please give me some time to finish.', cid)
		elseif player:getStorageValue(Storage.OutfitQuest.WarriorShoulderAddon) == 6 then
			if player:getStorageValue(Storage.OutfitQuest.WarriorShoulderTimer) > os.time() then
				npcHandler:say('I\'m not done yet. Please be as patient as you are courageous.', cid)
			elseif player:getStorageValue(Storage.OutfitQuest.WarriorShoulderTimer) > 0 and player:getStorageValue(Storage.OutfitQuest.WarriorShoulderTimer) < os.time() then
				player:addOutfitAddon(142, 1)
				player:addOutfitAddon(134, 1)
				player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
				player:setStorageValue(Storage.OutfitQuest.WarriorShoulderAddon, 7)
				player:addAchievementProgress('Wild Warrior', 2)
				npcHandler:say('Finished! Since you are a man, I thought you probably wanted two. Men always want that little extra status symbol. <giggles>', cid)
			else
				npcHandler:say('I\'m selling leather armor, chain armor, and brass armor. Ask me for a {trade} if you like to take a look.', cid)
			end
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Welcome to the finest {armor} shop in the land, |PLAYERNAME|!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. Come back soon.")
npcHandler:addModule(FocusModule:new())
