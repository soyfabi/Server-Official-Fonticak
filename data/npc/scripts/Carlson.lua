local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Travel
local function addTravelKeyword(keyword, text, cost, destination)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you want to sail ' .. text, cost = cost})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
end

addTravelKeyword('tibia', 'back to Tibia?', 0, Position(32235, 31674, 7))
addTravelKeyword('senja', 'Senja for {20 gold coins}?', 20, Position(32128, 31664, 7))
addTravelKeyword('folda', 'Folda for {20 gold coins}?', 20, Position(32046, 31578, 7))

-- Basic
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Where do you want to go? To {Folda}, {Senja} or {Tibia}?'})

local function greetCallback(cid)
	npcHandler:setMessage(MESSAGE_GREET, "Ahoi, young man |PLAYERNAME| and welcome to the Nordic Tibia Ferries. If you need a {passage}, let me know.")
	return true
end

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:addModule(FocusModule:new())
