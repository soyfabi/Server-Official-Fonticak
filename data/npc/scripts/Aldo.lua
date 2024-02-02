 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function getTable(player)
local itemsList = {}
	
local buyList	= {
	{ name = "brass helmet", id = 3354, buy = 120, sell = 30 },
	{ name = "brass legs", id = 3372, buy = 195, sell = 49 },
	{ name = "chain helmet", id = 3352, buy = 52, sell = 17 },
	{ name = "chain legs", id = 3558, buy = 80, sell = 25 },
	{ name = "iron helmet", id = 3353, buy = 390, sell = 150 },
	{ name = "leather boots", id = 3552, buy = 10, sell = 2 },
	{ name = "leather helmet", id = 3355, buy = 12, sell = 4 },
	{ name = "leather legs", id = 3559, buy = 10, sell = 9 },
	{ name = "legion helmet", id = 3374, sell = 22 },
	{ name = "plate legs", id = 3557, sell = 115 },
	{ name = "sandals", id = 3551, buy = 2 },
	{ name = "small axe", id = 3462, sell = 5 },
	{ name = "soldier helmet", id = 3375, buy = 110, sell = 16 },
	{ name = "steel helmet", id = 3351, buy = 580, sell = 293 },
	{ name = "studded helmet", id = 3376, buy = 63, sell = 20 },
	{ name = "studded legs", id = 3362, buy = 50, sell = 15 },
	{ name = "viking helmet", id = 3367, buy = 265, sell = 66 }
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
        return player:sendTextMessage(MESSAGE_INFO_DESCR, "You don't have enough cap.")
    end

    if not player:removeMoneyNpc(items[item].buyPrice * amount) then
        selfSay("You don't have enough money.", cid)
    else
        local itemCharges = items[item].count or 0
        player:addItem(items[item].itemId, amount, false, itemCharges)
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
	local player = Player(cid)
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("I am selling equipment for your adventure, take advantage of this opportunity.", cid)
	end
	
	if isInArray({"soft boots", "repair", "soft", "boots"}, msg) then
		npcHandler:say("Do you want to repair your worn soft boots for 10000 gold coins?", cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] == 1 then
		npcHandler.topic[cid] = 0
		if player:getItemCount(6530) == 0 then
			npcHandler:say("Sorry, you don't have the item.", cid)
			return true
		end

		if not player:removeMoneyNpc(10000) then
			npcHandler:say("Sorry, you don't have enough gold.", cid)
			return true
		end

		player:removeItem(6530, 1)
		player:addItem(6529, 1)
		npcHandler:say("Here you are.", cid)
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] == 1 then
		npcHandler.topic[cid] = 0
		npcHandler:say("Ok then.", cid)
	end

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
