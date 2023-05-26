local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid) npcHandler:onCreatureAppear(cid) end
function onCreatureDisappear(cid) npcHandler:onCreatureDisappear(cid) end
function onCreatureSay(cid, type, msg) npcHandler:onCreatureSay(cid, type, msg) end
function onThink() npcHandler:onThink() end
local shopWindow = {}

local shop = {
	{name = "toy mouse", id = 123, buy = 16000, sell = 16000, count = 1},
	{name = "exploding cookie.", id = 130, buy = 100, count = 1},
	{name = "special flask", id = 135, buy = 5000, count = 1},
	{name = "toy mouse", id = 138, buy = 600, count = 1},
	{name = "toy mouse", id = 141, buy = 2000, count = 1},
	{name = "toy mouse", id = 142, buy = 6000, count = 1},
	{name = "toy mouse", id = 349, buy = 15000, count = 1},
	{name = "toy mouse", id = 396, buy = 5000, count = 1},
	{name = "toy mouse", id = 406, buy = 15000, count = 1},
	{name = "toy mouse", id = 3216, buy = 8000, count = 1},
	{name = "toy mouse", id = 3217, buy = 8000, count = 1},
	{name = "toy mouse", id = 3232, buy = 3000, count = 1},
	{name = "toy mouse", id = 3233, buy = 16000, count = 1},
	{name = "toy mouse", id = 3234, buy = 150, count = 1},
	{name = "toy mouse", id = 4827, buy = 18000, count = 1},
	{name = "toy mouse", id = 4832, buy = 24000, count = 1},
	{name = "toy mouse", id = 4834, buy = 1000, count = 1},
	{name = "toy mouse", id = 4835, buy = 8000, count = 1},
	{name = "toy mouse", id = 4836, buy = 15000, count = 1},
	{name = "toy mouse", id = 4841, buy = 3000, count = 1},
	{name = "toy mouse", id = 4843, buy = 500, count = 1},
	{name = "toy mouse", id = 4846, buy = 4000, count = 1},
	{name = "toy mouse", id = 4847, buy = 6000, count = 1},
	{name = "toy mouse", id = 5940, buy = 10000, count = 1},
	{name = "toy mouse", id = 6124, buy = 40000, count = 1},
	{name = "toy mouse", id = 7281, buy = 500, count = 1},
	{name = "toy mouse", id = 7924, buy = 10000, count = 1},
	{name = "toy mouse", id = 7936, buy = 7000, count = 1},
	{name = "toy mouse", id = 8453, buy = 50000, count = 1},
	{name = "toy mouse", id = 8746, buy = 50000, count = 1},
	{name = "toy mouse", id = 8818, buy = 8000, count = 1},
	{name = "toy mouse", id = 8822, buy = 20000, count = 1},
	{name = "toy mouse", id = 9107, buy = 600, count = 1},
	{name = "toy mouse", id = 9188, buy = 5000, count = 1},
	{name = "toy mouse", id = 9191, buy = 5000, count = 1},
	{name = "toy mouse", id = 9236, buy = 10000, count = 1},
	{name = "toy mouse", id = 9237, buy = 12500, count = 1},
	{name = "toy mouse", id = 9238, buy = 17000, count = 1},
	{name = "toy mouse", id = 9239, buy = 12500, count = 1},
	{name = "toy mouse", id = 9240, buy = 13000, count = 1},
	{name = "toy mouse", id = 9241, buy = 10000, count = 1},
	{name = "toy mouse", id = 9247, buy = 13500, count = 1},
	{name = "toy mouse", id = 9248, buy = 12500, count = 1},
	{name = "toy mouse", id = 9249, buy = 13000, count = 1},
	{name = "toy mouse", id = 9251, buy = 8000, count = 1},
	{name = "toy mouse", id = 9252, buy = 13000, count = 1},
	{name = "toy mouse", id = 9255, buy = 25000, count = 1},
	{name = "toy mouse", id = 9308, buy = 5250, count = 1},
	{name = "toy mouse", id = 9390, buy = 8500, count = 1},
	{name = "toy mouse", id = 9391, buy = 10000, count = 1},
	{name = "toy mouse", id = 9537, buy = 350, count = 1},
	{name = "toy mouse", id = 9696, buy = 1000, count = 1},
	{name = "toy mouse", id = 9698, buy = 1000, count = 1},
	{name = "toy mouse", id = 9699, buy = 1000, count = 1},
	{name = "toy mouse", id = 10009, buy = 700, count = 1},
	{name = "toy mouse", id = 10011, buy = 650, count = 1},
	{name = "toy mouse", id = 10025, buy = 600, count = 1},
	{name = "toy mouse", id = 10028, buy = 666, count = 1},
	{name = "toy mouse", id = 10183, buy = 1000, count = 1},
	{name = "toy mouse", id = 10187, buy = 1000, count = 1},
	{name = "toy mouse", id = 10189, buy = 1000, count = 1},
	{name = "toy mouse", id = 11329, buy = 1000, count = 1},
	{name = "toy mouse", id = 11339, buy = 550, count = 1},
	{name = "toy mouse", id = 11341, buy = 1000, count = 1},
	{name = "toy mouse", id = 11544, buy = 600, count = 1},
	{name = "toy mouse", id = 11545, buy = 4000, count = 1},
	{name = "toy mouse", id = 11546, buy = 4000, count = 1},
	{name = "toy mouse", id = 11547, buy = 4000, count = 1},
	{name = "toy mouse", id = 11548, buy = 4000, count = 1},
	{name = "toy mouse", id = 11549, buy = 4000, count = 1},
	{name = "toy mouse", id = 11550, buy = 4000, count = 1},
	{name = "toy mouse", id = 11551, buy = 4000, count = 1},
	{name = "toy mouse", id = 11552, buy = 4000, count = 1},
	{name = "toy mouse", id = 13974, buy = 5000, count = 1},
	{name = "toy mouse", id = 31414, buy = 50000, count = 1},
	{name = "toy mouse", id = 31447, buy = 5000, count = 1}
}

