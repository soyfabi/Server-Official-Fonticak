local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local HiddenThreats = Storage.Quest.U11_50.HiddenThreats
local function greetCallback(cid, type, msg)
	local player = Player(cid)

	if player:getStorageValue(HiddenThreats.corymRescued08) < 0 then
		npcHandler:setMessage(MESSAGE_GREET, 'Every man is the architect of his own fortune. We have nearly died of {hunger}.')
	else
		npcHandler:setMessage(MESSAGE_GREET, 'What we get to eat is really ridiculous.')
	end
	return true
end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	
	if(msgcontains(msg, "hunger")) then
			npcHandler:say({
				"What we get to eat is really ridiculous. Particularly in view of the fact that we should dig up an insane amount of ores."
			}, cid)
			if player:getStorageValue(HiddenThreats.corymRescued08) < 0 then
				player:setStorageValue(HiddenThreats.corymRescueMission, player:getStorageValue(HiddenThreats.corymRescueMission) +1 )
				player:setStorageValue(HiddenThreats.corymRescued08, 1 )
			end
	end
	
	return true
end


npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
