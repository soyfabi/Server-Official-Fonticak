 local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

-- Travel
local function addTravelKeyword(keyword, text, cost, destination)
	local travelKeyword = keywordHandler:addKeyword({keyword}, StdModule.say, {npcHandler = npcHandler, text = 'Do you seek a ride to {' .. text .. '} for {'.. cost ..' gold coins}?', cost = cost, discount = 'postman'})
		travelKeyword:addChildKeyword({'yes'}, StdModule.travel, {npcHandler = npcHandler, premium = false, cost = cost, discount = 'postman', destination = destination})
		travelKeyword:addChildKeyword({'no'}, StdModule.say, {npcHandler = npcHandler, text = 'You shouldn\'t miss the experience.', reset = true})
end

addTravelKeyword('darashia', 'Darashia on Darama', 60, Position(33270, 32441, 6))
addTravelKeyword('svargrond', 'Svargrond', 60, Position(32253, 31097, 4))
addTravelKeyword('femor hills', 'the Femor Hills', 60, Position(32536, 31837, 4))
addTravelKeyword('edron', 'Edron', 60, Position(33193, 31784, 3))
addTravelKeyword('kazordoon', 'Kazordoon', 70, Position(32588, 31941, 0))
addTravelKeyword('hills', 'the Femor Hills', 60, Position(32536, 31837, 4))
addTravelKeyword('issavi', 'Issavi', 100, Position(33957, 31515, 0))
addTravelKeyword('marapur', 'Marapur', 70, Position(33805, 32767, 2))

-- Basic
keywordHandler:addKeyword({'lizard'}, StdModule.say, {npcHandler = npcHandler, text = 'There are many of them to the north and south of this continent. I had thought they only existed on Tiquanda, but I was mistaken.'})
keywordHandler:addKeyword({'zao'}, StdModule.say, {npcHandler = npcHandler, text = 'What a strange and bizarre continent. I\'m glad my landing place is far away from all the mess I\'ve seen from above.'})
keywordHandler:addKeyword({'fly'}, StdModule.say, {npcHandler = npcHandler, text = 'I can fly you to {Darashia}, {Edron}, {Issavi}, {Svargrond}, {Kazordoon}, {Femor Hills} or to {Marapur} if you like. Where do you want to go?'})
keywordHandler:addKeyword({'service'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m a carpet pilot. I can fly you to the {Femor Hills}, to {Kazordoon}, {Svargrond}, {Edron}, {Darashia}, {Issavi} or {Marapur}.'})
keywordHandler:addKeyword({'job'}, StdModule.say, {npcHandler = npcHandler, text = 'I\'m a carpet pilot. I can fly you to the {Femor Hills}, to {Kazordoon}, {Svargrond}, {Edron}, {Darashia}, {Issavi} or {Marapur}.'})
keywordHandler:addKeyword({'name'}, StdModule.say, {npcHandler = npcHandler, text = 'Melian at your service.'})
keywordHandler:addKeyword({'mountain'}, StdModule.say, {npcHandler = npcHandler, text = 'These mountains don\'t look friendly. I prefer not staying long inbetween my carpet trips.'})
keywordHandler:addKeyword({'carpet'}, StdModule.say, {npcHandler = npcHandler, text = 'Only licensed carpet pilots are allowed to fly those.'})
keywordHandler:addKeyword({'orc'}, StdModule.say, {npcHandler = npcHandler, text = 'There\'s so much green stuff down there that I\'m not sure whether there are any, but yes, might be, might be.'})
keywordHandler:addKeyword({'dwarf'}, StdModule.say, {npcHandler = npcHandler, text = 'Well, dwarves and their steamboat technology are well and good, but nothing beats flying on a carpet.'})
keywordHandler:addKeyword({'steamboat'}, StdModule.say, {npcHandler = npcHandler, text = 'Well, dwarves and their steamboat technology are well and good, but nothing beats flying on a carpet.'})
keywordHandler:addKeyword({'farmine'}, StdModule.say, {npcHandler = npcHandler, text = 'That\'s the name of that dwarven base as far as I know. Got a bit of a pessimistic ring to it if you ask me. Sounds to me like they\'re starving.'})
keywordHandler:addKeyword({'passage'}, StdModule.say, {npcHandler = npcHandler, text = 'I can fly you to {Darashia} on {Darama}, to {Kazordoon}, to {Svargrond} on Hrodmir, to {Edron}, to the {Femor Hills}, to {Issavi} or to {Marapur} if you like. Where do you want to go?'})
keywordHandler:addKeyword({'tibia'}, StdModule.say, {npcHandler = npcHandler, text = 'I can fly you to {Darashia} on {Darama}, to {Kazordoon}, to {Svargrond} on Hrodmir, to {Edron}, to the {Femor Hills}, to {Issavi} or to {Marapur} if you like. Where do you want to go?'})
keywordHandler:addKeyword({'ride'}, StdModule.say, {npcHandler = npcHandler, text = 'I can fly you to {Darashia} on {Darama}, to {Kazordoon}, to {Svargrond} on Hrodmir, to {Edron}, to the {Femor Hills}, to {Issavi} or to {Marapur} if you like. Where do you want to go?'})
keywordHandler:addKeyword({'trip'}, StdModule.say, {npcHandler = npcHandler, text = 'I can fly you to {Darashia} on {Darama}, to {Kazordoon}, to {Svargrond} on Hrodmir, to {Edron}, to the {Femor Hills}, to {Issavi} or to {Marapur} if you like. Where do you want to go?'})
keywordHandler:addKeyword({'transport'}, StdModule.say, {npcHandler = npcHandler, text = 'I can fly you to {Darashia} on {Darama}, to {Kazordoon}, to {Svargrond} on Hrodmir, to {Edron}, to the {Femor Hills}, to {Issavi} or to {Marapur} if you like. Where do you want to go?'})
keywordHandler:addKeyword({'human'}, StdModule.say, {npcHandler = npcHandler, text = 'The only humans I\'ve seen on this continent are those that come up to my carpet.'})
keywordHandler:addKeyword({'continent'}, StdModule.say, {npcHandler = npcHandler, text = 'What a strange and bizarre continent. I\'m glad my landing place is far away from all the mess I\'ve seen from above.'})
keywordHandler:addKeyword({'femur'}, StdModule.say, {npcHandler = npcHandler, text = 'You are probably talking about the {FEMOR hills}.'})
keywordHandler:addKeyword({'time'}, StdModule.say, {npcHandler = npcHandler, text = 'It\'s 2:55 pm right now. I think I\'m five minutes late in my schedule.'})

npcHandler:setMessage(MESSAGE_GREET, "Ah, the wind brings in another visitor. Feel welcome |PLAYERNAME|. Where do you want me to {fly} you?")
npcHandler:setMessage(MESSAGE_FAREWELL, "Daraman's blessings!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Daraman's blessings!")

npcHandler:addModule(FocusModule:new())
