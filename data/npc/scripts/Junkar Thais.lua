local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = 'So much to do. So many things to be fixed.' },
	{ text = 'Still so much work.' }
}

npcHandler:addModule(VoiceModule:new(voices))

-- Travel
local function addTravelKeyword(keyword, cost, destination)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = text or 'So you wish for a trip to {' .. keyword:titleCase() .. '}? for {'..cost..' gold coins}?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, text = 'Full steam ahead!', cost = cost, discount = 'postman', destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'Well, then you stay here, simple as that.', reset = true})
end

addTravelKeyword('kazordoon', 100, Position(32660, 31957, 15))
addTravelKeyword('robsons isle', 80, Position(32527, 32036, 14))
addTravelKeyword('mines', 90, Position(32555, 32069, 10))

keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want me to take you? To {Kazordoon} or to {Robsons Isle}? Occasionally we can even reach the {mines} if they are cleared.'})

npcHandler:setMessage(MESSAGE_GREET, "Welcome, {|PLAYERNAME|}! You are lucky that the service is running right now. Save your coal for the days to come though!")
npcHandler:setMessage(MESSAGE_FAREWELL, "See you next time!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "<Sigh> No patience!")

npcHandler:addModule(FocusModule:new())
