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
	if msgcontains(msg, 'disguise') then
		if player:getStorageValue(Storage.ThievesGuild.TheatreScript) < 0 then
			npcHandler:say({
				'Hmpf. Why should I waste my time to help some amateur? I\'m afraid I can only offer my assistance to actors that are as great as I am. ...',
				'Though, your futile attempt to prove your worthiness could be amusing. Grab a copy of a script from the prop room at the theatre cellar. Then talk to me again about your test!'
			}, cid)
			player:setStorageValue(Storage.ThievesGuild.TheatreScript, 0)
		end
	elseif msgcontains(msg, 'test') then
		if player:getStorageValue(Storage.ThievesGuild.Mission04) == 5 then
			npcHandler:say('I hope you learnt your role! I\'ll tell you a line from the script and you\'ll have to answer with the corresponding line! Ready?', cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, 'yes') then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say('How dare you? Are you mad? I hold the princess hostage and you drop your weapons. You\'re all lost!', cid)
			npcHandler.topic[cid] = 2
		elseif npcHandler.topic[cid] == 3 then
			npcHandler:say('Too late puny knight. You can\'t stop my master plan anymore!', cid)
			npcHandler.topic[cid] = 4
		elseif npcHandler.topic[cid] == 5 then
			npcHandler:say('What\'s this? Behind the doctor?', cid)
			npcHandler.topic[cid] = 6
		elseif npcHandler.topic[cid] == 7 then
			npcHandler:say('Grrr!', cid)
			npcHandler.topic[cid] = 8
		elseif npcHandler.topic[cid] == 9 then
			npcHandler:say('You\'re such a monster!', cid)
			npcHandler.topic[cid] = 10
		elseif npcHandler.topic[cid] == 11 then
			npcHandler:say('Ah well, I think you passed the test! Here is your disguise kit! Now get lost, fate awaits me!', cid)
			player:setStorageValue(Storage.ThievesGuild.Mission04, 6)
			player:addItem(7865, 1)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 2 then
		if msgcontains(msg, 'I don\'t think so, dear doctor!') then
			npcHandler:say('Ok, ok. You\'ve got this one right! Ready for the next one?', cid)
			npcHandler.topic[cid] = 3
		else
			npcHandler:say('No no no! That is not correct!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 4 then
		if msgcontains(msg, 'Watch out! It\'s a trap!') then
			npcHandler:say('Ok, ok. You\'ve got this one right! Ready for the next one?', cid)
			npcHandler.topic[cid] = 5
		else
			npcHandler:say('No no no! That is not correct!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 6 then
		if msgcontains(msg, 'Look! It\'s Lucky, the wonder dog!') then
			npcHandler:say('Ok, ok. You\'ve got this one right! Ready for the next one?', cid)
			npcHandler.topic[cid] = 7
		else
			npcHandler:say('No no no! That is not correct!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 8 then
		if msgcontains(msg, 'Ahhhhhh!') then
			npcHandler:say('Ok, ok. You\'ve got this one right! Ready for the next one?', cid)
			npcHandler.topic[cid] = 9
		else
			npcHandler:say('No no no! That is not correct!', cid)
			npcHandler.topic[cid] = 0
		end
	elseif npcHandler.topic[cid] == 10 then
		if msgcontains(msg, 'Hahaha! Now drop your weapons or else...') then
			npcHandler:say('Ok, ok. You\'ve got this one right! Ready for the next one?', cid)
			npcHandler.topic[cid] = 11
		else
			npcHandler:say('No no no! That is not correct!', cid)
			npcHandler.topic[cid] = 0
		end
	end
	
	if (msgcontains(msg, "outfit")) or (msgcontains(msg, "addon")) 
		or (msgcontains(msg,"royal")) then
		npcHandler:say("In exchange for a truly generous donation of gold and silver tokens, I will offer a special outfit. Do you want to make a donation?", cid)
		npcHandler.topic[cid] = 12
	elseif msgcontains(msg, "yes") then
		-- vamos tratar todas condições para YES aqui
		if npcHandler.topic[cid] == 12 then
			-- para o primeiro Yes, o npc deve explicar como obter o outfit
			npcHandler:say({
				"Excellent! Now, let me explain. If you donate 30,000 silver tokens and 25,000 gold tokens, you will be entitled to wear a unique outfit. ...",
				"You will be entitled to wear the armor for 15,000 silver tokens and 12,500 gold tokens, and the shield and the crown for additional 7,500 silver tokens and 6,250 gold tokens each. ...",
				"What will it be?",
			}, cid)
			npcHandler.topic[cid] = 13
			-- O NPC só vai oferecer os addons se o player já tiver escolhido.
		elseif npcHandler.topic[cid] == 13 then
			-- caso o player repita o yes, resetamos o tópico para começar de novo?
			npcHandler:say("In that case, return to me once you made up your mind.", cid)
			npcHandler.topic[cid] = 0
			-- Inicio do outfit
		elseif npcHandler.topic[cid] == 14 then -- ARMOR/OUTFIT 1457
			if player:getStorageValue(Storage.OutfitQuest.RoyalCostumeOutfit) < 1 then
				if (player:removeItem(22516, 15000) and player:removeItem(22721, 12500)) then
					npcHandler:say("Take this armor as a token of great gratitude. Let us forever remember this day, my friend!", cid)
					player:addOutfit(1457)
					player:addOutfit(1456)
					player:getPosition():sendMagicEffect(171)
					player:setStorageValue(Storage.OutfitQuest.RoyalCostumeOutfit, 1)
				else
					npcHandler:say("You do not have enough tokens to donate that amount.", cid)
				end
			else
				npcHandler:say("You alread have that addon.", cid)
			end
			npcHandler.topic[cid] = 13
			-- Fim do outfit
			-- Inicio do helmet
		elseif npcHandler.topic[cid] == 15 then
			if player:getStorageValue(Storage.OutfitQuest.RoyalCostumeOutfit) == 1 then
				if player:getStorageValue(Storage.OutfitQuest.RoyalCostumeOutfit) < 2 then
					if (player:removeItem(22516, 7500) and player:removeItem(22721, 6250)) then
						npcHandler:say("Take this sheild as a token of great gratitude. Let us forever remember this day, my friend. ", cid)
						player:addOutfitAddon(1457, 1)
						player:addOutfitAddon(1456, 1)
						player:getPosition():sendMagicEffect(171)
						player:setStorageValue(Storage.OutfitQuest.RoyalCostumeOutfit, 2)
						npcHandler.topic[cid] = 13
					else
						npcHandler:say("You do not have enough tokens to donate that amount.", cid)
						npcHandler.topic[cid] = 13
					end
				else
					npcHandler:say("You alread have that outfit.", cid)
					npcHandler.topic[cid] = 13
				end
			else
				npcHandler:say("You need to donate {armor} outfit first.", cid)
				npcHandler.topic[cid] = 13
			end
			npcHandler.topic[cid] = 13
			-- Fim do helmet
			-- Inicio da boots
		elseif npcHandler.topic[cid] == 16 then
			if player:getStorageValue(Storage.OutfitQuest.RoyalCostumeOutfit) == 2 then
				if player:getStorageValue(Storage.OutfitQuest.RoyalCostumeOutfit) < 3 then
					if (player:removeItem(22516, 7500) and player:removeItem(22721, 6250)) then
						npcHandler:say("Take this crown as a token of great gratitude. Let us forever remember this day, my friend. ", cid)
						player:addOutfitAddon(1457, 2)
						player:addOutfitAddon(1456, 2)
						player:getPosition():sendMagicEffect(171)
						player:setStorageValue(Storage.OutfitQuest.RoyalCostumeOutfit, 3)
						npcHandler.topic[cid] = 13
					else
						npcHandler:say("You do not have enough tokens to donate that amount.", cid)
						npcHandler.topic[cid] = 13
					end
				else
					npcHandler:say("You alread have that outfit.", cid)
					npcHandler.topic[cid] = 13
				end
			else
				npcHandler:say("You need to donate {shield} addon first.", cid)
				npcHandler.topic[cid] = 13
			end
			-- Fim da boots
			npcHandler.topic[cid] = 13
		end
		--inicio das opções armor/helmet/boots
		-- caso o player não diga YES, dirá alguma das seguintes palavras:
	elseif (msgcontains(msg, "armor")) and npcHandler.topic[cid] == 13 then
		npcHandler:say("So you would like to donate 15,000 silver tokens and 12,500 gold tokens, which in return will entitle you to wear a unique red armor?", cid)
		npcHandler.topic[cid] = 14 -- alterando o tópico para que no próximo YES ele faça o outfit
	elseif (msgcontains(msg, "shield")) and npcHandler.topic[cid] == 13 then
		npcHandler:say("So you would like to donate 7,500 silver tokens and 6,250 gold tokens, which in return will entitle you to wear a unique shield?", cid)
		npcHandler.topic[cid] = 15 -- alterando o tópico para que no próximo YES ele faça o helmet
	elseif (msgcontains(msg, "crown")) and npcHandler.topic[cid] == 13 then
		npcHandler:say("So you would like to donate 7,500 silver tokens and 6,250 gold tokens, which in return will entitle you to wear a crown?", cid)
		npcHandler.topic[cid] = 16 -- alterando o tópico para que no próximo YES ele faça a boots
	end
	return true
end

npcHandler:setMessage(MESSAGE_GREET, "Be greeted |PLAYERNAME|! Please don't {interrupt} me for too long!")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
