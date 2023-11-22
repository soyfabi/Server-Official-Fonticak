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
		if player:getStorageValue(Storage.Quest.U13_10.Ocarina) ~= -1 then
			npcHandler.topic[cid] = 1
			npcHandler:say("Do you seek a passage to the {oskayaat} for {100 gold coins}?", cid)
		else
			npcHandler.topic[cid] = 0
			npcHandler:say("You need to look for an {ocarina}, it is located in the east north of the city.", cid)
		end
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 1 then
		player:teleportTo(Position(33069, 32916, 7))
		player:getPosition():sendMagicEffect(CONST_ME_TELEPORT)
		npcHandler:say("Have a nice trip!", cid)
		player:removeMoneyNpc(100)
	elseif msgcontains(msg, "no") then
		npcHandler:say("Well, I\'ll be here if you change your mind", cid)
		npcHandler:releaseFocus(cid)	
	else
		npcHandler:say("Don\'t know you\'re talking.", cid)
	end
	
	return true
end

keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = "My name is Tonar."})
keywordHandler:addKeyword({'project'}, StdModule.say, {npcHandler = npcHandler, text = "Our family fortune was lost when the colonization of those cursed lands failed. Now nothing is left of our fame or our fortune. If I only had something as a reminder of those better times. <sigh>"})
keywordHandler:addKeyword({'need'}, StdModule.say, {npcHandler = npcHandler, text = "There is little I can offer you but a trip with my boat. Are you looking for a {passage} to the isle of oskayaat?"})
keywordHandler:addKeyword({'ship'}, StdModule.say, {npcHandler = npcHandler, text = "My ship is my only pride and joy."})

npcHandler:setMessage(MESSAGE_GREET, "Be greeted, traveller |PLAYERNAME|. If you want to travel, say {passage}.")
npcHandler:setMessage(MESSAGE_FAREWELL, "Good bye. You are welcome.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good bye.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
