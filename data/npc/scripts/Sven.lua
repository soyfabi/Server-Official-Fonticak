local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function greetCallback(cid, msg)
	local player = Player(cid)
	if player:getStorageValue(Storage.TheIceIslands.HuskyKillStatus) == 1 then
		npcHandler:setMessage(MESSAGE_GREET, "Iskan told me that you killed huskies here in Svargrond. I will be lenient towards you and won't ban you from Svargrond. But you have to pay me a compensation of 1500 gold for each husky you have killed. Are you willing to pay "..player:getStorageValue(Storage.TheIceIslands.HuskyKill) * 1500 .."?")
	else
		npcHandler:setMessage(MESSAGE_GREET, "Be greeted, |PLAYERNAME|! What brings you {here}?")
	end
	return true
end

local function creatureSayCallback(cid, type, msg)
	if not npcHandler:isFocused(cid) then
		return false
	end
	local player = Player(cid)
	
	if msgcontains(msg, "barbarian") or msgcontains(msg, "barbarians") then
		if player:getStorageValue(Storage.BarbarianTest.Questline) < 1 then
			npcHandler:say("A true barbarian is something special among our people. Everyone who wants to become a barbarian will have to pass the barbarian {test}.", cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "test") and npcHandler.topic[cid] == 1 then
		npcHandler:say({
			"All of our juveniles have to take the barbarian test to become a true member of our community. Foreigners who manage to master the test are granted the title of an honorary barbarian and the respect of our people ...",
			"Are you willing to take the barbarian test?"
		}, cid)
		npcHandler.topic[cid] = 2
	elseif msgcontains(msg, "mead") then
		if player:getStorageValue(Storage.BarbarianTest.Questline) == 1 then
			npcHandler:say("Do you have some honey with you?", cid)
			npcHandler.topic[cid] = 4
		elseif player:getStorageValue(Storage.BarbarianTest.Questline) == 3 then
			npcHandler:say({
				"An impressive start. Here, take your own mead horn to fill it at the mead bucket as often as you like ...",
				"But there is much left to be done. Your next test will be to hug a bear ...",
				"You will find one in a cave north of the town. If you are lucky, it's still sleeping. If not ... well that might hurt ...",
				"Unless you feel that you hugged the bear, the test is not passed. Once you are done, talk to me about the bear hugging."
			}, cid)
			player:setStorageValue(Storage.BarbarianTest.Questline, 4)
			player:setStorageValue(Storage.BarbarianTest.Mission02, 1) -- Questlog Barbarian Test Quest Barbarian Test 2: The Bear Hugging
			player:addItem(7140, 1)
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "hug") then
		if player:getStorageValue(Storage.BarbarianTest.Questline) == 5 then
			npcHandler:say({
				"Amazing. That was as clever and brave as a barbarian is supposed to be. But a barbarian also has to be strong and fearless. To prove that you will have to knock over a mammoth ...",
				"Did your face just turn into the color of fresh snow? However, you will find a lonely mammoth north west of the town in the wilderness. Knock it over to prove to be a true barbarian ...",
				"Return to me and talk about the {mammoth} pushing when you are done."
			}, cid)
			player:setStorageValue(Storage.BarbarianTest.Questline, 6)
			player:setStorageValue(Storage.BarbarianTest.Mission03, 1) -- Questlog Barbarian Test Quest Barbarian Test 3: The Mammoth Pushing
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "mammoth") then
		if player:getStorageValue(Storage.BarbarianTest.Questline) == 7 then
			npcHandler:say({
				"As you have passed all three tests, I welcome you in our town as an honorary barbarian. You can now become a citizen. Don't forget to talk to the people here. Some of them might need some help ...",
				"We usually solve our problems on our own but some of the people might have a mission for you. Old Iskan, on the ice in the northern part of the town had some trouble with his dogs lately."
			}, cid)
			player:setStorageValue(Storage.BarbarianTest.Questline, 8)
			player:setStorageValue(Storage.BarbarianTest.HonoraryBarbarian, 1)
			player:addAchievement('Honorary Barbarian')
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "yes") then
		if player:getStorageValue(Storage.TheIceIslands.HuskyKillStatus) == 1 and player:getStorageValue(Storage.BarbarianTest.Questline) == 8 then
			if player:removeMoneyBank(player:getStorageValue(Storage.TheIceIslands.HuskyKill) * 1500) then
				npcHandler:say("Alright, we are even!", cid)
				player:setStorageValue(Storage.TheIceIslands.HuskyKillStatus, 0)
				player:setStorageValue(Storage.TheIceIslands.HuskyKill, 0)
				npcHandler.topic[cid] = 0
			else
				npcHandler:say("You don't have enough. Bring me the money and I will forget about it.", cid)
				npcHandler.topic[cid] = 0
			end
		elseif npcHandler.topic[cid] == 2 then
			npcHandler:say({
				"That's the spirit! The barbarian test consists of a few tasks you will have to fulfill. All are rather simple - for a barbarian that is...",
				"Your first task is to drink some barbarian mead. But be warned, it's a strong brew that could even knock out a bear. You need to make at least ten sips of mead in a row without passing out to pass the test ...",
				"Do you think you can do this?"
			}, cid)
			npcHandler.topic[cid] = 3
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say({
				"Good, but to make barbarian mead we need some honey which is rare here. I'd hate to waste mead just to learn you're not worth it ...",
				"Therefore, you have to get your own honey. You'll probably need more than one try so better get some extra honeycombs. Then talk to me again about barbarian {mead}."
			}, cid)
			npcHandler.topic[cid] = 0
			player:setStorageValue(Storage.BarbarianTest.Questline, 1)
			player:setStorageValue(Storage.TheIceIslands.Questline, 1)
			player:setStorageValue(Storage.BarbarianTest.Mission01, 1) -- Questlog Barbarian Test Quest Barbarian Test 1: Barbarian Booze
		elseif npcHandler.topic[cid] == 4 then
			if player:removeItem(5902, 1) then
				npcHandler:say("Good, for this honeycomb I allow you 20 sips from the mead bucket over there. Talk to me again about barbarian mead if you have passed the test.", cid)
				npcHandler.topic[cid] = 0
				player:setStorageValue(Storage.BarbarianTest.Questline, 2)
				player:setStorageValue(Storage.TheIceIslands.Questline, 1)
				player:setStorageValue(Storage.BarbarianTest.Mission01, 2) -- Questlog Barbarian Test Quest Barbarian Test 1: Barbarian Booze
				player:setStorageValue(Storage.BarbarianTest.MeadTotalSips, 0)
			else
				npcHandler:say("You bring me a honeycomb and don't waste my time.", cid)
				npcHandler.topic[cid] = 0
			end
		end
	elseif msgcontains(msg, "no") then
		if player:getStorageValue(Storage.TheIceIslands.HuskyKillStatus) == 1 and npcHandler.topic[cid] == 0 then
			npcHandler:say("I don't know if you realise the consequences. You won't be a member of our community anymore. I ask you for the last time: Are you willing to pay "..player:getStorageValue(Storage.TheIceIslands.HuskyKill) * 1500 .." gold as a compensation?", cid)
			npcHandler.topic[cid] = 10
		elseif npcHandler.topic[cid] == 10 then
			npcHandler:say("Alright, it's your choice. If you regret your decision and want to be a barbarian again, talk to me about the {barbarian} test.", cid)
			player:setStorageValue(Storage.BarbarianTest.Questline, -1)
			player:setStorageValue(Storage.BarbarianTest.Mission01, -1)
			player:setStorageValue(Storage.BarbarianTest.Mission02, -1)
			player:setStorageValue(Storage.BarbarianTest.Mission03, -1)
		end
	end
	return true
end
npcHandler:setCallback(CALLBACK_GREET, greetCallback)
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
