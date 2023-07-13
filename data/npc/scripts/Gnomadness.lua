local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local voices = {
	{ text = " I'll have to write that idea down."},
	{ text = "So many ideas, so little time" },
	{ text = "Muhahaha!" },
}
npcHandler:addModule(VoiceModule:new(voices))


local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)


	if msgcontains(msg, "hazard") then
		npcHandler:say("I can change your hazard level to spice up your hunt in the gardens. Your current level is set to " .. current .. ". And your maximum unlocked level is {" .. maximum .. "}. What level would you like to hunt in?", cid)
		npcHandler.topic[cid] = 1
	else
		if npcHandler.topic[cid] == 1 then
			local desiredLevel = getMoneyCount(message)
			if desiredLevel == -1 then
				npcHandler:say("I'm sorry, I don't understand. What hazard level would you like to set?", cid)
				npcHandler:setTopic(playerId, 0)
				return true
			end
			if hazard:setPlayerCurrentLevel(player, desiredLevel) then
				npcHandler:say("Your hazard level has been set to " .. desiredLevel .. ". Good luck!", cid)
			else
				npcHandler:say("You can't set your hazard level higher than your maximum unlocked level.", cid)
			end
		end
	end

	return true
end

keywordHandler:addGreetKeyword({'hi'}, {npcHandler = npcHandler, text = "Hello and welcome in the Gnomprona Gardens. If you want to change your {hazard} level, I 'm who you're looking for."})
keywordHandler:addAliasKeyword({'hello'})

npcHandler:setMessage(MESSAGE_GREET, 'Hello and welcome in the Gnomprona Gardens')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
