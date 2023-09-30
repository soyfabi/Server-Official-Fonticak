local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)              npcHandler:onCreatureAppear(cid)            end
function onCreatureDisappear(cid)           npcHandler:onCreatureDisappear(cid)         end
function onCreatureSay(cid, type, msg)      npcHandler:onCreatureSay(cid, type, msg)    end
function onThink()                          npcHandler:onThink()                        end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)

    if not player:isPlayer() then
        return false
    end

    if msgcontains(msg, "sail") then
        if player:hasOutfit(153) and player:hasOutfit(157) then
			if player:removeMoney(50) then
				npcHandler:say("Good luck.", cid)
				npcHandler:releaseFocus(cid)
				player:teleportTo(Position(32227, 31756, 7))
			else
				npcHandler:say("Nao tem dinheiro.", cid)
				npcHandler:releaseFocus(cid)
			end
		else
			npcHandler:say("Voce não pode, voce é da classe X.", cid)
			npcHandler:releaseFocus(cid)
		end
	end
	
    return true
end

npcHandler:setMessage(MESSAGE_GREET, 'Olá, com meu barco você pode {sail} para x.')
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())