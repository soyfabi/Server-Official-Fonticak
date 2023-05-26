local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local HiddenThreats = Storage.Quest.U11_50.HiddenThreats
local function greetCallback(cid, creature, msg)
	local player = Player(cid)

	if player:getStorageValue(HiddenThreats.corymRescued03) < 0 then
		npcHandler:setMessage(MESSAGE_GREET, {
			'Every man is the architect of his own fortune. The times of {repression} are finally over.'
		})
	else
		npcHandler:setMessage(MESSAGE_GREET, 'We need weapons to overcome our situation.')
	end
	return true
end

local function creatureSayCallback(cid, creature, type, msg)
	--local player = Player(creature)
	if(msgcontains(msg, "repression")) then
			npcHandler:say({
				"We need weapons to overcome our situation."
			}, cid)
			if player:getStorageValue(HiddenThreats.corymRescued03) < 0 then
				player:setStorageValue(HiddenThreats.corymRescueMission, player:getStorageValue(HiddenThreats.corymRescueMission) +1 )
				player:setStorageValue(HiddenThreats.corymRescued03, 1 )
			end
	end
	return true
end

npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
