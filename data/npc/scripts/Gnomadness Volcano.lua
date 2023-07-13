local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

keywordHandler:addGreetKeyword({'hi'}, {npcHandler = npcHandler, text = 'Hello and welcome in the Gnomprona Gardens'})
keywordHandler:addAliasKeyword({'hello'})

npcHandler:setMessage(MESSAGE_GREET, 'Hello and welcome in the Gnomprona Gardens')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
