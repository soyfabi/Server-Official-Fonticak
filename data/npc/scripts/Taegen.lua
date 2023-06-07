local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Id like to take a walk with Aurita.'},{text = 'I miss Aurita golden hair.*sigh*'},{text = 'Pas in boldly tyll thow com to an hall the feyrist undir sky ... *sings*'} }
npcHandler:addModule(VoiceModule:new(voices))

local function getTable(player)
local itemsList = {}
	
local buyList = {
	{ name = "arrow", id = 3447, buy = 3 },
	{ name = "blue quiver", id = 35848, buy = 400 },
	{ name = "bolt", id = 3446, buy = 4 },
	{ name = "bow", id = 3350, buy = 400, sell = 100 },
	{ name = "crossbow", id = 3349, buy = 500, sell = 120 },
	{ name = "crystalline arrow", id = 15793, buy = 20 },
	{ name = "diamond arrow", id = 35901, buy = 100 },
	{ name = "drill bolt", id = 16142, buy = 12 },
	{ name = "earth arrow", id = 774, buy = 5 },
	{ name = "envenomed arrow", id = 16143, buy = 12 },
	{ name = "flaming arrow", id = 763, buy = 5 },
	{ name = "flash arrow", id = 761, buy = 5 },
	{ name = "onyx arrow", id = 7365, buy = 7 },
	{ name = "piercing bolt", id = 7363, buy = 5 },
	{ name = "power bolt", id = 3450, buy = 7 },
	{ name = "prismatic bolt", id = 16141, buy = 20 },
	{ name = "quiver", id = 35562, buy = 400 },
	{ name = "red quiver", id = 35849, buy = 400 },
	{ name = "royal spear", id = 7378, buy = 15 },
	{ name = "shiver arrow", id = 762, buy = 5 },
	{ name = "sniper arrow", id = 7364, buy = 5 },
	{ name = "spear", id = 3277, buy = 9, sell = 3 },
	{ name = "spectral bolt", id = 35902, buy = 70 },
	{ name = "tarsal arrow", id = 14251, buy = 6 },
	{ name = "throwing star", id = 3287, buy = 42 },
	{ name = "vortex bolt", id = 14252, buy = 6 }
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

local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams
local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Of course, here you have everything.", cid)
	end

	local player = Player(cid)

	if msgcontains(msg, "mission") then
		if player:getStorageValue(ThreatenedDreams.Mission03[1]) < 1 then
			npcHandler:say({
				"Yes, there is something. It's a bit embarassing, you must promise not to tell anyone else. I'm in love with Aurita. Well, that wouldn't be a reson to be ashamed, but she is a mermaid. ...",
				"A faun on the other hand is inhabiting the forests, dancing with fairies and, well, nymphs. But I lost my heart to the lovely Aurita. I can't help it. We would love to spend some time together, but not just sitting on the beach. ...",
				"I'd love to show her the deep forest I love so much. I have an idea but I can't do it alone. Would you help me?"
			}, cid)
			npcHandler.topic[cid] = 1
		elseif player:getStorageValue(ThreatenedDreams.Mission03[1]) == 1 then
			npcHandler:say({
				"There is a fairy who once told me about this spell. Perhaps she will share her knowledge. You can find her in a small fairy village in the southwest of Feyrist."
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(ThreatenedDreams.Mission03[1]) == 2
		and player:getItemCount(25782) >= 1 then
			npcHandler:say({
				"We are so happy. Now Aurita can take a walk on the beach. But I still can't visit her secret underwater grotto. To achieve this, we need something else: a very rare plant called raven herb. ...",
				"If eaten it allows an air breathing creature to breathe underwater for a while. Please find this plant for me. But know that you'll only find it at night. It resembles a common fern but its leaves are of a lighter green."
			}, cid)
			player:removeItem(25782, 1)
			player:setStorageValue(ThreatenedDreams.Mission03[1], 3)
			player:setStorageValue(ThreatenedDreams.Mission03.UnlikelyCouple, 4)
			npcHandler.topic[cid] = 0
		else
			npcHandler:say({
				"Thank you! We are so happy. Now Aurita can take a walk on the beach. And I can visit her secret underwater grotto, now say {sun catcher}."
			}, cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "sun catcher") then
		if player:getStorageValue(ThreatenedDreams.Mission03[1]) == 3 then
			npcHandler:say({
				"Have you found some {raven herb}?"
			}, cid)
			npcHandler.topic[cid] = 2
		elseif player:getStorageValue(ThreatenedDreams.Mission03[1]) == 4 then
			npcHandler:say({
				"Thank you again, mortal being. A sun catcher is similar to a dream catcher but other than the latter it can preserve sunlight rather than bad dreams. I can craft one out of enchanted branches of a fairy tree as well as several enchanted gems. ...",
				"The branches are no problem, I will find some in the forest. But I don't have any gems. If you bring me some, I can craft a sun catcher for you. Do you have gems?"
			}, cid)
			npcHandler.topic[cid] = 3
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say({
				"That's very kind of you, my friend! Listen: I know there is a spell to transform her fishtail into legs. It is a temporary effect, so she could return to the ocean as soon as the spell ends. Unfortunately I don't know how to cast this spell. ...",
				"But there is a fairy who once told me about it. Perhaps she will share her knowledge. You can find her in a small fairy village in the southwest of Feyrist."
			}, cid)
			player:setStorageValue(ThreatenedDreams.Mission03[1], 1)
			player:setStorageValue(ThreatenedDreams.Mission03.UnlikelyCouple, 1)
			npcHandler.topic[cid] = 0
		elseif npcHandler.topic[cid] == 2 then
			if player:getItemCount(5953) > 0  then
				npcHandler:say({
					"Thank you, friend! Now I can visit Aurita in her underwater grotto!"
				}, cid)
				player:removeItem(5953, 1)
				npcHandler.topic[cid] = 3
				player:setStorageValue(ThreatenedDreams.Mission03[1], 4)
			else
				npcHandler:say({
					"Please find this plant for me. But know that you'll only find it at night. It resembles a common fern but its leaves are of a lighter green."
				}, cid)
				npcHandler.topic[cid] = 0
			end
		elseif npcHandler.topic[cid] == 3 then
			if player:getStorageValue(ThreatenedDreams.Mission03.DarkSunCatcher) == 1 then
				npcHandler:say({
					"I already crafted one sun catcher for you."
				}, cid)
			elseif player:getItemCount(675) >= 2
			and player:getItemCount(676) >= 2
			and player:getItemCount(677) >= 2
			and player:getItemCount(678) >= 2
			and player:getStorageValue(ThreatenedDreams.Mission03.DarkSunCatcher) < 1 then
				npcHandler:say({
					"Alright, I will craft a sun catcher for you."
				}, cid)
				player:removeItem(675, 2)
				player:removeItem(676, 2)
				player:removeItem(677, 2)
				player:removeItem(678, 2)
				player:addItem(25733, 1)
				player:setStorageValue(ThreatenedDreams.Mission03.DarkSunCatcher, 1)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say({
					"I don't have any gems. If you bring me some, I can craft a sun catcher for you. Do you have gems?"
				}, cid)
				npcHandler.topic[cid] = 0
			end
		end
	elseif msgcontains(msg, "no") then
		npcHandler:say("Then not.", cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Be greeted, mortal being!")
npcHandler:setMessage(MESSAGE_SENDTRADE, " Im carving bolts and arrows and i also craft bows anda spears.If you'd like to buy some ammunition, take a look.")
npcHandler:setMessage(MESSAGE_FAREWELL, "May enlightenment be your path, |PLAYERNAME|.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
