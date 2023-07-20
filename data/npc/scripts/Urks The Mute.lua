local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Travel
local function addTravelKeyword(keyword, text, cost, destination)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a passage to {' .. keyword:titleCase() .. '} for {'..cost..' gold coins?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, discount = 'postman', destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'Maybe later.', reset = true})
end

addTravelKeyword('kazordoon', 'Do you want to get to kazordoon for |TRAVELCOST|?', 200, Position(32660, 31957, 15))
addTravelKeyword('cormaya', 'Do you want to get to cormaya for |TRAVELCOST|?', 200, Position(33311, 31989, 15))
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = ' <the dwarf quizzically raises his brow - the only destinations he accepts seems to be {Cormaya} or {Kazordoon}>'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome, {|PLAYERNAME|}! Lovely steamboat, ain\'t it? I can even offer you a {passage} if you like.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Until next time.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Until next time.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
