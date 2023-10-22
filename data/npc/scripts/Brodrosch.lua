local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = { {text = 'Passage to Cormaya! Unforgettable steamboat ride!'} }
npcHandler:addModule(VoiceModule:new(voices))

local function creatureSayCallback(cid, type, msg)

	if not npcHandler:isFocused(cid) then
		return false
	end

	if msgcontains(msg, 'ticket') then
		if Player(cid):getStorageValue(Storage.WagonTicket) >= os.time() then
			npcHandler:say('Your weekly ticket is still valid. Would be a waste of money to purchase a second one', cid)
			return true
		end

		npcHandler:say('Do you want to {purchase} a weekly {ticket} for the ore wagons? With it you can travel freely and swiftly through {Kazordoon} for one week. {250 gold coins} only. Deal?', cid)
		npcHandler.topic[cid] = 1
	elseif msgcontains(msg, 'yes') and npcHandler.topic[cid] > 0 then
		local player = Player(cid)
		if npcHandler.topic[cid] == 1 then
			if not player:removeMoneyNpc(250) then
				npcHandler:say('You don\'t have enough money.', cid)
				npcHandler.topic[cid] = 0
				return true
			end

			player:setStorageValue(Storage.WagonTicket, os.time() + 7 * 24 * 60 * 60)
			npcHandler:say('Here is your stamp. It can\'t be transferred to another person and will last one week from now. You\'ll get notified upon using an ore wagon when it isn\'t valid anymore.', cid)
		end
		npcHandler.topic[cid] = 0
	elseif msgcontains(msg, 'no') and npcHandler.topic[cid] > 0 then
		npcHandler:say('No then.', cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

local function addTravelKeyword(keyword, cost, discount, destination, action)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a ride to {' .. keyword:titleCase() .. '} for '.. cost ..' gold coins}?', cost = cost, discount = discount})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, text = 'Full steam ahead!', cost = cost, discount = discount, destination = destination}, nil, action)
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'We would like to serve you some time.', reset = true})
end

addTravelKeyword('farmine', 160, 'postman', Position(33024, 31553, 10))
addTravelKeyword('cormaya', 160, 'postman', Position(33311, 31989, 15))

keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'Do you want me take you to {Cormaya} or {Farmine}?'})

npcHandler:setMessage(MESSAGE_GREET, 'Welcome, |PLAYERNAME|! May earth protect you on the rocky grounds. If you need a {passage}, I can help you.')
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye.')
npcHandler:setMessage(MESSAGE_WALKAWAY, 'Good bye then.')

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
