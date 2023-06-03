
local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()		npcHandler:onThink()		end

local TheNewFrontier = Storage.Quest.U8_54.TheNewFrontier

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	
	if msgcontains(msg, "farmine") and player:getStorageValue(TheNewFrontier.Questline) == 14 then
		if player:getStorageValue(TheNewFrontier.Mission05.Humgolf) == 1 then
			npcHandler:say(
			"Bah, Farmine here, Farmine there. Is there nothing else than Farmine to talk about these days? Hrmpf, whatever. So what do you want?",
			cid)
			npcHandler.topic[cid] = 1
		else
			npcHandler:say(
			"You are here to apologise? Have you got anything that would make me reconsider my decision never to talk to you again about this subject?",
			cid)
			npcHandler.topic[cid] = 2
		end
	elseif msgcontains(msg, "flatter") and player:getStorageValue(TheNewFrontier.Mission05.HumgolfKeyword) == 1 and player:getStorageValue(TheNewFrontier.Mission05.Humgolf) == 1 then
		if npcHandler.topic[cid] == 1 then
			if player:getStorageValue(TheNewFrontier.Mission05.HumgolfKeyword) == 1 then
				npcHandler:say(
				"Hah! Now you talk like a dwarf! That's the spirit! Of course you can have some of my worms. I'll send a bunch to Farmine as soon as possible.",
				cid)
				player:setStorageValue(TheNewFrontier.Mission05.Humgolf, 4)
			else
				npcHandler:say("Wrong Word, Now you will have to bring me something in return. I {need} an {Baby Rotworm}.", cid)
				npcHandler:releaseFocus(cid)
				player:setStorageValue(TheNewFrontier.Mission05.HumgolfKeyword, math.random(1, 2))
				player:setStorageValue(TheNewFrontier.Mission05.Humgolf, 2)
			end
		end
	elseif msgcontains(msg, "threaten") and player:getStorageValue(TheNewFrontier.Mission05.HumgolfKeyword) == 2 and
	player:getStorageValue(TheNewFrontier.Mission05.Humgolf) == 1 then
		if npcHandler.topic[cid] == 1 then
				npcHandler:say(
				"Hah! Now you talk like a dwarf! That's the spirit! Of course you can have some of my worms. I'll send a bunch to Farmine as soon as possible.",
				cid)
				player:setStorageValue(TheNewFrontier.Mission05.Humgolf, 4)
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 2 then
			if player:getStorageValue(TheNewFrontier.Questline) == 14 and
			player:getStorageValue(TheNewFrontier.Mission05.Humgolf) == 2 and player:removeItem(10026, 1) then
				npcHandler:say(
				"Uh, how cute! Look how he's snapping for my fingers! You really know how to make an old dwarf happy! Well, so let's try again. Why do you think I should send my precious worms to Farmine?",
				cid)
				player:setStorageValue(TheNewFrontier.Mission05.Humgolf, 1)
				npcHandler.topic[cid] = 1
			end
		end
	else
		if player:getStorageValue(TheNewFrontier.Questline) == 14 and
		player:getStorageValue(TheNewFrontier.Mission05.Humgolf) == 1 then
			npcHandler:say("Wrong Word, Now you will have to bring me something in return. I {need} an {Baby Rotworm}.", cid)
			npcHandler:releaseFocus(cid)
			player:setStorageValue(TheNewFrontier.Mission05.Humgolf, 2)
		end
	end
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	return true
end
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
