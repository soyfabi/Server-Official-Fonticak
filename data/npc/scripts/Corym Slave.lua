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

	if player:getStorageValue(HiddenThreats.corymRescued02) < 0 then
		npcHandler:setMessage(MESSAGE_GREET, 'Every man is the architect of his own fortune. There will be the day of {pay back}.')
	else
		npcHandler:setMessage(MESSAGE_GREET, 'The repression has taken too long. With our new weapons the respective people will get their just punishment.')
	end
	return true
end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	
	if(msgcontains(msg, "pay back")) then
			npcHandler:say({
				"The repression has taken too long. With our new weapons the respective people will get their just punishment."
			}, cid)
			if player:getStorageValue(HiddenThreats.corymRescued02) < 0 then
				player:setStorageValue(HiddenThreats.corymRescueMission, player:getStorageValue(HiddenThreats.corymRescueMission) +1 )
				player:setStorageValue(HiddenThreats.corymRescued02, 1 )
			end
	end
	
	return true
end


npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
