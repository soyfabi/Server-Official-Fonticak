local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	if msgcontains(msg, "meat") then
		if player:removeItem(3577, 1) then
			npcHandler:say("<munch>", cid)
			if player:getStorageValue(Storage.TheIceIslands.Mission01) == 1 then
				player:setStorageValue(Storage.TheIceIslands.Questline, 2)
				player:setStorageValue(Storage.TheIceIslands.Mission01, 2) -- Questlog The Ice Islands Quest, Befriending the Musher
			end
		else
			npcHandler:releaseFocus(cid)
		end
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
