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
	{ name = "angelic axe", id = 7436, sell = 5000 },
	{ name = "blue robe", id = 3567, sell = 10000 },
	{ name = "bonelord shield", id = 3418, buy = 7000, sell = 1200 },
	{ name = "boots of haste", id = 3079, sell = 30000 },
	{ name = "broadsword", id = 3301, sell = 500 },
	{ name = "butcher's axe", id = 7412, sell = 18000 },
	{ name = "crown armor", id = 3381, sell = 12000 },
	{ name = "crown helmet", id = 3385, sell = 2500 },
	{ name = "crown legs", id = 3382, sell = 12000 },
	{ name = "crown shield", id = 3419, sell = 8000 },
	{ name = "crusader helmet", id = 3391, sell = 6000 },
	{ name = "dragon lance", id = 3302, sell = 9000 },
	{ name = "dragon shield", id = 3416, sell = 4000 },
	{ name = "fire axe", id = 3320, sell = 8000 },
	{ name = "fire sword", id = 3280, sell = 4000 },
	{ name = "glorious axe", id = 7454, sell = 3000 },
	{ name = "guardian shield", id = 3415, sell = 2000 },
	{ name = "ice rapier", id = 3284, sell = 1000 },
	{ name = "noble armor", id = 3380, buy = 8000, sell = 900 },
	{ name = "obsidian lance", id = 3313, buy = 3000, sell = 500 },
	{ name = "phoenix shield", id = 3439, sell = 16000 },
	{ name = "queen's sceptre", id = 7410, sell = 20000 },
	{ name = "royal helmet", id = 3392, sell = 30000 },
	{ name = "shadow sceptre", id = 7451, sell = 10000 },
	{ name = "spike sword", id = 3271, buy = 8000, sell = 1000 },
	{ name = "thaian sword", id = 7391, sell = 16000 },
	{ name = "war hammer", id = 3279, buy = 10000, sell = 1200 }
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
		npcHandler:say("At your service, just browse through my wares", cid)
	end
	
	if msgcontains(msg, 'cookie') then
		if player:getStorageValue(Storage.WhatAFoolish.Questline) == 31
				and player:getStorageValue(Storage.WhatAFoolish.CookieDelivery.Djinn) ~= 1 then
			npcHandler:say('You brought cookies! How nice of you! Can I have one?', cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			if not player:removeItem(130, 1) then
				npcHandler:say('You have no cookie that I\'d like.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			player:setStorageValue(Storage.WhatAFoolish.CookieDelivery.Djinn, 1)
			if player:getCookiesDelivered() == 10 then
				player:addAchievement('Allow Cookies?')
			end

			npc:getPosition():sendMagicEffect(CONST_ME_GIFT_WRAPS)
			npcHandler:say('You see, good deeds like this will ... YOU ... YOU SPAWN OF EVIL! I WILL MAKE SURE THE MASTER LEARNS ABOUT THIS!', cid)
			npcHandler:removeInteraction(cid)
		end
	elseif msgcontains(msg, 'no') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say('I see.', cid)
			npcHandler.topic[cid] = 0
		end
	end
	return true
end


npcHandler:setMessage(MESSAGE_GREET, "<Sighs> Another {customer}! I've only just sat down! What is it, |PLAYERNAME|?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye now, Neutrala |PLAYERNAME|. Visit old Bob again one day!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Bye then.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
