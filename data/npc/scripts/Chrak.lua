
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
	
	if msgcontains(msg, "battle") then
		if player:getStorageValue(TheNewFrontier.Questline) == 24 then
			npcHandler:say({
				"Zo you {want to enter} ze arena, you know ze rulez and zat zere will be no ozer option zan deaz or {victory}?"
			}, cid)
			npcHandler.topic[cid] = 1
		end
	elseif msgcontains(msg, "mission") then
		if player:getStorageValue(TheNewFrontier.Questline) == 24 then
			npcHandler:say({
				"Ze tournament iz ze ultimate challenge of might and prowrezz. Ze rulez may have changed over ze centuriez but ze ezzence remained ze zame. ...",
				"If you know ze rulez, you might enter ze arena for ze {battle}."
			}, cid)
			npcHandler.topic[cid] = 0
		elseif player:getStorageValue(TheNewFrontier.Questline) == 27 then
			npcHandler:say({
				"You have done ze impozzible and beaten ze champion. Your mazter will be pleazed. Hereby I cleanze ze poizon from your body. You are now allowed to leave. ...",
				"For now ze mazter will zee zat you and your alliez are zpared of ze wraz of ze dragon emperor az you are unimportant for hiz goalz. ...",
				"You may crawl back to your alliez and warn zem of ze gloriouz might of ze dragon emperor and hiz minionz."
			}, cid)
			player:setStorageValue(TheNewFrontier.Questline, 28)
			player:setStorageValue(TheNewFrontier.Mission09[1], 3) --Questlog, "Mission 09: Mortal Combat"
			player:setStorageValue(TheNewFrontier.Mission10[1], 1) --Questlog, "Mission 10: New Horizons"
			npcHandler.topic[cid] = 0
		end
	elseif msgcontains(msg, "yes") then
		if npcHandler.topic[cid] == 1 then
			npcHandler:say("I grant you ze {permizzion} to enter ze arena. {Remember}, you'will have to enter ze arena az a {team of two}. If you are not familiar wiz ze {rulez}, I can explain zem to you once again.", cid)
			player:setStorageValue(TheNewFrontier.Questline, 25)
			player:setStorageValue(TheNewFrontier.Mission09.ArenaDoor, 1)
			npcHandler.topic[cid] = 0
		end
		
		
	elseif msgcontains(msg, "rulez") then
            npcHandler:say(
                {"I waz informed zat you were zent to fight for one of ze mozt preztigiouz officialz of ze court. According to ze rulez, ziz zponzorzhip allowz you to participate in ze tournament. ....",
                 "While in ze pazt, ze tournament waz ztrictly non-leazal, ze ztakez have raized conziderably nowadayz. Zo lizten clozely: You will enter ze tornament az a team! ...", 
                 "Two of you muzt have gotten ze permizzion to enter ze arena. Zen you have to ztand on ze platformz in ze back and one of you haz to pull ze lever. You will be tranzported into ze arena. ...",       
                 "Once you enter, zere will only be victory or deaz! You have to be aware zat zere will be no chance to flee ze combat! Firzt you will face one team of opponentz. ...",
                 "You don't have long to defeat zem becauze zoon anozer team will enter ze fight. Az outziderz you will certainly be ze target of zeir concentrated attackz, zo it iz advizable to get rid of your opponentz az quickly az pozzible. ...",
                 "You might even gain zome time to regroup and tend your woundz if you are quick. After fighting zix teamz, you will have to face ze current champion of ze arena of ztrive. ...",
                 "If you manage to defeat him, your mazter winz ze tournament and all honourz. Zo if you feel prepared for ze battle, you can azk me to enter ze arena any time."},
                cid)
	end
	
	return true
end

keywordHandler:addKeyword({'competitor'}, StdModule.say, {npcHandler = npcHandler, text = "I'm ze mazter of ze ceremony and ze {gamez}. I overzee zat everyzing iz handled accordingly to ze ancient {traditionz}. I'm ze one to teach ze {rulez} of ze {tournament} to ze competitorz."})	
	
npcHandler:setMessage(MESSAGE_GREET, "Greetingz, {competitor}.")
npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:addModule(FocusModule:new())
