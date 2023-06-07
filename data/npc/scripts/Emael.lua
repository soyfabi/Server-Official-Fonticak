local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local voices = { 
{text = 'Not enough space for all my trophies...'} 
}

local GraveDanger = Storage.Quest.U12_20.GraveDanger

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	
	if msg == "podium" then
		npcHandler:say("Do you want to appropriately show off your boss trophies and buy an additional podium of vigour for 1000000 Gold?", cid)
		npcHandler.topic[cid] = 1
	elseif msg == "yes" and npcHandler.topic[cid] == 1 then
		if player:getStorageValue(30020) == 1 then
			if player:removeMoney(1000000) then
				npcHandler:say("Ah, I see you killed a lot of dangerous creatures. Here's your podium of vigour!", cid)
				local inbox = player:getSlotItem(CONST_SLOT_STORE_INBOX)
				if inbox and inbox:getEmptySlots() > 0 then
					local decoKit = inbox:addItem(23398, 1)
					if decoKit then
						decoKit:setAttribute(ITEM_ATTRIBUTE_DESCRIPTION, "Unwrap it in your own house to create a <" .. ItemType(38707):getName() .. ">.")
						decoKit:setCustomAttribute("unWrapId", 38707)
					end
				else
					npcHandler:say("Please make sure you have free slots in your store inbox.", cid)
				end
			else
				npcHandler:say("You don'\t have enough money.", cid)
			end
		else
			npcHandler:say("You have not aquired enough knowledge in hunting big scary creatures.", cid)
		end
			npcHandler.topic[cid] = 0
	elseif msg == "no" and npcHandler.topic[cid] == 1 then
		npcHandler:say("Blessings on your hunts!", cid)
		npcHandler.topic[cid] = 0
	end
	
	return true
end


npcHandler:setMessage(MESSAGE_GREET, "Hello! Ever asked yourself who killed all the monsters for the wall trophies? Yeah, that was me, Emael the Beasthunter! I am an expert in displaying trophies. ...",								  
"So if you have at least some dangerous monster to show off I strongly advise you to aquire a {podium} of vigour.")
npcHandler:setMessage(MESSAGE_FAREWELL, "I wish you a good hunt. Goodbye!")
npcHandler:setMessage(MESSAGE_WALKAWAY, "Good hunting!")

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
