local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local HiddenThreats = Storage.Quest.U11_50.HiddenThreats
local function greetCallback(cid, creature, message)
	local player = Player(cid)

	if player:getStorageValue(HiddenThreats.corymRescued01) < 0 then
		npcHandler:setMessage(MESSAGE_GREET, {
			'My hero! A friend of mine sent you to liberate me? A true friend! I am poor but nevertheless I give you this as little reward.'
		})
		player:setStorageValue(HiddenThreats.corymRescueMission, player:getStorageValue(HiddenThreats.corymRescueMission) +1 )
		player:setStorageValue(HiddenThreats.corymRescued01, 1 )
		player:addItem(3030, 1)
	else
		npcHandler:setMessage(MESSAGE_GREET, 'My hero! A friend of mine sent you to liberate me? A true friend!')
	end
	return true
end

local function creatureSayCallback(cid, creature, type, message)
	--local player = Player(creature)

	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
