 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Passages to Kazordoon! Gotta try the beer there.'} }
npcHandler:addModule(VoiceModule:new(voices))

-- Travel
local function addTravelKeyword(keyword, text, cost, discount, destination)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = text[1], cost = cost, discount = discount})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, text = text[2], cost = cost, discount = discount, destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = text[3], reset = true})
end

addTravelKeyword('farmine', {'Do you want to go to {Farmine} to try the beer there? {160 gold coins}?', 'Set the sails!', 'Then not.'}, 160, 'postman', Position(33024, 31553, 10))
addTravelKeyword('kazordoon', {'Do you want to go to {Kazordoon} to try the beer there? {160 gold coins}?', 'Set the sails!', 'Then not.'}, 160, 'postman', Position(32660, 31957, 15))
addTravelKeyword('gnomprona', {'Would you like to travel to {Gnomprona} for {200 gold coins}?', 'Full steam ahead!', 'Then not.'}, 200, 'postman', Position(33516, 32856, 14))

keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Do you want me take you to {Kazordoon}, {Farmine} or {Gnomprona}?'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome, |PLAYERNAME|! May Earth protect you, even whilst sailing!')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Until next time.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Until next time.')

npcHandler:addModule(FocusModule:new())
