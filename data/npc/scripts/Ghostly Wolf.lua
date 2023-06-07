local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local ThreatenedDreams = Storage.Quest.U11_40.ThreatenedDreams
local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)

	if msgcontains(msg, "mission") then
		if player:getStorageValue(ThreatenedDreams.Mission01[1]) == 5 then
			npcHandler:say({
				"I'm heartbroken, traveler. Some months ago, I was taking care of my three newborn whelps. They just opened their eyes and started exploring the wilderness as a hunter came by. ...",
				"He shot me and took my three puppies with him. I have no idea where he brought them or whether they are still alive. This uncertainty harrows me and thus I'm unable to find peace. Will you help me?"
			}, cid)
			npcHandler.topic[cid] = 1
		elseif player:getStorageValue(ThreatenedDreams.Mission01[1]) == 8 then
			npcHandler:say({"So one of my bables died and another one has to live with the orcs. This makes me very sad. But at least one of them could return to the forest and found a surrogate mother. I hope it will lead a long, happy and most of all free life. ....",
			"Please do one last thing for me: The fur your brought me, place it in this stone's mouth. This will be a worthly resting place."
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(ThreatenedDreams.Mission01[1]) == 9 then
			npcHandler:say("I guess I will stick around for a time to watch over the grave. After this final watch I will find peace, I can feel this. Thank you, human being. You redeemed me.", cid)
			player:setStorageValue(ThreatenedDreams.Mission01[1], 10)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(ThreatenedDreams.Mission01[1]) >= 10 then
			npcHandler:say("I guess I will stick around for a time to watch over the grave. After this final watch I will find peace, I can feel this. Thank you, human being. You redeemed me.", cid)
			npcHandler.topic[cid] = 0
		else
			npcHandler:say("You are not on that mission.", cid)
			npcHandler.topic[cid] = 0
		end

	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say({
				"I didn't dare hope for it! The man told something about selling my babies to the orcs so they could train them as war wolves. ...",
				"I guess he mentioned Ulderek's Rock. Please search for them and - be they alive or not - return and tell me what happened to them."
			}, cid)
			player:setStorageValue(ThreatenedDreams.Mission01[1], 6)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "no") then
		npcHandler:say("Then not.", cid)
		npcHandler.topic[cid] = 0
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "You are speaking the language of animals? I'm surprised. But I'm not in the right mood for a chat.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
