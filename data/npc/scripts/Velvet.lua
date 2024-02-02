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
	{ name = "blue pillow", id = 2394, buy = 25 },
	{ name = "blue tapestry", id = 2659, buy = 25 },
	{ name = "green pillow", id = 2396, buy = 25 },
	{ name = "green tapestry", id = 2647, buy = 25 },
	{ name = "heart pillow", id = 2393, buy = 30 },
	{ name = "orange tapestry", id = 2653, buy = 25 },
	{ name = "purple tapestry", id = 2644, buy = 25 },
	{ name = "red pillow", id = 2395, buy = 25 },
	{ name = "red tapestry", id = 2656, buy = 25 },
	{ name = "round blue pillow", id = 2398, buy = 25 },
	{ name = "round purple pillow", id = 2400, buy = 25 },
	{ name = "round red pillow", id = 2399, buy = 25 },
	{ name = "round turquoise pillow", id = 2401, buy = 25 },
	{ name = "small blue pillow", id = 2389, buy = 20 },
	{ name = "small green pillow", id = 2387, buy = 20 },
	{ name = "small orange pillow", id = 2390, buy = 20 },
	{ name = "small purple pillow", id = 2386, buy = 20 },
	{ name = "small red pillow", id = 2388, buy = 20 },
	{ name = "small turquoise pillow", id = 2391, buy = 20 },
	{ name = "small white pillow", id = 2392, buy = 20 },
	{ name = "white tapestry", id = 2667, buy = 25 },
	{ name = "yellow pillow", id = 900, buy = 25 },
	{ name = "yellow tapestry", id = 2650, buy = 25 }
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
	if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
		local items = setNewTradeTable(getTable(player))
		openShopWindow(cid, getTable(player), onBuy, onSell)
		npcHandler:say("Are you looking for home decoration? here I have everything you are looking for.", cid)
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
