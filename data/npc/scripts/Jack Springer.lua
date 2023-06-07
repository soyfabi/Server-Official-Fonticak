local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)	npcHandler:onCreatureSay(cid, type, msg)	end
function onThink()						npcHandler:onThink()						end

local voices = { 
{text = 'Always be on guard.'},
{text = 'Hmm.'} 
}

npcHandler:addModule(VoiceModule:new(voices))

local GraveDanger = Storage.Quest.U12_20.GraveDanger
local function greetCallback(cid, type, msg)
	local player = Player(cid)

	if player:getStorageValue(GraveDanger.QuestLine) < 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome, |PLAYERNAME|! There is much we have to {discuss}.")
	elseif player:getStorageValue(GraveDanger.QuestLine) >= 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Welcome, |PLAYERNAME|! Is there anything to {report}?")
	end
	return true
end

function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end

	local player = Player(cid)
	
	if msgcontains(msg, "late") then
		if player:getStorageValue(GraveDanger.QuestLine) < 1 then
			npcHandler:say({
				"While you travel and fight the threat where it arises, we will put all our resources into researching the ultimate plans of the legion. Perhaps I can tell you more when you {report} back. ...",
				"Don't forget that you'll need very potent holy water for your task. If you need some, just ask me for a {trade}."}, cid)
			player:setStorageValue(GraveDanger.QuestLine, 1)
			player:setStorageValue(GraveDanger.Graves.Edron, 1)
			player:setStorageValue(GraveDanger.Graves.DarkCathedral, 1)
			player:setStorageValue(GraveDanger.Graves.Ghostlands, 1)
			player:setStorageValue(GraveDanger.Graves.Cormaya, 1)
			player:setStorageValue(GraveDanger.Graves.FemorHills, 1)
			player:setStorageValue(GraveDanger.Graves.Ankrahmun, 1)
			player:setStorageValue(GraveDanger.Graves.Kilmaresh, 1)
			player:setStorageValue(GraveDanger.Graves.Vengoth, 1)
			player:setStorageValue(GraveDanger.Graves.Darashia, 1)
			player:setStorageValue(GraveDanger.Graves.Thais, 1)
			player:setStorageValue(GraveDanger.Graves.Orclands, 1)
			player:setStorageValue(GraveDanger.Graves.IceIslands, 1)
		end
	end
	
	return true
end


npcHandler:setMessage(MESSAGE_SENDTRADE, "Of course, my friend.")
npcHandler:setMessage(MESSAGE_FAREWELL, 'Good bye, |PLAYERNAME|.')

npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
