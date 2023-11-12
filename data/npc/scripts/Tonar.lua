local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	
	if msgcontains(msg, "passage") then
		npcHandler.topic[cid] = 1
		npcHandler:say("Do you seek a passage to the {isle of the kings} for {10 gold coins}?", cid)
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 1 then
		player:teleportTo(Position(33069, 32916, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		npcHandler:say("Have a nice trip!", cid)
		player:removeMoneyNpc(10)
	elseif msgcontains(msg, "no") then
		npcHandler:say("Well, I\'ll be here if you change your mind", cid)
		npcHandler:releaseFocus(cid)
	elseif msgcontains(msg, "post") and player:getStorageValue(Storage.WhiteRavenMonastery.Passage) <= 0 then
		npcHandler:say("I have only sailed to the {isle of the kings} once or twice. I dare not anger the monks by bringing travellers there without their {permission}.", cid)
		npcHandler:releaseFocus(cid)
	else
		
	end
	
	return true
end

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "My name is Dalbrect Windtrouser, of the once proud Windtrouser family."})
keywordHandler:addKeyword({'hut'}, StdModule.say, {npcHandler = npcHandler, text = "I am merely a humble fisher now that nothing is left of my noble {legacy}."})
keywordHandler:addKeyword({'legacy'}, StdModule.say, {npcHandler = npcHandler, text = "Once my family was once noble and wealthy, but {fate} turned against us and threw us into poverty."})
keywordHandler:addKeyword({'poverty'}, StdModule.say, {npcHandler = npcHandler, text = "When Carlin tried to colonize the region now known as the ghostlands, my ancestors put their fortune in that {project}."})
keywordHandler:addKeyword({'fate'}, StdModule.say, {npcHandler = npcHandler, text = "When Carlin tried to colonize the region now known as the ghostlands, my ancestors put their fortune in that {project}."})
keywordHandler:addKeyword({'ghostlands'}, StdModule.say, {npcHandler = npcHandler, text = "Our family fortune was lost when the colonization of those cursed lands failed. Now nothing is left of our fame or our fortune. If I only had something as a reminder of those better times. <sigh>"})
keywordHandler:addKeyword({'project'}, StdModule.say, {npcHandler = npcHandler, text = "Our family fortune was lost when the colonization of those cursed lands failed. Now nothing is left of our fame or our fortune. If I only had something as a reminder of those better times. <sigh>"})
keywordHandler:addKeyword({'carlin'}, StdModule.say, {npcHandler = npcHandler, text = "To think my family used to belong to the local nobility! And now those arrogant women are in charge!"})
keywordHandler:addKeyword({'need'}, StdModule.say, {npcHandler = npcHandler, text = "There is little I can offer you but a trip with my boat. Are you looking for a {passage} to the isle of kings perhaps?"})
keywordHandler:addKeyword({'ship'}, StdModule.say, {npcHandler = npcHandler, text = "My ship is my only pride and joy."})

npcHandler:setMessage(MESSAGE_GREET, "Be greeted, traveller |PLAYERNAME|. Welcome to my {hut}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. You are welcome.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
