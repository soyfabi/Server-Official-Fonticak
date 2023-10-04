local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
    local player = Player(cid)
	
    if not npcHandler:isFocused(cid) then
		return false
	end

    if (msgcontains(msg, "tactical")) then
        npcHandler:say(
            {"Since you are seasoned adventurers I'll skip the basics and jump right to the important part! This cave system is overrun by the minions of ... ah well, the greatest shame of gnomekind. ...",
             "That traitorous gnome, known as Gnomevil, who was my pupil before his changeover to the dark side of gnomedom, has abandoned all gnomish ethics and joined forces with our enemies. ...",
             "It's hard to tell what led to his downfall. In the end he seems to have forgotten the principle that with small stature comes great responsibility. ...",
             "He became tainted and corrupted by evil, obviously enough to grow in size, which is always an indicator for evil of course. ...",
             "Now he commands his armies in the name of those below and hides in his lair protected by layers of thick crystal that only he can form and change due to his corrupted powers! ...",
             "There is one thing though that could cause his downfall! His corruption has spread to his minions and in his lair there are some infected weepers that are full of parasites. ...",
             "These parasites will spread a fluid that will weaken the integrity of the crystals in front of Gnomevils lair when they die. The entrance is marked with crystal columns, so you can't miss it. ...",
             "You have to kill enough of the parasites DIRECTLY in front of the crystals. Eventually the columns will collapse and allow you entrance to Gnomevils lair. ...",
             "Take care though, due to Gnomevils power the crystals will grow back quite fast. Better manage the parasites in quick succession or everything will be for naught. ..., Enter his lair and bring an end to his despicable reign!"},
            cid)
		npcHandler.topic[cid] = 0
    end
    return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