local onBuy = function(cid, item, subType, amount, ignoreCap, inBackpacks)
	if doPlayerRemoveMoney(cid, shopWindow[item].Price) then
		local thing = doPlayerAddItem(cid, shopWindow[item].ID, 1)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Bought x" .. amount .. " "..shopWindow[item].KeyName.." for "..shopWindow[item].Price.." gold coins.")
      else
      selfSay("You don't have enough money.", cid)
   end
   return true
end

local onSell = function(cid, item, subType, amount, ignoreCap, inBackpacks)
	if getPlayerItemCount(cid, item) >= amount and doPlayerRemoveItem(cid, item, amount) then
		doPlayerAddMoney(cid, amount * shopWindow[item].Price)
		local thing = doPlayerAddItem(cid, shopWindow[item].ID, 1)
		doPlayerSendTextMessage(cid, MESSAGE_INFO_DESCR, "Sold x" .. amount .. " " .. shopWindow[item].KeyName .. " for " .. shopWindow[item].Price * amount .. " gold coins.")
	else
		selfSay("You do not have that item.", cid)
	end
	return true
end

local function creatureSayCallback(cid, type, msg)

	if not npcHandler:isFocused(cid) then
		return false
	end
	
	if msgcontains(msg, "interesting") then
	npcHandler:say({
		"I'd really like to rebuild my reputation someday and maybe find a nice girl. If you come across scrolls of heroic deeds or addresses of lovely maidens... let me know! ...",
		"Oh no, it doesn't matter what name is on the scrolls. I'm, uhm... flexible! And money - yes, I can pay. My, erm... uncle died recently and left me a pretty sum. Yes."
	}, cid)
end

if isInArray({"trade", "offer", "shop", "trad", "tra", "tradde", "tradee", "tade"}, msg:lower()) then
	for var, item in pairs(shop) do
		shopWindow[item.id] = {name = "toy mouse", id = item.id, Price = item.buy, KeyName = item.name, count = item.count}
	end
	openShopWindow(cid, shop, onBuy, onSell)
end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hi there, |PLAYERNAME|! You look like you are eager to {trade}!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Bye, |PLAYERNAME|")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())