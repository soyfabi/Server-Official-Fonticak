local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local treasureKeyword = keywordHandler:addKeyword({"treasure"}, StdModule.say, {npcHandler = npcHandler, text = "LIKE MY TREASURE? WANNA PICK SOMETHING OUT OF IT?"})
	treasureKeyword:addChildKeyword({"yes"}, StdModule.say, {npcHandler = npcHandler, text = "ALRIGHT. BUT FIRST OF ALL I WANT YOU TO BRING ME SOMETHING IN EXCHANGE. SURPRISE ME....AND IF I LIKE IT, YOU MAY GET WHAT YOU DESERVE.", reset = true})
	treasureKeyword:addChildKeyword({"no"}, StdModule.say, {npcHandler = npcHandler, text = "HAVE YOU SEEN THESE LEGENDARY ITEMS BACK THERE? WHO COULD REFUSE THE CHANCE OF OBTAINING ONE?!? SO WHAT IS YOUR ANSWER?"})



local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)

	if msgcontains(msg, "offer") and player:getLevel() > 99 then
		npcHandler.topic[cid] = 1
		npcHandler:say("I GRANT YOU ACCESS TO THE DUNGEON IN THE NORTH. YOU'LL FIND SOME OF MY LIVING BROTHERS THERE....BUT.....EVERY TIME YOU WANT TO ENTER YOU HAVE TO GIVE ME SOMETHING PRECIOUS. ALRIGHT?", cid)
	elseif msgcontains(msg, "yes") and npcHandler.topic[cid] == 1  then
		npcHandler.topic[cid] = 2
		npcHandler:say("AS YOU WISH. WHAT DO YOU HAVE TO OFFER?", cid)
	elseif msgcontains(msg, "golden mug") and npcHandler.topic[cid] == 2 and player:removeItem(2903, 1) then
	npcHandler:say("I LIKE THAT AND GRANT YOU ACCESS TO THE DUNGEON IN THE NORTH FOR THE NEXT FEW MINUTES. COME BACK ANYTIME AND BRING ME MORE TREASURES.", cid)
	player:setStorageValue(Storage.HiddenCityOfBeregar.PythiusTheRotten, os.time() + 180)
	player:getPosition():sendMagicEffect(CONST_ME_MAGIC_BLUE)
	player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Now you have access for 3 hours.")
	else
	npcHandler:say("THIS IS NOT WORTH BEING PART OF MY TREASURE! BRING ME SOMETHING ELSE.", cid)
	end
	
	--npcHandler:say("YOU LITTLE MAGGOT. COME BACK TO ME WHEN YOU CAN HANDLE A FIGHT AGAINST MY KIND.", cid)

	return true
end











-- Basic keywords
keywordHandler:addKeyword({"awaited"}, StdModule.say, {npcHandler = npcHandler, text = "I HAVE A MISSION FOR YOU BUT YOU NEED TO DIE FIRST AND RETURN AS AN {UNDEAD} CREATURE. COME BACK TO ME WHEN YOU ACHIEVED THIS GOAL."})
keywordHandler:addKeyword({"exchange"}, StdModule.say, {npcHandler = npcHandler, text = "EVERYTHING YOU CARRY WITH YOU CAN ALSO BE FOUND IN MY {TREASURE}. BRING ME SOMETHING I DON'T OWN!!!"})
keywordHandler:addKeyword({"mission"}, StdModule.say, {npcHandler = npcHandler, text = "I HAVE A MISSION FOR YOU BUT YOU NEED TO DIE FIRST AND RETURN AS AN {UNDEAD} CREATURE. COME BACK TO ME WHEN YOU ACHIEVED THIS GOAL."})
keywordHandler:addKeyword({"undead"}, StdModule.say, {npcHandler = npcHandler, text = "BOON AND BANE. I HAVE CHOSEN THIS LIFE VOLUNTARILLY AND I NEVER REGRET IT. MY {TREASURE} IS GROWING BIGGER EACH DAY."})

npcHandler:setMessage(MESSAGE_GREET, "I {AWAITED} YOU!")
npcHandler:setMessage(MESSAGE_FAREWELL, "COME BACK ANYTIME AND BRING ME TREASURES.")
npcHandler:setMessage(MESSAGE_WALKAWAY, "COME BACK ANYTIME AND BRING ME TREASURES.")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
