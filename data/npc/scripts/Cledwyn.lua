 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)
local talkState = {}

function onCreatureAppear(cid)    npcHandler:onCreatureAppear(cid)   end
function onCreatureDisappear(cid)   npcHandler:onCreatureDisappear(cid)   end
function onCreatureSay(cid, type, msg)   npcHandler:onCreatureSay(cid, type, msg)  end
function onThink()     npcHandler:onThink()     end

local voices = { 
	{ text = 'Trading tokens! First-class bargains!' },
	{ text = 'Bespoke armor for all vocations! For the cost of some tokens only!' },
	{ text = 'Tokens! Bring your tokens!' }
}
npcHandler:addModule(VoiceModule:new(voices))

local function getTable(player)
local itemsList = {}


local buyList = {
	{ name = "earthheart cuirass", id = 22521, buy = 100},
	{ name = "earthheart hauberk", id = 22522, buy = 100, },
	{ name = "earthheart platemail", id = 22523, buy = 100, },
	{ name = "earthmind raiment", id = 22535, buy = 100, },
	{ name = "earthsoul tabard", id = 22531, buy = 100, },
	{ name = "fireheart cuirass", id = 22518, buy = 100, },
	{ name = "fireheart hauberk", id = 22519, buy = 100, },
	{ name = "fireheart platemail", id = 22520, buy = 100 },
	{ name = "firemind raiment", id = 22534, buy = 100 },
	{ name = "firesoul tabard", id = 22530, buy = 100},
	{ name = "frostheart cuirass", id = 22527, buy = 100},
	{ name = "frostheart hauberk", id = 22528, buy = 100, },
	{ name = "frostheart platemail", id = 22529, buy = 100 },
	{ name = "frostmind raiment", id = 22537, buy = 100 },
	{ name = "frostsoul tabard", id = 22533, buy = 100 },
	{ name = "magic shield potion", id = 35563, buy = 1 },
	{ name = "thunderheart cuirass", id = 22524, buy = 100 },
	{ name = "thunderheart hauberk", id = 22525, buy = 100 },
	{ name = "thunderheart platemail", id = 22526, buy = 100 },
	{ name = "thundermind raiment", id = 22536, buy = 100 },
	{ name = "thundersoul tabard", id = 22532, buy = 100 }
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

local charge = {}

local chargeItem = {
	['pendulet'] = {noChargeID = 29429, ChargeID = 30344},
	['sleep shawl'] = {noChargeID = 29428, ChargeID = 30342},
	['blister ring'] = {noChargeID = 31621, ChargeID = 31557},
	['theurgic amulet'] = {noChargeID = 30401, ChargeID = 30403},
	['ring of souls'] = {noChargeID = 32636, ChargeID = 32621},
	['spiritthorn ring'] = {noChargeID = 39179, ChargeID = 39177},
	['alicorn ring'] = {noChargeID = 39182, ChargeID = 39180},
	['arcanomancer sigil'] = {noChargeID = 39185, ChargeID = 39183},
	['arboreal ring'] = {noChargeID = 39188, ChargeID = 39187},
	['turtle amulet'] = {noChargeID = 39235, ChargeID = 39233}
}

function creatureSayCallback(cid, type, msg)
     if not npcHandler:isFocused(cid) then
               return false
     end

     local player = Player(cid)
	 
	 if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Keep in mind you won't find better offers here. Just browse through my wares.", cid)
	end
	 
	 if msgcontains(msg, 'token') or msgcontains(msg, 'tokens') then
		npcHandler:say("If you have any {silver} tokens with you, let's have a look! Maybe I can offer you something in exchange.", cid)
	elseif msgcontains(msg, 'information') then
		npcHandler:say("With pleasure. <bows> I trade {token}s. There are several ways to obtain the {token}s I am interested in - killing certain bosses, for example. In exchange for a certain amount of tokens, I can offer you some first-class items.", cid)
	elseif msgcontains(msg, 'talk') then
		npcHandler:say({"Why, certainly! I'm always up for some small talk. ...",
						 "The weather continues just fine here, don't you think? Just the day for a little walk around the town! ...",
						 "Actually, I haven't been around much yet, but I'm looking forward to exploring the city once I've finished trading {token}s."}, cid)
	elseif msgcontains(msg, 'silver') then
		npcHandler:say({"Here's the deal, " .. player:getName() .. ". For 100 of your silver tokens, I can offer you some first-class torso armor. These armors provide a solid boost to your main attack skill, as well as ...",
		"some elemental protection of your choice! I also sell a magic shield potion for one silver token. So these are my offers."}, cid)
	elseif msgcontains(msg, 'enchant') then
		npcHandler:say({"The following items can be enchanted: {pendulet}, {sleep shawl}, {blister ring}, {theurgic amulet}, {ring of souls}. ...",
						"For sufficient silver tokens you can also enchant: {spiritthorn ring}, {alicorn ring}, {arcanomancer sigil}, {arboreal ring}, {turtle amulet}. Make you choice!"}, cid)
		npcHandler.topic[cid] = 1
	elseif isInArray({'pendulet', 'sleep shawl', 'blister ring', 'theurgic amulet', 'ring of souls', 'turtle amulet'}, msg:lower()) and npcHandler.topic[cid] == 1 then
		npcHandler:say("Should I enchant the item " .. message .. " for 2 ".. ItemType(npc:getCurrency()):getPluralName():lower() .."?", cid)
		charge = message:lower()
		npcHandler.topic[cid] = 2
	elseif isInArray({'spiritthorn ring', 'alicorn ring', 'arcanomancer sigil', 'arboreal ring'}, msg:lower()) and npcHandler.topic[cid] == 1 then
		npcHandler:say("Should I enchant the item " .. message .. " for 5 ".. ItemType(npc:getCurrency()):getPluralName():lower() .."?", cid)
		charge = message:lower()
		npcHandler.topic[cid] = 2
	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'yes') then
			if not chargeItem[charge] then
				npcHandler:say("Sorry, you don't have an unenchanted ".. charge ..".", cid)
			else
				if (player:getItemCount(npc:getCurrency()) >= 2) and (player:getItemCount(chargeItem[charge].noChargeID) >= 1) then
					player:removeItem(npc:getCurrency(), 2)
					player:removeItem(chargeItem[charge].noChargeID, 1)
					local itemAdd = player:addItem(chargeItem[charge].ChargeID, 1)
					npcHandler:say("Ah, excellent. Here is your " .. itemAdd:getName():lower() .. ".", cid)
				else
					npcHandler:say("Sorry, friend, but one good turn deserves another. Bring enough ".. ItemType(npc:getCurrency()):getPluralName():lower() .." and it's a deal.", cid)
				end
				npcHandler.topic[cid] = 0
			end
		elseif msgcontains(msg, 'no') then
			npcHandler:say("Alright, come back if you have changed your mind.", cid)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, 'addon') then
		if player:hasOutfit(846, 0) or player:hasOutfit(845, 0) then
			npcHandler:say("Ah, very good. Now choose your addon: {first} or {second}.", cid)
			npcHandler.topic[cid] = 3
		else
			npcHandler:say("Sorry, friend, but one good turn deserves another. You need to obtain the rift warrior outfit first.", cid)
		end
	elseif isInArray({'first', 'second'}, msg:lower()) and npcHandler.topic[cid] == 3 then
		if message:lower() == 'first' then
			if not(player:hasOutfit(846, 1)) and not(player:hasOutfit(845, 1)) then
				if player:removeItem(22516, 100) then
					npcHandler:say("Ah, excellent. Obtain the first addon for your rift warrior outfit.", cid)
					player:addOutfitAddon(846, 1)
					player:addOutfitAddon(845, 1)
					if (player:hasOutfit(846, 1) or player:hasOutfit(845, 1)) and (player:hasOutfit(846, 2) or player:hasOutfit(845, 2)) then
						player:addAchievement("Rift Warrior")
					end
				else
					npcHandler:say("Sorry, friend, but one good turn deserves another. Bring enough ".. ItemType(npc:getCurrency()):getPluralName():lower() .." and it's a deal.", cid)
				end
			else
				npcHandler:say("Sorry, friend, you already have the first Rift Warrior addon.", cid)
			end
		elseif message:lower() == 'second' then
			if not(player:hasOutfit(846, 2)) and not(player:hasOutfit(845, 2)) then
				if player:removeItem(22516, 100) then
					npcHandler:say("Ah, excellent. Obtain the second addon for your rift warrior outfit.", cid)
					player:addOutfitAddon(846, 2)
					player:addOutfitAddon(845, 2)
					if (player:hasOutfit(846, 1) or player:hasOutfit(845, 1)) and (player:hasOutfit(846, 2) or player:hasOutfit(845, 2)) then
						player:addAchievement("Rift Warrior")
					end
				else
					npcHandler:say("Sorry, friend, but one good turn deserves another. Bring enough ".. ItemType(npc:getCurrency()):getPluralName():lower() .." and it's a deal.", cid)
				end
			else
				npcHandler:say("Sorry, friend, you already have the second Rift Warrior addon.", cid)
			end
		end
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
