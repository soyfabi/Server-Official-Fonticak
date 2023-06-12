local loginMessage = CreatureEvent("loginMessage")

function loginMessage.onLogin(player)
	local serverName = configManager.getString(configKeys.SERVER_NAME)
	loginStr = string.format("Your last visit in %s: %s.", serverName, os.date("%d %b %Y %X", player:getLastLoginSaved()))
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
	
    print(player:getName() .. " has logged in.")
	
	player:openChannel(2) -- Global Chat
	player:openChannel(12) -- Death Channel
	player:openChannel(6) -- Quests
	player:openChannel(7) -- Trade Market
	player:openChannel(4) -- Help
	player:openChannel(8) -- Changelog
	player:openChannel(3) -- Advertising

	if player:getGuild() then
	player:openChannel(10) -- Guild Leaders Channel
	end
	
	-- Bank Balance Text --
	--[[if player:getBankBalance() > 0 then
		player:sendTextMessage(MESSAGE_STATUS_BLUE_LIGHT, "Your Bank Balance is: {"..player:getBankBalance().."}.")
	end
	
	-- Inbox Notice --
	local inboxItems = player:getInbox():getItemHoldingCount()
	if inboxItems > 0 then
		player:sendTextMessage(MESSAGE_EVENT_ADVANCE, "Check the inbox, you have "..inboxItems.." item" .. (inboxItems > 1 and "s." or "."))
	end]]
	
    return true
end

loginMessage:register()

local logoutMessage = CreatureEvent("logoutMessage")

function logoutMessage.onLogout(player)
    print(player:getName() .. " has logged out.")
    return true
end

logoutMessage:register()