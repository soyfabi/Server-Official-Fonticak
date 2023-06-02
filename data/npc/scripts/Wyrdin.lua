local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local voices = {
	{ text = "<mumbles> So where was I again?" },
	{ text = "<mumbles> Typical - you can never find a hero when you need one!" },
	{ text = "<mumbles> Could the bonelord language be the invention of some madman?" },
	{ text = "<mumbles> The curse algorithm of triplex shadowing has to be two times higher than an overcharged nanoquorx on the peripheral..." }
}

npcHandler:addModule(VoiceModule:new(voices))

local TheNewFrontier = Storage.Quest.U8_54.TheNewFrontier

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	
	if msgcontains(msg, "mission") then
		if player:getStorageValue(Storage.TheWayToYalahar.QuestLine) < 1 and
		player:getStorageValue(Storage.ExplorerSociety.JoiningTheExplorers) >= 4 and
		player:getStorageValue(Storage.ExplorerSociety.QuestLine) >= 4 then
			npcHandler:say(
			{"There is indeed something that needs our attention. In the far north, a new city named Yalahar was discovered. It seems to be incredibly huge. ...",
				"According to travelers, it's a city of glory and wonders. We need to learn as much as we can about this city and its inhabitants. ...",
				"Gladly the explorer's society already sent a representative there. Still, we need someone to bring us the information he was able to gather until now. ...",
				"Please look for the explorer's society's captain Maximilian in Liberty Bay. Ask him for a passage to Yalahar. There visit Timothy of the explorer's society and get his research notes. ...",
			"It might be a good idea to explore the city a bit on your own before you deliver the notes here, but please make sure you don't lose them."},
			cid)
			player:setStorageValue(Storage.TheWayToYalahar.QuestLine, 1)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(Storage.TheWayToYalahar.QuestLine) == 2 then
			npcHandler:say("Did you bring the papers I asked you for?", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			if player:removeItem(9171, 1) then
				player:setStorageValue(Storage.TheWayToYalahar.QuestLine, 3)
				npcHandler:say(
				"Oh marvellous, please excuse me. I need to read this text immediately. Here, take this small reward of 500 gold pieces for your efforts.",
				cid)
				player:addMoney(500)
				npcHandler.topic[cid] = 0
			end
		elseif npcHandler.topic[cid] == 3 then
			if player:getStorageValue(TheNewFrontier.Mission05.Wyrdin) == 2 and player:removeItem(10025, 1) then
				npcHandler:say(
				{"By Uman! That's one of the rare almanacs of Origus! I had no idea that you are a scholar yourself! And a generous one on top of it! ...",
					"This book must be worth some thousand crystal coins on the free market. Look at the signature here, it's Origus' very own! ...",
				"Of course we should talk again about your request. What do you say makes Farmine important?"},
				cid)
				player:setStorageValue(TheNewFrontier.Mission05.Wyrdin, 1)
				npcHandler.topic[cid] = 2
			end
		end
		-- The New Frontier
	elseif msgcontains(msg, "farmine") then
		if player:getStorageValue(TheNewFrontier.Questline) == 14 then
			if player:getStorageValue(TheNewFrontier.Mission05.Wyrdin) == 1 then
				npcHandler:say(
				"I've heard some odd rumours about this new dwarven outpost. But tell me, what has the {Edron} academy to do with {Farmine}?",
				cid)
				npcHandler.topic[cid] = 2
			else
				npcHandler:say(
				"I'm not sure if I'm in the mood to talk about that matter again. Or do you have anything that might change my mind?",
				cid)
				npcHandler.topic[cid] = 3
			end
		end
	elseif msgcontains(msg, "plea") and player:getStorageValue(TheNewFrontier.Mission05.WyrdinKeyword) == 1 and
	player:getStorageValue(TheNewFrontier.Mission05.Wyrdin) == 1 then
		if npcHandler.topic[cid] == 2 then
			local chance = math.random(1, 3)
			if chance == 1 then
				npcHandler:say(
				"Hm, you are right, we are at the forefront of knowledge and innovation. Our dwarven friends could learn much from one of our representatives.",
				cid)
			elseif chance == 2 then
				npcHandler:say(
				"<sighs> Okay, sending some trader there won't hurt. I hope it will be worth the effort, though.",
				cid)
			else
				npcHandler:say(
				{"Well, it can't be wrong to be there when new discoveries are made. Also, all those soldiers of fortune that might travel there could turn out to be a good source of income for a magic shop. ...",
				"I think we'll send a representative. At least, for some time."}, cid)
			end
			player:setStorageValue(TheNewFrontier.Mission05.Wyrdin, 3)
		end
	elseif msgcontains(msg, "bluff") and player:getStorageValue(TheNewFrontier.Mission05.WyrdinKeyword) == 2 and
	player:getStorageValue(TheNewFrontier.Mission05.Wyrdin) == 1 then
		npcHandler:say(
		"What do you mean the druids of Carlin could provide the service as well? They are incompetent imposters! I will not allow them to ruin our reputation! I'll send some trader with supplies right away!",
		cid)
		player:setStorageValue(TheNewFrontier.Mission05.Wyrdin, 3)
	elseif msgcontains(msg, "flatter") and player:getStorageValue(TheNewFrontier.Mission05.WyrdinKeyword) == 3 and
	player:getStorageValue(TheNewFrontier.Mission05.Wyrdin) == 1 then
		npcHandler:say(
		"Hm, you are right, we are at the forefront of knowledge and innovation. Our dwarven friends could learn much from one of our representatives.",
		cid)
		player:setStorageValue(TheNewFrontier.Mission05.Wyrdin, 3)
	else
		if player:getStorageValue(TheNewFrontier.Questline) == 14 and
		player:getStorageValue(TheNewFrontier.Mission05.Wyrdin) == 1 then
			npcHandler:say("Wrong Word, Now you will have to bring me something in return. I {need} an {Almanac of Magic}.", cid)
			player:setStorageValue(TheNewFrontier.Mission05.Wyrdin, 2)
			npcHandler:releaseFocus(cid)
		end
	end
	
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Hello, what brings you here?")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
