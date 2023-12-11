local keywordHandler = KeywordHandler:new()
local npcHandler = NpcHandler:new(keywordHandler)
NpcSystem.parseParameters(npcHandler)

function onCreatureAppear(cid)			npcHandler:onCreatureAppear(cid)			end
function onCreatureDisappear(cid)		npcHandler:onCreatureDisappear(cid)			end
function onCreatureSay(cid, type, msg)		npcHandler:onCreatureSay(cid, type, msg)		end
function onThink()				npcHandler:onThink()					end

local function getTimeRemainingText(remainingSeconds)
    local days = math.floor(remainingSeconds / (24 * 3600))
    remainingSeconds = remainingSeconds % (24 * 3600)
    local hours = math.floor(remainingSeconds / 3600)
    remainingSeconds = remainingSeconds % 3600
    local minutes = math.floor(remainingSeconds / 60)
    local seconds = remainingSeconds % 60
    
    local timeString = ""
    
    if days > 0 then
        timeString = days .. " days, " .. hours .. " hours, " .. minutes .. " minutes and " .. seconds .. " seconds"
    elseif hours > 0 then
        timeString = hours .. " hours, " .. minutes .. " minutes"
    elseif minutes > 0 then
        timeString = minutes .. " minutes, " .. seconds .. " seconds"
    else
        timeString = seconds .. " seconds"
    end
    
    return timeString
end

local function creatureSayCallback(cid, type, msg)
    if not npcHandler:isFocused(cid) then
        return false
    end
    
    local player = Player(cid)
    
    if(msgcontains(msg, "ticket")) then
        local currentTime = os.time()
        local expirationTime = player:getStorageValue(Storage.WagonTicket)
        
        if expirationTime > currentTime then
            local remainingTime = expirationTime - currentTime
            local timeString = getTimeRemainingText(remainingTime)
            
            npcHandler:say("Your weekly ticket is still valid. It will expire in {" .. timeString .. "}.", cid)
            npcHandler.topic[cid] = 0
        else
            npcHandler:say("Do you want to purchase a weekly ticket for the ore wagons? With it, you can travel freely and swiftly through Kazordoon for one week. It's only 250 gold. Deal?", cid)
            npcHandler.topic[cid] = 1
        end
    elseif(msgcontains(msg, "yes")) then
		if(npcHandler.topic[cid] == 1) then
			if player:getMoney() + player:getBankBalance() >= 250 then
				player:removeMoneyNpc(250)
				player:setStorageValue(Storage.WagonTicket, os.time() + 7 * 24 * 60 * 60)
				npcHandler:say("Here is your stamp. It can't be transferred to another person and will last one week from now. You'll get notified upon using an ore wagon when it isn't valid anymore.", cid)
			else
				npcHandler:say("You don't have enough money.", cid)
			end
			npcHandler.topic[cid] = 0
		end
	elseif(npcHandler.topic[cid] == 1) then
		if(msgcontains(msg, "no")) then
			npcHandler:say("No then.", cid)
			npcHandler.topic[cid] = 0
		end
	-- WAGON TICKET
	end
	return true
end

npcHandler:setCallback(CALLBACK_MESSAGE_DEFAULT, creatureSayCallback)
npcHandler:setMessage(MESSAGE_GREET, "Welcome, |PLAYERNAME|! Do you feel adventurous? Do you want a weekly {ticket} for the ore wagon system here? You can use it right here to get to the centre of Kazordoon!")
npcHandler:setMessage(MESSAGE_FAREWELL, "Hope to see you again.")
npcHandler:addModule(FocusModule:new())
